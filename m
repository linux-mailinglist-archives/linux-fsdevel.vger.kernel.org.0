Return-Path: <linux-fsdevel+bounces-22300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5BC9161E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EAA2862F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692D149C62;
	Tue, 25 Jun 2024 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVdoImMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EE1494A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306452; cv=none; b=ueW5n+LxYFnXRDG6FMNP2qap40zRfM4a5aZio5y8p+DoO3viSNcSlRBqwUN0mJavIKJqwAeTb8GAnRxVfjnXK6haMgevge9+P5s/+8DFIxE5bW3pnHUCBUjQSLcqfayBFwLicttdrbkf/56Qxzi41CKYq9iy73fnp6e4ypPQECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306452; c=relaxed/simple;
	bh=wFwYowz7Dl6VAlaWIslldOW6InGRGZjbxpGMyvu7qBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIr1na9dvglvksIhMZjWpeI1+JoXi6klRiwt5c5O532lygEvGvAgz+9m+Zz5oZJ5HrLn/z33+oRVhXzbiLz3drCdURsaZ1VACotzTj2KhyfZoThu3lFbHjXr8DkMULHukfmqPlHP1VxkZawUQs0aus4ipQK7Kvh0fX3YGf+Ds5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVdoImMc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719306449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5gIbstmYx7+hVakYhvJm3/I7jrdwPXMN2vBR3BGT10=;
	b=RVdoImMccqRzRGCapbMG0ABfCDIbjb455gTD/mn9ZbdLfJpmZmMwZFjBglvibgCumHnUVX
	0ncyS2T7+aki+S8EyfBdXfMv9XNFe/LcGSrWA2RLZIRQA4GkldCt/srpV9K8z7JJd/fMAw
	2x54o1pUfC0GjTygtE89lFcrL+MNYKY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-Qm534JkkMrG-56Hj37KU5w-1; Tue,
 25 Jun 2024 05:07:20 -0400
X-MC-Unique: Qm534JkkMrG-56Hj37KU5w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A9931956050;
	Tue, 25 Jun 2024 09:07:18 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.67.24.180])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5AC11954AC0;
	Tue, 25 Jun 2024 09:07:11 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	djwong@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	torvalds@linux-foundation.org,
	zhenyzha@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 1/4] mm/filemap: Make MAX_PAGECACHE_ORDER acceptable to xarray
Date: Tue, 25 Jun 2024 19:06:43 +1000
Message-ID: <20240625090646.1194644-2-gshan@redhat.com>
In-Reply-To: <20240625090646.1194644-1-gshan@redhat.com>
References: <20240625090646.1194644-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Fixes: 4f6617011910 ("filemap: Allow __filemap_get_folio to allocate large folios")
Cc: stable@kernel.org # v6.6+
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
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


