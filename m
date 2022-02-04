Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FF4A98F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 13:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbiBDMJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 07:09:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbiBDMJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643976560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ug0j2D3hPaBD8ARb0/WmIlQ1wD9LKsRfGtTL8Fytta4=;
        b=S4tQTZoquoa0YKgJqGwAh0N92aApu1xObcP7BqqwbzpdTdv1VS0ZA1BUFi/SfnPmMOkB7V
        V92Kf5+iOVd+i7PRDnjQHRh6ts3qLikL2qb0FI6J/1gPaxj3cEjm2S48Q1DdT9KAln1/DW
        NMn3WCOwrF8db7FcxWStD0lN52FNOps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-F7yHxsWwMP2s-ecdrp4ehg-1; Fri, 04 Feb 2022 07:09:19 -0500
X-MC-Unique: F7yHxsWwMP2s-ecdrp4ehg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B182B8145E0;
        Fri,  4 Feb 2022 12:09:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 914F178A9E;
        Fri,  4 Feb 2022 12:09:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 214C99wH019986;
        Fri, 4 Feb 2022 07:09:09 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 214C97pr019978;
        Fri, 4 Feb 2022 07:09:07 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 4 Feb 2022 07:09:07 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
In-Reply-To: <a2ec9086-72d2-4a4e-c4fa-fe53bf5ba092@acm.org>
Message-ID: <alpine.LRH.2.02.2202040657060.19134@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <20220201102122.4okwj2gipjbvuyux@mpHalley-2> <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <efd2e976-4d2d-178e-890d-9bde1a89c47f@acm.org> <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com> <a2ec9086-72d2-4a4e-c4fa-fe53bf5ba092@acm.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 3 Feb 2022, Bart Van Assche wrote:

> On 2/3/22 10:50, Mikulas Patocka wrote:
> > On Tue, 1 Feb 2022, Bart Van Assche wrote:
> > > On 2/1/22 10:32, Mikulas Patocka wrote:
> > > >    /**
> > > > + * blk_queue_max_copy_sectors - set maximum copy offload sectors for
> > > > the
> > > > queue
> > > > + * @q:  the request queue for the device
> > > > + * @size:  the maximum copy offload sectors
> > > > + */
> > > > +void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int
> > > > size)
> > > > +{
> > > > +	q->limits.max_copy_sectors = size;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);
> > > 
> > > Please either change the unit of 'size' into bytes or change its type into
> > > sector_t.
> > 
> > blk_queue_chunk_sectors, blk_queue_max_discard_sectors,
> > blk_queue_max_write_same_sectors, blk_queue_max_write_zeroes_sectors,
> > blk_queue_max_zone_append_sectors also have the unit of sectors and the
> > argument is "unsigned int". Should blk_queue_max_copy_sectors be
> > different?
> 
> As far as I know using the type sector_t for variables that represent a number
> of sectors is a widely followed convention:
> 
> $ git grep -w sector_t | wc -l
> 2575
> 
> I would appreciate it if that convention would be used consistently, even if
> that means modifying existing code.
> 
> Thanks,
> 
> Bart.

Changing the sector limit variables in struct queue_limits from unsigned 
int to sector_t would increase the size of the structure and its cache 
footprint.

And we can't send bios larger than 4GiB anyway because bi_size is 32-bit.

Jens, what do you think about it? Should the sectors limits be sector_t?

Mikulas

