Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED054C7197
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiB1QTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 11:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiB1QTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:19:48 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F42546BD;
        Mon, 28 Feb 2022 08:19:09 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id k7so3375042ilo.8;
        Mon, 28 Feb 2022 08:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vn4WqbIDG/ntBsUraOm1IfhiMXb4IqH7hNoF8dQN1uY=;
        b=Ognv/qoEC0BCigqfD1iUfyFcTQ3UwJB1WPyrj4kfHLT2TSZJTxm0YFpoxUIedWOQzn
         HtDwMr91zfT7JEZ74zqyTZVHyNvbJYHpc3O7w2v0e72mJCKMMQ2Ji3qmb50ofxCjX6tW
         99HjfeVmGQtV1nTJdlYRODEQAL5W+W0WSDBSiHJKrGA3nY1GoNWXU0a0UvoZIl2IIt8l
         E24JKq6cel6fdhzIk8pK0AFYagwaRKmZbrmCFKjpvHU3qDy42fIQpyQfxp3+zxY+A3rJ
         sFvaRlJIISSkevkaIGV3UiQp0zMLzqVUH8PxKBcerX/JzspjNwRx++NHPBfGnhTXMnvg
         WADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vn4WqbIDG/ntBsUraOm1IfhiMXb4IqH7hNoF8dQN1uY=;
        b=Eb5vlEIHX+Esr9WrmMz7Rm9MUMGYOALG5M2JU2OsuYUyr9EsNtJbw92pXDL9WOsBDV
         WoGWzUBcXHO21oxBeIdbnQO4UXnP5rQTuQ8SALwCuDelvZQgzyGui96EgoA9c68phUfQ
         bf7cS04mSMSfinLDD4FkYxVNF8Pn24HE/ogprxR8tgXkhxkeFym8QU8fsb6oLybV8rV8
         1vTJTkS+ecb+ZPAyq1rUwTQVj0PHZPuWZbQm1TUwtszM7H36K9dvuKNUiuv7V1QiLwbS
         5ZpxMMk2QkMpiGLRLiDPrJCX8DgUZu9u6rksnI/ZvJ3RxCenbI6rwbQnml0XtzJHENAA
         Er6g==
X-Gm-Message-State: AOAM530kIzv7ejrVjWt8bWHBYznSomwv0cvQ3qY6xtQyecQBaQSUKgQr
        8YjHTzazAORy1fzhh1uqPDKtfW9EdTims5NoH1Q=
X-Google-Smtp-Source: ABdhPJyYWLgA3PGjLihMX1l90N0F/cIajbZfCmGKwzaLbv8t8ihI+2SAJMYxBumI8bsenElezTEN8S34LMTmDsUSq+k=
X-Received: by 2002:a05:6e02:1aa2:b0:2c2:2fc1:face with SMTP id
 l2-20020a056e021aa200b002c22fc1facemr20387524ilv.198.1646065148701; Mon, 28
 Feb 2022 08:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20220228113910.1727819-1-amir73il@gmail.com> <20220228113910.1727819-5-amir73il@gmail.com>
 <CAJfpegvZefGp9NChm_69Km0FgpxwUs+og-uc2mpMAbH6mZ2azQ@mail.gmail.com>
In-Reply-To: <CAJfpegvZefGp9NChm_69Km0FgpxwUs+og-uc2mpMAbH6mZ2azQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 28 Feb 2022 18:18:57 +0200
Message-ID: <CAOQ4uxgg8PDweNvkhXE20Gbb+=OGBbwLXjR6Yffc4ZkiKzGM0w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fs: report per-mount io stats
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        containers@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 5:06 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 28 Feb 2022 at 12:39, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Show optional collected per-mount io stats in /proc/<pid>/mountstats
> > for filesystems that do not implement their own show_stats() method
> > and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.
>
> This would allow some filesystems to report per-mount I/O stats, while
> leaving CIFS and NFS reporting a different set of per-sb stats.  This
> doesn't sound very clean.
>
> There was an effort to create saner and more efficient interfaces for
> per-mount info.  IMO this should be part of that effort instead of
> overloading the old interface.
>

That's fair, but actually, I have no much need for per-mount I/O stats
in overlayfs/fuse use cases, so I could amend the patches to collect and
show per-sb I/O stats.

Then, the generic show_stats() will not be "overloading the old interface".
Instead, it will be creating a common implementation to share among different
filesystems and using an existing vfs interface as it was intended.

Would you be willing to accept adding per-sb I/O stats to overlayfs
and/or fuse via /proc/<pid>/mountstats?

Thanks,
Amir.
