Return-Path: <linux-fsdevel+bounces-14489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5B87D18F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4984F1C21FB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF274DA08;
	Fri, 15 Mar 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUDyOe+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B464CB2E;
	Fri, 15 Mar 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521590; cv=none; b=SnyJj3kgCKVscIuXKMYjLuOQOsqTkLFkr90L3Zex4P4C+HbBoDPpTDBGat6nQWU1OnIIlK5F6lXt7vQn664t4A1PVB2vmbH9O6M5py8jEsY9BN+y/zPOrqrjLtGZPEvEjYslZVepMpWlAVuWx1vjal/0N7aBFx5i9CdTdR/E150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521590; c=relaxed/simple;
	bh=8T+6AOlfeQNDoOcwsJEzBNC68QavdbxR38E+z9RzRco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afb3MXSTdZKVZGCaNc1I1G2hFyrLkmvjuGga9YO7hgjM992oSycPUMdjEcjoZkcPlohvqw/d1d3nHGwCtP52vxW/pYvInnJU+kO/fFOV9odNDRvTCvxFDdXYcSYNMcyp5+Y3bCCvHpVbOCxJRxg1ttdqMw5jfeW7F9TvcFjgc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUDyOe+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE9CC43330;
	Fri, 15 Mar 2024 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521590;
	bh=8T+6AOlfeQNDoOcwsJEzBNC68QavdbxR38E+z9RzRco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AUDyOe+Q5lZxtJzsCf7qTK7H4/hxOvfkImC2NcB/evyqNClohpHmxZM/hQPJsf62W
	 DS2OP7iHyOMqCuLZSAdcO+7bfYHpQsQGMz75vrfBzjd4ZrD8EPsdjA9TtraEMbWkso
	 pBvJ6alqfXf36Cg0xIL/2JH07c1Rf2G+4+BkQco4koJVWwTdXCtdeSV7KHARTZ0sFu
	 kcVjcqI2sbJyJR9MH2SG0adqDaYmkiT+9sJLBpCKLr5m4Ch9dkMvAf1J7DlHh55TjN
	 TwkjEDioYr1cUN6SH3fAMVdXAEP9umrPP+UZfogGhXNBKKReHUEEkIO01aZ1+QeQIK
	 J02PcEkUH6g+Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:52 -0400
Subject: [PATCH RFC 01/24] filelock: push the S_ISREG check down to
 ->setlease handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-1-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8T+6AOlfeQNDoOcwsJEzBNC68QavdbxR38E+z9RzRco=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzsJ1CBEsrq8i5Ktjn9sZVvT1iJpsa6mUcrE
 MFBp+WpUjyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87AAKCRAADmhBGVaC
 FQ69D/9Gv0ui46+5Z7asnVv3ONO1FfD1Q27hfM+zoxC44Kn2IQR1AW8gU2Y8zAvnx+bPM2W6rdZ
 uNMueRm6pIHtjRX3LpIkRbXADPaQBhtMoLBO95opU0PQe3b3Fv04BN+drlyJvG5NsxclTzqAy2R
 swCVQh2cvBjPik90E2d4gGpaddqJgzmThyhFzcvpJEyECheSWljRSj81tlcXZMlOQBvwDaxHnNT
 fHnWxSvqLaIpDh/7XJgnNFp0/auy/nV4mM2KfUv5dm9Oxu3Dnm82zIB0130RZMj6vce9aLWT/+n
 rexsrTOF/SLE+jSDlfaHy9NxF6CPDaj8vSNDWf3fVfuquN+kLhLOgvmO0ug/zNncgBCM0nP5JyC
 P0XUPWUvlXqlL7+liFs5YZ80jR7FJRWmE1bZzSRI8PTmj6YEU3p5mvocnBQLfMJnz4pFr7Dh6xX
 7ZaGDJNdZXagKsz8fn0abO9543C8hej+RSPpR58Ma9HcYvobnDub4aU0WbQr29FTsrCzGxKERih
 +WjetRDcMl+QrhIU148tacvuu/wT8fZXaAOUjtDkGG7WOC5UG9NnJwL+blCyM/wKNnAerlLitmS
 UBJmG7hTqXYUtBqb/01UE30rbth48Q2cc/4qu8TZqt5hC0C1LpETknJMBmZNaZF9EgdhI10RYw3
 KVk/Jrr27U64+Dw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When nfsd starts requesting directory delegations, setlease handlers may
see requests for leases on directories. Push the !S_ISREG check down
into the non-trivial setlease handlers, so we can selectively enable
them where they're supported.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c             | 5 +++--
 fs/nfs/nfs4file.c      | 2 ++
 fs/smb/client/cifsfs.c | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 90c8746874de..cb4b35d26162 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1925,6 +1925,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
+	if (!S_ISREG(file_inode(filp)->i_mode))
+		return -EINVAL;
+
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
@@ -2014,8 +2017,6 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 
 	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
 		return -EACCES;
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
 	error = security_file_lock(filp, arg);
 	if (error)
 		return error;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c28..b7630a437ad2 100644
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
index fb368b191eef..81a96fbfa3ed 100644
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
2.44.0


