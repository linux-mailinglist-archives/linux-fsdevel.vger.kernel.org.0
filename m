Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6335F30E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 13:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhDNL7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhDNL7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:59:34 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB5C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 04:59:10 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id l1so2853591vkk.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0MGv1y1F0WYbwqNAIg1w6XGdt99IUf8puJ2a4PrjtQ=;
        b=eVDJOwASSOF6O4gCTeM7sHeK9zcoZ3LffJdSqKnhm0rK9/hTOw/bNYTGCm/u8jD7sj
         PbYKwUAKHudkOae5TQvheCGPwHVTSrnQNSzLMq2QW5C/q986g1yCrOlgaR6cibwRp9eu
         9KGzw74/LwFEoYQokLEHB/SPig0QC/W21DrqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0MGv1y1F0WYbwqNAIg1w6XGdt99IUf8puJ2a4PrjtQ=;
        b=moF3GPlmdfpvQoqqoz0ZF+V5I32K2u4Ce+ppg5i2PukaDsj0Wfbm4PKV4icBFomwoP
         XpukziLbTyTVhMIWE0Q9E36zZbyYGC3tyfGYUUVZ8CeyQ+GnElJsEJMTrBforsZnVUhj
         3QthT9uzD+ShGkywC/TAKSXlhE22jAXF167aZK24IL59JPqrkvpenWeZHQa0sIGCD+B8
         8pHQItKYmKidWmptn/TEn2YH/tuM5wcO5btHw9ow9c9qjispNeQ2R+GpjwRYrhkL2NfU
         QAaa32BiT+iwma7edyUe0EKDtkXXX4qV0Y+Y56NsWpLxCIrnc+zystasI8fu4N7wTaze
         KdGQ==
X-Gm-Message-State: AOAM5332VRjITULwnhTAH5VG3igWiBHPSF8W5/puztpPjb1CiKioF8Nj
        wSsPF419ri67HnlOK6aVgOpDgEiJZ7CSlOhkDUPQiA==
X-Google-Smtp-Source: ABdhPJwvyBvVQrGuiNLmmhoc1+YjkZrqv4wqX7YYKlGChrZEB1/29Tc65QTw3zR7GdGCTxDNV7IroErWiKl6EqFO8ac=
X-Received: by 2002:a1f:99cc:: with SMTP id b195mr5082094vke.19.1618401549235;
 Wed, 14 Apr 2021 04:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210412145919.GE1184147@redhat.com> <CAJfpegsaY05jSRNFTcquNFyMr+GMpPBMgoEO0YZcXxfqBi3g2A@mail.gmail.com>
 <20210414135622.4d677fd7@bahia.lan>
In-Reply-To: <20210414135622.4d677fd7@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 14 Apr 2021 13:58:58 +0200
Message-ID: <CAJfpegv60U4EecWhZSE27iC0n13kxOBfT83UZD6ziSRE4h9xVA@mail.gmail.com>
Subject: Re: Query about fuse ->sync_fs and virtiofs
To:     Greg Kurz <groug@kaod.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Robert Krawitz <rkrawitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 1:56 PM Greg Kurz <groug@kaod.org> wrote:
>
> On Mon, 12 Apr 2021 17:08:26 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > On Mon, Apr 12, 2021 at 4:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Hi Miklos,
> > >
> > > Robert Krawitz drew attention to the fact that fuse does not seem to
> > > have a ->sync_fs implementation. That probably means that in case of
> > > virtiofs, upon sync()/syncfs(), host cache will not be written back
> > > to disk. And that's not something people expect.
> > >
> > > I read somewhere that fuse did not implement ->sync_fs because file
> > > server might not be trusted and it could block sync().
> > >
> > > In case of virtiofs, file server is trusted entity (w.r.t guest kernel),
> > > so it probably should be ok to implement ->sync_fs atleast for virtiofs?
> >
> > Yes, that looks like a good idea.
> >
>
> I've started looking into this. First observation is that implementing
> ->sync_fs() is file server agnostic, so if we want this to only be used
> by a trusted file server, we need to introduce such a notion in FUSE.
> Not sure where though... in struct fuse_fs_context maybe ?

Yep, makes sense.

Thanks,
Miklos
