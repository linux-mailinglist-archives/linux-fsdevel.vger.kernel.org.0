Return-Path: <linux-fsdevel+bounces-66776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FDC2BD9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BD01899756
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B330E832;
	Mon,  3 Nov 2025 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR1zJoP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4730DEDE;
	Mon,  3 Nov 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174374; cv=none; b=Hk7lARYCEnS7VR9ZeMJy82gblZnriL6wFhhKiE5fEe51W9KlfsD7cRMsjSPB+pSUemg9sV9YdjHXpCm/+amxOKIBYmMfqoS11OLJ7+f4J0Gw2BfB0FNvPN6kehlV4wZ7u+zh6nUOCCq511dZYXbDZwqrgt3AG0EVL2/8pZiaq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174374; c=relaxed/simple;
	bh=DYoclxA9VZrJYyH2ZjWf3xD/XgnD9xjMazzJyvQdh7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrMkTBlLRSDBPcAA9hyOa4YAH3gSIlvgfb2LVGBXxW691ayEag8QmiPae3ZbiC1e/ZpVa94X11HIV5RbFoL1Hl+z18HBuPtogSwNKROVW1PdcS9BTWZMW9tvMEwZsk1vbqpNXPuTZ2mdC/2CdascpuFmhNa2woe8TV5Sf6bcDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR1zJoP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CCFC19421;
	Mon,  3 Nov 2025 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174374;
	bh=DYoclxA9VZrJYyH2ZjWf3xD/XgnD9xjMazzJyvQdh7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NR1zJoP8/qYNRoKn8wIVBBiJefwXKSiHbVyTKEZeNYBlHEr5slnC6gQNyeUyH2Chs
	 2ragPzFggE+LiABTAAEvH12jJjTcWZof+jNRXmshP51gqrxqDTGfSNO5IAjpk0C0MK
	 XS3nBPUdG2ZRPs0a9FZfQgNKhBgHoZba/0vEFJ/Qq4ml6gIhBmI+3CzXgf2Cl0e70v
	 MWKY7PTijxgRZ82RlvVeH4Tb+UqkZkzoqLg37UZD4kaWKTaFwkFqTyAyy/v70bxjmU
	 JhbFH8EM/k4KwQvXAbkIq56Uyxq2jWwyfIdVOHJ1ZuMVEmFeqR0/QkSL3aKsaFEJKp
	 qAg6QGe/ispPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:29 -0500
Subject: [PATCH v4 01/17] filelock: make lease_alloc() take a flags
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-1-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DYoclxA9VZrJYyH2ZjWf3xD/XgnD9xjMazzJyvQdh7g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWbf4MlvbYriNtvr7x82KNxfScMHm+Kjrld9
 eBtqKtwhSqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilmwAKCRAADmhBGVaC
 FQfVEACNLUsYEx4R9itULq3/9BW5ZDttkRzCMZbER2qzLD6nxPBPhCS4tiqvmW0wEcAAzDz8OsP
 tFjwQXJG5+iibs7uQPZoZY0N46jBuiCkKp+VisgnDbVsx8lh9b03MfMYNrZ9RKZag91Ge7Gv+D9
 D+IOG8hJIoresxeGFIT+cdb0OCQCZ1rmO1sRy/lHVbkpIqo+PWOu0plu4NlDpzC4yS92MbPlfaV
 Osd1hRInZ3m0Im7C1SS5p4QqloHpSrGd1F41x9p3Fl/0AhZzfLtFj3LC6s9r3+bww6wezfoC1LH
 1Ok49UsPqfOKpQEWVh1jblkFXuM7xmsbJ7cdwiPFLZ0sDwAfDMlAkyEDQ6MqRFfLfe5masdBk9L
 DVtXJsSmq4SsQS5gAVxLmVASlV8azOroFZgQSL/d7zfxO2gfK3HKdm8g5ITkQiPo1h8ppMIsbqY
 SzoUzyLHCyaILwy0JEFc6Ti9cnWosePdQB2RCblDzxzePOKeDWGC5Wn8XwKe2NEbdGBbwRvnzHR
 h8ED+RkQm35+Cg8COgN86JLp8qGNPip8JvC8u08Ly4PAlss3wOeTeT3F+xpWKXV6XFkLN5p8csV
 oSNTw+xn4jAkr8iIB7AEIVdBDnVLsRL85ONTRusjj3rdqalNFhSMzWYUd9NyUrNJ/RImFfmCRNB
 oDlFM0dxKhGp31Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

__break_lease() currently overrides the flc_flags field in the lease
after allocating it. A forthcoming patch will add the ability to request
a FL_DELEG type lease.

Instead of overriding the flags field, add a flags argument to
lease_alloc() and lease_init() so it's set correctly after allocating.

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


