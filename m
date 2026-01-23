Return-Path: <linux-fsdevel+bounces-75177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLZXGt+8cmklpAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:12:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57286EB62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF3B300DF44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E928DB76;
	Fri, 23 Jan 2026 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIiFnBTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7D2F25F5;
	Fri, 23 Jan 2026 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769127113; cv=none; b=LD6drRrXcMPO9a1XKLnHKaDg70NaqD50KQFUXbQg0+I0manjznRPJe8Mpu2F5XDCGwyk4fq5lwU026vCMUill009wvM3Ho3fcNWhily+kQvcKP/kDPt8fXT8ymqMnRRnhZFiYxzB7uVXeROSJhR6DzDER0GgehtdR1kL4W8u12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769127113; c=relaxed/simple;
	bh=W0l8rkdl/NphprkLF/MG7YFKFxORfE9biiB9GZtSY2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeYcslNjFA/FfFHrbAWqulX+7VTyxdQwerE1HfTAw5CkeXjQv3b/lSgcX3n4B/aO7r7lRQC/JkQUQkwpSEYsxTE4rmXeFBBpvI8fDi7tQKt8R1BlvmoEOj+0+z0K6OLNDkB1zJzVMv43Mk935yo+u3HPcoBWX09eP8B8w8bTswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIiFnBTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576F7C116C6;
	Fri, 23 Jan 2026 00:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769127111;
	bh=W0l8rkdl/NphprkLF/MG7YFKFxORfE9biiB9GZtSY2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIiFnBToxYE01ZXyMMjqfJy+5cYgiK8Xq2CVVUeoOPMSjn602pBJ75WRufgeQmmWq
	 VO/A5qmTBPV5fHj0tS75TgiQBxdI3/vNJmx3X89C40BfxVcGvzhNLQ6K6905qRkZqd
	 Zcb2u4YR/ZJDdWFFoMcJvmkh+JdxJifCGYFQTAk/Xp1x8YbP/vBpn/ARZG1jIWK31H
	 YT4U1y3QM3cgXqxzbO2E5BNOG9yTb3vbVl3hKSBg25FiYvHi/0VR9NXHxQBT8BPim1
	 dtc3GWbAAy0vf+4QFj3hv1DhE14gPq/IhQbIamSsjpsMvKPDClJWsye4MDUmyh8avV
	 wE7a+nylyQJjQ==
Date: Thu, 22 Jan 2026 16:11:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/15] block: add fs_bio_integrity helpers
Message-ID: <20260123001150.GK5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-7-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75177-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: E57286EB62
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:14AM +0100, Christoph Hellwig wrote:
> Add a set of helpers for file system initiated integrity information.
> These include mempool backed allocations and verifying based on a passed
> in sector and size which is often available from file system completion
> routines.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/Makefile                |  2 +-
>  block/bio-integrity-fs.c      | 81 +++++++++++++++++++++++++++++++++++
>  include/linux/bio-integrity.h |  6 +++
>  3 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 block/bio-integrity-fs.c
> 
> diff --git a/block/Makefile b/block/Makefile
> index c65f4da93702..7dce2e44276c 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -26,7 +26,7 @@ bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
>  obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
>  
>  obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o \
> -				   bio-integrity-auto.o
> +				   bio-integrity-auto.o bio-integrity-fs.o
>  obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
>  obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
>  obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
> diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
> new file mode 100644
> index 000000000000..c8b3c753965d
> --- /dev/null
> +++ b/block/bio-integrity-fs.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Christoph Hellwig.
> + */
> +#include <linux/blk-integrity.h>
> +#include <linux/bio-integrity.h>
> +#include "blk.h"
> +
> +struct fs_bio_integrity_buf {
> +	struct bio_integrity_payload	bip;
> +	struct bio_vec			bvec;
> +};
> +
> +static struct kmem_cache *fs_bio_integrity_cache;
> +static mempool_t fs_bio_integrity_pool;
> +
> +void fs_bio_integrity_alloc(struct bio *bio)
> +{
> +	struct fs_bio_integrity_buf *iib;
> +	unsigned int action;
> +
> +	action = bio_integrity_action(bio);
> +	if (!action)
> +		return;
> +
> +	iib = mempool_alloc(&fs_bio_integrity_pool, GFP_NOIO);
> +	bio_integrity_init(bio, &iib->bip, &iib->bvec, 1);
> +
> +	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
> +	if (action & BI_ACT_CHECK)
> +		bio_integrity_setup_default(bio);
> +}
> +
> +void fs_bio_integrity_free(struct bio *bio)
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	bio_integrity_free_buf(bip);
> +	mempool_free(container_of(bip, struct fs_bio_integrity_buf, bip),
> +			&fs_bio_integrity_pool);
> +
> +	bio->bi_integrity = NULL;
> +	bio->bi_opf &= ~REQ_INTEGRITY;
> +}
> +
> +void fs_bio_integrity_generate(struct bio *bio)
> +{
> +	fs_bio_integrity_alloc(bio);
> +	bio_integrity_generate(bio);
> +}
> +EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
> +
> +int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
> +{
> +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	/*
> +	 * Reinitialize bip->bit_iter.

s/bit_iter/bip_iter/ ?

With that fixed, this looks fine to me;
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	 *
> +	 * This is for use in the submitter after the driver is done with the
> +	 * bio. Requires the submitter to remember the sector and the size.
> +	 */
> +
> +	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
> +	bip->bip_iter.bi_sector = sector;
> +	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
> +	return blk_status_to_errno(bio_integrity_verify(bio, &bip->bip_iter));
> +}
> +
> +static int __init fs_bio_integrity_init(void)
> +{
> +	fs_bio_integrity_cache = kmem_cache_create("fs_bio_integrity",
> +			sizeof(struct fs_bio_integrity_buf), 0,
> +			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
> +	if (mempool_init_slab_pool(&fs_bio_integrity_pool, BIO_POOL_SIZE,
> +			fs_bio_integrity_cache))
> +		panic("fs_bio_integrity: can't create pool\n");
> +	return 0;
> +}
> +fs_initcall(fs_bio_integrity_init);
> diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
> index 232b86b9bbcb..503dc9bc655d 100644
> --- a/include/linux/bio-integrity.h
> +++ b/include/linux/bio-integrity.h
> @@ -145,4 +145,10 @@ void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer);
>  void bio_integrity_free_buf(struct bio_integrity_payload *bip);
>  void bio_integrity_setup_default(struct bio *bio);
>  
> +void fs_bio_integrity_alloc(struct bio *bio);
> +void fs_bio_integrity_free(struct bio *bio);
> +void fs_bio_integrity_generate(struct bio *bio);
> +int fs_bio_integrity_verify(struct bio *bio, sector_t sector,
> +		unsigned int size);
> +
>  #endif /* _LINUX_BIO_INTEGRITY_H */
> -- 
> 2.47.3
> 
> 

