Return-Path: <linux-fsdevel+bounces-67950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB14C4E6FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A0FA4FD86B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043E136998C;
	Tue, 11 Nov 2025 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If61DYpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB1359F92;
	Tue, 11 Nov 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870429; cv=none; b=byKc+z2l0CQFH7QtQpppW8NpEwvCCe/PyBccIIld3D3zm0nUtR5Xl1fzCcwOczL4YqPCfxiaZNXElgLd7enwfzSXeLaxFSSDWKCUKsDQmZqk0USvEAEID0GljsV3N1oj8pbM++jsFGJUcovsFTL9W/ie5mZZVK/QY4zpNXGsaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870429; c=relaxed/simple;
	bh=fAStZ1VGox28sSBTaeIOxtIwVEbCulrkhuzHCrifXdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jyb7uBFwedt32CL0rEvX9gIIzT3CCOFYAWBbaC5FhstG1Txzqy8FQBthqknPeqor0jOx1Qa5ejEjWjGQj4iH8h8iyRPz7z5wm3Kj9HEO3uR3ay7qbQN0YtS/DI3wqcYCEU8dUNrllR3lIDvs8f9PMMx3F1uhTfaBBykI1zN65Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If61DYpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4228DC4CEF7;
	Tue, 11 Nov 2025 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870428;
	bh=fAStZ1VGox28sSBTaeIOxtIwVEbCulrkhuzHCrifXdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=If61DYptj2Johvj4/0m2cxn+Jtx6+aoRvnud/ewIdmU7XltDGeH4eF8ApjFSI8p5l
	 lnJ7p5pHfiWY9VAIz8ULd/GGL10Bo1rTaWcSoOxXrV4YoF7dUsDUhRdfSKXFKqjLBR
	 4bYovpJS5+2rVJs/dj6U0k+Vc9PZ8vLRrX+GPSq1UTXg0eTqBTv17mhEHH9U/8qJps
	 AecM198CDxKtyTburtc8E+EolPZSo7VY7uhafX1OEVF92DT+qeEbud4TGLZaF8kAyW
	 Y3+7hqpqm4xIbM7ZN8Mvxy4JMFETlKhjeFeDbkMB1KZrgYGtNZd7+mgPko37LvY4RY
	 kPvS68ayzmBtQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:54 -0500
Subject: [PATCH v6 13/17] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-13-52f3feebb2f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fAStZ1VGox28sSBTaeIOxtIwVEbCulrkhuzHCrifXdg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RpBaIjdJGfeWQB08MiWg68vBQK/vGgJilx1
 nTpnUBoo3aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEaQAKCRAADmhBGVaC
 FYItD/43NGFBQ5pVg7GHt8Zf/jcXtSjHtrYj/S2C7cYhT3FJf+kTEgrMJmzVHxFLgryrDWaQ/eF
 Hza74PqVL/HtkUFhWpnbE0T2jdxkSwo63YJ5SPRIY7nGLhiWwWMv6Sow1jmTurFzbDj23w8AGQY
 rKKF/WikvDHwpkauZgxO84lKW19Nm2Qxrbj2c65+pKBSSe78HGLoCk7WhQAg4VoNn4FH0nIiKwJ
 zRjj6qtxRPz0rzGoK9IchUm17FCzUCnohzcScWvZMRyE1hrJF+yKvx+wFwMdCUz7MMBP92PJ7RL
 +l0oBdrf9TuwtKYYQ4QcnCYevsCgAuHAunOxeyQ83zcISxxNXxt+ZllngERPizslssMyW6NY6xD
 HjDGAzJYWwEX0WkA+Rvc/4Kq567dEJe+u5IMSBzvgFeFw12HmcB9/mvHSD5KlkSJ21UXcH/dYa9
 R56vExc39LcDoV5BPWE6CV62jc0YY/6WWXxNWO/YeDpyP3suDCkvJaIT/15e0s4i21Gp8T62+Ls
 cQRPYMGq2ORcvKEoO/OkzFlziji/kzKo2otj/FtxNr4sTKdWPrOpA2t+iyvfaErv5FCJHToXT8f
 aH+eQnX2C5+Q/whAqJdJmLVWmR3LOgrSry1lK8+XC93T+ov3d33KDhqIEHltVL6aUJGMQf+zNi3
 +WIHlD8FCIVSy1g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the addition of the try_break_lease calls in directory changing
operations, allow generic_setlease to hand them out. Write leases on
directories are never allowed however, so continue to reject them.

For now, there is no API for requesting delegations from userland, so
ensure that userland is prevented from acquiring a lease on a directory.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index f5b210a2dc34c70ac36e972436c62482bbe32ca6..dd290a87f58eb5d522f03fa99d612fbad84dacf3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1935,14 +1935,19 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
-	if (!S_ISREG(file_inode(filp)->i_mode))
+	struct inode *inode = file_inode(filp);
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
-	case F_RDLCK:
 	case F_WRLCK:
+		if (S_ISDIR(inode->i_mode))
+			return -EINVAL;
+		fallthrough;
+	case F_RDLCK:
 		if (!(*flp)->fl_lmops->lm_break) {
 			WARN_ON_ONCE(1);
 			return -ENOLCK;
@@ -2071,6 +2076,9 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
  */
 int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 {
+	if (S_ISDIR(file_inode(filp)->i_mode))
+		return -EINVAL;
+
 	if (arg == F_UNLCK)
 		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
 	return do_fcntl_add_lease(fd, filp, arg);

-- 
2.51.1


