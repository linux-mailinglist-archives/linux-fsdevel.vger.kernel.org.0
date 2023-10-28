Return-Path: <linux-fsdevel+bounces-1475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896AD7DA562
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 08:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741E41C21040
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67B441E;
	Sat, 28 Oct 2023 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E891391
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 06:59:28 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B7E3;
	Fri, 27 Oct 2023 23:59:24 -0700 (PDT)
X-QQ-mid: bizesmtp63t1698476359tcw69q76
Received: from localhost.localdomain ( [175.10.24.131])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Oct 2023 14:59:13 +0800 (CST)
X-QQ-SSF: 00400000000000O0T000000A0000000
X-QQ-FEAT: S0uf0xb+BQn1Qs6ENthHsLfFauTVfiNdT4Kdi4ekkZOrMzbIs+8ImU0wAvR5U
	GehrhuypVGXjps3h1ip/EFdWFlYbfZ1PiHxGEXt+RRO1215o398S9M2A2RnHRfKM2QmCQNH
	QwOROKIvO596jthBOGmMCjaOgU7a3SoRA9TMiVi8v40cAhCMbiL5a9x7UHSCNoFbaUSZdiy
	5/MJm4a3qVk/SBv5pUqPwlz3Pvn5PEKiqiPv2nNVQQQApH83PT7eF8ysr5rdoyPsopUfSeO
	pTKMXOPVjUvns7108Y++J1ntULyLTBUfkv/ZUGyCu85wywdbZmmTaTD2LiWAMafFHiZY5OQ
	RP345d+IHz/XC+5tDAHQW8ZVhvcJwN3ToSL3HQNl9nuLu+9khE3t5psQv1iew==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11460424809230058568
From: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Subject: [PATCH] fuse: Track process write operations in both direct and writethrough modes
Date: Sat, 28 Oct 2023 14:59:12 +0800
Message-Id: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.com.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

Due to the fact that fuse does not count the write IO of processes in the
direct and writethrough write modes, user processes cannot track
write_bytes through the “/proc/[pid]/io” path. For example, the system
tool iotop cannot count the write operations of the corresponding process.

Signed-off-by: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
---
 fs/fuse/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..6051d2e2a021 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -19,6 +19,7 @@
 #include <linux/uio.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
+#include <linux/task_io_accounting_ops.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -1305,6 +1306,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t written = 0;
 	struct inode *inode = mapping->host;
 	ssize_t err;
+	ssize_t count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	if (fc->writeback_cache) {
@@ -1326,10 +1328,12 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 writethrough:
 	inode_lock(inode);
 
-	err = generic_write_checks(iocb, from);
-	if (err <= 0)
+	count = generic_write_checks(iocb, from);
+	if (count <= 0)
 		goto out;
 
+	task_io_account_write(count);
+
 	err = file_remove_privs(file);
 	if (err)
 		goto out;
@@ -1600,6 +1604,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
+		task_io_account_write(res);
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
-- 
2.18.1


