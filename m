Return-Path: <linux-fsdevel+bounces-66699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D53C29994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 633CF4E903D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC902522BE;
	Sun,  2 Nov 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urcobR42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F741FBF0;
	Sun,  2 Nov 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125179; cv=none; b=YpKG4RSAZsk/gE4o2QBQgOUyCz7SPSoymuLLqmuQxw4C9xjC6zglbzW2OroIsNs6zT6HrTdqKkDrlVByw861Uq5dHuiMfBhgNvBhcUI3plSOiB6JmPx0F8LXvIZ1lZVMtdLYrZKEhOjwS7BbRPsRAOtr7HKKX/WRtz/7ygPXNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125179; c=relaxed/simple;
	bh=s8zI9WG47PjzniQToHXGHJt+ASTAkWITbPaI9IMDaUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qI+AR5rpmDIVd6M2zDDHvbQFiHrXnRDo1OMa0ngl8d/p1m6B7Z/6n0kdCZ0q2Cr6+75DETT1FhL37gP5Rs6usYZBc1l1Ttp9qCrqkm6oqG30lw2sM42Oiyg1UChVCI7ecpqKph6P+1RZ6tAhiLMu5eZ48+/LbHcQR8Af6328mAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urcobR42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C7CC4CEFD;
	Sun,  2 Nov 2025 23:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125178;
	bh=s8zI9WG47PjzniQToHXGHJt+ASTAkWITbPaI9IMDaUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=urcobR42bfmXm6OEX2+u0KT93ekUFr6zjpf9rw08nH7pNZB1AJKceuBBaEhK2Ummd
	 ss3dMtxrfZcsXUFevNiX+Mge3/Pi2tm67Fep3vyZDjUcQ5EnVpvxkOAKoz6BLPMYvp
	 1OJoqHbsaoVI2DhmaL3BERre1tZrzmAw5IWRptdyIb4XHHw1u9AJ+4Asx+b/Qd7pAQ
	 4Lt1jQ+QhbqlI9G2JdkM505LY1US33F+CvtDHvMvvO+f06RGvrTtc/tNgo5LvFcjY2
	 kAFEbj/uuCc1h5h9pLTjLk8wfWfRBE1lmJ3dmy4R9Xg+MXnLjcWzd7KlJFxB0+ccWz
	 0w4ngzeKy8GPg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:41 +0100
Subject: [PATCH 2/8] cred: add kernel_cred() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-2-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s8zI9WG47PjzniQToHXGHJt+ASTAkWITbPaI9IMDaUA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy21enxlCV+euESB3/92nYOpghovv8aLVtycaybCm
 F2xtLixo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK/DRkZpvz89HhZGW9Q/1eB
 /4qfS2OuT2ZP2V/z8nr/1phVHP43HzEybPY7LnXr5JOOotUrGhenZ5d9yU147v9zZ2S7UG3PG7s
 INgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Access kernel creds based off of init_task. This will let us avoid any
direct access to init_cred.

Link: https://patch.msgid.link/20251031-work-creds-init_cred-v1-1-cbf0400d6e0e@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 89ae50ad2ace..8ab3718184ad 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -20,6 +20,8 @@
 struct cred;
 struct inode;
 
+extern struct task_struct init_task;
+
 /*
  * COW Supplementary groups list
  */
@@ -156,6 +158,11 @@ extern struct cred *prepare_exec_creds(void);
 extern int commit_creds(struct cred *);
 extern void abort_creds(struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
+static inline const struct cred *kernel_cred(void)
+{
+	/* shut up sparse */
+	return rcu_dereference_raw(init_task.cred);
+}
 extern int set_security_override(struct cred *, u32);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);

-- 
2.47.3


