Return-Path: <linux-fsdevel+bounces-67941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6639C4E601
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F83B5ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BE635BDBA;
	Tue, 11 Nov 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivq4+v8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98C35A936;
	Tue, 11 Nov 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870397; cv=none; b=blUCJq2n3F/rfHwyQFfq6C7zqWF6k7o1diCOeZPXP3IyDm4FePaUqJD2CFu9HArFjp0Krf5U+cxE04fCBiLLbze8JPTrkPStL4ONCaf6M5vt5VXGiNh94W3XQ1rmv/ew9lkAHX0SOANcWQFt1YS5PMbLu2uYYocgF34cOx3AtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870397; c=relaxed/simple;
	bh=GcsMrS33yeMCZHbhLsrwn2fXghDYDgJpfU5BwKmzfzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4Hu4uwL0PurD0xbxYsujbu7bdS40QO8xuK1LwsdfT0I/0zlPA41oASGINtaGXaRRvDvfEn93GoWCmWVw/gVZ7jH58D0j8Ue9lv9UdzY7ZVP6XrvoQMa/77TzzK7UojyCFI6cygb8AxatgXeIjzT6UboDUa9tQez+7azCZREfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivq4+v8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D2AC4CEF5;
	Tue, 11 Nov 2025 14:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870396;
	bh=GcsMrS33yeMCZHbhLsrwn2fXghDYDgJpfU5BwKmzfzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ivq4+v8LZbq3VMIZRAx9xaEcxmalQwXvKiyED/tMFkRt4VVX7I025l65WOZnUOVL+
	 dPmRVH27FY//79kyYzRGBxHYShbY5Xdlxkv3fKCOsrbfNhXcF7t1gsY4WYcFe+6jeX
	 50np0rCyHx2NmNM2DSqzy8V7ZVdoq4MuE0tnj+NCZtn41egInm4GOC4GV+PDNzxdmy
	 TpTko2hl/DCNiF5ui9sw4krd1L5uuWr8ij+5POHpmnbcAg3PyEml+dim6vT3TqbAM1
	 kSbnK6DWC04CE4jwPy4kQn/XXmhpqJOxKVKsbwv4VtZlPUKjzORSsOLav8C43m6MHz
	 yu20qE7R7Efgw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:45 -0500
Subject: [PATCH v6 04/17] filelock: push the S_ISREG check down to
 ->setlease handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-4-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GcsMrS33yeMCZHbhLsrwn2fXghDYDgJpfU5BwKmzfzs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RnZXf5vWXMu7ocP8gL9oRsQGQv1qS2Zu5wH
 N2iZG33UIKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEZwAKCRAADmhBGVaC
 FW4MD/9MZbM4ESjlmFlYCPKFhX1BTgL8Q+8KJzx5nJdclnxMFkFG0nH32rDWtvOppDG0LDftYcC
 fF6UvsBVPE2E2J+PGBvbQ9UYq9XmE0nu/5lFYVSWE6Wxk1/hYDlZOc85SdXOA5puFW261KPlfFO
 eAyPwB4sv4oAmJ/dkiaDWrZ0TGWemevtt1QkwBPTHmdfBmfd+SxtHBpxuRNtctnjDYo3soPJCMR
 fCOcgYT+3UVxoliPhnX/I1MMkbp6117M/SYkbGsfs5Dl66wiM44a4ZuaWN2w4sZ0TRSiSbcbpf1
 T3fqHmIU6RXB4RifvAXE2PzLpIx7tkDjBGUi+CnMa6N5BDEtksc1X2LPn0I1Km4kNow7TyYNrac
 AyWrrqBE+bpArKW/JIOADVAXUL831m6MYwoUSareQcliPX+/uLdtUCRvb6+XDed7ppNkKEr+tL0
 ZRhY6pT8bf7PxPpRq//ZEUVtHmdmfPyYfIFxON1s/7sLKTGz4uZRsP2V6VR3MNNdaudgI0dh/ss
 4xTd3Xzlr4s3J+ogsk0+/CTXZXdDhve08Cn2MijyqF+0o0ecCr3qQOAQS2YIEMnEyS4/YHeEgsc
 T5INL5UHK6NJyT+PRsBZKbhmnBZ6P5ZW2l2K+HZ37wumHkc6Xy+PgsujQ9sYIOjVIlrTllqIT9U
 xvX0/3ZTPlu3ocQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When nfsd starts requesting directory delegations, setlease handlers may
see requests for leases on directories. Push the !S_ISREG check down
into the non-trivial setlease handlers, so we can selectively enable
them where they're supported.

FUSE is special: It's the only filesystem that supports atomic_open and
allows kernel-internal leases. atomic_open is issued when the VFS
doesn't know the state of the dentry being opened. If the file doesn't
exist, it may be created, in which case the dir lease should be broken.

The existing kernel-internal lease implementation has no provision for
this. Ensure that we don't allow directory leases by default going
forward by explicitly disabling them there.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dir.c          | 1 +
 fs/locks.c             | 5 +++--
 fs/nfs/nfs4file.c      | 2 ++
 fs/smb/client/cifsfs.c | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a132e7cbb88121e7db7fb504d57d3c..667774cc72a1d49796f531fcb342d2e4878beb85 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2230,6 +2230,7 @@ static const struct file_operations fuse_dir_operations = {
 	.fsync		= fuse_dir_fsync,
 	.unlocked_ioctl	= fuse_dir_ioctl,
 	.compat_ioctl	= fuse_dir_compat_ioctl,
+	.setlease	= simple_nosetlease,
 };
 
 static const struct inode_operations fuse_common_inode_operations = {
diff --git a/fs/locks.c b/fs/locks.c
index 3cdd84a0fbedc9bd1b47725a9cf963342aafbce9..f5b210a2dc34c70ac36e972436c62482bbe32ca6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1935,6 +1935,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
+	if (!S_ISREG(file_inode(filp)->i_mode))
+		return -EINVAL;
+
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
@@ -2024,8 +2027,6 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 
 	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
 		return -EACCES;
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
 	error = security_file_lock(filp, arg);
 	if (error)
 		return error;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 7f43e890d3564a000dab9365048a3e17dc96395c..7317f26892c5782a39660cae87ec1afea24e36c0 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -431,6 +431,8 @@ void nfs42_ssc_unregister_ops(void)
 static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
 			 void **priv)
 {
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return -EINVAL;
 	return nfs4_proc_setlease(file, arg, lease, priv);
 }
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 05b1fa76e8ccf1e86f0c174593cd6e1acb84608d..03c44c1d9bb631b87a8b67aa16e481d6bb3c7d14 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1149,6 +1149,9 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
 	/* Check if file is oplocked if this is request for new lease */
 	if (arg == F_UNLCK ||
 	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||

-- 
2.51.1


