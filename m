Return-Path: <linux-fsdevel+bounces-73289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C60D1495F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2121330C7147
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536CC3815DF;
	Mon, 12 Jan 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIiDq/J6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2C37F0F9;
	Mon, 12 Jan 2026 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240012; cv=none; b=BkSUat+HiX1Ppg3oGYjxp39ROpqpB7hme8rUI1JjchOo+akl3Ydd6Jesxxyf2mC8BTioO4X9aRFy0O5RZAobiMqd9vcWeHtiw8u1OOeB0lZirExqONMdhsgfCbbXOApwoaUBQPI5t31r02nlyoCNB59doSkmEH4ONajgFDM5B4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240012; c=relaxed/simple;
	bh=L5CDc1Nm8Bp2qYtvo56luGywAJSsqnRCZMclqhdhavs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUs+pYIl8pVIcRHeHSTNarDSsuBsqbvPZTKe2PJFTbV3KgVj/3zd40OGIox+Ky+Nl6qDkZKwgpI1Sho3F8GrSeMEKziCxzH8GpkMsb0g7qMkXWdgrB2rDZyFuWAx0uj0jgJRBpyia37egD9Gh707GePkUJUkB3g0jntqW3OtCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIiDq/J6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3D8C16AAE;
	Mon, 12 Jan 2026 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240012;
	bh=L5CDc1Nm8Bp2qYtvo56luGywAJSsqnRCZMclqhdhavs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIiDq/J6c8fJ/AFmnlkONFsYYJ+8sEbkwLX508eZBqVurO4qweeYHdmcikGGOUz2M
	 8Ds+QX/wRi8ZdxM88f2UNEMHns9A6Y3hAZFHg2j/VASpXtFBt7i+tXmCteGYh2EPqh
	 IP1zyqGDfh+CfbKibYB7SFWf2zwn3aGCs9FjsnkMeiPI289MeZakQ5GGhq4Mr6oDUW
	 YtToEL3wINLCGyMpr5Tvf7x5ZIwRYM36f4xopVVpm7QFTNQcsL4GXgiEVb1l8r0VB9
	 d2sPgXlqiLnasqM0nUFmn9WJxX1CJZaChrOOe5hNG5AbYFaAHsWrpzMfEiyisl5IwV
	 eBKeUlogrk9xw==
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
Subject: [PATCH v3 06/16] hfsplus: Report case sensitivity in fileattr_get
Date: Mon, 12 Jan 2026 12:46:19 -0500
Message-ID: <20260112174629.3729358-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112174629.3729358-1-cel@kernel.org>
References: <20260112174629.3729358-1-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7ae6745ca7ae..0ce9561c0f18 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -694,6 +694,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -705,6 +706,14 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	/*
+	 * HFS+ always preserves case. Case sensitivity depends on how
+	 * the filesystem was formatted: HFSX volumes may be either
+	 * case-sensitive or case-insensitive.
+	 */
+	fa->case_insensitive = test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags);
+	fa->case_preserving = true;
+
 	return 0;
 }
 
-- 
2.52.0


