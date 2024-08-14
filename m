Return-Path: <linux-fsdevel+bounces-25963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D995237A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9FA1F22E73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16431C7B85;
	Wed, 14 Aug 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPzNxRGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD531C3F0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667962; cv=none; b=dExBHetzwvaEQDYiPAqZsXWWXbifJETnQz2IwWngQ3cr8NT5J6OT0qIpk0Ynwi7Gs9h+0VFQT98Om8Vs3MKgZaFoHRcBYTrquq6ospGpGaywOP8TS4do/zv/H+u9BzskTakOWl2MZZCmj8z5Qcx99m/rG5zXEKvGY1JxKmsTcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667962; c=relaxed/simple;
	bh=IHyODcEE763hJBCK3rKDKBkcelFClmu6LkKn24BrvVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLwxCtdeYvkbxW0ibnAHN0SS4h1/LQZRNtLtuqbRjp1XetHO0q2iOeIlhRHNFL4OLQ3iIaoKEwmZ+SfuZmLDhshnEr01FV3isGzcNAZoH4B9uJqbc8Pjf87XzgZ/VaKIUCIS6G1pbsGX4bLVVfTiBtK37CWGALQCJz+WKjquBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPzNxRGg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723667958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSm2exThzk/ONkPYsLo5wk2mtv0Gd6Av4xPNxsPfqsw=;
	b=dPzNxRGgLj0+Hj93JpzVSJeK21XEkDgXdPWBRoRa7EtrUcw+QP+cepDmBuOkhWQPnWeGze
	Kxr/ShVMu0L9jMHMF/KXLX/a2IXVMtz4M3brEqYBoId0v9kuucQMhm4vy/+OfJES2HyezH
	w5VVzD51PlI/5CZNE7EHbkowoir9Pys=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-9yDs-KHPO0qhfQhsIZ1yWQ-1; Wed,
 14 Aug 2024 16:39:15 -0400
X-MC-Unique: 9yDs-KHPO0qhfQhsIZ1yWQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C2591956095;
	Wed, 14 Aug 2024 20:39:10 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9959E3001FE1;
	Wed, 14 Aug 2024 20:39:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>,
	Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 01/25] netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"
Date: Wed, 14 Aug 2024 21:38:21 +0100
Message-ID: <20240814203850.2240469-2-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.

In addition to reverting the removal of PG_private_2 wrangling from the
buffered read code[1][2], the removal of the waits for PG_private_2 from
netfs_release_folio() and netfs_invalidate_folio() need reverting too.

It also adds a wait into ceph_evict_inode() to wait for netfs read and
copy-to-cache ops to complete.

Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Max Kellermann <max.kellermann@ionos.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e5ced7804cb9184c4a23f8054551240562a8eda [2]
---
 fs/ceph/inode.c | 1 +
 fs/netfs/misc.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 71cd70514efa..4a8eec46254b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -695,6 +695,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
+	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 83e644bd518f..554a1a4615ad 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -101,6 +101,8 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 
 	_enter("{%lx},%zx,%zx", folio->index, offset, length);
 
+	folio_wait_private_2(folio); /* [DEPRECATED] */
+
 	if (!folio_test_private(folio))
 		return;
 
@@ -165,6 +167,11 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 
 	if (folio_test_private(folio))
 		return false;
+	if (unlikely(folio_test_private_2(folio))) { /* [DEPRECATED] */
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
+			return false;
+		folio_wait_private_2(folio);
+	}
 	fscache_note_page_release(netfs_i_cookie(ctx));
 	return true;
 }


