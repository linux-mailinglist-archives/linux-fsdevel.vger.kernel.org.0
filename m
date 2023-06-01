Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15EE719BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjFAMSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 08:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFAMSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:18:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0BED7
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 05:18:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f8d485ef3so104562266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1685621908; x=1688213908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TjKKwQ7YZ52K1F/sXvcot46oThTtzilfqhAodws70s=;
        b=CsDnRRS5uBym/ALZvCHGm7OVO8VYPXC64GNn1FNTOnKgg5jOg+iOXhAtG66CKfdOd+
         UPXHtlKvdlXjgSlLL+BM5UOjTJVvXB3W3bNTbmPXlP/wSVxZXEPl4s/zZG20uM6c54SO
         gm6uJ0Ltny7bOCl5S+z77XWhByJWJjWtyW9yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685621908; x=1688213908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TjKKwQ7YZ52K1F/sXvcot46oThTtzilfqhAodws70s=;
        b=A4fVpMfTBjf8UgEeONnJUUI9+l48ZOBzzaG04tv7a4KRY5a4DCGMuZQJ9Rs4Jd8Ntd
         spsoHkRHAAtIBmqkSZ6C5iJ7gjRLRWWhJnXvQ8c+KPjHkBcq0dJrLhkHUgeEYanWAYq2
         5xFzlVIhMWv6dK56UNpxdsjAyK3u7KhSY4g5mkSJsXmMIfAUX4onN+7956xYSdOSbDin
         mgGn51cQ9Vlk6zH18XgBh8lugGbdx1cHsiu93xVirQ/1nX8/UD+YO7x4lBCg+evRiPjt
         ONxgwn8jlQBOCjrVpPMxh3X+BDCkrJRsLqqFvdIeZvY45CCcnvg66fqFigrH3s7ICg+S
         en5g==
X-Gm-Message-State: AC+VfDzrf1+sZiGqtblYRKrt7V2kBlKk4UYF16GkFlua3WxVRzlcGp5G
        ozVQw4jfDBk8CluXLwsRx89hNnaFqZGit2NfAKXxpA==
X-Google-Smtp-Source: ACHHUZ55F5DRBseT4RmqqRQQ91PxbqrS+uhYpVfbuYrfQBpqlSD3QfHRGiR4nhu24vV3ldqVRa5Eq7dAl71hm9xTI8A=
X-Received: by 2002:a17:907:6e09:b0:973:eac4:a24d with SMTP id
 sd9-20020a1709076e0900b00973eac4a24dmr7988792ejc.57.1685621908409; Thu, 01
 Jun 2023 05:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
 <ccfd2c96-35c7-8e33-9c5e-a1623d969f39@ddn.com> <CAJfpegswePPhVrDrwjZHbHb91iOkbfObnxFqzJU88U7pH86Row@mail.gmail.com>
 <805d122a-34d0-b097-c3e3-f3cc7c95aa46@ddn.com>
In-Reply-To: <805d122a-34d0-b097-c3e3-f3cc7c95aa46@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Jun 2023 14:18:17 +0200
Message-ID: <CAJfpegs7DFvP3ZctPcgzYC+4CKg3nqag69oRxH0H339R-M+z8A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Horst Birthelmer <horst@birthelmer.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 1 Jun 2023 at 14:01, Bernd Schubert <bschubert@ddn.com> wrote:
>
> On 6/1/23 13:50, Miklos Szeredi wrote:
> > On Thu, 1 Jun 2023 at 13:17, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> Hi Miklos,
> >>
> >> On 5/19/22 11:39, Miklos Szeredi wrote:
> >>> On Tue, 17 May 2022 at 12:08, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >>>>
> >>>> In FUSE, as of now, uncached lookups are expensive over the wire.
> >>>> E.g additional latencies and stressing (meta data) servers from
> >>>> thousands of clients. These lookup calls possibly can be avoided
> >>>> in some cases. Incoming three patches address this issue.
> >>>>
> >>>>
> >>>> Fist patch handles the case where we are creating a file with O_CREAT.
> >>>> Before we go for file creation, we do a lookup on the file which is most
> >>>> likely non-existent. After this lookup is done, we again go into libfuse
> >>>> to create file. Such lookups where file is most likely non-existent, can
> >>>> be avoided.
> >>>
> >>> I'd really like to see a bit wider picture...
> >>>
> >>> We have several cases, first of all let's look at plain O_CREAT
> >>> without O_EXCL (assume that there were no changes since the last
> >>> lookup for simplicity):
> >>>
> >>> [not cached, negative]
> >>>      ->atomic_open()
> >>>         LOOKUP
> >>>         CREATE
> >>>
> >>
> >> [...]
> >>
> >>> [not cached]
> >>>      ->atomic_open()
> >>>          OPEN_ATOMIC
> >>
> >> new patch version is eventually going through xfstests (and it finds
> >> some issues), but I have a question about wording here. Why
> >> "OPEN_ATOMIC" and not "ATOMIC_OPEN". Based on your comment  @Dharmendra
> >> renamed all functions and this fuse op "open atomic" instead of "atomic
> >> open" - for my non native English this sounds rather weird. At best it
> >> should be "open atomically"?
> >
> > FUSE_OPEN_ATOMIC is a specialization of FUSE_OPEN.  Does that explain
> > my thinking?
>
> Yeah, just the vfs function is also called atomic_open. We now have
>
>
> static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>                  struct file *file, unsigned flags,
>                  umode_t mode)
> {
>      struct fuse_conn *fc = get_fuse_conn(dir);
>
>      if (fc->no_open_atomic)
>          return fuse_open_nonatomic(dir, entry, file, flags, mode);
>      else
>          return fuse_open_atomic(dir, entry, file, flags, mode);
> }
>
>
> Personally I would use something like _fuse_atomic_open() and
> fuse_create_open() (instead of fuse_open_nonatomic). The order of "open
> atomic" also made it into libfuse and comments - it just sounds a bit
> weird ;) I have to live with it, if you prefer it like this.

I'd prefer FUSE_OPEN_ATOMIC for the API, but I don't care about
function names, as long as the purpose is clear.

Thanks,
Miklos
