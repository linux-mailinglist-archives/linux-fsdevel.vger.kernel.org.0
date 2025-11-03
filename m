Return-Path: <linux-fsdevel+bounces-66788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1FC2BF0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B266342171B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D73164BE;
	Mon,  3 Nov 2025 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlIGZDqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADD30E828;
	Mon,  3 Nov 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174415; cv=none; b=UsVB9ZqAwqBMkmzPcIxXFH2R3EDOVXizHy7E8GKQhmHB51yC9wou+DpjProdBAO7rUezH1gZ76VTkuYpGA1yRCFDjCbg1+Dtl7I6HP13wEd3u0w/X+mIJ1KnueOnbwT0OgbjWv16zCwTfIMlrnb+CwAJwPfm6UoU92YzWjPnDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174415; c=relaxed/simple;
	bh=fAStZ1VGox28sSBTaeIOxtIwVEbCulrkhuzHCrifXdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvCdKWknA3SMC1PRwQ8ohgU23GdPDeRxHuBoWuaTVtvVIuvhT0mLlZ0Jj1YURRYKGdcNCdT6+kVIFZO+UHzdpnwNuBjSakGpv6vGv4ZUL65I/PgLi5Al3Gkv6OyVhhoz9HGjU4EXa6gGvkJXPHGU1Wt48IRlI+IU2ZkIPItswEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlIGZDqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD3BC116B1;
	Mon,  3 Nov 2025 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174415;
	bh=fAStZ1VGox28sSBTaeIOxtIwVEbCulrkhuzHCrifXdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GlIGZDqUHetc2450ZHmmkS8cLtoED4qaEyDWrLL7sgqMB6y7O1Jp/Ls/4o08dn8KA
	 qZsPAgwQEcYABla/xdezJFCzDyONhom/1tZJOClCGXhlnrQ89Z4N2N+W6KVfDzOyQe
	 LUFLPshLT8YJfl5CZxNKYX9FVs1n//E2U2VvQjJRpeWZLZQIkMn7lxzM4/H9949sSt
	 ipVZGlcirxhCfNKouU5Xibvjvj+LCJvJdcB7Q0RiEQoB5HG7iszENKnq8jwsS6MzY+
	 Nm2gz53a2xFg36g9AtA2FKblLXr/wj6/CtyvUujbZ2ppSPpoWpgQJsPJMqC9Tz1PrM
	 OHrLpooEtUSfQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:41 -0500
Subject: [PATCH v4 13/17] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-13-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fAStZ1VGox28sSBTaeIOxtIwVEbCulrkhuzHCrifXdg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWeZxaSzbRnP+HDlhpPctVnbqfGrRC1V8YxE
 oZtToTbH6+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilngAKCRAADmhBGVaC
 FbenEACbMPmeDuff/GDAt5OB9dYhRo+Q+oT275O1d/yBl82BrIN5VTAtFQjKIJyJw0snHqc38qX
 eVaSzt72WO57+DokAfihTvCe5UthsojJIKJ6h0ciZhH+KBBmT1i8mzMvakv5Fku3Rse5bLvWU6k
 SbIvhmfXdjvhB2XeeRGf+GrR3wplzWalJHcK76YklTajmJjuaEnx75Aib+rNge6ZPM4gdWBPFqA
 DjkqbSrWHBKLLU+YsOH9LA8OkyJ9YcDtI3LlElgDxzFLE1V1vcn8XpNr9HcbI5e08wq3/1NnymE
 Ui54ekwESIysx8SwEcDTjI+9IbjcpHNghEMvErNSujALUOMBbZAj5NRME3Z8jehynHVoPRr/FWx
 tRSS6J9TZ+ia/EafHJ4yFtu2qpd5VduNC0LP7x3kgzCAZWQ196V+2Py4tyMltvaQGCPW6LkILZ7
 I+ZGlV24jT4K0A2hle3IoJy+7zkRZEOO4vRQHjZyUia7ZnVAa7AwoIEhkTOvzVJ+XnmD+PuNw2O
 QG0seOiDurZM9wO7V6oOr7PTQThvXZlvo9HdeDro/UrRqF7a9jGz6nuXpAWs3jtpr5EhxpNlGLg
 X1Jfzq7nqSuhG4AvIaydSRYlnYsGJqBDDtWm/1T9mentCOqwxSZu3UTwLzG+5CvNd0gbI3b0EB4
 XIr2K9Nxc+KiK/g==
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


