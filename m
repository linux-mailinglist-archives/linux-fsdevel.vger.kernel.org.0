Return-Path: <linux-fsdevel+bounces-73294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E3BD14878
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4A683022488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04843816FE;
	Mon, 12 Jan 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKIO+8L8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66B37F74F;
	Mon, 12 Jan 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240025; cv=none; b=fczJW0FRnamEqr2D5Ul2J32WQIVLqu31eOyQrGFVqcY0Ghk++GbjtLL+3Wk844nZUfUzYI+wPsG0wakbFYeFxve6Uxfp18Xmq2svjeOsrHEK4gTt/sykWr5iCceNu+YiMZMucpLIj0GffKpjDWTyIcNuZQXdWhxdcXH/TTLQS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240025; c=relaxed/simple;
	bh=izMvHmk+mBtllXLOnrvTWmwXYyIaajWUeC93SIFXyqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZd30Q+tde9QeS98JonLguusZvM2KQJXZzorknU2/dpvvRXM0kENuBY1oYNXjV1Zy1cYfsSgDGFdCeWCbI2YGlfXz1ab5xW9FzSg80MTl7Z0Y/rvanG5Agb/rw50LnUubgmpaqg39u3aSYxYnAdv3PBxx9ap08iOBf92ZOleHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKIO+8L8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94124C19422;
	Mon, 12 Jan 2026 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240024;
	bh=izMvHmk+mBtllXLOnrvTWmwXYyIaajWUeC93SIFXyqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKIO+8L8MC8xU2/UR1aq83UYJtQWRu7PO1Rrw1c77thHDCjIZgpgw5mGUP9N/Z8uB
	 I/y7Bx/MbBdAzlVnW3qIyEJ1F8Beq9vY4qDPP5iOfNSde7/KW05S/++xEP3zs054BS
	 TZodd7SzI7fMGzf9TKb2z+2H1V74NIPIlxTJglopNLBVUD+1Uz+Z863onXYCb09bz4
	 m6b3RUmIDps5lnqznIj9THJSiy52/DEyj7r6Zo/k7hVXuLQq3KxE5UfenLNfyvnMa+
	 ThSt6xSPqA67l1Zb0NmLwDmMiUZTWIVMqCm+kIEQJeme/fy6urooILl1IC1bdWPLB/
	 IqSmpUsg8GD1A==
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
Subject: [PATCH v3 11/16] f2fs: Add case sensitivity reporting to fileattr_get
Date: Mon, 12 Jan 2026 12:46:24 -0500
Message-ID: <20260112174629.3729358-12-cel@kernel.org>
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

NFS and other remote filesystem protocols need to determine
whether a local filesystem performs case-insensitive lookups
so they can provide correct semantics to clients. Without
this information, f2fs exports cannot properly advertise
their filename case behavior.

Report f2fs case sensitivity behavior via the file_kattr
boolean fields. Like ext4, f2fs supports per-directory case
folding via the casefold flag (IS_CASEFOLDED). Files are
always case-preserving.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/f2fs/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d7047ca6b98d..e73e6d21d36b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3439,6 +3439,14 @@ int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
 
+	/*
+	 * f2fs always preserves case. If this inode is a casefolded
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


