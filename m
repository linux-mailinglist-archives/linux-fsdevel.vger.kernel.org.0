Return-Path: <linux-fsdevel+bounces-73737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DDDD1F72A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B03B3015443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C2389464;
	Wed, 14 Jan 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nijd/OMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041D2DCC04;
	Wed, 14 Jan 2026 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400959; cv=none; b=fZLuUEfr+tBlfn5G+NhgGb1ZMFNXqFIdjnCHRLwoT0gsStPFSrOLpgry5kpxI5APX2cmyba1doxKxWqVwUAIuYZtu5K+kkwG24IIXBJ4Q8kWr/sZEv0KWkjDNI7oTvsu/IWeQT8uFHU6PTn86D7uAvjSShgpuq/bh5lyrIiE75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400959; c=relaxed/simple;
	bh=7L4KjJ52/tlODNs/DbrL8VR4WdJ76Ryp9p91k5Grblo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU8gNX0qaTsq284HsJTEEJCtdk73G8oXopTRVf021cTxoSGVHBVCXiaToDNB0hERSJgEf4cOKwBo/O3PxrQyZA8mq7NLwUC3eiqMI0I4qdEINNgI6NUj9cW2m5mGE18U6P5YL/E/NRtaU+3F4gyx5JZFbE0ruLk3E2C+zS8lRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nijd/OMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C839C16AAE;
	Wed, 14 Jan 2026 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400959;
	bh=7L4KjJ52/tlODNs/DbrL8VR4WdJ76Ryp9p91k5Grblo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nijd/OMGAs7q2xnoLkc+Xv35DQEOlxxlx1WfpNMDoAxq6z6rNJdOuLYyjWSmLM9qf
	 gKzkGHwhU8tzxq7iw5AraLTJW5NK+drjvgEhrGKAQDLXYE8gQQrXeWaAa89p7S3Tm+
	 qziEp4BuZhbaaqM0ly2WLJoSz6XJhF51ZXJ+CAMb1rlnAUb52/ej//ZQkK5FneEtic
	 U0UHEZo/WX4UHuWrm4qR6LJMBWi/657wnDS3VIKPUucs2CIvDdfmkQFT8GzDvqI/gB
	 31Juf/lcf4sNgee2/1+aL0GoQMc3SE+hdj1k4r6OokRXSe4BIQOT3nXXfIyCIqTd15
	 o5UEvAz20pVNQ==
From: Chuck Lever <cel@kernel.org>
To: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 06/16] hfsplus: Report case sensitivity in fileattr_get
Date: Wed, 14 Jan 2026 09:28:49 -0500
Message-ID: <20260114142900.3945054-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114142900.3945054-1-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function. HFS+ always preserves case at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7ae6745ca7ae..7889d37f5c85 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -694,6 +694,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -705,6 +706,12 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	/*
+	 * HFS+ preserves case (the default). Case sensitivity depends
+	 * on how the filesystem was formatted: HFSX volumes may be
+	 * either case-sensitive or case-insensitive.
+	 */
+	fa->case_insensitive = test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags);
 	return 0;
 }
 
-- 
2.52.0


