Return-Path: <linux-fsdevel+bounces-73290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E428D14968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 362913148EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E4B3815EA;
	Mon, 12 Jan 2026 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1YEe+sG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14B37E312;
	Mon, 12 Jan 2026 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240015; cv=none; b=jXjt6P/RRsrAnSABsSxJgKafApGxY6aCBHh7YdHeA6EplmDw9cUhAwMGvU3GFqvKVfW7Jcx39UJzCXUAE1mfWe/1x8Uo9mrdnPl296r91XkDT5tqLVJit5QWvZoJIDoWSXQC9EHNq45R/6JZezRnk6BdCw3bmT8QhjvAyLDiT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240015; c=relaxed/simple;
	bh=adSYz/aH/JJhedd8LYc9zNP3COoAonVjNEu8GDlmYN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iStV+2BHCPSVrFaaOdNHhDGKd/mnS91B2DNBvkO4c42CiZy00vJZ0NyEZ/Ty558Mf/lN7whvUzPbJIGLeulWaJintYY8qdH4xvCrLDv+ba9tSR/QS349MLtJvtqlvzlU8btzlCl0KVl8VcJ0GVeWAG2RLbFh6jJIHat3Pggx7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1YEe+sG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8266BC116D0;
	Mon, 12 Jan 2026 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240014;
	bh=adSYz/aH/JJhedd8LYc9zNP3COoAonVjNEu8GDlmYN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1YEe+sGuhJi2JzEnSEQOyOSwvYlYMSE7wCuiosOgAuf2xeSKcPV45t8RfNFxwfFi
	 YpvBLv419Mi7UO+E+WF6n1IFJ47Wb53mx8s4sA7BFIWm6+xyEI0OM7UxdjHlfBdRLg
	 Y/fUWVTAKEVJAXsq2nJq+C616NW7vStwnPGwMTVQCImwsbWURRMmSukYqLXKL7rKy0
	 SCZYOORfI3aj2e2+wauvVKczlgj0XniWIKwWP9aA6e4SG9sKlVIcA9icjUeGkP0bPY
	 o6gGAGvHoA4vOUOjbESXPtOfb3YN7x/bu3x2qWuVPbkN4F+4d/ld04d2Okp9fLvhF2
	 OaaVFRp7yK5ww==
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
Subject: [PATCH v3 07/16] ext4: Report case sensitivity in fileattr_get
Date: Mon, 12 Jan 2026 12:46:20 -0500
Message-ID: <20260112174629.3729358-8-cel@kernel.org>
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

Report ext4's case sensitivity behavior via file_kattr boolean
fields. ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report case-insensitive; otherwise
report case-sensitive (standard POSIX behavior).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2..653035017c7f 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -996,6 +996,14 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * ext4 always preserves case. If this inode is a casefolded
+	 * directory, report case-insensitive; otherwise report
+	 * case-sensitive (standard POSIX behavior).
+	 */
+	fa->case_insensitive = IS_CASEFOLDED(inode);
+	fa->case_preserving = true;
+
 	return 0;
 }
 
-- 
2.52.0


