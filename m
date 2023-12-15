Return-Path: <linux-fsdevel+bounces-6163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474E813FBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 03:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B124D1C221BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 02:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C48110C;
	Fri, 15 Dec 2023 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/sN+wwe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAE809
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702607299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgS/vwRdBBmypWL18nvZwV/FWJEphVJ/VHhyXn/HPOs=;
	b=V/sN+wweSiScI6kqCVUd97N5EqvFjFgJOyg4yora1r2gDmQtEXIlzpQcPLwfjXmctxUizR
	qLOCym46f9NnZU+Kg5gpNH7bHFU4oNEWj9zGbQ7hfLtSj0CC67UHnL1KPS4YQR7ZNOMLxg
	7R+J1Bh1s5gdyNrYAQnBptoK8tmPxG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-mSb3xmusMoa9ZEZVR7neRw-1; Thu, 14 Dec 2023 21:28:16 -0500
X-MC-Unique: mSb3xmusMoa9ZEZVR7neRw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00C1880BEC3;
	Fri, 15 Dec 2023 02:28:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E7A71492BC6;
	Fri, 15 Dec 2023 02:28:04 +0000 (UTC)
Date: Fri, 15 Dec 2023 10:27:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	jaswin@linux.ibm.com, bvanassche@acm.org, ming.lei@redhat.com
Subject: Re: [PATCH v2 08/16] block: Limit atomic write IO size according to
 atomic_write_max_sectors
Message-ID: <ZXu5rykouOcNOSa1@fedora>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-9-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Tue, Dec 12, 2023 at 11:08:36AM +0000, John Garry wrote:
> Currently an IO size is limited to the request_queue limits max_sectors.
> Limit the size for an atomic write to queue limit atomic_write_max_sectors
> value.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/blk-merge.c | 12 +++++++++++-
>  block/blk.h       |  3 +++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 0ccc251e22ff..8d4de9253fe9 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -171,7 +171,17 @@ static inline unsigned get_max_io_size(struct bio *bio,
>  {
>  	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
>  	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
> -	unsigned max_sectors = lim->max_sectors, start, end;
> +	unsigned max_sectors, start, end;
> +
> +	/*
> +	 * We ignore lim->max_sectors for atomic writes simply because
> +	 * it may less than bio->write_atomic_unit, which we cannot
> +	 * tolerate.
> +	 */
> +	if (bio->bi_opf & REQ_ATOMIC)
> +		max_sectors = lim->atomic_write_max_sectors;
> +	else
> +		max_sectors = lim->max_sectors;

I can understand the trouble for write atomic from bio split, which
may simply split in the max_sectors boundary, however this change is
still too fragile:

1) ->max_sectors may be set from userspace
- so this change simply override userspace setting

2) otherwise ->max_sectors is same with ->max_hw_sectors:

- then something must be wrong in device side or driver side because
->write_atomic_unit conflicts with ->max_hw_sectors, which is supposed
to be figured out before device is setup

3) too big max_sectors may break driver or device, such as nvme-pci
aligns max_hw_sectors with DMA optimized mapping size

And there might be more(better) choices:

1) make sure atomic write limit is respected when userspace updates
->max_sectors

2) when driver finds that atomic write limits conflict with other
existed hardware limits, fail or solve(such as reduce write atomic unit) the
conflict before queue is started; With single write atomic limits update API,
the conflict can be figured out earlier by block layer too.



thanks, 
Ming


