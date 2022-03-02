Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B44C9F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiCBIfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 03:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiCBIfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:35:21 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB246A0BE0;
        Wed,  2 Mar 2022 00:34:38 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i1so836868ila.7;
        Wed, 02 Mar 2022 00:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BO30jB7mXVgV0Gpsy/VhmBKi6MdrW6p/eZpi+7Kl5hA=;
        b=pHnXFZaN7mOFIwtIE6+3giPnTuu9p6K/U8Tgf+XTa957bxUPj1APa719hsSQT1aJZU
         Ux7RJyiu5lwmTMmS5dNny1lefo7YlbmfLZ+iUpb34ZMU5/Mc2fxi7hNi/OFWzrJcE2pB
         BOvtlMpAf4HYypcU+8wrsd7Kppi2D8BUbCxXwyRGabwweGNn0WdvwzB9SY0lBr1Djf/X
         OiMaXtJJxQ2t0g6cfsY+lA47HdU6EMNojT6W56YrYOaFWPxDQG/6Ct60/tRTQpFui8YV
         JqDz7tIrRN4mb+cSjbeTsaQWWBQrEG2bf4KytnZtqJNSvi+dz6sq53TifCvcgXHPRRYo
         EiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BO30jB7mXVgV0Gpsy/VhmBKi6MdrW6p/eZpi+7Kl5hA=;
        b=BLI/iaz3K9JH6j1DtQodCQsPb9pVTN+5hdcWpPKwdA4hHlWMGuyw6ZDVyc6+JrXSeG
         N22gLbM8evqpioo8llH0eCcLRe5jkBnqDIaMRUuPJbjHZxVIVx/SH4bWt/9xPHaLUOKh
         GCqLalFDvic6GdvxjCeXancKt06yckaHrNQf3EoEtAFZiiaKqBBwJVHrthrExcSNe3Ap
         HWcdVL00ztdpX2nbdeMEVUvsn83Yq/hDuUsCF+TLRw69YwDaPAByl5UjOVWvKdxnS7Q6
         5BR8m8LMxePCva3AtM/xmWhleYvYMkKg8YdI0rSPYPcmxPZSyM15+tYRWwqiTjkv8V1Z
         HubQ==
X-Gm-Message-State: AOAM533/M01T69ndm82+Y7GKmqePJtww+4x64NhoqldafMeOxFGCrWHh
        +0jbsX9WYyFP06xWM2Bnwu55fTP/bpJuI/fQ5k0=
X-Google-Smtp-Source: ABdhPJwfnt8kEyXGyEkCaDVFsCCMASA12/FWOsuZ4Qm/qWNvzRmVxrI/k/bxv14UMZ9gSIxqGngh1Fr6kc/7JfQxGas=
X-Received: by 2002:a05:6e02:16cf:b0:2c2:b29f:9399 with SMTP id
 15-20020a056e0216cf00b002c2b29f9399mr21094884ilx.24.1646210078231; Wed, 02
 Mar 2022 00:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20220301184221.371853-1-amir73il@gmail.com> <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com> <20220302082658.GF3927073@dread.disaster.area>
In-Reply-To: <20220302082658.GF3927073@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Mar 2022 10:34:27 +0200
Message-ID: <CAOQ4uxguQ8GE2U0QCKeFj8Bs7+u=8ULMWnUAP9K9YmAO4dFswQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Generic per-sb io stats
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
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

On Wed, Mar 2, 2022 at 10:27 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Mar 02, 2022 at 09:43:50AM +0200, Amir Goldstein wrote:
> > On Wed, Mar 2, 2022 at 8:59 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, Mar 01, 2022 at 08:42:15PM +0200, Amir Goldstein wrote:
> > > > Miklos,
> > > >
> > > > Following your feedback on v2 [1], I moved the iostats to per-sb.
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://lore.kernel.org/linux-unionfs/20220228113910.1727819-1-amir73il@gmail.com/
> > > >
> > > > Changes since v2:
> > > > - Change from per-mount to per-sb io stats (szeredi)
> > > > - Avoid percpu loop when reading mountstats (dchinner)
> > > >
> > > > Changes since v1:
> > > > - Opt-in for per-mount io stats for overlayfs and fuse
> > >
> > > Why make it optional only for specific filesystem types? Shouldn't
> > > every superblock capture these stats and export them in exactly the
> > > same place?
> > >
> >
> > I am not sure what you are asking.
> >
> > Any filesystem can opt-in to get those generic io stats.
>
> Yes, but why even make it opt-in? Why not just set these up
> unconditionally in alloc_super() for all filesystems? Either this is
> useful information for userspace montioring and diagnostics, or it's
> not useful at all. If it is useful, then all superblocks should
> export this stuff rather than just some special subset of
> filesystems where individual maintainers have noticed it and thought
> "that might be useful".
>
> Just enable it for every superblock....
>
> > This is exactly the same as any filesystem can already opt-in for
> > fs specific io stats using the s_op->show_stats() vfs op.
> >
> > All I did was to provide a generic implementation.
> > The generic io stats are collected and displayed for all filesystems the
> > same way.
> >
> > I only included patches for overlayfs and fuse to opt-in for generic io stats,
> > because I think those stats should be reported unconditionally (to
> > mount options)
> > for fuse/overlayfs and I hope that Miklos agrees with me.
>
> Yup, and I'm asking you why it should be optional - no filesystem
> ever sees this information - it's totally generic VFS level code
> except for the structure allocation. What's the point of *not*
> enabling it for every superblock unconditionally?
>
> > If there is wide consensus that all filesystems should have those stats
> > unconditionally (to mount options), then I can post another patch to make
> > the behavior not opt-in, but I have a feeling that this discussion
>
> That's exactly what I want you to do. We're already having this
> discussion, so let's get it over and done with right now.
>
> > How would you prefer the io stats behavior for xfs (or any fs) to be?
> > Unconditional to mount options?
> > Opt-in with mount option? (suggest name please)
> > Opt-in/out with mount options and default with Kconfig/sysfs tunable?
> > Anything else?
>
> Unconditional, for all filesystems, so they all display the same
> stats in exactly same place without any filesystem having to
> implement a single line of code anywhere. A single kconfig option
> like you already hav is just fine to turn it off for those that
> don't want to use it.
>

Very well then. I'll post this version with your Suggested-by ;-)

Thanks,
Amir.
