Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE33B20C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFWTGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 15:06:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37004 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWTGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 15:06:34 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id D3E8E20B83F5;
        Wed, 23 Jun 2021 12:04:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3E8E20B83F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624475056;
        bh=iqMYBX8gNJqygF5F9g1MwbXLNoGunuU4jx9xCfqhSX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f70CcZvM/X7fzhoqUcMyo7Roi1vV3/vgWgNEKgWo5+lETiBHk3BERcmLN8jUe2Fps
         xMnNIdfI2QILIpkVmd2wWBudvWqVfJqhtoyRN2+Bmx0ysTjetGEQhorSEYYxJbz2Pt
         eznGGnjlr9NrhSpO9MCcHGvA/dHVsuPim7IsWm10=
Received: by mail-pl1-f181.google.com with SMTP id v12so1653329plo.10;
        Wed, 23 Jun 2021 12:04:16 -0700 (PDT)
X-Gm-Message-State: AOAM530ySDJmbQ2tUKCfRsBa5kFZIeJYXPbSL1K3wzxx+uwMuGcx3rG5
        UutYrVMrqGAhpF60I6XwGgCqstcn/AMzqP6lE1s=
X-Google-Smtp-Source: ABdhPJz7IFiXQyTVrVydscmqOnQmgiIcflbsxtRx4Tot0Tc0Fti2nXFcTJ0ZQbo4ObI6ragERNkM1cn9NgR3bmygy2Q=
X-Received: by 2002:a17:902:e9d5:b029:124:926:7971 with SMTP id
 21-20020a170902e9d5b029012409267971mr816793plk.19.1624475056368; Wed, 23 Jun
 2021 12:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-4-mcroce@linux.microsoft.com> <YNMgmK2vqQPL7PWb@infradead.org>
In-Reply-To: <YNMgmK2vqQPL7PWb@infradead.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 21:03:40 +0200
X-Gmail-Original-Message-ID: <CAFnufp3=2Jhr9NqVhE2nCLcr48UvxVww=RpWHp2wpm7DWwGuEA@mail.gmail.com>
Message-ID: <CAFnufp3=2Jhr9NqVhE2nCLcr48UvxVww=RpWHp2wpm7DWwGuEA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] block: refactor sysfs code
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Javier Gonz??lez" <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 1:53 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > -static void disk_add_events(struct gendisk *disk)
> > +static void disk_add_sysfs(struct gendisk *disk)
> >  {
> >       /* FIXME: error handling */
> > -     if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
> > +     if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs) < 0)
> >               pr_warn("%s: failed to create sysfs files for events\n",
> >                       disk->disk_name);
> > +}
>
> Actually, what we need here is a way how we can setup the ->groups
> field of the device to include all attribute groups instead of having
> to call sysfs_create_files at all.

I don't get this one. You mean in general or in this series?

-- 
per aspera ad upstream
