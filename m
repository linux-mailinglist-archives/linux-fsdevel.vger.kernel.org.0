Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696B120737A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390661AbgFXMf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 08:35:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32977 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390330AbgFXMf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593002156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXOd3FWsgxfpuN6FCKX2ClEKNWirNYpN+5hpadr6Dd4=;
        b=CdGnKZRSdyTYjv7f0Cd78D9P0h0GtR23W+E2QxOmYEsQXDmVLerUhweEXqVP3ITF3D+zcp
        w6yBzUEZLT+hShXpLZWTbTnlY4H3U4l3W99RF28nHlcSjXY/CYRV5+g70gvneI2J0tJHbh
        zHi+LV0Fiv4DU+FkV/Gw6QQLDt18h20=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-vUzR7xmPOWeeQWFX5JFtuw-1; Wed, 24 Jun 2020 08:35:52 -0400
X-MC-Unique: vUzR7xmPOWeeQWFX5JFtuw-1
Received: by mail-oi1-f197.google.com with SMTP id v8so1398448oiv.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 05:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXOd3FWsgxfpuN6FCKX2ClEKNWirNYpN+5hpadr6Dd4=;
        b=H8N5+r9qS/86KXUbC2zzWzTlwxpZ6n44FzGrnMbBoErFj0u35MSr69p66pPhDcFTDX
         GouC4G7tlQSoG9RahjMHUzP8rz/oS0s71MaP543Afe47hNHU0QWHjL2pbTBsQKz1fZoa
         Wj6MWG83hOzmIdr+Aqu9m4RuESBbGEJVqlBUlSHVn38iQdz3oTOs80F0F6epgenDqvLQ
         GwfVkpNEMk9jAMXIbTjm8IBWt8Fc75eLpq3jW0sYFQTwSM505G5s92VCsTWeJ3XDvLrH
         Wo/zTZxJsVi7Vc+TWZG2XFiQSTR4wi9QLWWV/apTHhzDtH6f8gdL8YfLZnpW11GfxrFH
         9T3Q==
X-Gm-Message-State: AOAM531XmVI/ka7k41elvHbZMWb+nkUaGW89fqAReg58r/dIc2kUhITF
        9a8udWrYl/sZ4hqW1CCXIt6z8zYgCzFI2Eczbk1mx7MFaeGiCcT7Q8K9xraahp5uJ90Enav45qz
        /POeyiuv68WQ872eg3BEf3NU4vTHPpFEvj5CEi9BWHg==
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr20797119oto.95.1593002151759;
        Wed, 24 Jun 2020 05:35:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX1TWYnFwEpwDI3Wr6NaU8l9Igwlb4//wePGQRtnuC7RPWRAmd3PhYKW23yN302Duu4KI+Bsz7H4/6MJejzh8=
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr20797107oto.95.1593002151523;
 Wed, 24 Jun 2020 05:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org> <20200622003215.GC2040@dread.disaster.area>
 <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com> <20200622181338.GA21350@casper.infradead.org>
In-Reply-To: <20200622181338.GA21350@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 24 Jun 2020 14:35:40 +0200
Message-ID: <CAHc6FU7R2vMZ9+aXLsQ+ubECbfrBTR+yh03b_T++PRxd479vsQ@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 8:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jun 22, 2020 at 04:35:05PM +0200, Andreas Gruenbacher wrote:
> > I'm fine with not moving that functionality into the VFS. The problem
> > I have in gfs2 is that taking glocks is really expensive. Part of that
> > overhead is accidental, but we definitely won't be able to fix it in
> > the short term. So something like the IOCB_CACHED flag that prevents
> > generic_file_read_iter from issuing readahead I/O would save the day
> > for us. Does that idea stand a chance?
>
> For the short-term fix, is switching to a trylock in gfs2_readahead()
> acceptable?

Well, it's the only thing we can do for now, right?

> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 72c9560f4467..6ccd478c81ff 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -600,7 +600,7 @@ static void gfs2_readahead(struct readahead_control *rac)
>         struct gfs2_inode *ip = GFS2_I(inode);
>         struct gfs2_holder gh;
>
> -       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> +       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_TRY, &gh);
>         if (gfs2_glock_nq(&gh))
>                 goto out_uninit;
>         if (!gfs2_is_stuffed(ip))

Thanks,
Andreas

