Return-Path: <linux-fsdevel+bounces-55974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1005B1126A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 22:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869197B1A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343C42737E5;
	Thu, 24 Jul 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfhfcJAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093221771C
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389325; cv=none; b=ubTkiRrG5UAYxjgcnfkozFCIAskLtYfivHh3RPbA+itM6TJCm+97RWqx22eXDSeZWJFp8rjQ8gcA24QCJDDPWWbY1Oe3u7gx528+ZTaalGkOoCZ+gYqabdvLzeg6MSLc2HlJgOWk0YBGL18YZUn0FqTw/D/zPGlqVJ9MZAO9qSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389325; c=relaxed/simple;
	bh=1Jk7quE97jjbdcnzR1aUrqMbEapRrN5ATJzYBGQ2ipU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYFeoJsSJiTNmGVEdNNZ7d8q6r73TdnZr6gnCtTiVAzVox9IT9IEd2kCMuHChRkKqmQmB7Brlp0aiOuXWHvaUUUN9poiY1yV7ZRfGHG3GI7QwtdzHOMT8+667usZbmAHfIiZ1iz0H9hBjLU9ejHJPymrS9xMxZ2eLP7bWmS2tW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfhfcJAi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753389322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=48WYtcAdW78LpDzkPvUS+YcqmMCD/5HXCbJSgc5ggck=;
	b=LfhfcJAi5OiYE4yTl32PTQvC987QSRYr4RHHzCgPTOSR97UgiRYmgydQ7tGptgiulQKKie
	JgsAq4FQoQ0Zl0xUu4wLnw3d11+JrvsctXmmkS4WPXG5htnBqzorCscDzJ1nsk07yKa3TG
	PdDhIwQm3zGg1C/56psFqFoDL++pFEA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-57FeadSKMa2UMN3qr75tYw-1; Thu,
 24 Jul 2025 16:35:21 -0400
X-MC-Unique: 57FeadSKMa2UMN3qr75tYw-1
X-Mimecast-MFC-AGG-ID: 57FeadSKMa2UMN3qr75tYw_1753389320
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BC09195FD1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 20:35:20 +0000 (UTC)
Received: from tbecker-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99F031800242;
	Thu, 24 Jul 2025 20:35:19 +0000 (UTC)
From: tbecker@redhat.com
To: linux-fsdevel@vger.kernel.org
Cc: tbecker@redhat.com
Subject: [PATCH] locks: Remove the last reference to EXPORT_OP_ASYNC_LOCK.
Date: Thu, 24 Jul 2025 17:35:16 -0300
Message-ID: <20250724203516.153616-1-tbecker@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Thiago Becker <tbecker@redhat.com>

Commit b875bd5b381e ("exportfs: Remove EXPORT_OP_ASYNC_LOCK") removed
all references to EXPORT_OP_ASYNC_LOCK, but one lasted in the
comments for fs/locks.c. Remove it.

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 fs/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1619cddfa7a4..890af69baa5f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2328,8 +2328,8 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
  * locks, the ->lock() interface may return asynchronously, before the lock has
  * been granted or denied by the underlying filesystem, if (and only if)
- * lm_grant is set. Additionally EXPORT_OP_ASYNC_LOCK in export_operations
- * flags need to be set.
+ * lm_grant is set. Additionally FOP_ASYNC_LOCK in file_operations fop_flags
+ * need to be set.
  *
  * Callers expecting ->lock() to return asynchronously will only use F_SETLK,
  * not F_SETLKW; they will set FL_SLEEP if (and only if) the request is for a
-- 
2.49.0


