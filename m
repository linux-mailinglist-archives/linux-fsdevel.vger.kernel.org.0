Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0D1CA427
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHGi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 02:38:56 -0400
Received: from nibbler.cm4all.net ([82.165.145.151]:42671 "EHLO
        nibbler.cm4all.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgEHGi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 02:38:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 4261EC029D
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 08:38:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Ch4vvPkI2Ewi for <linux-fsdevel@vger.kernel.org>;
        Fri,  8 May 2020 08:38:54 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 231D0C0271
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 08:38:54 +0200 (CEST)
Received: (qmail 3876 invoked from network); 8 May 2020 09:55:13 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 8 May 2020 09:55:13 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id E9824461450; Fri,  8 May 2020 08:38:53 +0200 (CEST)
From:   Max Kellermann <mk@cm4all.com>
To:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Max Kellermann <mk@cm4all.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] fs/io_uring: fix O_PATH fds in openat, openat2, statx
Date:   Fri,  8 May 2020 08:38:45 +0200
Message-Id: <20200508063846.21067-1-mk@cm4all.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an operation's flag `needs_file` is set, the function
io_req_set_file() calls io_file_get() to obtain a `struct file*`.

This fails for `O_PATH` file descriptors, because io_file_get() calls
fget(), which rejects `O_PATH` file descriptors.  To support `O_PATH`,
fdget_raw() must be used (like path_init() in `fs/namei.c` does).
This rejection causes io_req_set_file() to throw `-EBADF`.  This
breaks the operations `openat`, `openat2` and `statx`, where `O_PATH`
file descriptors are commonly used.

This could be solved by adding support for `O_PATH` file descriptors
with another `io_op_def` flag, but since those three operations don't
need the `struct file*` but operate directly on the numeric file
descriptors, the best solution here is to simply remove `needs_file`
(and the accompanying flag `fd_non_reg`).

Signed-off-by: Max Kellermann <mk@cm4all.com>
Cc: stable@vger.kernel.org
---
 fs/io_uring.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a46de2cfc28e..d24f8e33323c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -693,8 +693,6 @@ static const struct io_op_def io_op_defs[] = {
 		.needs_file		= 1,
 	},
 	[IORING_OP_OPENAT] = {
-		.needs_file		= 1,
-		.fd_non_neg		= 1,
 		.file_table		= 1,
 		.needs_fs		= 1,
 	},
@@ -708,8 +706,6 @@ static const struct io_op_def io_op_defs[] = {
 	},
 	[IORING_OP_STATX] = {
 		.needs_mm		= 1,
-		.needs_file		= 1,
-		.fd_non_neg		= 1,
 		.needs_fs		= 1,
 	},
 	[IORING_OP_READ] = {
@@ -739,8 +735,6 @@ static const struct io_op_def io_op_defs[] = {
 		.unbound_nonreg_file	= 1,
 	},
 	[IORING_OP_OPENAT2] = {
-		.needs_file		= 1,
-		.fd_non_neg		= 1,
 		.file_table		= 1,
 		.needs_fs		= 1,
 	},
-- 
2.20.1

