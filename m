Return-Path: <linux-fsdevel+bounces-50717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407AACED1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 11:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8037AA563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350D20E023;
	Thu,  5 Jun 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDD6dUVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2022C3242
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117215; cv=none; b=f6HcF3vH2Nz9tPCJgLf8hBIwIbtgHrBxnaxKCe8ZcnKuTZg3gSLrt47oMrJSMdID0FjQHty92Rwy5A4QG7X90irhm4nHXggtGfv8Dxx9WnUcncWV4RDEeHPtPPGzc3ud9eC0kNGpFFlgtMj5Dyx4vqNcgBddkKka/9u9dvG22N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117215; c=relaxed/simple;
	bh=mW8rsPuXw3nVhLHFk3N0mUcTcpixe+P0UMYtzIRiv5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCSELRwQtvtObDKPzmZN2g/RK/1deY3NCL6Hzjhj+l9oybV7X50kVl0Zbmtfpu5iLXQfkGbsJ7IgohpwYAc9EOWWpcpwVYkcW9egWmCj71yN2TrpVFPlDe3fJR3BevBvDgpndWR2JUGppHIbUg979hw9ei2imoBYJQS0BhwoDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDD6dUVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ACEC4CEE7;
	Thu,  5 Jun 2025 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749117213;
	bh=mW8rsPuXw3nVhLHFk3N0mUcTcpixe+P0UMYtzIRiv5c=;
	h=From:To:Cc:Subject:Date:From;
	b=FDD6dUVAjsA+rXIUtKNMLChpCEvzF6B5J8yyCmu3K9wXx1rSHHZJ+4vIDb5wtdYuV
	 YbGGzMX1hKqO6eqJZw6elyfdDMzlMD9ZXWZOOrON7H5DQZJCsiCcGcFxPUFYMvPnAj
	 AUNl87m2BynhAMQubkZb6ClwKSK6BMRc4YxBjM56azMPNsymjXALY6kpNGUukstvYT
	 s0xWs2Fjitq+L+UjB7wBQl0nmZYNyQqfQ69fn1JbFJy0XMdDnkC5HO9WjM9qabJ1hM
	 TkfZ39PzrBC+p0D3Nqd0RuFTkO529Bl/c4RzQQzaBUTEVTElfMmwyiiZd5pWGHrP4/
	 kxn1fkY7EeJcw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Lennart Poettering <lennart@poettering.net>,
	Mike Yuan <me@yhndnzj.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH] coredump: cleanup coredump socket functions
Date: Thu,  5 Jun 2025 11:53:15 +0200
Message-ID: <20250605-schlamm-touren-720ba2b60a85@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6326; i=brauner@kernel.org; h=from:subject:message-id; bh=mW8rsPuXw3nVhLHFk3N0mUcTcpixe+P0UMYtzIRiv5c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ4Zoowcm1++1c7V2bendOWireWXguf3j7zU3ardUzhZ quOm+e3dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE34qRYddTjhdZZzZ8rH07 zaoiS6Ff6eqpq9MLxK2FnOsW/v11WJnhr6jNnF+v1ZhXsxo9lo4IMVhX6Tdr++rZ+RP/mm75dv7 MdSYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

We currently use multiple CONFIG_UNIX guards. This looks messy and makes
the code harder to follow and maintain. Use a helper function
coredump_sock_connect() that handles the connect portion. This allows us
to remove the CONFIG_UNIX guard in the main do_coredump() function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 154 +++++++++++++++++++++++++++-----------------------
 1 file changed, 82 insertions(+), 72 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 26443018266e..11859d53afee 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -646,6 +646,77 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 }
 
 #ifdef CONFIG_UNIX
+static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *cprm)
+{
+	struct file *file __free(fput) = NULL;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	ssize_t addr_len;
+	int retval;
+	struct socket *socket;
+
+	addr_len = strscpy(addr.sun_path, cn->corename);
+	if (addr_len < 0)
+		return false;
+	addr_len += offsetof(struct sockaddr_un, sun_path) + 1;
+
+	/*
+	 * It is possible that the userspace process which is supposed
+	 * to handle the coredump and is listening on the AF_UNIX socket
+	 * coredumps. Userspace should just mark itself non dumpable.
+	 */
+
+	retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
+	if (retval < 0)
+		return false;
+
+	file = sock_alloc_file(socket, 0, NULL);
+	if (IS_ERR(file))
+		return false;
+
+	/*
+	 * Set the thread-group leader pid which is used for the peer
+	 * credentials during connect() below. Then immediately register
+	 * it in pidfs...
+	 */
+	cprm->pid = task_tgid(current);
+	retval = pidfs_register_pid(cprm->pid);
+	if (retval)
+		return false;
+
+	/*
+	 * ... and set the coredump information so userspace has it
+	 * available after connect()...
+	 */
+	pidfs_coredump(cprm);
+
+	retval = kernel_connect(socket, (struct sockaddr *)(&addr), addr_len,
+				O_NONBLOCK | SOCK_COREDUMP);
+	/*
+	 * ... Make sure to only put our reference after connect() took
+	 * its own reference keeping the pidfs entry alive ...
+	 */
+	pidfs_put_pid(cprm->pid);
+
+	if (retval) {
+		if (retval == -EAGAIN)
+			coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
+		else
+			coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
+		return false;
+	}
+
+	/* ... and validate that @sk_peer_pid matches @cprm.pid. */
+	if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid != cprm->pid))
+		return false;
+
+	cprm->limit = RLIM_INFINITY;
+	cprm->file = no_free_ptr(file);
+
+	return true;
+}
+
 static inline bool coredump_sock_recv(struct file *file, struct coredump_ack *ack, size_t size, int flags)
 {
 	struct msghdr msg = {};
@@ -709,7 +780,7 @@ static inline void coredump_sock_shutdown(struct file *file)
 	kernel_sock_shutdown(socket, SHUT_WR);
 }
 
-static bool coredump_request(struct core_name *cn, struct coredump_params *cprm)
+static bool coredump_sock_request(struct core_name *cn, struct coredump_params *cprm)
 {
 	struct coredump_req req = {
 		.size		= sizeof(struct coredump_req),
@@ -759,6 +830,14 @@ static bool coredump_request(struct core_name *cn, struct coredump_params *cprm)
 	return true;
 }
 #else
+static bool coredump_sock_connect(struct core_name *cn,
+				  struct coredump_params *cprm)
+{
+	coredump_report_failure("Core dump socket support %s disabled", cn->corename);
+	return false;
+}
+static bool coredump_sock_request(struct core_name *cn,
+				  struct coredump_params *cprm) { return false; }
 static inline void coredump_sock_wait(struct file *file) { }
 static inline void coredump_sock_shutdown(struct file *file) { }
 #endif
@@ -984,80 +1063,11 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	case COREDUMP_SOCK_REQ:
 		fallthrough;
 	case COREDUMP_SOCK: {
-#ifdef CONFIG_UNIX
-		struct file *file __free(fput) = NULL;
-		struct sockaddr_un addr = {
-			.sun_family = AF_UNIX,
-		};
-		ssize_t addr_len;
-		struct socket *socket;
-
-		addr_len = strscpy(addr.sun_path, cn.corename);
-		if (addr_len < 0)
-			goto close_fail;
-		addr_len += offsetof(struct sockaddr_un, sun_path) + 1;
-
-		/*
-		 * It is possible that the userspace process which is
-		 * supposed to handle the coredump and is listening on
-		 * the AF_UNIX socket coredumps. Userspace should just
-		 * mark itself non dumpable.
-		 */
-
-		retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
-		if (retval < 0)
+		if (!coredump_sock_connect(&cn, &cprm))
 			goto close_fail;
 
-		file = sock_alloc_file(socket, 0, NULL);
-		if (IS_ERR(file))
+		if (!coredump_sock_request(&cn, &cprm))
 			goto close_fail;
-
-		/*
-		 * Set the thread-group leader pid which is used for the
-		 * peer credentials during connect() below. Then
-		 * immediately register it in pidfs...
-		 */
-		cprm.pid = task_tgid(current);
-		retval = pidfs_register_pid(cprm.pid);
-		if (retval)
-			goto close_fail;
-
-		/*
-		 * ... and set the coredump information so userspace
-		 * has it available after connect()...
-		 */
-		pidfs_coredump(&cprm);
-
-		retval = kernel_connect(socket, (struct sockaddr *)(&addr),
-					addr_len, O_NONBLOCK | SOCK_COREDUMP);
-
-		/*
-		 * ... Make sure to only put our reference after connect() took
-		 * its own reference keeping the pidfs entry alive ...
-		 */
-		pidfs_put_pid(cprm.pid);
-
-		if (retval) {
-			if (retval == -EAGAIN)
-				coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
-			else
-				coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
-			goto close_fail;
-		}
-
-		/* ... and validate that @sk_peer_pid matches @cprm.pid. */
-		if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid != cprm.pid))
-			goto close_fail;
-
-		cprm.limit = RLIM_INFINITY;
-		cprm.file = no_free_ptr(file);
-
-		if (!coredump_request(&cn, &cprm))
-			goto close_fail;
-#else
-		coredump_report_failure("Core dump socket support %s disabled", cn.corename);
-		goto close_fail;
-#endif
 		break;
 	}
 	default:
-- 
2.47.2


