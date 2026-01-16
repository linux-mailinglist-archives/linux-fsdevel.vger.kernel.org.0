Return-Path: <linux-fsdevel+bounces-74139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041AD33000
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C9493172ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E539E6DF;
	Fri, 16 Jan 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+BrI+6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDA39C62F;
	Fri, 16 Jan 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574797; cv=none; b=rif8Pc8rSkv8iyKgFqvTnNgmT46IWzNMypAJ1VxukqzIiUl3CnqOKruJr5Hlc33cQgYSMi9iP0NhiNWIp6Vd0ji1S27UEsLsSLLrjS66NVZ+wn1SvMJuZoi/rj7n5IGInmKuzPeXO3M7nySxV7xqEsQpsageWMVN8Flwni1/DCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574797; c=relaxed/simple;
	bh=tyhvqqIS+ku3U7Hk/wztpIFyA6yZTojJ9ILKjB/tyUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue2Bk61cIn20ZczgUqaabtvLLSqb96IB4CK719l/bTMdQI6koJ/UZsoyhbr1loreOn+pubG/rJjrDKofK12jQ7VWNLXa9O7MFvr6Wuj1Xf322c35vLjLoUIkxEkbmjJ2PfMzzQTF9sSWSVXK1gw53GJEkwSFevNMwPCXj4jm+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+BrI+6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658B2C19421;
	Fri, 16 Jan 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574797;
	bh=tyhvqqIS+ku3U7Hk/wztpIFyA6yZTojJ9ILKjB/tyUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+BrI+6nlKHQZfkg5DDc/BbSQzbF8SNUNZIO/2QyelkLAE8q1wWo8MR88Fk5Hv1HM
	 VBlnSa/OG03+z2mLQk7nfajOgsXCkpUNRxCIU9l24DyMDsc9Y/XwgVj7v4Pyj7zaVo
	 4iBrq4wEKDPY3N6ZKzQ1HfdxOnoEoUtjjbfKm+0Uc7KOL70yAYcVaZUtjRzDqy4o6r
	 YEVijPjcCHCnMnvH5cPN9jduQWINKJO41WCcbEIhBUy0n+Dg9xLmcnImv462YAcWO1
	 5JeuW5sSA1GYYx6L2XlgTxi0kY6wAFLEVNNDRyfOAy50Pfvvo/CAWgLHZznkm6Uiif
	 Vd8HEuVEnFrYQ==
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
Subject: [PATCH v5 07/16] ext4: Report case sensitivity in fileattr_get
Date: Fri, 16 Jan 2026 09:46:06 -0500
Message-ID: <20260116144616.2098618-8-cel@kernel.org>
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

Report ext4's case sensitivity behavior via file_kattr boolean
fields. ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report case-insensitive; otherwise
report case-sensitive (standard POSIX behavior).

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2..213769d217c3 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -996,6 +996,12 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * ext4 preserves case (the default). If this inode is a
+	 * casefolded directory, report case-insensitive; otherwise
+	 * report case-sensitive (standard POSIX behavior).
+	 */
+	fa->case_insensitive = IS_CASEFOLDED(inode);
 	return 0;
 }
 
-- 
2.52.0


