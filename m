Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40264539AA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 03:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348910AbiFABMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348911AbiFABML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 21:12:11 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B06326113
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:12:06 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-30c143c41e5so2957697b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a87IcC9urf+k/BpqnG3OjFGgMumKd7iQpHu0ssOaiic=;
        b=KQ6xfJ2MAx8t5MCYwFKqlYdylzl0qF96ue+1TQyTzPIVqA1MdgUob06UcOoIjKW79i
         wsE4ILBjjsv/D1JUbtoib1/KfZ7P54OcZCrSadx67qPJ+3OGSTxgFodRzydg3MfH2xZ+
         D08AjOQmDAsg9claFvSgYRGipck7i4+lJsGc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a87IcC9urf+k/BpqnG3OjFGgMumKd7iQpHu0ssOaiic=;
        b=vAW0jPtae/X8SvhbklerhnT+8xHgnVexLwLnH1+DSBaDx5gJBdaPvrjQl7sI3PosIr
         7MNpk/1QxGA9Pccy5Y9KfO2sJa8nwi64cPggmqVTuBvMO9DGKKJf66yb3jbIQBtRU5Kd
         E7q7WWWRTl+lHzseHfquLMaBEk5gY9Ta/C6QibRyK002XlYpSsclP73ugb8mczg9v0VX
         uLcspGDsPIeUCjlj1Y/wNQ2pkZ3ttlcfWsVcFrCskTzS+ew8doZDpPov8kFbuzzZseSV
         IEo0jmAf4AyxQgWyVAp5ziMjPxIMTUHwdYPIx5UPZIEK98n+cmYS4IhvTm5/7DgNBbaK
         6LtA==
X-Gm-Message-State: AOAM533W2deyWqDBfRP1hYdrfSEiKxydqHqDHXejwbSWM5qiUq76svn+
        87PgWT94DQtCgKGBROfgrKsnngIsglZax0va6p72JA==
X-Google-Smtp-Source: ABdhPJxN8CFFftQdSRWB+oFw+/9K6wx0YHUNqX3WYh3HcxuMASW/AiqGynB9Key4qJsp58N1ju6u+fPv+2562H6cc8Q=
X-Received: by 2002:a81:848c:0:b0:30c:4684:3b6 with SMTP id
 u134-20020a81848c000000b0030c468403b6mr15060632ywf.77.1654045926104; Tue, 31
 May 2022 18:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220530013958.577941-1-dlunev@chromium.org> <20220530113953.v3.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
 <YpXCt14eL2edq6IB@infradead.org>
In-Reply-To: <YpXCt14eL2edq6IB@infradead.org>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 1 Jun 2022 11:11:55 +1000
Message-ID: <CAONX=-dQuiG26gCp7FVfZk83au=RXXcnTWJO8+Ygep0iVqvnxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs/super: function to prevent super re-use
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, tytso@mit.edu,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your comments. Uploaded v4 with requested changes.
--Daniil

On Tue, May 31, 2022 at 5:24 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 30, 2022 at 11:39:57AM +1000, Daniil Lunev wrote:
> > +void retire_super(struct super_block *sb)
> > +{
> > +     down_write(&sb->s_umount);
> > +     if (sb->s_bdi != &noop_backing_dev_info) {
> > +             if (sb->s_iflags & SB_I_PERSB_BDI && !(sb->s_iflags & SB_I_RETIRED))
>
> SB_I_PERSB_BDI can't be set for noop_backing_dev_info, so that check
> should not be needed.  Which also conveniently fixes the overly long
> line.
>
> Also this should clear SB_I_PERSB_BDI as the only place that checks
> it is the unregistration.
>
> >       spin_lock(&sb_lock);
> > -     /* should be initialized for __put_super_and_need_restart() */
>
> This is a completely unrelated change.  While the function is gone
> it might be worth to check what it got renamed to or folded in, or
> if the initialization is still needed.  But all that is for a separate
> patch.
>
> >       up_write(&sb->s_umount);
> >       if (sb->s_bdi != &noop_backing_dev_info) {
> > -             if (sb->s_iflags & SB_I_PERSB_BDI)
> > +             /* retire should have already unregistered bdi */
> > +             if (sb->s_iflags & SB_I_PERSB_BDI && !(sb->s_iflags & SB_I_RETIRED))
> >                       bdi_unregister(sb->s_bdi);
> >               bdi_put(sb->s_bdi);
>
> And once SB_I_PERSB_BDI is dropped when retiring we don't need this
> change.
