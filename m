Return-Path: <linux-fsdevel+bounces-22558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3497919BCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46170285C0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08454C66;
	Thu, 27 Jun 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoWDNJ3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13707483
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448841; cv=none; b=m8N3UR/ouGG/ICnQb73JtZoeYQ/CvEWTjRVrKh5yA7Krr/0kiGzKF3Cub3nbphpfI5bdIscUVMuootekQ1p4q1cspPjvEGkF+NolYC6rXBUhN5oy1U3SIyvRgV9+kdhttsiL/XjdgceyzdIAeI6RuHORsOgJcx31EFlwgj/myVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448841; c=relaxed/simple;
	bh=QI4OJj6bqC7RbdFrzeSPY1kQx6AznnYD85GZ2Bx1ZJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMu6X8M4kKj1Y1m5JBalUjJLanJD+ud0kdqLwWSEeUAv5UjqtC87b0waSPbRCk7Ak9YMyx0gjlpxWJybgPNDt9mEPX6x7A0xeTXThawuvvYJqTC79Wb6hfw1PqjiI9UCeH8dJ3ylPntJRJHpZdB83Tbgov4AM0YmOGGdGZ06C18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoWDNJ3C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719448838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cpV/jEIS9qrEe5QTxZNnHiwX0lBBCb8zcjYRkQZwwU=;
	b=EoWDNJ3C1oSiT3efFMQyRQcqiAoj9vVgTfR33lfZd+QwpOxtE3sjepKVWgX07Z4qWY2vTS
	0zf7oggolI3JycqC720MQ9F6URRFBD/lUcBiMQCTemRD0QskfunfajVve5xJFuuf7Vp3YA
	/HpsKsYd+Z9TSZKZAghQqfFjOim6MfM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-_RHQC5QyOHSPUjOcIg_VlA-1; Wed,
 26 Jun 2024 20:40:32 -0400
X-MC-Unique: _RHQC5QyOHSPUjOcIg_VlA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9E3219560AF;
	Thu, 27 Jun 2024 00:40:29 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7490C1956087;
	Thu, 27 Jun 2024 00:40:22 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	hughd@google.com,
	william.kucharski@oracle.com,
	djwong@kernel.org,
	torvalds@linux-foundation.org,
	ddutile@redhat.com,
	zhenyzha@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 1/4] mm/filemap: Make MAX_PAGECACHE_ORDER acceptable to xarray
Date: Thu, 27 Jun 2024 10:39:49 +1000
Message-ID: <20240627003953.1262512-2-gshan@redhat.com>
In-Reply-To: <20240627003953.1262512-1-gshan@redhat.com>
References: <20240627003953.1262512-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The largest page cache order can be HPAGE_PMD_ORDER (13) on ARM64
with 64KB base page size. The xarray entry with this order can't
be split as the following error messages indicate.

------------[ cut here ]------------
WARNING: CPU: 35 PID: 7484 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib  \
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct    \
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4    \
ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm      \
fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64      \
sha1_ce virtio_net net_failover virtio_console virtio_blk failover \
dimlib virtio_mmio
CPU: 35 PID: 7484 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #9
Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : xas_split_alloc+0xf8/0x128
lr : split_huge_page_to_list_to_order+0x1c4/0x720
sp : ffff800087a4f6c0
x29: ffff800087a4f6c0 x28: ffff800087a4f720 x27: 000000001fffffff
x26: 0000000000000c40 x25: 000000000000000d x24: ffff00010625b858
x23: ffff800087a4f720 x22: ffffffdfc0780000 x21: 0000000000000000
x20: 0000000000000000 x19: ffffffdfc0780000 x18: 000000001ff40000
x17: 00000000ffffffff x16: 0000018000000000 x15: 51ec004000000000
x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
x11: 51ec000000000000 x10: 51ece1c0ffff8000 x9 : ffffbeb961a44d28
x8 : 0000000000000003 x7 : ffffffdfc0456420 x6 : ffff0000e1aa6eb8
x5 : 20bf08b4fe778fca x4 : ffffffdfc0456420 x3 : 0000000000000c40
x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
Call trace:
 xas_split_alloc+0xf8/0x128
 split_huge_page_to_list_to_order+0x1c4/0x720
 truncate_inode_partial_folio+0xdc/0x160
 truncate_inode_pages_range+0x1b4/0x4a8
 truncate_pagecache_range+0x84/0xa0
 xfs_flush_unmap_range+0x70/0x90 [xfs]
 xfs_file_fallocate+0xfc/0x4d8 [xfs]
 vfs_fallocate+0x124/0x2e8
 ksys_fallocate+0x4c/0xa0
 __arm64_sys_fallocate+0x24/0x38
 invoke_syscall.constprop.0+0x7c/0xd8
 do_el0_svc+0xb4/0xd0
 el0_svc+0x44/0x1d8
 el0t_64_sync_handler+0x134/0x150
 el0t_64_sync+0x17c/0x180

Fix it by decreasing MAX_PAGECACHE_ORDER to the largest supported order
by xarray. For this specific case, MAX_PAGECACHE_ORDER is dropped from
13 to 11 when CONFIG_BASE_SMALL is disabled.

Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@kernel.org # v5.18+
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pagemap.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 59f1df0cde5a..a0a026d2d244 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -354,11 +354,18 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  * a good order (that's 1MB if you're using 4kB pages)
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
 #else
-#define MAX_PAGECACHE_ORDER	8
+#define PREFERRED_MAX_PAGECACHE_ORDER	8
 #endif
 
+/*
+ * xas_split_alloc() does not support arbitrary orders. This implies no
+ * 512MB THP on ARM64 with 64KB base page size.
+ */
+#define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
+#define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
  * @mapping: The file.
-- 
2.45.1


