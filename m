Return-Path: <linux-fsdevel+bounces-56872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CF1B1CB7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C137A5C13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF529E115;
	Wed,  6 Aug 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="pK/OvsSg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17329CB5A;
	Wed,  6 Aug 2025 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502944; cv=none; b=qPh3XSFHoWMj7ib0qcG9AmXMFD6Pyswdp3L35YbC9qBJ2+9bDEl11xGkleCznj/+f4VQcL9Fu362adlxX23vPFB6hhvNkoqqnWlZIMzDmVuz7ggtf9C56EHhMJFH6gNmCVxk0ZS0333T8gYh/yrENXi6GVV0ZQnEeqOiPoeFHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502944; c=relaxed/simple;
	bh=z68HCvfkXK90e/VOiKW5nRZ0qgXVCLpKrldZh1HS3so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iElFDAh8jWrM8yg/m0o4XBsHo6WsFNiHhtXlemfy7CiZphle3WCl1K/Ng1ulF2M+uxad9O0cQlp8OLNuuA19t69On/LEx9CLyalUYcTvF6+MoGTdl81r15TRe6CvAiB6XcijvaFcLGupONGzcQchrXVXxWix179LGXBWbkmD55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=pK/OvsSg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxyd52rDZz9slL;
	Wed,  6 Aug 2025 19:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TE0rtw3lb0X3gYduAmyvXOk6AuwnMINma8AtPhbNONI=;
	b=pK/OvsSgwSmb0JVhYJ3NPCyxxamZFKHXzBUonvb1WH0ixik/97pcXNdLP7IBXQnl4NK3Nv
	QyudSOwQVjkZF/DyeiuNEoZaljw5Bcxz/ayRu2St6OUFoxbOAIYPG41pG1FE9odkKZvipr
	KOSJEYKwsFfcpk4EVqU2lPDh7gsGfHCJO6qVo8igY25wJg6li4Solpq0vCwoZLdJ+h0Leq
	T37CddkZVRCSNf+cGRx6928gQhchsArT3XFPMFrw/XnJP2gjeYtzBflx2WNqjZ9W3CuldI
	E411yg20viNNk3jbNyuA/BFL/mOwR+klnHWhMtwYziL+L9r78HMPjb1E9hniaw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:55:23 +1000
Subject: [PATCH v3 1/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com>
References: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
In-Reply-To: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=z68HCvfkXK90e/VOiKW5nRZ0qgXVCLpKrldZh1HS3so=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMns7PE19l8n/CQtawrKZggcPTRT98Yz/iJjlpVfKJ3
 6d/77RT7yhlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQAT6Uxk+J+8UuzEq2xxjXD1
 Cb9/18nULnYwMD4WV+Qz/5PZYamvyvsZ/ulOeZkmv5L9xfJ4xey3dtt6dGV/nhF5WL/H+fqlvx/
 6rfgA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Userspace generally expects APIs that return -EMSGSIZE to allow for them
to adjust their buffer size and retry the operation. However, the
fscontext log would previously clear the message even in the -EMSGSIZE
case.

Given that it is very cheap for us to check whether the buffer is too
small before we remove the message from the ring buffer, let's just do
that instead. While we're at it, refactor some fscontext_read() into a
separate helper to make the ring buffer logic a bit easier to read.

Fixes: 007ec26cdc9f ("vfs: Implement logging through fs_context")
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/fsopen.c | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 1aaf4cb2afb2..538fdf814fbf 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -18,47 +18,53 @@
 #include "internal.h"
 #include "mount.h"
 
+static inline const char *fetch_message_locked(struct fc_log *log, size_t len,
+					       bool *need_free)
+{
+	const char *p;
+	int index;
+
+	if (unlikely(log->head == log->tail))
+		return ERR_PTR(-ENODATA);
+
+	index = log->tail & (ARRAY_SIZE(log->buffer) - 1);
+	p = log->buffer[index];
+	if (unlikely(strlen(p) > len))
+		return ERR_PTR(-EMSGSIZE);
+
+	log->buffer[index] = NULL;
+	*need_free = log->need_free & (1 << index);
+	log->need_free &= ~(1 << index);
+	log->tail++;
+
+	return p;
+}
+
 /*
  * Allow the user to read back any error, warning or informational messages.
+ * Only one message is returned for each read(2) call.
  */
 static ssize_t fscontext_read(struct file *file,
 			      char __user *_buf, size_t len, loff_t *pos)
 {
 	struct fs_context *fc = file->private_data;
-	struct fc_log *log = fc->log.log;
-	unsigned int logsize = ARRAY_SIZE(log->buffer);
 	ssize_t ret;
-	char *p;
+	const char *p;
 	bool need_free;
-	int index, n;
+	int n;
 
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret < 0)
 		return ret;
-
-	if (log->head == log->tail) {
-		mutex_unlock(&fc->uapi_mutex);
-		return -ENODATA;
-	}
-
-	index = log->tail & (logsize - 1);
-	p = log->buffer[index];
-	need_free = log->need_free & (1 << index);
-	log->buffer[index] = NULL;
-	log->need_free &= ~(1 << index);
-	log->tail++;
+	p = fetch_message_locked(fc->log.log, len, &need_free);
 	mutex_unlock(&fc->uapi_mutex);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-	ret = -EMSGSIZE;
 	n = strlen(p);
-	if (n > len)
-		goto err_free;
-	ret = -EFAULT;
-	if (copy_to_user(_buf, p, n) != 0)
-		goto err_free;
+	if (copy_to_user(_buf, p, n))
+		n = -EFAULT;
 	ret = n;
-
-err_free:
 	if (need_free)
 		kfree(p);
 	return ret;

-- 
2.50.1


