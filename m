Return-Path: <linux-fsdevel+bounces-50331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA73ACB099
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E871884EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220372253B0;
	Mon,  2 Jun 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOllxQD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E3224245;
	Mon,  2 Jun 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872944; cv=none; b=pyQ+/S/TOtnpp09KhNyWBXNrUGJDaLXQDXcuwfggbJ+uO9yJNKNIASPZ1w5JXotCA2wMDdhhlDGQk31ZNlNPR288Dc5jxYzdE3myiuAj1DwPnp5IvDTjaN8iq2DkPjxBIB7y9rmQ6YpsH4qozYWzin/qpcyvX1dNMYIgk8G92MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872944; c=relaxed/simple;
	bh=ZrFup30IUUI62IhIRTGdtQyA3ni1qkUHKiEvsunwAIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBpzpBggOeVtG9BEyXo+UTaesmJ29TvUwCTrkbNHcpZq3OTtMNzROCTQDcNWWbjbJyh9wwa2zTwEke2z8HVnzmk7gNrBO3/zvjFjQoMSbzvtxOi++dGSWgoBSkyyuWDYOnZdGwASjho5bdkvJ0Wt2++IYdBt1gtQFd5Mhg2xQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOllxQD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACF1C4CEF5;
	Mon,  2 Jun 2025 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872944;
	bh=ZrFup30IUUI62IhIRTGdtQyA3ni1qkUHKiEvsunwAIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bOllxQD0QutP185Tx+5m080NYaVFu/O8IYq4VMDolty/P/OSOenm0IFy/5qjX2YH1
	 YgAmwfzQUR3pN1VHhT5OP1ESmeA1tz9QLmLiauh8CC7OjrwJCwAqXlWaMYjOtZTXpi
	 8mXs4qcJncvNH3LyKlPiZydfldKGUEl1qJQ34tEe7EdCu3nYG8Klv6oq0AjuvsyEWW
	 W0xt5u/THz5svq3SMg/YUAZAreWLy+SS12qq3oERDKZDrG6F3N5qiNBNcQDoN8+R2Z
	 GPnFJx0s+wWszvs43irEtRrB6utXaGwtgsQMhvZ8VtB+Tsq1cYiPjCUGHuoESr2cSR
	 YUf7p3u9/4Ucw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:44 -0400
Subject: [PATCH RFC v2 01/28] filelock: push the S_ISREG check down to
 ->setlease handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-1-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZrFup30IUUI62IhIRTGdtQyA3ni1qkUHKiEvsunwAIc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7kbGXbFK+2MezlY3MJ/Xtzr/ggiQYYbxlfc
 LXfkYQCqF+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5AAKCRAADmhBGVaC
 FbHvD/9vSTVF8NJ7ALqyShqeu2mSuoidlK+DgJlsHzCpSFoJ4QmMFY53YntfUE6tg4GYQgGRxv6
 eL8ix5GzWuQCu/aZ9F5Fpno+yDZ9DbZPumGZDUQy3pWpfSfeiqtV648XILPtQMZdzH6l75LVnut
 4DrL0vRNg4UTjJP4hHXTKrt6O1hYmX3XNlyk6m24CMa/Pv9D/hVoOk1h7Q6EUyG8Gq6BsY5uIyT
 0z1KH1Ok5xg9uj1Xj5RyB4N2lHrBMbucFWTh74ug0L2ebnKve7dh/WiIQgpTaf8L3AQ7yHj5OrA
 Or+8t0/98p1RRVq57i/uShY7+gMgzLPBzJSq6kMVDaMODvfcTLY09XMYypKTDEN2etAifXPTz7/
 kgLw7P2IVuME5DpLTXpH7VGyod/qbu+f/lu05uBLf7z+gexzz6Xesf6eHkIenCDJ0JBTX33GHmg
 Lb7hazPie+DtN0CWxTBzjzB6HqeOq9xgh0VNEI5MemTkcCgsnidLu/UebrKhhqHOfvsqvk160pV
 hFSUV9a9+FLTcLFebW5qAclhoKvi9oWOvby2qoQCwyNpqly+NJEkzwu3sYwjlenXz2bHspYTYsc
 7x2I3jSCyKW7eN7Gecmy4Wgf6okjfult8w114tBEVjgLSGyC38PNSiukTa+C/k9mOMdjMZbvfQC
 /n5RRBGG/tMRkHw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When nfsd starts requesting directory delegations, setlease handlers may
see requests for leases on directories. Push the !S_ISREG check down
into the non-trivial setlease handlers, so we can selectively enable
them where they're supported.

FUSE is specialr:. It's the only filesystem that supports atomic_open and
allow kernel-internal leases. Ensure that we don't allow directory
leases by default going forward by explicitly disabling them there.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dir.c          | 1 +
 fs/locks.c             | 5 +++--
 fs/nfs/nfs4file.c      | 2 ++
 fs/smb/client/cifsfs.c | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 33b82529cb6e4bffa607e1b20bd09ac489b0667f..c83e61b52e0fff106ef2a3d62efcc3949ccf39e7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2218,6 +2218,7 @@ static const struct file_operations fuse_dir_operations = {
 	.fsync		= fuse_dir_fsync,
 	.unlocked_ioctl	= fuse_dir_ioctl,
 	.compat_ioctl	= fuse_dir_compat_ioctl,
+	.setlease	= simple_nosetlease,
 };
 
 static const struct inode_operations fuse_common_inode_operations = {
diff --git a/fs/locks.c b/fs/locks.c
index 1619cddfa7a4d799f0f84f0bc8f28458d8d280db..a35d033dcaf0b604b73395260562af08f7711c12 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1929,6 +1929,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
+	if (!S_ISREG(file_inode(filp)->i_mode))
+		return -EINVAL;
+
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
@@ -2018,8 +2021,6 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 
 	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
 		return -EACCES;
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
 	error = security_file_lock(filp, arg);
 	if (error)
 		return error;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c280358209f22503ea573a906a6194e..b7630a437ad22fbfb658086953b25b9ae6b4f057 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -442,6 +442,8 @@ void nfs42_ssc_unregister_ops(void)
 static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
 			 void **priv)
 {
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return -EINVAL;
 	return nfs4_proc_setlease(file, arg, lease, priv);
 }
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index fb04e263611cadaea210f5c1d90c05bea37fb496..991583b0b77e480c002974b410f06853740e4b1b 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1094,6 +1094,9 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
 	/* Check if file is oplocked if this is request for new lease */
 	if (arg == F_UNLCK ||
 	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||

-- 
2.49.0


