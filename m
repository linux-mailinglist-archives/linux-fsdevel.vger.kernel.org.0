Return-Path: <linux-fsdevel+bounces-67159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0BC37207
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B48668591
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477E33C537;
	Wed,  5 Nov 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSunfpXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8D33A01E;
	Wed,  5 Nov 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361653; cv=none; b=OtBY+aF+GtwfNup+UEPQ/Yt5S+W6zOdzZzQBd/q5u8iwzXpUfu35WLYez4KQ/4PtHf1a3fcCHlAF5BMQkiH/iBe1CfzA2hppajMq2iafXg+zFqZ1r1ZrWqELzYqfkJpm3ZtFIUug37iWtv5BWBibzxRDZLDxSqXzgsr5RIesrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361653; c=relaxed/simple;
	bh=DYoclxA9VZrJYyH2ZjWf3xD/XgnD9xjMazzJyvQdh7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGVbzLa7fW2dfhdTKdDCTkYA4bGrU6ZND532r5k7sgIfK1tUljcS7lNSC0wALx8tw5a8tEZ6f1a7C7HFNJRszjhd7aMmT5CxhLLPjfN1DnWD5QRx7FexH9uHavZ82jybXQ6Y7GQTek6BeJYyOkq0055Slj4fAvOIcymyRGCzcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSunfpXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4877C4CEF8;
	Wed,  5 Nov 2025 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361653;
	bh=DYoclxA9VZrJYyH2ZjWf3xD/XgnD9xjMazzJyvQdh7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MSunfpXAiHU10vX26TynV+xjoGR3m2gF21iTbqZu0X7sA1ZC1lNIY+E7xko38Pyhi
	 GwD73zrZKA8qrefjZtulEHAMZ+tlhv1CUqNm9Q1pOfCnK/pcOP2XnsrAVbcEc+Q/kQ
	 Uvv1wwC3Xiu0CGP723hg+jayrcTSCM+V0rjZSEtjB/IpH0WiqrEOcZbh20swDHBHuE
	 Vp7IlWmrgiEo99kB1N3L5LKMywDBOKKINKgk+p5EsZ+bGZeS2ZjdCT3JSPu6TZKQef
	 gDy3/2Rrqv7fUcDHIAhlgRmRgZNEXrluPkrqxZkGVViOEM545kVZyrl534JMtORdp3
	 2KAf38wQYAqzw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:53:47 -0500
Subject: [PATCH v5 01/17] filelock: make lease_alloc() take a flags
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-1-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4EqjML62xgq4XzaEsV/ZpAKPBdfsBad5mp8n
 BweQfxpDxiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBKgAKCRAADmhBGVaC
 FTH4EADFNLAXOZY5/FqKKq3Pc0xk3auYMqXcagPZUiQ8LMgYCJhcDj89OwubY7e9eD/P1IIZ3G6
 bFmpqBwPMcN1F2CxQO2JjjSLy5u1pJev8LHEtc6btKl2ZisfzLIc/iK0O70gBW8c5ZnLj5U+mml
 BTYlviVP+PQhWwb5B3akfo/YlQ3/F9nQbYakfbqSiQg3nTIZ3e1/gaBBNsszdzrgPeVNCtKd3M/
 tRd4WeV8dx/nnf+abpPJ68661CHImIudCfPxZhFHB58a0wmsFkJrKTzRrMK3DefQ5qJg7kwA2ZE
 SatErv6BGvap2bkXQ0PcKKi1wAlHSUfd+l/EfClKsgMlP+tjGyisYW5YQmc6H25J6YlirwHfzy/
 8mz7ITi711PRWrbqed7J97XccW0QjjNlQkLVwC8CURRhyM03yV+Fh11fi2z7JTTVIci8Fq5Tt56
 WkC0ij9z40VYeZdgjt+hZvKtIO+HROd88k8HKclic8tUQPF03ARaELvWzgX8yX0ieULsr6gkNrO
 RMrIr6cM3m6huMlr7YSQrTj6DtJ86q3EhqywAoqB5sfXfGt9fw2Nn+E5ZZVxuJiYxIvHR++jRbB
 kRHrrkmXKbUSxsoa6i1wWWcXYY8aJ6NW0Tsj1mXS+YXw4Ge12KShvGcEvoIlAffTkPm+3fzWmsB
 zR5DOL8RlwLxMhA==
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


