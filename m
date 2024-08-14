Return-Path: <linux-fsdevel+bounces-25957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4859522CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA45EB24698
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EE51BF326;
	Wed, 14 Aug 2024 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj15zXkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD34370
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665016; cv=none; b=vAftVBZ8njCqAEBYDNePF8+rQUL048khl3e6Ixq+D1opEw3xnmcvi/8sQ91orkcrKW4TD2kyrpVCDfvNwk7hCergPeM3h2CyID26tO9H0J4fI0PNfGimrAPf/iBUsU9zLOFhki3TnNsfGAi5NwgHR9uMQEk5vm6nKEFH0sSVbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665016; c=relaxed/simple;
	bh=0IJfcZS7r6EPJLniVsMkD68/yY+O53iik/ZnogU9/aw=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=JEk6a/ALxyHrOHBSHLwpbw4KBNl6kwFJTau5/Ef19FtB/AQ4k4wY0curZsb131QbPSrVg6fY5dIc/3W1UC/dIY5ZCyqxi0DJubMtoG/bbvb2SPTfTczPMLsJk8SfLCUTLWSMY2hZoBra8Ps8tln0LIyTm1Wvj2zDmIDCuYc6D5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj15zXkb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723665013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/f2tGiDB/aYV2fKGojac/R/nY51VPmqymykpR+kaL+k=;
	b=Cj15zXkb4dX33uPtpNkN/lH+5xnlksvjwftGBekbKQVZqqhhNr/TLG++7E4UnkM/M33jP6
	20xfIVD3JZva4IcwYTXUs5O0mqBKiVsYKk8amdY4seHSFlTcG3qaWKxatuWZ2RfLJHjNuh
	amn4Ihgs0pkrWhY+MD8rGW0Ib6dlHqI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-GYkvsiM6PluIyAv1x30gAA-1; Wed,
 14 Aug 2024 15:50:09 -0400
X-MC-Unique: GYkvsiM6PluIyAv1x30gAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C148E1953942;
	Wed, 14 Aug 2024 19:50:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37E9E19560AA;
	Wed, 14 Aug 2024 19:50:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2181766.1723665003.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Aug 2024 20:50:03 +0100
Message-ID: <2181767.1723665003@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

    =

This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.

In addition to reverting the removal of PG_private_2 wrangling from the
buffered read code[1][2], the removal of the waits for PG_private_2 from
netfs_release_folio() and netfs_invalidate_folio() need reverting too.

It also adds a wait into ceph_evict_inode() to wait for netfs read and
copy-to-cache ops to complete.

Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private =
and marking dirty")
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
Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk =
[1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D8e5ced7804cb9184c4a23f8054551240562a8eda [2]
---
 fs/ceph/inode.c |    1 +
 fs/netfs/misc.c |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 71cd70514efa..4a8eec46254b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -695,6 +695,7 @@ void ceph_evict_inode(struct inode *inode)
 =

 	percpu_counter_dec(&mdsc->metric.total_inodes);
 =

+	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 83e644bd518f..554a1a4615ad 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -101,6 +101,8 @@ void netfs_invalidate_folio(struct folio *folio, size_=
t offset, size_t length)
 =

 	_enter("{%lx},%zx,%zx", folio->index, offset, length);
 =

+	folio_wait_private_2(folio); /* [DEPRECATED] */
+
 	if (!folio_test_private(folio))
 		return;
 =

@@ -165,6 +167,11 @@ bool netfs_release_folio(struct folio *folio, gfp_t g=
fp)
 =

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


