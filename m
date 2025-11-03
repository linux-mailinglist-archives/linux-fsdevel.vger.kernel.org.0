Return-Path: <linux-fsdevel+bounces-66779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D89C2BDC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D762F189AC65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349431079B;
	Mon,  3 Nov 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg4fQm5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224563101B4;
	Mon,  3 Nov 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174385; cv=none; b=o5yNyf1pPd+yf7MiTwCyp7zDm1fTtjRdY85HLiXTSp1Pym9KUR/fB6qiAadvv68pX1iIxefdt4ViWQDkMGMB/EpJc0S0NVioR7RbfwqNyKtUZJsOX2F8rm20nvAayOXUieDidfbSgiMg83lnbbPp2lEw+i6gOZMVvOufkeDfaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174385; c=relaxed/simple;
	bh=GcsMrS33yeMCZHbhLsrwn2fXghDYDgJpfU5BwKmzfzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYjePbRO4RUrix5zI2zbK6vhguXpQMyRJAwryc1lWp0d0kBz19Le1CrnA6hjDBZ3HJ33jTdIKbOKN7ZcNMI2vh0KQNSJ/s33KT7N6Ohbjom1l8TbTm8hMXT6e6LqkldDY8BT9mc/IjNQW43uiokEug/Fi9aD/c3lxtW4gLoX7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg4fQm5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E857C4CEFD;
	Mon,  3 Nov 2025 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174384;
	bh=GcsMrS33yeMCZHbhLsrwn2fXghDYDgJpfU5BwKmzfzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dg4fQm5soAyKA3v+1JP2aNfcipOpouAI/3YdPAADtM+IHvepxzD3ZEkMa4HmGLHRN
	 lcsuaKbsAQI2NzoLQuo1LsEQs2gCERf10dxbqOA5FU0z5JjUW8fXxpUMaAMU282mIP
	 5cvBE9tldxaEJG1V5cytTNMG5SAdNmzKrHXqgea4bYOI9Y1agm2DimU4AdgajEBLZN
	 DxFAmpCwaSXex/8fPTVNnrgOx8IUBz10EEcjU6CfhgdE+2e6CoDdII5ax4AZVzTh9r
	 bbIb2O3RU3piRAXYpY6meifjq7ebVdte+o4589bbp1OjC8SCpUVgdBxvzTTIYrBXAa
	 RFuQJcPwLQskg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:32 -0500
Subject: [PATCH v4 04/17] filelock: push the S_ISREG check down to
 ->setlease handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-4-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
In-Reply-To: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GcsMrS33yeMCZHbhLsrwn2fXghDYDgJpfU5BwKmzfzs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWc97ftCqyzCG7IGvXML5YmMsCRGcKaqblYR
 esf9TI/CTeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnAAKCRAADmhBGVaC
 FTRQEADQnOUc1rtYachjMJVYxJ+ro7m9R3DGgnYVF5HZgvodW1Q3oe3qjJiG1KD6/LmUhHxwtw0
 nZiYqtKEW1e2vUUhWgWkqVt/NioQjjfil/Jerb0g5XqWn1sJAjCF6pfuUlbbQ9CI+smUjKFvdfE
 0qzEFrjiXg95hYi+pI05maVzwQHt37BFUgR/le/knDbX5VfpNMUpgzk5j1K1t76fr15i+FBYE0q
 ae8nojCvlvJ4r7QIj8160xgIm0Uy8cDeyWGQRHdo5KrrciHJ2LzOlKAt/e47Cz4icrK2OJbBxh7
 gcMmPaaOas2qqiFntW+jgIIdZsvrKS1kcp7UcAQDRbmLC/QBbJaySGKajIsAszmPjbNP0VCeTXm
 EMA8N2YufhyYcf3SbdpQAVYxDXy/PrGLz1qp+4bS2p+fpOo3xqvzRqf1mDAFNdF6Eqzl6eNJZcn
 qeLyHoNc68KmiH9l/H14JpobB18L31TgJ3PxXCO16hQz4QsqK09Lqx0a1TNP/NK2UnCfV6eajIb
 Wn/MrZFXWiJOOg7z90ItpH7fHA+v6kKd5hztLCym41yRhXnidkx+4YeRgQIYbLbSxoAu9V4DNvi
 Z0tbCDu1sbaPsYH3RfVjG0VdpeW4f7j4GKGIn4FAJLM8Y9GSPm4yBuOhn7TOEKrBAeoWxmaFGtl
 ZZFqYrMp2q6nWTg==
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


