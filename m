Return-Path: <linux-fsdevel+bounces-78375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL0wH2j5nmm+YAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:30:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC95C19815D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91113183FF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB363B8D40;
	Wed, 25 Feb 2026 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PysBdkzu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A917BB21;
	Wed, 25 Feb 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025938; cv=none; b=DLrxO4WudvBCE8jpY27IjM62fd6cIWxOXM20CaFLAwP6EppwDD3/G2goGYovmh44hDtWR+2OqBky5mWRgc3CXeXjp/81tsKsrXWq5ldGEMtBuFNEKNAfJIBbE7fE9HeZXTgsdKm/d9mAKqW/ibj5v5WBYMFNf6ftDbAd4+EJBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025938; c=relaxed/simple;
	bh=ipECqI7cd59CYi34i5Y36GacUMUAmIYn8MWSFPiNvVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnjCb6UobKpfatQjrrmZwCSs2G0fHFNtlMIGjWNq7yLuvDGDsrX+v8IisW8ZY2VKPBtn4nCtdCffqfLBON57rOf6EoBFdVJwoYj44WY/YF40r7MFzZ5fyTEXIYN6iRpwqglxAGouegjeydPzwH7rhopzxRz6W2sDhm5n3uQ2qVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PysBdkzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B242C116D0;
	Wed, 25 Feb 2026 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025938;
	bh=ipECqI7cd59CYi34i5Y36GacUMUAmIYn8MWSFPiNvVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PysBdkzuyhh3S4Nucw+rxb56SeX2b3mqivj7ctxoNnKqPHUxnglSOPRYRKzhYEY2D
	 bKuyCisfsgVXJ5Hx1f8yksOn64Z1yBLgbhaOjKZjuxU0c6fL/5DocrOpjPVCEZDw4j
	 dDf9q7Kk+zHoCRe1RNCzRVnLrxrt1jEx8aJRZLbUZ4aYpDWLo+QYvNasm1u7viTs5c
	 0jCIpAcJrKc3Ba1v972+uBYxjZT2w34P9I7TVuqB9MSqXrgulDFerdMGnbct+CvF9a
	 rUZQxOlrnI7rhIy83nGK46N0ubEB+if72a4oIRxIGKh1zoUUgG2APZQq28LmP6HEv+
	 SO65WR7jGCEJA==
Date: Wed, 25 Feb 2026 08:25:37 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	changfengnan@bytedance.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffer: fix kmemleak false positive in submit_bh_wbc
Message-ID: <aZ74UbGA261L4mxQ@laps>
References: <20260224190637.3279019-1-sashal@kernel.org>
 <825ab511-9335-4827-a3fd-6dd6f498326e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <825ab511-9335-4827-a3fd-6dd6f498326e@kernel.dk>
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
	TAGGED_FROM(0.00)[bounces-78375-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC95C19815D
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:57:35PM -0700, Jens Axboe wrote:
>On 2/24/26 12:06 PM, Sasha Levin wrote:
>> Bios allocated in submit_bh_wbc are properly freed via their end_io
>> handler. Since commit 48f22f80938d, bio_put() caches them in a per-CPU
>> bio cache for reuse rather than freeing them back to the mempool.
>> While cached bios are reachable by kmemleak via the per-CPU cache
>> pointers, once recycled for new I/O they are only referenced by block
>> layer internals that kmemleak does not scan, causing false positive
>> leak reports.
>>
>> Mark the bio allocation with kmemleak_not_leak() to suppress the false
>> positive.
>>
>> Fixes: 48f22f80938d ("block: enable per-cpu bio cache by default")
>> Assisted-by: Claude:claude-opus-4-6
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/buffer.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index 22b43642ba574..c298df6c7f8c6 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -49,6 +49,7 @@
>>  #include <linux/sched/mm.h>
>>  #include <trace/events/block.h>
>>  #include <linux/fscrypt.h>
>> +#include <linux/kmemleak.h>
>>  #include <linux/fsverity.h>
>>  #include <linux/sched/isolation.h>
>>
>> @@ -2799,6 +2800,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>>  		opf |= REQ_PRIO;
>>
>>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>> +	kmemleak_not_leak(bio);
>>
>>  	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
>
>What if they do end up getting leaked? This seems like an odd

I was under the impression that kmemleak doesn't really track much under the
hood of the block layer to begin with, but looking at the code I'm probably
wrong.

>work-around, would be better to ensure the caching side marks them as
>in-use when grabbed and freed when put.

Something like:?

diff --git a/block/bio.c b/block/bio.c
index d80d5d26804e3..45a19de02eca6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -17,6 +17,7 @@
  #include <linux/cgroup.h>
  #include <linux/highmem.h>
  #include <linux/blk-crypto.h>
+#include <linux/kmemleak.h>
  #include <linux/xarray.h>
  
  #include <trace/events/block.h>
@@ -504,6 +505,9 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
         cache->nr--;
         put_cpu();
  
+       kmemleak_alloc((void *)bio - bs->front_pad,
+                      kmem_cache_size(bs->bio_slab), 1, gfp);
+
         if (nr_vecs)
                 bio_init_inline(bio, bdev, nr_vecs, opf);
         else
@@ -765,6 +769,9 @@ static int __bio_alloc_cache_prune(struct bio_alloc_cache *cache,
         while ((bio = cache->free_list) != NULL) {
                 cache->free_list = bio->bi_next;
                 cache->nr--;
+               kmemleak_alloc((void *)bio - bio->bi_pool->front_pad,
+                              kmem_cache_size(bio->bi_pool->bio_slab),
+                              1, GFP_NOWAIT);
                 bio_free(bio);
                 if (++i == nr)
                         break;
@@ -823,6 +830,7 @@ static inline void bio_put_percpu_cache(struct bio *bio)
  
         if (in_task()) {
                 bio_uninit(bio);
+               kmemleak_free((void *)bio - bio->bi_pool->front_pad);
                 bio->bi_next = cache->free_list;
                 /* Not necessary but helps not to iopoll already freed bios */
                 bio->bi_bdev = NULL;
@@ -832,6 +840,7 @@ static inline void bio_put_percpu_cache(struct bio *bio)
                 lockdep_assert_irqs_disabled();
  
                 bio_uninit(bio);
+               kmemleak_free((void *)bio - bio->bi_pool->front_pad);
                 bio->bi_next = cache->free_list_irq;
                 cache->free_list_irq = bio;
                 cache->nr_irq++;

-- 
Thanks,
Sasha

