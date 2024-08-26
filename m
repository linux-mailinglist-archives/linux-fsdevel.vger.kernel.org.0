Return-Path: <linux-fsdevel+bounces-27171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96C95F25B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AC91C217AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061217BEB4;
	Mon, 26 Aug 2024 13:07:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64215176AC7;
	Mon, 26 Aug 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677632; cv=none; b=H8IyApUveV/34OWP8YHe2eE2C0dA4/RBpX6BLxDZyW584iW1Bm0HyTaq/83snS2drHVAa2mCWSFDpwaSl6NbUcpSAB9MgcRRo14oEt4Xw/K/Udz/MsdfZXDo4kbfI7nL4rPOePgXNNLxMbg3KC7NS6+gJFGGVzi82Xmeqsh/gNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677632; c=relaxed/simple;
	bh=u2GU0B7E0+MJoDtNYBcEJmfsGvNZQLNwW+EI0SzgLdQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lvTyMDbUFSoLy5GWDSrdIrdDY0/4t96/ChZxbzhwqfGJSoUbSluL8Ro4Td8c1rwIuBoprhNOKnUoHY+VsHetgAFWj/3czzdalK+p9xeeSOazLeIbtb3doX8+NE88mX69UtP1ZrYqhRMEmap2EBYACJxrVdVYBzUjehYbaWRyyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WsrYD4BKSz2CnZX;
	Mon, 26 Aug 2024 21:06:56 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ED001A0170;
	Mon, 26 Aug 2024 21:07:05 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 21:07:04 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lixiaokeng@huawei.com>
Subject: [PATCH] fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter
Date: Mon, 26 Aug 2024 21:06:12 +0800
Message-ID: <20240826130612.2641750-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100024.china.huawei.com (7.221.188.41)

Commit 23c94e1cdcbf ("fuse: Switch to using async direct IO
for FOPEN_DIRECT_IO") gave the async direct IO code path in the
fuse_direct_read_iter() and fuse_direct_write_iter(). But since
these two functions are only called under FOPEN_DIRECT_IO is set,
it seems that we can also use the async direct IO even the flag
IOCB_DIRECT is not set to enjoy the async direct IO method. Also
move the definition of fuse_io_priv to where it is used in fuse_
direct_write_iter.

Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..03809ecc23ec 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1649,7 +1649,7 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t res;
 
-	if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
+	if (!is_sync_kiocb(iocb)) {
 		res = fuse_direct_IO(iocb, to);
 	} else {
 		struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
@@ -1663,7 +1663,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
 	bool exclusive;
 
@@ -1671,9 +1670,11 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		task_io_account_write(res);
-		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
+		if (!is_sync_kiocb(iocb)) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
+			struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
+
 			res = fuse_direct_io(&io, from, &iocb->ki_pos,
 					     FUSE_DIO_WRITE);
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
-- 
2.33.0


