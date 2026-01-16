Return-Path: <linux-fsdevel+bounces-74143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8866D32E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C109D3233C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528FD3A0E8C;
	Fri, 16 Jan 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNdF2vRJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C538F22E;
	Fri, 16 Jan 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574807; cv=none; b=Yb4Mk0vMPte9861x/Zc5hWuDKMvH4bfUgRbo133uH611jp53pP+djDBhtUPoxaW5bANBnViT9gROqZRb19+jiqVz4f9nopoB9xUiBcxdm4mffTfWn1V5CcTSnoby7zxNwKnpSm/cgQu7sqUs5JU6qGOnPrZ2LYq3M8koNaiFYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574807; c=relaxed/simple;
	bh=X2CfF5Mn9CRS+EjjMIOtUmXyiac4dDTyVUDa2EW06DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4AjMJsTbEfPWgtt6WyoFN9WnAin+N/alsCVAfeisPoKL1JtW0cRB4gcxLY6nrTHy6oN29gnZ3iK7rxepJb1XF4gfBwGXxXwWBglbgAX1TWe/KgWjMGYQxRaohcXSk7eZgW195GSm00TwBkKl0iwtxjKpumJ68IuyUGJYjBWICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNdF2vRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25774C116C6;
	Fri, 16 Jan 2026 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574807;
	bh=X2CfF5Mn9CRS+EjjMIOtUmXyiac4dDTyVUDa2EW06DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNdF2vRJwOyNfl7yRbt6btWzSu2j7/jgy0BVYMsNh3hi3FUC9TYx506NQpvrMxgJx
	 SzKmFhd+/57pVQd7brlNQTlvW7Kz/u4QBvc84nCPtsJeiqqtRtAZyINM1ADY6yxTJk
	 4lBRZxk3rGTwagg7yTX/bqhf/uuM77ntNUNFAmh3+d7baR4cN8AoGRLQPJkey6epKg
	 lmLnjJEYLNl4KbYVsDBsOeIdspzVc1aIYbrujj68UvT59E85H11zeyXmPuPOoFdrFI
	 IETTXoOlJs+52hcEKMIOaHDCnBvbXLzpYyW8TuhhOTR9hubTmNP2w+JWsM4m09n4E2
	 HG90OG33jvE3g==
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
Subject: [PATCH v5 11/16] f2fs: Add case sensitivity reporting to fileattr_get
Date: Fri, 16 Jan 2026 09:46:10 -0500
Message-ID: <20260116144616.2098618-12-cel@kernel.org>
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

NFS and other remote filesystem protocols need to determine
whether a local filesystem performs case-insensitive lookups
so they can provide correct semantics to clients. Without
this information, f2fs exports cannot properly advertise
their filename case behavior.

Report f2fs case sensitivity behavior via the file_kattr
boolean fields. Like ext4, f2fs supports per-directory case
folding via the casefold flag (IS_CASEFOLDED). Files are
always case-preserving.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/f2fs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d7047ca6b98d..5d4c129c9802 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3439,6 +3439,12 @@ int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
 
+	/*
+	 * f2fs preserves case (the default). If this inode is a
+	 * casefolded directory, report case-insensitive; otherwise
+	 * report case-sensitive (standard POSIX behavior).
+	 */
+	fa->case_insensitive = IS_CASEFOLDED(inode);
 	return 0;
 }
 
-- 
2.52.0


