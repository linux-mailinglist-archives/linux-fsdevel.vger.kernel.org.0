Return-Path: <linux-fsdevel+bounces-56811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B7FB1BFF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 07:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB81833D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 05:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C261FDA7B;
	Wed,  6 Aug 2025 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ONxbjG7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45E63CF;
	Wed,  6 Aug 2025 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458290; cv=none; b=arhRlEcsoFm3H9AEvk5y/7S1bQRvM0qpUNI+b3YAfYMlTttgLrHfcxbmfLbdrS/L2H4PABJiKOcUW/ulbpdY7KMXTlZ9r7ukjonTDovmRnHOCOzCagFhJVCaUxLE5dokVGJmuVUBBIP3EX3Jvz8Od+LyaRPWRZQdmim24R3l2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458290; c=relaxed/simple;
	bh=grK8qXho5eJRNhUBpVWJrruv3CCOc+X2tolA7nBflUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPLpw/eLdpX2qFfRwAZdjWw/7IWNK51jt/gAoGEL5+xFME/ObtISaQ4CmP0Vbd2NTND/r3rgvA/c9XeOIxwz8bpkG+I+TbCTCql4uljT7VtfY52ayV+sRG3/CvGCXSaofyhMyykPCjF/RQLIPpEJxYVHGllG7tg6Mv15JrWb0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ONxbjG7l; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bxf6P2gJfz9tlP;
	Wed,  6 Aug 2025 07:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754458285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7MzN3ay8IG6Jjs4hHxY8KUxDAJt90+4JEoWvq0gBos=;
	b=ONxbjG7lyvDXO08sTSvdNMc24C2fvZprSEf5JWO2FC/eTPsZM4EDcXfmO8e0Z/I5SGh3xD
	Jxa/I0aLz29mMe0VYQe9nAtF8p3lVAV4lyAeWrpoHrcDwJDcNLMJscE1TUuyk5uJHXRCzC
	sHh6mL21bKifjXAz7bMzgevhgHj9ZmI0LvesId0vwpNUxIzCHHSukvSl7gDcivPLXK3WYr
	fVqFHyNEPIq/dQQO9L1S4ItVY8yyXtEAXi3+ZHw/E3spAwRAfIqunpBlya57KPIhlHkFOT
	a/5L89Dt3iPq1LlA0VuYYt35ZgfOh6A8nVrhbfxONe5vvGOPNETBasdqxsczAg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 06 Aug 2025 15:31:10 +1000
Subject: [PATCH 1/2] fscontext: do not consume log entries for -EMSGSIZE
 case
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-fscontext-log-cleanups-v1-1-880597d42a5a@cyphar.com>
References: <20250806-fscontext-log-cleanups-v1-0-880597d42a5a@cyphar.com>
In-Reply-To: <20250806-fscontext-log-cleanups-v1-0-880597d42a5a@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=grK8qXho5eJRNhUBpVWJrruv3CCOc+X2tolA7nBflUg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMerFo7d7JDMq5VR1/MvwOZod5rWXdW1O6YP7Gf/+Ob
 ilc0h+c3VHKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAmIv+C4Z/COr5CRffdSvmK
 jZPjJ87tUU6asjFBWzk+sUDrW/MBHlaGvzJqaott67/O26L5Om3aVA37mOx9+5clrJAMkXoQyv7
 +IxMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Userspace generally expects APIs that return EMSGSIZE to allow for them
to adjust their buffer size and retry the operation. However, the
fscontext log would previously clear the message even in the EMSGSIZE
case.

Given that it is very cheap for us to check whether the buffer is too
small before we remove the message from the ring buffer, let's just do
that instead.

Fixes: 007ec26cdc9f ("vfs: Implement logging through fs_context")
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/fsopen.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 1aaf4cb2afb2..f5fdaa97965b 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -36,23 +36,25 @@ static ssize_t fscontext_read(struct file *file,
 	if (ret < 0)
 		return ret;
 
-	if (log->head == log->tail) {
-		mutex_unlock(&fc->uapi_mutex);
-		return -ENODATA;
-	}
+	ret = -ENODATA;
+	if (log->head == log->tail)
+		goto err_unlock_nomsg;
 
 	index = log->tail & (logsize - 1);
 	p = log->buffer[index];
+	n = strlen(p);
+
+	ret = -EMSGSIZE;
+	if (n > len)
+		goto err_unlock_nomsg;
+
+	/* Consume the message from the queue. */
 	need_free = log->need_free & (1 << index);
 	log->buffer[index] = NULL;
 	log->need_free &= ~(1 << index);
 	log->tail++;
 	mutex_unlock(&fc->uapi_mutex);
 
-	ret = -EMSGSIZE;
-	n = strlen(p);
-	if (n > len)
-		goto err_free;
 	ret = -EFAULT;
 	if (copy_to_user(_buf, p, n) != 0)
 		goto err_free;
@@ -62,6 +64,10 @@ static ssize_t fscontext_read(struct file *file,
 	if (need_free)
 		kfree(p);
 	return ret;
+
+err_unlock_nomsg:
+	mutex_unlock(&fc->uapi_mutex);
+	return ret;
 }
 
 static int fscontext_release(struct inode *inode, struct file *file)

-- 
2.50.1


