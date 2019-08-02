Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECD80131
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406427AbfHBToc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 15:44:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43271 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405999AbfHBToc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:44:32 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so1428099ios.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2019 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OdiY1TSytxJmY9JO95nn2U14StWQvCBLnZREmGPB/8=;
        b=mpsEy4IJUslvqOxsBpPGF4I69atorNlHMtgUURS+OXx6n/IHopxJTe9JpLbI9WLxlw
         GUmZQF6QFfkHgWACqT3ELOmv8QeO9ZwqG/7KwKoslwRKi00c2C8m+Rx2s81ByaaknKwt
         qtWVSMQNhjfyGTNnaeFaEGvwfvdM4MxmANwmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OdiY1TSytxJmY9JO95nn2U14StWQvCBLnZREmGPB/8=;
        b=S1PI2t9zbVd5KpNk+zHNQFkOFO/ezmHD0UbtqdLYa58taMPwXi0vdcLQQ1GJmSE3LN
         r6e5a0QiN1K8uhVTxp8SUYQYxQpmltzR0P1XLjToPtc74v+ceRB+J8T6t1W2Ib/nf2nJ
         6RnPj64OArEbvszhZ2hqNdpX00BpdamLB0qnkVS6qu//YqDIdPy77HtlOILnJqLGHfh/
         naDSNpdu1f6MS503mnuQfYg+y3T3MSxXBIrATO7wDF4xtSxpbgxjTsl5BOxsLoRN1Gpd
         mfOsrrPKoCQT1+FNljyTQl19Ow3zAOA/fLlwSmcCGP4M3ciGRiZArw40xi4/VnNt+QNn
         O9aQ==
X-Gm-Message-State: APjAAAUC+Q24fPQvgyJp9KFcg+RR8r30EXA4sVILJOT2xnudRmuTyzHD
        /ITnp3xvSyxcH4vlEbXHfeZWeXwLRO6l241qvgY=
X-Google-Smtp-Source: APXvYqydxAkURHNHqbakNScu/HaP2DLVCOpFzwiM0/z1dtoIllwB2AV9y7JK/xb+ceMvn4cKV9/pi2xZWQIrbgZUKak=
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr51002265jai.39.1564775070896;
 Fri, 02 Aug 2019 12:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <1546163027.3036.2.camel@domdv.de> <CAJfpegvBvY2hLUc010hgi3JwWPyvT1CK1X2GD3qUe-dBDtoBbA@mail.gmail.com>
 <388f911ccba16dee350bb2534b67d601b44f3a92.camel@domdv.de> <CAJfpegtQ11yRhg3+h+dCJ_juc6KGKBLLwB_Vco8+KDACpBmY5w@mail.gmail.com>
 <20190802081501.GK26174@kroah.com>
In-Reply-To: <20190802081501.GK26174@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 2 Aug 2019 21:44:20 +0200
Message-ID: <CAJfpegvm=Et+MH+h0QYtF14JCdu+QNpnyKubA3Fd137+Wtc4ew@mail.gmail.com>
Subject: Re: [PATCH] Fix cuse ENOMEM ioctl breakage in 4.20.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Steinmetz <ast@domdv.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 2, 2019 at 10:15 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 28, 2019 at 03:12:28PM +0200, Miklos Szeredi wrote:
> > On Sat, May 18, 2019 at 3:58 PM Andreas Steinmetz <ast@domdv.de> wrote:
> >
> > > > On Sun, Dec 30, 2018 at 10:52 AM Andreas Steinmetz <ast@domdv.de> wrote:
> > > > > This must have happened somewhen after 4.17.2 and I did find it in
> > > > > 4.20.0:
> > > > >
> > > > > cuse_process_init_reply() doesn't initialize fc->max_pages and thus all
> > > > > cuse bases ioctls fail with ENOMEM.
> > > > >
> > > > > Patch which fixes this is attached.
> > > >
> > > > Thanks.  Pushed a slightly different patch:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=for-next&id=666a40e87038221d45d47aa160b26410fd67c1d2
> > > >
> >
> > > It got broken again, ENONEM.
> > > I do presume that commit 5da784cce4308ae10a79e3c8c41b13fb9568e4e0 is the
> > > culprit. Could you please fix this and, please, could somebody do a cuse
> > > regression test after changes to fuse?
> >
> > Hi,
> >
> > Can you please tell us which kernel is broken?
>
> Did this ever get resolved?

Apparently yes, in v4.20.8 (f191c028cc33).  No other kernel was
affected, AFAICS.

Thanks,
Miklos
