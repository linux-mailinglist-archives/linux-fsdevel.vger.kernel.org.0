Return-Path: <linux-fsdevel+bounces-2210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC17E3673
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 09:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8FDB20B8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 08:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A61DF59;
	Tue,  7 Nov 2023 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110CDDAB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 08:14:06 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8771FE8;
	Tue,  7 Nov 2023 00:14:03 -0800 (PST)
X-QQ-mid: bizesmtp91t1699344838tve14rzx
Received: from localhost.localdomain ( [175.11.90.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Nov 2023 16:13:52 +0800 (CST)
X-QQ-SSF: 00400000000000O0T000000A0000000
X-QQ-FEAT: 3M0okmaRx3gmxPjUV56yDKvB3Uhj8OcIpw7vWvpFGbsFfrB+bfwV7TozelY5e
	DMI/DxjOU8Tal584vSNyxOx5pZja88QCqwwjIl0o4CnUzPFLiXAU5V+M/gM+ILYnZlGx2fL
	Jtl2leZXWwQhqffFZSUUQEocdjWH3F4eOS62spWgc7UHKQqsP8msvrB1ZrTyn/0osDH2IbE
	vLMPurMnhNfp3gYSRyxXgXcSFR8EijFT4Tc5E7FQEEtmDyQ5kGlsh+q0H5Fhu9zhx67geNf
	LIX4c7sTyfsZqkCglfVxYcWEEYPYE2251UY5+kro/DpLtPKHGkK0BdTXZKmtZBmMBpLtKWV
	B1POWAVC+ErxfxG5NqfZuSDd+jfAvfTIqZSM81S0nMdu5b7Xn/ktDwb+Q498ZuzIU6ci3Qs
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11280650343400386784
From: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
To: zhoujifeng@kylinos.com.cn
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu
Subject: [PATCH v2] fuse: Track process write operations in both direct and writethrough modes
Date: Tue,  7 Nov 2023 16:13:50 +0800
Message-Id: <20231107081350.14472-1-zhoujifeng@kylinos.com.cn>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>
References: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>
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
v1 -> v2: Fix "Miss error code" issue

 fs/fuse/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..4846ab8c01cf 100644
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
@@ -1330,6 +1332,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err <= 0)
 		goto out;
 
+	count = err;
+	task_io_account_write(count);
+
 	err = file_remove_privs(file);
 	if (err)
 		goto out;
@@ -1600,6 +1605,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
+		task_io_account_write(res);
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
-- 
2.18.1


