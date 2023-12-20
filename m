Return-Path: <linux-fsdevel+bounces-6561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693F9819814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277F5288390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16544FBE0;
	Wed, 20 Dec 2023 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HDFtu6yu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798DCA47;
	Wed, 20 Dec 2023 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=duE4g5Ia2UG16LD2iQr91EPGHVpyuW2l4XuSdK8kuqQ=; b=HDFtu6yuFHkNPvIAjEE71Wjv2e
	NfXTza8VpIokRxipJV1PMES/LsoKt9+MooDUnHOuiMDloPzrN5v4rhbY27Pv23W9dexx8LWbNKJTm
	bli+odXTQk3b+lb2S/pxT1h1DcQczVabTOF9mpM/sJtAq/GdRBGOeyT23R0IdRa1pJ7Hb58sL1BFN
	YanO2ZhVurVrq05Agir2ogIS5sG6cYy97P3vQDeJWaIEk/K0xXjRfZ2TFkg9/luGj4s88EriAq4Kd
	Oze4C+qZaOup21uyvj6no7Q+z1FU8EQR3Zw8zZzFw/Ic3sN+q+KFEZXhOuJnXmK35Sir/HquW1o/n
	ze+IWVhQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp6M-00HJE1-39;
	Wed, 20 Dec 2023 05:26:39 +0000
Date: Wed, 20 Dec 2023 05:26:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: ocfs2-devel@lists.linux.dev
Subject: [PATCH 14/22] __ocfs2_add_entry(), ocfs2_prepare_dir_for_insert():
 namelen checks
Message-ID: <20231220052638.GM1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

namelen can't be zero; neither when it's coming from dentry name,
nor when dealing with orphans (in ocfs2_orphan_add() and
__ocfs2_prepare_orphan_dir()).  Rudiment of old ext2 pointless
check, long gone in ext2 itself...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/dir.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index a14c8fee6ee5..d620d4c53c6f 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1593,9 +1593,6 @@ int __ocfs2_add_entry(handle_t *handle,
 	struct buffer_head *insert_bh = lookup->dl_leaf_bh;
 	char *data_start = insert_bh->b_data;
 
-	if (!namelen)
-		return -EINVAL;
-
 	if (ocfs2_dir_indexed(dir)) {
 		struct buffer_head *bh;
 
@@ -4245,12 +4242,6 @@ int ocfs2_prepare_dir_for_insert(struct ocfs2_super *osb,
 	trace_ocfs2_prepare_dir_for_insert(
 		(unsigned long long)OCFS2_I(dir)->ip_blkno, namelen);
 
-	if (!namelen) {
-		ret = -EINVAL;
-		mlog_errno(ret);
-		goto out;
-	}
-
 	/*
 	 * Do this up front to reduce confusion.
 	 *
-- 
2.39.2


