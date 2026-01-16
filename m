Return-Path: <linux-fsdevel+bounces-74138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F02D7D32E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 781EE321A095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572F39B494;
	Fri, 16 Jan 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsRpk/C5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BD3933FD;
	Fri, 16 Jan 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574795; cv=none; b=Hj1osgTJTDoODy0oTNRSbsKEn13TEfsOhR0O7nQSVFLUhJCX/QrdNmj2tROSwHPxR9Y8KAaeF2q9SIM114PpFxOTP3XZvs+kdnw56lp3/fMjrqu4Vqc2auhPsFmHizOfYVJjRQPFH/FBhdcG0Jp8sFfuPOum+JAF7pYWvP2NVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574795; c=relaxed/simple;
	bh=7L4KjJ52/tlODNs/DbrL8VR4WdJ76Ryp9p91k5Grblo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnXEU6xrJ05LBckQyWUzMug19BPkJuVxFuOBqKVPWdLGhUBbsWOMsNpRKJ3/y7GWq3oji+354kkbxmC8ZMg8pe2Y2mNkGejdfFwSqgo0OxCWJKzQl4KP3temHah6X+v4SrvUbiqRcNrSgNxx5Sml1/xOhZ/IzgnV5GhUbZ2ejgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsRpk/C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32EAC116C6;
	Fri, 16 Jan 2026 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574795;
	bh=7L4KjJ52/tlODNs/DbrL8VR4WdJ76Ryp9p91k5Grblo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsRpk/C5WD128bHCrTDAhbUJQHUMOR6eVKWJDhnsz1Uv5beLQM3FFeh9k8PdEnD+j
	 9wkg5vOie2GpG9SwdMIqGagbMurKpoD8C8yjZqBuyEegRU3+50+4EwARqaL+HPzl/G
	 SdP9JhfYjMmLbsOrZbTDckXkW0qrHRpF33eLdEeXN7MXarBU9rpAFDsqhZkxQCC+Y1
	 zjMRi3Gd1j9f+ryX7g/BLJ5d14gHeCUaQAP2BMnMKovbUSHteNzQLtwOkR5RY7fUji
	 vGmJnMw/tPsALbSeWXeSXBCnUK/femVtMhjz0TB9iHJiwAgdTo60WcJFN82FGQlmxa
	 kgPSdp6q6EVoQ==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH v5 06/16] hfsplus: Report case sensitivity in fileattr_get
Date: Fri, 16 Jan 2026 09:46:05 -0500
Message-ID: <20260116144616.2098618-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116144616.2098618-1-cel@kernel.org>
References: <20260116144616.2098618-1-cel@kernel.org>
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


