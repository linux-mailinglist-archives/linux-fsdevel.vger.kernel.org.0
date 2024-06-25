Return-Path: <linux-fsdevel+bounces-22303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC49161F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A6C1C23A4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E111494AC;
	Tue, 25 Jun 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtBA3hco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8614901B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306469; cv=none; b=enohbcOsU2DQ2sq4WLhP0PMAgpbNfxxw+n9QV086UgR7YL2YxM9cssMI2hd52YeOh9o64e7mgUq+hnH8yUH7fsG1Wv0oQApqldwZbiYhTrqdZx3RwjWV8fGc4KzckYlO6MnyCtMuNiXEvSdFw4Jmn0rq0S8k/kuO+YoDzL09ASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306469; c=relaxed/simple;
	bh=Reb8FXWE1bNKYcROb75ET4K21cBg7dj9GL79z7/FvFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0qT6ixm4BmzAXurJLXnnu7pocRSnLk/VAI/piJCWA0H8gUVqEWMTIz4v7Z3m8nneMYwUOt/7TsloN7to32Cl2mmO7Zn6Otqya1NF5DKJGW8cLT0Jo0Btu1YU/DtR//O0uGSaw3CkYn7YKfULIIvpyustB+8al5Nf+sEvwvQZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtBA3hco; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719306467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGvYW01hrriXIF+o1pxrfngY25C2k8nRiGAXWHuPddk=;
	b=TtBA3hco7pPZYCBiweIyrL0wsaHj9tTMSmakJuH7wU54LtvwgjETrRWjNIoK84iTvSvQmD
	ruPL9bXOrF+YUr3YMJjqpOgpSwDu8qZrR4/Ux8FEwHx/pIF8O/W9LTIqmkr36Y06vDjECo
	M05SASROt8m/y8rIRGjKyJjLXNNBJ2o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-6AGImXKrPlyqhXgDXD6VTQ-1; Tue,
 25 Jun 2024 05:07:41 -0400
X-MC-Unique: 6AGImXKrPlyqhXgDXD6VTQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36A681955DCE;
	Tue, 25 Jun 2024 09:07:40 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.67.24.180])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 282E41956087;
	Tue, 25 Jun 2024 09:07:33 +0000 (UTC)
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
Subject: [PATCH 4/4] mm/shmem: Disable PMD-sized page cache if needed
Date: Tue, 25 Jun 2024 19:06:46 +1000
Message-ID: <20240625090646.1194644-5-gshan@redhat.com>
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

For shmem files, it's possible that PMD-sized page cache can't be
supported by xarray. For example, 512MB page cache on ARM64 when
the base page size is 64KB can't be supported by xarray. It leads
to errors as the following messages indicate when this sort of xarray
entry is split.

WARNING: CPU: 34 PID: 7578 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6   \
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject        \
nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4  \
ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm fuse xfs  \
libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_net \
net_failover virtio_console virtio_blk failover dimlib virtio_mmio
CPU: 34 PID: 7578 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #9
Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : xas_split_alloc+0xf8/0x128
lr : split_huge_page_to_list_to_order+0x1c4/0x720
sp : ffff8000882af5f0
x29: ffff8000882af5f0 x28: ffff8000882af650 x27: ffff8000882af768
x26: 0000000000000cc0 x25: 000000000000000d x24: ffff00010625b858
x23: ffff8000882af650 x22: ffffffdfc0900000 x21: 0000000000000000
x20: 0000000000000000 x19: ffffffdfc0900000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000018000000000 x15: 52f8004000000000
x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
x11: 52f8000000000000 x10: 52f8e1c0ffff6000 x9 : ffffbeb9619a681c
x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff00010b02ddb0
x5 : ffffbeb96395e378 x4 : 0000000000000000 x3 : 0000000000000cc0
x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
Call trace:
 xas_split_alloc+0xf8/0x128
 split_huge_page_to_list_to_order+0x1c4/0x720
 truncate_inode_partial_folio+0xdc/0x160
 shmem_undo_range+0x2bc/0x6a8
 shmem_fallocate+0x134/0x430
 vfs_fallocate+0x124/0x2e8
 ksys_fallocate+0x4c/0xa0
 __arm64_sys_fallocate+0x24/0x38
 invoke_syscall.constprop.0+0x7c/0xd8
 do_el0_svc+0xb4/0xd0
 el0_svc+0x44/0x1d8
 el0t_64_sync_handler+0x134/0x150
 el0t_64_sync+0x17c/0x180

Fix it by disabling PMD-sized page cache when HPAGE_PMD_ORDER is
larger than MAX_PAGECACHE_ORDER.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/shmem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a8b181a63402..5453875e3810 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -541,8 +541,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-		   struct mm_struct *mm, unsigned long vm_flags)
+static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
+			    bool shmem_huge_force, struct mm_struct *mm,
+			    unsigned long vm_flags)
 {
 	loff_t i_size;
 
@@ -573,6 +574,16 @@ bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
 	}
 }
 
+bool shmem_is_huge(struct inode *inode, pgoff_t index,
+		   bool shmem_huge_force, struct mm_struct *mm,
+		   unsigned long vm_flags)
+{
+	if (!__shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags))
+		return false;
+
+	return HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER;
+}
+
 #if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
-- 
2.45.1


