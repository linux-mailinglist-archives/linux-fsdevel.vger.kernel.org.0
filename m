Return-Path: <linux-fsdevel+bounces-586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23B7CD29E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 05:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03853B211A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39905249;
	Wed, 18 Oct 2023 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fasvnEde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8414436
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 03:19:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58649FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697599143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zVoFF6aUxd9VaJA+YrLxhoeUc7CrRCl7wEDGMfXOIc=;
	b=fasvnEdejbSWyFSdMb4LrGWCTtr/ME8H2tk1WerK4n518Ii1GMN1rzE7A6YvX9o+dM3hIs
	Mtc8r0FOHNQpg1Y/zApZE4VRITxPGaRR+wRHKoK60/knnm1w2GcCRuukk7dzR/XSrmhQ3U
	mAXNny1cd5gIGR0ROzBN8CaM9Pp3PAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-YAMtSfHVPQqLcrpN2E1-AA-1; Tue, 17 Oct 2023 23:18:48 -0400
X-MC-Unique: YAMtSfHVPQqLcrpN2E1-AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96417101FA22;
	Wed, 18 Oct 2023 03:18:47 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 19A2E1121314;
	Wed, 18 Oct 2023 03:18:42 +0000 (UTC)
Date: Wed, 18 Oct 2023 11:18:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] block: assert that we're not holding open_mutex over
 blk_report_disk_dead
Message-ID: <ZS9OjlDuELDHJ4XM@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:48:22PM +0200, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> blk_report_disk_dead() has the following major callers:
> 
> (1) del_gendisk()
> (2) blk_mark_disk_dead()
> 
> Since del_gendisk() acquires disk->open_mutex it's clear that all
> callers are assumed to be called without disk->open_mutex held.
> In turn, blk_report_disk_dead() is called without disk->open_mutex held
> in del_gendisk().
> 
> All callers of blk_mark_disk_dead() call it without disk->open_mutex as
> well.
> 
> Ensure that it is clear that blk_report_disk_dead() is called without
> disk->open_mutex on purpose by asserting it and a comment in the code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 4a16a424f57d4f..c9d06f72c587e8 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -559,6 +559,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
>  	struct block_device *bdev;
>  	unsigned long idx;
>  
> +	/*
> +	 * On surprise disk removal, bdev_mark_dead() may call into file
> +	 * systems below. Make it clear that we're expecting to not hold
> +	 * disk->open_mutex.
> +	 */
> +	lockdep_assert_not_held(&disk->open_mutex);
> +
>  	rcu_read_lock();
>  	xa_for_each(&disk->part_tbl, idx, bdev) {
>  		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks, 
Ming


