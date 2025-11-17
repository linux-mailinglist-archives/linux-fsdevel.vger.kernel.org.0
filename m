Return-Path: <linux-fsdevel+bounces-68663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB3CC6345A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3F1F367204
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667732C312;
	Mon, 17 Nov 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRkGzbU1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50E32B996;
	Mon, 17 Nov 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372061; cv=none; b=hYrIGWNi77yzT6YVGOWxdG57LSFy93Js2Ye8f/I2qc3CGYNb0prLdo1afPpEBEEKbH4hZgxt+j8t1fMJc822oKBlMV+P/CdDgk9fbL15QdheAfRMsqERKQh8qdBEgqU9ADJ0ImYU1nrUehgU83/tO521hz+VB5MrIyRoYxEt99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372061; c=relaxed/simple;
	bh=MYGTFx3lPfWJdTrVOJ8KQ4lu0UujbjHiUqOl9oglQZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhyEJD/G5bXPzgL0Y0qJBTrabiKPLpKzJV/1upl0tIjLQQM8bhIyQJbrCTFY4LCBbZhNmPF08b+nJ7qH4S+eKQPjd42DWR7GjTOFRr8A3yUEqtHMKoxYrGm57l7dZTuyGn0zvfCERIg12ehXTnN04cEBt7WIoKwrdJt1VFUI1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRkGzbU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF7FC116B1;
	Mon, 17 Nov 2025 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372060;
	bh=MYGTFx3lPfWJdTrVOJ8KQ4lu0UujbjHiUqOl9oglQZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qRkGzbU1P67546JDGS7p+iOcIZ9Ug50EqaeS61KUlZUgD5EegoZ6EJUxX4kMSc+te
	 WUhd/xoCcaYpZCyITaYKGFRZn2M3zmCow2mchmfPboPsmYPVM8zMzxRQPecqUetOBz
	 ttzjGxaajXo36fm+O3GFlYElfS37uXHFR3Hr0SvibSIQ2Z2UgYATTNxD6mwj2F+mfo
	 0JWEcav86wjBe5PkKGh4K9fc7neZ21Za6KHDcpVlhGmb8SJrLwFPIvUuciQc8uV8LD
	 nUkc2BKOD2LybdjFdUXld+aHbcJV6Ihn/071DKrFTCTjiY9qSKQsBHQUafVPrs6/y0
	 IHIfggTM3qM+Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:51 +0100
Subject: [PATCH v4 20/42] ovl: port ovl_fileattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-20-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MYGTFx3lPfWJdTrVOJ8KQ4lu0UujbjHiUqOl9oglQZU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf46jzvkUPlKhVPXpk/Y+fjvIq2kP4+Y2BYuTt+vl
 Wof5f1xR0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE7Gcw/DOVPbHXvjlk6gmT
 OIVm//ytTJM3R5tK/90o1190cV2TVi4jw8L53v5nUn7On66/cNZ8k06bI/cE7y/P2DcvWNxSqZ8
 xiBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 5574ce30e0b2..3a23eb038097 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -638,7 +638,6 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct path upperpath;
-	const struct cred *old_cred;
 	unsigned int flags;
 	int err;
 
@@ -650,7 +649,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		with_ovl_creds(inode->i_sb) {
 			/*
 			 * Store immutable/append-only flags in xattr and clear them
 			 * in upper fileattr (in case they were set by older kernel)
@@ -661,7 +660,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 			err = ovl_set_protattr(inode, upperpath.dentry, fa);
 			if (!err)
 				err = ovl_real_fileattr_set(&upperpath, fa);
-		ovl_revert_creds(old_cred);
+		}
 		ovl_drop_write(dentry);
 
 		/*

-- 
2.47.3


