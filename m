Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A6283D3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgJERW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJERW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:22:59 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E2C0613CE;
        Mon,  5 Oct 2020 10:22:59 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d20so5073954iop.10;
        Mon, 05 Oct 2020 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZRtmjOYtpHBNM212M1ledQJfVr2VJ6yoQhIQ7bVB48=;
        b=mSQ0LPOdKz+shB3s5abRAYiD5DnDSzpIlTrwvdRl7MnB8VCF7z2zA9KPvBQWREFuAr
         V9kXgG0wkGqKWlZPidtmFb4s3FrzHaF1v37saUwVNUY0CpFizPwhr48RYSGN9yPbgOOc
         lj+AVg78qiKD5b5AO9VVnfTBxoJvl55OtCLf5W7zEQP3mH4IjomQ2+I5m3nYrQYNOa2S
         q30+lzGInEFb9Ry+JS5viBs0z2WfHK0E/komTAMpLuIdXcgNp5+Go30LREQN+/+OEzVz
         ySSAwhF4p9hW4tpmX2fMjX8Lui2FWcNM2pmu51hse+8iNlPH+bx1cHHWczLBgSmvhu+8
         V9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZRtmjOYtpHBNM212M1ledQJfVr2VJ6yoQhIQ7bVB48=;
        b=hSDjCScmuc85PGVrEmeGREEZYK02DRE554yZb3WI4T0F6+c1mx91ZacI0OTRwj9pZp
         dgOOjjBlpSkZOdKPW5bn0SKx+yZ0mTQUaG8Zhbp55u5yvyJoe/CIm+RPyqwjUAse/MbO
         P/f6uH5RtnLeFk9dxpOT1SjMEkTkemhetQ2k7VTkMtyGDFoU/36f1FzgPofyQ5I5UJAa
         F1eJuImRUqNOD4GuVPnMByJTw9lW/FmYaTGaMPZkWKffyFQaOXkp0L71ftjt3DGGwFqD
         lWmaK5QvY3+oRvUNiK/6BoVjkuVCeW7BkvcOY8/ZO6ObzJ9Of2MdSWdYILkeyg/Fq55O
         3XVA==
X-Gm-Message-State: AOAM532YBBjL774JBrZ+Rh4LN6DzdVl0GP+XxebAS2u5EgrPTcxxxl0R
        cQj2nxM1Iabc6OHfNVFoHAXLVE82bsHmsVeTyOo=
X-Google-Smtp-Source: ABdhPJwRyJHnDxbqKob8p9WvPedYD68n+ADV/ljcburJhGIsDf8uD0j8l8VlS7MozBS4CeaqS7iPmdQcHhun29P88UE=
X-Received: by 2002:a05:6638:3a6:: with SMTP id z6mr865054jap.93.1601918578650;
 Mon, 05 Oct 2020 10:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
 <20201005170227.11340-1-alexander.mikhalitsyn@virtuozzo.com>
 <83d78791-b650-c8d5-e18a-327d065d53d7@infradead.org> <20201005201222.d1f42917d060a5f7138b6446@virtuozzo.com>
In-Reply-To: <20201005201222.d1f42917d060a5f7138b6446@virtuozzo.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 5 Oct 2020 20:22:47 +0300
Message-ID: <CAOQ4uxiGq40XLhjx_Nz1ymGj967QsMAj_PvuSKH1_4dX=dRMXA@mail.gmail.com>
Subject: Re: [RFC PATCH] overlayfs: add OVL_IOC_GETINFOFD ioctl that opens ovlinfofd
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 5, 2020 at 8:13 PM Alexander Mikhalitsyn
<alexander.mikhalitsyn@virtuozzo.com> wrote:
>
> On Mon, 5 Oct 2020 10:08:42 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
>
> > On 10/5/20 10:02 AM, Alexander Mikhalitsyn wrote:
> > >  #define    OVL_IOC_GETLWRFHNDLSNUM                 _IO('o', 1)
> > >  // DISCUSS: what if MAX_HANDLE_SZ will change?
> > >  #define    OVL_IOC_GETLWRFHNDL                     _IOR('o', 2, struct ovl_mnt_opt_fh)
> > >  #define    OVL_IOC_GETUPPRFHNDL                    _IOR('o', 3, struct ovl_mnt_opt_fh)
> > >  #define    OVL_IOC_GETWRKFHNDL                     _IOR('o', 4, struct ovl_mnt_opt_fh)
> > > +#define    OVL_IOC_GETINFOFD                       _IO('o', 5)
> >
> > Hi,
> >
> > Quoting (repeating) from
> > https://lore.kernel.org/lkml/9cd0e9d1-f124-3f2d-86e6-e6e96a1ccb1e@infradead.org/:
> >
> > This needs to have Documentation/userspace-api/ioctl/ioctl-number.rst
> > updated also.
> >
> > ...
> >
> > Are you waiting until it's past RFC stage?
> >
> > thanks.
> > --
> > ~Randy
> >
>
> Hi,
>
> thank you! I will prepare this change too when we
> decide which ioctls to add. ;)
>

Or... don't do ioctls and avoid the ABI headaches.
If you are going to expose a seqfile I think it would be much prefered
to do a /sys/fs/overlay/instance/<device minor>/layes file.

But that's just my opinion.

Thanks,
Amir.
