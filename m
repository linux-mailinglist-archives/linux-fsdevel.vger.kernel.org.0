Return-Path: <linux-fsdevel+bounces-67938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF498C4E55B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACB3F4F22F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8543E34252F;
	Tue, 11 Nov 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9bXfKuB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8583340273;
	Tue, 11 Nov 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870386; cv=none; b=K93gtOuXUILzRDhf42TEJV+cGPCKFxP3FG9ykS4hRzCxPc7TK/3mIFQsNny7gCNNDwEvNgh+EBU3kda7/j6eGs8Is6brvnibKuwPQfkcMph7PvpBoc00NbZQ5y9sXQTSLBuo7CMhZZ/x5ywdIAlGG2cYvMTPqLbhhTK0jwbOASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870386; c=relaxed/simple;
	bh=ga4TmUR59KoVfl15gt127269qV+bjIfb/4EDiwVOlYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5M2IKzVP0OVK47wXLVYRr+PK3bA50wU9C/ARhtKUqmuzAuV3EUNyNcjKwzNksacsloA7xTb1caQRCLBfUZB3e/o1lfXVWZ3mEoQLc41mnDeogOFX17o6UT7cW4NytbqsiyfvqSiZL27tFanHi2blUUK9O4Hwr6cBBYFw+z/1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9bXfKuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46A2C113D0;
	Tue, 11 Nov 2025 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870386;
	bh=ga4TmUR59KoVfl15gt127269qV+bjIfb/4EDiwVOlYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E9bXfKuBMW2JliZ6aGlTLM4Xd0dB4l7pUYEuG4qMSJW5e6n726UYTXe5n5ee7xago
	 luZUPcBdKt06aOSNpLWX1rJhJnC1nCOHxkMjTGTJxV9c54tmnaz8u8y4bbqDAgwbWE
	 d+fwCso2l96m3Oa644JlFnOm0V42ZvI0P4inYT4CVdnK+SADEl4UwyvQVqiZ0Kkq56
	 7qLDWQM7n294J01uwinZBCNnGUgnEHiEdhHUgv0uCbGk1rCwlBrFGN8iU4beultUEu
	 cH9Ih5uM/vTn/16QIjbBTo5iJ+XQIMlhiDHsgo1tsxJj709JzAASMZYoppXEMgNc7f
	 i3rCfy4awilzg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:42 -0500
Subject: [PATCH v6 01/17] filelock: make lease_alloc() take a flags
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-1-52f3feebb2f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ga4TmUR59KoVfl15gt127269qV+bjIfb/4EDiwVOlYg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RnLXY7FpMdMxxWLOen1XZNghWf2CF671/r6
 gSGJLumTVaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEZwAKCRAADmhBGVaC
 FcSPD/9rXYYtQ/eGtCAdPwikcbaFG8p7gG5XFbymlb3VCn7rw4OyvYgIYnVsnrTh+Wn5oRmTefA
 M6mZk/yrNPSTz9PrkRBrBssmrOAIfcaY3UEUHUE8vnOBEaucMbZxB09yoblM1cc3ukpE4MEfS/X
 K1Td/OPSJDOtH6B0csY4IFzDHWkRWGrzNAoVFNlk2+fxOJPKou6KzljUBHLv2gyKopDnC6kdoJW
 YRQLZCVwUOf//mXlYGqGQDVRpSK8lpwtzsBwwWjJgP0TDpRnFvqCf2JomQpej/NIks+1A4uLpZb
 bO4FvOygF7+pHiQTavwGA/IH+1HuXdaGWfUzG9BKEgK37C34aZBvUW2VhTrAlc7HFAXmvV0h1wz
 qYZSojOLkwohht0vh9uUe2cLaLWo2CCYerJ71XooJPOgI3pyTd7t+Yp+EE9UyFC6agKmin0Byri
 3WgTC1rEbD6n+m90TdFQThE0+yAWxfNzoEdGhqQUzhjiVrkCX16uxLIgBXR1RvybmWYxAeTpFvt
 PoFlCNod8DWjiVjfhlPWv0w2H2J9puJ2fg5Z36wgVSl7WKYdp9Ojm9FYLcYjyDCQY4CMv4VcoPO
 1az7EX0cX8i3SypZw2magCeiHAveZAFjy59Ae6g5N0p5huhHUOH3xb2EJArDw6fVZQpsJrY4SxK
 apjukdfuLJQjucQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

__break_lease() currently overrides the flc_flags field in the lease
after allocating it. A forthcoming patch will add the ability to request
a FL_DELEG type lease.

Instead of overriding the flags field, add a flags argument to
lease_alloc() and lease_init() so it's set correctly after allocating.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e2072461b6e2d3d1cd12f2b089d69a7db3..b33c327c21dcd49341fbeac47caeb72cdf7455db 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -585,7 +585,7 @@ static const struct lease_manager_operations lease_manager_ops = {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, int type, struct file_lease *fl)
+static int lease_init(struct file *filp, unsigned int flags, int type, struct file_lease *fl)
 {
 	if (assign_type(&fl->c, type) != 0)
 		return -EINVAL;
@@ -594,13 +594,13 @@ static int lease_init(struct file *filp, int type, struct file_lease *fl)
 	fl->c.flc_pid = current->tgid;
 
 	fl->c.flc_file = filp;
-	fl->c.flc_flags = FL_LEASE;
+	fl->c.flc_flags = flags;
 	fl->fl_lmops = &lease_manager_ops;
 	return 0;
 }
 
 /* Allocate a file_lock initialised to this type of lease */
-static struct file_lease *lease_alloc(struct file *filp, int type)
+static struct file_lease *lease_alloc(struct file *filp, unsigned int flags, int type)
 {
 	struct file_lease *fl = locks_alloc_lease();
 	int error = -ENOMEM;
@@ -608,7 +608,7 @@ static struct file_lease *lease_alloc(struct file *filp, int type)
 	if (fl == NULL)
 		return ERR_PTR(error);
 
-	error = lease_init(filp, type, fl);
+	error = lease_init(filp, flags, type, fl);
 	if (error) {
 		locks_free_lease(fl);
 		return ERR_PTR(error);
@@ -1548,10 +1548,9 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
 
-	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
+	new_fl = lease_alloc(NULL, type, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
-	new_fl->c.flc_flags = type;
 
 	/* typically we will check that ctx is non-NULL before calling */
 	ctx = locks_inode_context(inode);
@@ -2033,7 +2032,7 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
 	struct fasync_struct *new;
 	int error;
 
-	fl = lease_alloc(filp, arg);
+	fl = lease_alloc(filp, FL_LEASE, arg);
 	if (IS_ERR(fl))
 		return PTR_ERR(fl);
 

-- 
2.51.1


