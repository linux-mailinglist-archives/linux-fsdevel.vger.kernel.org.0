Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6F52CF8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiESJjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiESJjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 05:39:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC805793A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 02:39:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f9so8896058ejc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfUqL2hAQiwlZtQZKTSFdFDIUiwxRK4bfglUJckElMI=;
        b=BLtxyBSiFUiwliLEOyyyxg5U0ZrvialfgDzdK2PCV0do10BmtrOaky25bKhouRiohT
         TmNQPmcSduvNchV8buKxviiu2y3q8C7ic7/goOQtJbz95Lgi9+vh30wJC9oAR0rdKngr
         aZMhCLcsqf9f1H5aINm542hl6S+Ed9B1/DN7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfUqL2hAQiwlZtQZKTSFdFDIUiwxRK4bfglUJckElMI=;
        b=wKbSks9Zv8SnY3KGrkTcMrw72rRxzcSs6BWHSxQ9zWKy75sNAjgO38GHrYmf3MModl
         qMEd85is2MeF28EDSE7+MHwgsyHH4/1jt6dNSG2bBWuXepybcHQwZwz3wQHZp6kR7zJe
         y5bajVxzEGjQS90yIMnGSsCVU6o3zvcFghHu65UnXtpdbiaZ5Ww8BwYmIq5jT0qLaeNu
         e5oTHuw8A9Pp9Vtvv8w3t6v5TcK4Wp5r6S69V9X6Md+KGuZQgnQ6A8iKMCuyxzCTgLLR
         AKdwgQUYBGoG1cKdkkmLwRjBjMAE7EolPsN9HZuPNbiiO7lWyxtjAc/+oNjFOaEkxeBV
         Cmhw==
X-Gm-Message-State: AOAM532qm7aKFs48ah5WF5nDZ8K0bT8JFn2C+J6C19AbB3NN9yUdGJxK
        vf3W9outWxdAHMSa7hFRPB0zBRa9rRy2VwyMGJmB6w==
X-Google-Smtp-Source: ABdhPJxj0oVAOE6aIXDEMNP/kdLEg73QaqllM2/ZwxFox/aRNiKV6Pe6EhWggwNh5M1NNhdp+KjA0WWtIq0y9elHMA4=
X-Received: by 2002:a17:907:6e0f:b0:6fe:382a:6657 with SMTP id
 sd15-20020a1709076e0f00b006fe382a6657mr3345940ejc.192.1652953153454; Thu, 19
 May 2022 02:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220517100744.26849-1-dharamhans87@gmail.com>
In-Reply-To: <20220517100744.26849-1-dharamhans87@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 May 2022 11:39:01 +0200
Message-ID: <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 May 2022 at 12:08, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>
> In FUSE, as of now, uncached lookups are expensive over the wire.
> E.g additional latencies and stressing (meta data) servers from
> thousands of clients. These lookup calls possibly can be avoided
> in some cases. Incoming three patches address this issue.
>
>
> Fist patch handles the case where we are creating a file with O_CREAT.
> Before we go for file creation, we do a lookup on the file which is most
> likely non-existent. After this lookup is done, we again go into libfuse
> to create file. Such lookups where file is most likely non-existent, can
> be avoided.

I'd really like to see a bit wider picture...

We have several cases, first of all let's look at plain O_CREAT
without O_EXCL (assume that there were no changes since the last
lookup for simplicity):

[not cached, negative]
   ->atomic_open()
      LOOKUP
      CREATE

[not cached, positive]
   ->atomic_open()
      LOOKUP
   ->open()
      OPEN

[cached, negative, validity timeout not expired]
   ->d_revalidate()
      return 1
   ->atomic_open()
      CREATE

[cached, negative, validity timeout expired]
   ->d_revalidate()
      return 0
   ->atomic_open()
      LOOKUP
      CREATE

[cached, positive, validity timeout not expired]
   ->d_revalidate()
      return 1
   ->open()
      OPEN

[cached, positive, validity timeout expired]
   ->d_revalidate()
      LOOKUP
      return 1
   ->open()
      OPEN

(Caveat emptor: I'm just looking at the code and haven't actually
tested what happens.)

Apparently in all of these cases we are doing at least one request, so
it would make sense to make them uniform:

[not cached]
   ->atomic_open()
      CREATE_EXT

[cached]
   ->d_revalidate()
      return 0
   ->atomic_open()
      CREATE_EXT

Similarly we can look at the current O_CREAT | O_EXCL cases:

[not cached, negative]
   ->atomic_open()
      LOOKUP
      CREATE

[not cached, positive]
   ->atomic_open()
      LOOKUP
   return -EEXIST

[cached, negative]
   ->d_revalidate()
      return 0 (see LOOKUP_EXCL check)
   ->atomic_open()
      LOOKUP
      CREATE

[cached, positive]
   ->d_revalidate()
      LOOKUP
      return 1
   return -EEXIST

Again we are doing at least one request, so we can unconditionally
replace them with CREATE_EXT like the non-O_EXCL case.


>
> Second patch handles the case where we open first time a file/dir
> but do a lookup first on it. After lookup is performed we make another
> call into libfuse to open the file. Now these two separate calls into
> libfuse can be combined and performed as a single call into libfuse.

And here's my analysis:

[not cached, negative]
   ->lookup()
      LOOKUP
   return -ENOENT

[not cached, positive]
   ->lookup()
      LOOKUP
   ->open()
      OPEN

[cached, negative, validity timeout not expired]
    ->d_revalidate()
       return 1
    return -ENOENT

[cached, negative, validity timeout expired]
   ->d_revalidate()
      return 0
   ->atomic_open()
      LOOKUP
   return -ENOENT

[cached, positive, validity timeout not expired]
   ->d_revalidate()
      return 1
   ->open()
      OPEN

[cached, positive, validity timeout expired]
   ->d_revalidate()
      LOOKUP
      return 1
   ->open()
      OPEN

There's one case were no request is sent:  a valid cached negative
dentry.   Possibly we can also make this uniform, e.g.:

[not cached]
   ->atomic_open()
       OPEN_ATOMIC

[cached, negative, validity timeout not expired]
    ->d_revalidate()
       return 1
    return -ENOENT

[cached, negative, validity timeout expired]
   ->d_revalidate()
      return 0
   ->atomic_open()
      OPEN_ATOMIC

[cached, positive]
   ->d_revalidate()
      return 0
   ->atomic_open()
      OPEN_ATOMIC

It may even make the code simpler to clearly separate the cases where
the atomic variants are supported and when not.  I'd also consider
merging CREATE_EXT into OPEN_ATOMIC, since a filesystem implementing
one will highly likely want to implement the other as well.

Thanks,
Miklos
