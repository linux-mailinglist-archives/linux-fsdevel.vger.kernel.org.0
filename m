Return-Path: <linux-fsdevel+bounces-21148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1FA8FF9D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0998AB22999
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73A81C6A8;
	Fri,  7 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Qu53OqCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AE12E7E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725603; cv=none; b=selzclv/2qI6zFcv4fiIa+rU3Y6UJUH7PMknAucJfJDBTSx9HL0oZ4bbbh63MQMHo8YofTRNg/Y9hw9Q4USXrCPGcY5UHuyHprqWHGN1CRfe4fHegV8ue0qrO0uOobK6p8xoLgaC4ou/Z77PVLO2ZCzE6AiNIAqadZ0HfR+l/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725603; c=relaxed/simple;
	bh=myz81naXi1egMd0GIAZTsr3bnFNj4YoWa1WuTudwPrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CB3qhHplL7czLhxvJt315fulsJCBhI1CL84s/2nHUtzaPd63s9omrdeNN+LTyCtwYvq3L+kyBHlJGyG1T6u6hQ/bb7VLw4gwCR8FvNXeyg9A7vtu9Vm7XAltFmhWP5JKQnfAPoHvquN4sisP/t1DFIWm0yJAv6uxXfDnYJgkrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Qu53OqCr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QIJNQAsGQOVBrRpPZE5lCHnH/SJLGj3/fbie3/yZpIs=; b=Qu53OqCrUVQKSQP+E296t/xNej
	wiU8n3RY48lLC/+u+FWDuNSeaTtzRPOMu3u9iKwpTPyFuCMsGVbu/y54uug3kyJ8tMeul6VFRoeWJ
	fiXFOsQ3t8OoMdazS28dReXjNxk9U4c+1zY4vCTvT/b1cmfSSCEGdBBKf5yeL/wZhoytJyIozhsdz
	wfI6fuCZo9XA27t+aJxbSMUuWcCvEJJwUxDHxV4zpMg39Jtw2+UkzyKVF0EogpBC/eGJUTUmzfbU+
	tbuEypZHgw6BeVpQBM2hPlx1vghv9Ox6HqUpA5qD9Ag5FXlGnvbZFjh5ofWhbvU2mwDo0qcZMjxWp
	op+0BZog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtb-009xCN-37;
	Fri, 07 Jun 2024 02:00:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 13/19] convert vmsplice() to CLASS(fd, ...)
Date: Fri,  7 Jun 2024 02:59:51 +0100
Message-Id: <20240607015957.2372428-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 42aa7bc46be5..2898fa1e9e63 100644
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
-- 
2.39.2


