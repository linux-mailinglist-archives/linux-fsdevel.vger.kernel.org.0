Return-Path: <linux-fsdevel+bounces-42637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E03A457DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591A916A16A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9838238144;
	Wed, 26 Feb 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDs9w/9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA01898FB;
	Wed, 26 Feb 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557527; cv=none; b=LhmvQOkWWKGj7pPwIOshaGC0tdT0L/LEH5ytWU6CiX8cG/dgXvNMTrhTqsoNXxln9Q9r2ZX3oQMl7lqDavrd6fCtsWj6qn5N52XuL3IrjE6x0M0mEm6q3v/n2rge/KW9R2gCBxhF/MU5iepQtDEVrZsUL0CRIXGrcHyW3bdYDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557527; c=relaxed/simple;
	bh=AxvPnSdYWK3XwRXQOtiDzG+BiQbJeg5wLpvJO6mak7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a6cXSHLZhBGBbV6slPBUVJHr+KtuCvI+25/qk38QAmdlDJ5k5Bkf83RKHtgwK3Qs/sw1hFo4/adkhGdLFPs5IARa/W3qxOdcsjFQSTkJeQSqXfQcyDN9sLaGkm2Rc940tmlsgc0v0pUpPfEqr/WomM5m96s5vcLW8HvBVRplOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDs9w/9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1381FC4CED6;
	Wed, 26 Feb 2025 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740557527;
	bh=AxvPnSdYWK3XwRXQOtiDzG+BiQbJeg5wLpvJO6mak7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=DDs9w/9V2cNTGLDJxbuwB/5RZTwn4Jbdvd4lfNCcA1aaJRxAGgXlGI2y/6M/F1ku3
	 /Kvulz5sP8CxKaF5+v3YHXBt9mqRI/9SesmbNg/3NE8OYo5jR5M0X3zBe069S9/O6w
	 LtHVZgdX9Vmnoxs/BrFjXQJdYA27fyUZw6mw/aZSLiV221VYNAQn4vwpsA+bOd2PHn
	 sJg3qen5p61BBnV2sxuaR/j5Yn5/Ky34lWxE3xFKCbPAPO0jCNtwIwG7+6ktS9qJPd
	 AyA3GCtu0Qv6VWtFsYtnctOrEk0yR0OmjjAXbjhD7Gax+/u2o25ZmuWnvlA3ZJz7vC
	 MvFG0YHYtQVPg==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] fs: namespace: fix uninitialized variable use
Date: Wed, 26 Feb 2025 09:11:54 +0100
Message-Id: <20250226081201.1876195-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang correctly notices that the 'uflags' variable initialization
only happens in some cases:

fs/namespace.c:4622:6: error: variable 'uflags' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
 4622 |         if (flags & MOVE_MOUNT_F_EMPTY_PATH)    uflags = AT_EMPTY_PATH;
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/namespace.c:4623:48: note: uninitialized use occurs here
 4623 |         from_name = getname_maybe_null(from_pathname, uflags);
      |                                                       ^~~~~~
fs/namespace.c:4622:2: note: remove the 'if' if its condition is always true
 4622 |         if (flags & MOVE_MOUNT_F_EMPTY_PATH)    uflags = AT_EMPTY_PATH;
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: b1e9423d65e3 ("fs: support getname_maybe_null() in move_mount()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 663bacefddfa..7a531e03cb3c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4619,6 +4619,7 @@ SYSCALL_DEFINE5(move_mount,
 	lflags = 0;
 	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+	uflags = 0;
 	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
 	from_name = getname_maybe_null(from_pathname, uflags);
 	if (IS_ERR(from_name))
@@ -4627,6 +4628,7 @@ SYSCALL_DEFINE5(move_mount,
 	lflags = 0;
 	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+	uflags = 0;
 	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
 	to_name = getname_maybe_null(to_pathname, uflags);
 	if (IS_ERR(to_name))
-- 
2.39.5


