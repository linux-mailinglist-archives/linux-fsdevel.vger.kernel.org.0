Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1893EF432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhHQUmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 16:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhHQUmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629232909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wcl4Dsri643WTYT2ZVvqT65s7dgjheTTZlEE7QZJGi0=;
        b=cNtDwZv4I4gzlWlDkcuA9A8LcgnZ4nw7NmBcLOF6+OpgDv2ZO6OSlF8ZxXpuRNPNW729wm
        NZ+/1UVLUp0NF37JD2i31SjDARtkfuLT0GtjFQeMWfqwd0EVJvlTXnWDq3bqn9NFAZAPVV
        x1iL3DKXFcCXS3maVooTmvdX5SrfWSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-OibFsp8zNtK8OL7wOrtR7Q-1; Tue, 17 Aug 2021 16:41:46 -0400
X-MC-Unique: OibFsp8zNtK8OL7wOrtR7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08F51082925;
        Tue, 17 Aug 2021 20:41:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3995E60BF4;
        Tue, 17 Aug 2021 20:41:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 17HKfZQS031822;
        Tue, 17 Aug 2021 16:41:35 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 17HKfZrZ031818;
        Tue, 17 Aug 2021 16:41:35 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 17 Aug 2021 16:41:35 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Bart Van Assche <bvanassche@acm.org>
cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        djwong@kernel.org, Mike Snitzer <snitzer@redhat.com>,
        agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, nitheshshetty@gmail.com,
        joshi.k@samsung.com, javier.gonz@samsung.com,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
In-Reply-To: <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
Message-ID: <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com> <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com> <20210817101423.12367-4-selvakuma.s1@samsung.com> <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 17 Aug 2021, Bart Van Assche wrote:

> On 8/17/21 3:14 AM, SelvaKumar S wrote:
> > Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> > bio with control information as payload and submit to the device.
> > Larger copy operation may be divided if necessary by looking at device
> > limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
> > submitted to zoned device.
> > Native copy offload is not supported for stacked devices.
> 
> Using a single operation for copy-offloading instead of separate operations
> for reading and writing is fundamentally incompatible with the device mapper.
> I think we need a copy-offloading implementation that is compatible with the
> device mapper.

I once wrote a copy offload implementation that is compatible with device 
mapper. The copy operation creates two bios (one for reading and one for 
writing), passes them independently through device mapper and pairs them 
at the physical device driver.

It's here: http://people.redhat.com/~mpatocka/patches/kernel/xcopy/current

I verified that it works with iSCSI. Would you be interested in continuing 
this work?

Mikulas

> Storing the parameters of the copy operation in the bio payload is
> incompatible with the current implementation of bio_split().
> 
> In other words, I think there are fundamental problems with this patch series.
> 
> Bart.
> 

