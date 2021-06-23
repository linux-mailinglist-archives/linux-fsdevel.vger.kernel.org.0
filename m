Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80553B1ACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFWNNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 09:13:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48892 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWNNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:13:15 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id B430320B6AEE;
        Wed, 23 Jun 2021 06:10:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B430320B6AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624453857;
        bh=X0fsfcHKZT74HvXRviTlryAaKv2AtX1mjJYmSzENvUc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MiT/3muhlL9+IGywtJkQ2n5Qc/WNSVUoWcjCorFidH/MWy3QWmvIl23/J4G5/Xksj
         /J6YvXcn5iJzTLaA04sU7h5hGWF2UPoHhSwdHUudQCH5yjI8O3ynqw97vBxgo3RxG7
         fi+6Y1zPqIcY3IJ5ty7ftNtltnFmaHrCpv7ZF458=
Received: by mail-pf1-f176.google.com with SMTP id i6so2303935pfq.1;
        Wed, 23 Jun 2021 06:10:57 -0700 (PDT)
X-Gm-Message-State: AOAM531ZeHqYFzy9hVmntGjs32cow6pvKpMsFm8nRgJiZG6hTNZ/hp1i
        DQjMc0wsBKIjjzPAQQlIV5w/GUXRVoeYGGCQBZM=
X-Google-Smtp-Source: ABdhPJyJo3O9WtPdcoiaPiQCJ9HGOrBerIX/T5tIZdcD7UilkOswt+R/OQZdZqOaDYgDVaHliptWFpGGtVhfdlw62G4=
X-Received: by 2002:a05:6a00:17a5:b029:305:d4e8:7391 with SMTP id
 s37-20020a056a0017a5b0290305d4e87391mr6751150pfg.0.1624453857011; Wed, 23 Jun
 2021 06:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com> <YNMffBWvs/Fz2ptK@infradead.org>
In-Reply-To: <YNMffBWvs/Fz2ptK@infradead.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 15:10:21 +0200
X-Gmail-Original-Message-ID: <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
Message-ID: <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
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

On Wed, Jun 23, 2021 at 1:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 23, 2021 at 12:58:53PM +0200, Matteo Croce wrote:
> > +void inc_diskseq(struct gendisk *disk)
> > +{
> > +     static atomic64_t diskseq;
>
> Please don't hide file scope variables in functions.
>

I just didn't want to clobber that file namespace, as that is the only
point where it's used.

> Can you explain a little more why we need a global sequence count vs
> a per-disk one here?

The point of the whole series is to have an unique sequence number for
all the disks.
Events can arrive to the userspace delayed or out-of-order, so this
helps to correlate events to the disk.
It might seem strange, but there isn't a way to do this yet, so I come
up with a global, monotonically incrementing number.

-- 
per aspera ad upstream
