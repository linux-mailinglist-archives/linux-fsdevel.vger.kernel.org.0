Return-Path: <linux-fsdevel+bounces-71007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22284CAF38A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 08:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BFCD3080AEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E82C08C8;
	Tue,  9 Dec 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OngT3/bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BBF27AC4D;
	Tue,  9 Dec 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266850; cv=none; b=u+lFKydmtLMyuN8q/mT5d3EFjV6pEa9tfJnV9MMfsLxPdESv5UDEdy36A2encCjWAvRHEDt7oWbJaGgWwpB5NiXeL5qrVASVxcNLYlz+3Cq6H0TsYpofKH3vb+pkhTjmR45/0G3iyUASiZugv1Llvw7t/Y/JVI5H4Z5qYQ7ExUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266850; c=relaxed/simple;
	bh=4gKRmhMGAAFmo9RouZIC0oku/ckUJIeUh0rkmhUEAzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5IAFMCPZGISsevLFDhYe6XR8YbnlEP1kGCXkFiPfGlAqUIMEaTmXDCMPbrXEq7u3HaSf5DNJsBJe4VpMow0rC+hZZipwPmbIRu/FETCoWYtfcHClPo00PuDJAkaz2+D7sW/vB0H67XICcsiaIWCmhMlJIjrza9ZkUYtHixLOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OngT3/bw; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765266837; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JcHsXEQLoCnx/9B/1g0nlZ2AYA38BU5rTlT7jlTtClk=;
	b=OngT3/bwIRsj1Il5jao2WYc3OJs8oTsSXQItD/hT+VgNaXqjl18F+UfVX4yDwwJaP+EPViOVKgVxpXy6VR0/Q5+EgVtAov/qkmb7AECMEASJvU01OojCTlCpCMIlY4CEQfpLKRychk63HWk3ZvT3udPRc8lKo+JXv5T2gpaekM0=
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WuRoT.7_1765266836 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Dec 2025 15:53:57 +0800
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] file: Call security_file_alloc() after initializing the filp
Date: Tue,  9 Dec 2025 15:53:47 +0800
Message-Id: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When developing a dedicated LSM module, we need to operate on the
file object within the LSM function, such as retrieving the path.
However, in `security_file_alloc()`, the passed-in `filp` is
only a valid pointer; the content of `filp` is completely
uninitialized and entirely random, which confuses the LSM function.

Therefore, it is necessary to call `security_file_alloc()` only
after the main fields of the `filp` object have been initialized.
This patch only moves the call to `security_file_alloc()` to the
end of the `init_file()` function.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 fs/file_table.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 81c72576e548..e66531a629aa 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -156,11 +156,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	int error;
 
 	f->f_cred = get_cred(cred);
-	error = security_file_alloc(f);
-	if (unlikely(error)) {
-		put_cred(f->f_cred);
-		return error;
-	}
 
 	spin_lock_init(&f->f_lock);
 	/*
@@ -202,6 +197,14 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
 	 */
 	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
+
+	error = security_file_alloc(f);
+	if (unlikely(error)) {
+		mutex_destroy(&f->f_pos_lock);
+		put_cred(f->f_cred);
+		return error;
+	}
+
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)


