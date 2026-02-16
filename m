Return-Path: <linux-fsdevel+bounces-77264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHV6I66rkmlPwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:31:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6947141013
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E10300F137
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269FF28750A;
	Mon, 16 Feb 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="amlL+Rlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75350276
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219842; cv=none; b=t2vjsh2/NXkSSFIMoNwP91V2VJncJpe9Gl1lVoIAaZ653bMdsxVpSjTDtQF1u9/ITKhED+xBD8oP3Dad000R7B+6tm6urg2rb4m6mLIUYKNHJY918mteeZOU93YR3rpc/PGC8bfghrrHyDFpO8dN3xlp8/nRzxQcL7aEsyeItN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219842; c=relaxed/simple;
	bh=SJiKwxymJGjCI9qDNvCQ4ZR3L5NeVvhadFp/18rjHIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=NoB2L14mOJlQNh98PZtmsYT4eF0ubcdBlbPL5g/N/YL7hJ3pARM4+E9IobmBHhvkUFqBGfXkP9U27R0iUYgfU+B5jKczj57hc7VXcroT8e4eeNWM/3cVOa3tk19x3aXkDnEscnM58SIFe+hrL1OtO8EXoetQJS73lxG28WUuSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=amlL+Rlj; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260216053039epoutp0419cb8df4e1bab16e840abff70292af06~Uow9AyXsP0294102941epoutp04U
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260216053039epoutp0419cb8df4e1bab16e840abff70292af06~Uow9AyXsP0294102941epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771219839;
	bh=Pb+P0rLgEdovCO13BIPXUJybqmHX3PaFxXKcvG+y1qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amlL+RljZAs6yrHVXKl3AO7tce2WSIzckubi8ABEDEt1d+KpxEhoPNF0H+OE/8JF8
	 wWh3Wanls6zGTpMLOEw6AkDP3o4Wn0mqcBre8LxFNHeq+E/IAd1Uyfo+iaNwNmcqJx
	 I5c5yoaCOlmoM89t6bNLeCwbm3e+gVV0C/tvCMNo=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260216053038epcas5p34fca45a91ff20e0ecb6d0b403d2b42a6~Uow8i1w0n1545915459epcas5p3J;
	Mon, 16 Feb 2026 05:30:38 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fDrvy1KCWz2SSKX; Mon, 16 Feb
	2026 05:30:38 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260216053037epcas5p4db5c80cedd64a70a275c3371e4084122~Uow7iSDtq2439324393epcas5p4s;
	Mon, 16 Feb 2026 05:30:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260216053036epsmtip18aedcc0c50ab49207aad44b39d755f5b~Uow6Fc6iA1594915949epsmtip1T;
	Mon, 16 Feb 2026 05:30:36 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, brauner@kernel.org, jack@suse.cz, djwong@kernel.org,
	axboe@kernel.dk, kbusch@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 4/4] xfs: enable userspace write stream support
Date: Mon, 16 Feb 2026 10:55:40 +0530
Message-Id: <20260216052540.217920-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260216052540.217920-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260216053037epcas5p4db5c80cedd64a70a275c3371e4084122
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260216053037epcas5p4db5c80cedd64a70a275c3371e4084122
References: <20260216052540.217920-1-joshi.k@samsung.com>
	<CGME20260216053037epcas5p4db5c80cedd64a70a275c3371e4084122@epcas5p4.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77264-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E6947141013
X-Rspamd-Action: no action

Implement support for userspace controlled write-streams.

Add a new i_write_stream field in xfs inode (note: existing hole is
used), and use that to implement write stream management file operations.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/xfs/xfs_file.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_icache.c |  1 +
 fs/xfs/xfs_inode.h  |  3 +++
 fs/xfs/xfs_iomap.c  |  1 +
 4 files changed, 59 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 43d088a3bceb..f3b137407a60 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -2021,6 +2021,57 @@ xfs_file_mmap_prepare(
 	return 0;
 }
 
+static struct block_device *
+xfs_file_get_bdev(
+	struct inode		*inode)
+{
+	struct xfs_inode *ip = XFS_I(inode);
+	struct xfs_mount *mp = ip->i_mount;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		return mp->m_rtdev_targp->bt_bdev;
+
+	return mp->m_ddev_targp->bt_bdev;
+}
+
+static int
+xfs_file_get_max_write_streams(
+	struct file		*file)
+{
+	struct block_device *bdev = xfs_file_get_bdev(file_inode(file));
+
+	if (bdev)
+		return bdev_max_write_streams(bdev);
+
+	return 0;
+}
+
+static int
+xfs_file_get_write_stream(
+	struct file		*file)
+{
+	struct xfs_inode *ip = XFS_I(file_inode(file));
+
+	return READ_ONCE(ip->i_write_stream);
+}
+
+static int
+xfs_file_set_write_stream(
+	struct file		*file,
+	unsigned long		stream)
+{
+	struct xfs_inode *ip = XFS_I(file_inode(file));
+	int max_streams = xfs_file_get_max_write_streams(file);
+
+	if (stream > max_streams)
+		return -EINVAL;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	WRITE_ONCE(ip->i_write_stream, stream);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	return 0;
+}
+
 const struct file_operations xfs_file_operations = {
 	.llseek		= xfs_file_llseek,
 	.read_iter	= xfs_file_read_iter,
@@ -2040,6 +2091,9 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
+	.get_max_write_streams	= xfs_file_get_max_write_streams,
+	.get_write_stream = xfs_file_get_write_stream,
+	.set_write_stream = xfs_file_set_write_stream,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
 			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
 			  FOP_DONTCACHE,
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index dbaab4ae709f..fc9c6794b7db 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -130,6 +130,7 @@ xfs_inode_alloc(
 	spin_lock_init(&ip->i_ioend_lock);
 	ip->i_next_unlinked = NULLAGINO;
 	ip->i_prev_unlinked = 0;
+	ip->i_write_stream = 0;
 
 	return ip;
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bd6d33557194..be3580fec318 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -38,6 +38,9 @@ typedef struct xfs_inode {
 	struct xfs_ifork	i_df;		/* data fork */
 	struct xfs_ifork	i_af;		/* attribute fork */
 
+	/* Write stream information */
+	uint8_t			i_write_stream;	/* for placement, 0 = none */
+
 	/* Transaction and locking information. */
 	struct xfs_inode_log_item *i_itemp;	/* logging information */
 	struct rw_semaphore	i_lock;		/* inode lock */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index be86d43044df..7988c9e16635 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -148,6 +148,7 @@ xfs_bmbt_to_iomap(
 	else
 		iomap->bdev = target->bt_bdev;
 	iomap->flags = iomap_flags;
+	iomap->write_stream = ip->i_write_stream;
 
 	/*
 	 * If the inode is dirty for datasync purposes, let iomap know so it
-- 
2.25.1


