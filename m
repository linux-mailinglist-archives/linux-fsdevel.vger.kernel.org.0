Return-Path: <linux-fsdevel+bounces-33514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C39B9CE5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1664282BDD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E815C128;
	Sat,  2 Nov 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ODShfBhm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8801148826;
	Sat,  2 Nov 2024 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524112; cv=none; b=FbIneYdd1pSoUFQiyAXJ77oOSEOc5sqJBfN897gJdC4+P8k4S61gCBDyFM4WID+j/QBVUjsQVexDcIl0zA+5Y+cJ0VIigHPXYGKdEgXyJwIM9yE+EdryG/UFpJsLz2d9aIUo367AvRzkMgKFsOj7Of146FYtwLUnZAMXBCzFrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524112; c=relaxed/simple;
	bh=X4IynrG96V1CU9gjGAz7pnZJsbSZC5srtWPsTats5PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpEJ7hhrb8y7KSQbxbRRghggJ7+juR2gx+CF9JOF/O/pTapYrqIfBuIDnOh1ZhJJf/sejZ8I1UojBY5fEhG3yLaOm6YpGUKBJu0X5xYEUhDbV9VFAeOrCgvHjLJsjMwfvDNvP9s0DafX/mdwPYbhm0s5DZt3Mj9dKGnuXK0Cx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ODShfBhm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8M4XgD9wC/MPnBC9VgNfDd3/kbyB1QLg3xYpG2WXTzc=; b=ODShfBhm00Qqe1OP1kEzui28S3
	Vszx+J4GRvRUzT6+NIZrkSsbqHtLrc2HecDHVHToYGp2N4ZnvtxC4Mmvow2BwTZ9IbTDvfhTlz4T6
	KmGFsY1TCOvvmIXR2ag1Q56UGc+uu6vAWSn1Rkl2JuD5FaEUpTwpX9QraSsRzF9yFg3uJw/yOs01q
	4l3Kb2n/un4s7qpEnPrIAVlbLeN+zj681m+2qSmhtLTd6OF6Ie4D88g0pfDEKZtjKSEYUO4ZnhAHR
	Mn4W/24ya0VdEoR5P1rJUeoC0YSgw4fbyKw4DhY7uBsYBpOZ22sarromGYs+Xjm2yH1GE7NkyQAWA
	Y2jsQAMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NA-0000000AHmX-1PEH;
	Sat, 02 Nov 2024 05:08:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 09/28] convert vmsplice() to CLASS(fd)
Date: Sat,  2 Nov 2024 05:08:07 +0000
Message-ID: <20241102050827.2451599-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Irregularity here is fdput() not in the same scope as fdget(); we could
just lift it out vmsplice_type() in vmsplice(2), but there's no much
point keeping vmsplice_type() separate after that...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 06232d7e505f..29cd39d7f4a0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1564,21 +1564,6 @@ static ssize_t vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	return ret;
 }
 
-static int vmsplice_type(struct fd f, int *type)
-{
-	if (!fd_file(f))
-		return -EBADF;
-	if (fd_file(f)->f_mode & FMODE_WRITE) {
-		*type = ITER_SOURCE;
-	} else if (fd_file(f)->f_mode & FMODE_READ) {
-		*type = ITER_DEST;
-	} else {
-		fdput(f);
-		return -EBADF;
-	}
-	return 0;
-}
-
 /*
  * Note that vmsplice only really supports true splicing _from_ user memory
  * to a pipe, not the other way around. Splicing from user memory is a simple
@@ -1602,21 +1587,25 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
 	ssize_t error;
-	struct fd f;
 	int type;
 
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
-	f = fdget(fd);
-	error = vmsplice_type(f, &type);
-	if (error)
-		return error;
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+	if (fd_file(f)->f_mode & FMODE_WRITE)
+		type = ITER_SOURCE;
+	else if (fd_file(f)->f_mode & FMODE_READ)
+		type = ITER_DEST;
+	else
+		return -EBADF;
 
 	error = import_iovec(type, uiov, nr_segs,
 			     ARRAY_SIZE(iovstack), &iov, &iter);
 	if (error < 0)
-		goto out_fdput;
+		return error;
 
 	if (!iov_iter_count(&iter))
 		error = 0;
@@ -1626,8 +1615,6 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 		error = vmsplice_to_user(fd_file(f), &iter, flags);
 
 	kfree(iov);
-out_fdput:
-	fdput(f);
 	return error;
 }
 
-- 
2.39.5


