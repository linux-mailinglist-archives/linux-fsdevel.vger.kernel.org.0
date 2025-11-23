Return-Path: <linux-fsdevel+bounces-69535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B7BC7E3C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F413B349C8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2342D94B3;
	Sun, 23 Nov 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE6+CbQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD42D7D30
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915643; cv=none; b=kDkvfoKe9+cngcQ0YL3MJdAko7CzTBalEMwAdrzP6Y+zIKffE7OOL2m7m0i2vpfJ3I6rq96ZtG+KDJfSYh/NkNlWsHuUeZuUZ40U4qQSF5fwuRIUA9kpN6sZ6kf5+5bTdc5KeUHMH0Eneoz5rEca56g5KRQvF9cQbAcRNAeFauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915643; c=relaxed/simple;
	bh=yZzr1S+4OniiN2sBgclb70cUZrj4h4ANzMLs/AQ9b1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlGJShYfM0V1E/orN/mgY8m2WdC1V/wIb2nDCtUzE6RE9Q8t0f0jAVHl27XR6uKN2TV7danuoz57nKQLmU1P5gIXEqhMuI6GVPAFKca1iaGmGr4EKhzF+TJgJOR68z9L5esKCNVz8qF2NURMUeH830b5wHHVhaTNwOA3kSoYwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE6+CbQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18F1C116D0;
	Sun, 23 Nov 2025 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915642;
	bh=yZzr1S+4OniiN2sBgclb70cUZrj4h4ANzMLs/AQ9b1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cE6+CbQEnYQ+ROmo4DvcskP0VXFtN/xtQZOC7khh8W646iQ/+yz68oXGOy8GEk2BD
	 9c8b2qa4KtsUmBdP+WkYDbrg54DiQwuCJlao7eXYIOZPqhITX1kneiDdGHYJq0V8+1
	 vXgJ6XEBo4UzwcnRCXIE1ggOR+wZ8qQQrzgdLArnZmlSfKKtY0DSekYlOH5f28cDeK
	 SAzP5vL+6Cwe1j6ew1g/Fksw9zdNXOo5Kca64U0qRA2I13OI1BTLpY3I+P73qEVcQn
	 CvhrBskESleUhRbApuB9QEyfqTRmEI1w0NRlmwOE/eQVvIOMIECtR7dgoSQ2Bv/Jjx
	 R0iF/28v8pSFQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:31 +0100
Subject: [PATCH v4 13/47] open: convert do_sys_openat2() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-13-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yZzr1S+4OniiN2sBgclb70cUZrj4h4ANzMLs/AQ9b1A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0de+KLcd0Tsr9wFadHrcx50GM+IMr7+IZ51lW7Db
 6ujK99YdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkwJzhf2jWdIP43XMjptz4
 8o0ll1tO4mbvuqgHS8qsvAx0Pc3V4hj+WVpWNNxyehS0/MED5bXKL55vXZ2bZDWNkz+qrNXl/94
 EDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..fa00860f4e4c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1421,8 +1421,8 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 			  struct open_how *how)
 {
 	struct open_flags op;
-	struct filename *tmp;
-	int err, fd;
+	struct filename *tmp __free(putname);
+	int err;
 
 	err = build_open_flags(how, &op);
 	if (unlikely(err))
@@ -1432,18 +1432,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	fd = get_unused_fd_flags(how->flags);
-	if (likely(fd >= 0)) {
-		struct file *f = do_filp_open(dfd, tmp, &op);
-		if (IS_ERR(f)) {
-			put_unused_fd(fd);
-			fd = PTR_ERR(f);
-		} else {
-			fd_install(fd, f);
-		}
-	}
-	putname(tmp);
-	return fd;
+	return FD_ADD(how->flags, do_filp_open(dfd, tmp, &op));
 }
 
 int do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)

-- 
2.47.3


