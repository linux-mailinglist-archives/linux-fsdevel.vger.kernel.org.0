Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4F147A40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgAXJSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 04:18:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45883 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgAXJSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:18:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so509883pls.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2020 01:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RcxGgdRV5d1ycPgKGQshU3Dx8E58q2RM4BSH6L50H0=;
        b=kANUyGecpiYvb2WO2ikFMEFOaN9u2zq3XlV+Z5Nw/EA8/DlRMoPGwX73EyF2cCBkZt
         pcSrQchshZZ/6y7WX2YPWRhg9sC6oKm+hohz1m9VbDg9ARdka/rVoRBDAPEiMwrgT4x7
         0hvAnZKvMXI0h46+4EY5QHhcIhncztG0rzfcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RcxGgdRV5d1ycPgKGQshU3Dx8E58q2RM4BSH6L50H0=;
        b=SDwyWDulQSrm+2dlqKQtqrILQsNlRtkktQpIRqeLVW7Ixne7lrbZ1Wqhl/TgCXL7Aj
         p9cJ1TTLbXSnM9h2uejmWw+aUgjKt5gxgcARJ8MALpgbwSn9yGR4jp+NKpC+NBzTqNhX
         +KnTZ8ff75fyPPYdvHPJ1FWOtCuv4SzReCMfFSNuC5QAJPXMoVAVqCp+Ww0oElQfBXcY
         pSSRO+66vYZui0GfxwVvvpSZmTOFY0VVLI8F01vwjOHcFP8oCtQMV2eWVv5FsRWGeZ2p
         27Np8BsI1F+6vBy4CFZZ5FRZNuvSAMM+Y9maSX64sZRSTiYEmPNcdTk+l1JbIQpVFprJ
         Pzdg==
X-Gm-Message-State: APjAAAVOBp2CePAi7mwDX/J76Pj4DMJvzTJV9UWgpfcgn4ufePAf/VyF
        49tka/QvOQERfzVsRkBrF44aXw==
X-Google-Smtp-Source: APXvYqx1b2xzIF8PeZ6R4Bhfq1a/HDT+lOtsd1FQcTEZpaUwRHyP1m1M56OAz1kKECc2oz1uyuHobQ==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr2533438pln.185.1579857479183;
        Fri, 24 Jan 2020 01:17:59 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:17:58 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 1/4] pid: Add pidfd_create_file helper
Date:   Fri, 24 Jan 2020 01:17:40 -0800
Message-Id: <20200124091743.3357-2-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124091743.3357-1-sargun@sargun.me>
References: <20200124091743.3357-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper allow for creation of pidfd files. The existing helper
(pidfd_create) creates file descriptors directly, which cannot
be used without race conditions when there is an intermediate
step between creation, and informing userspace the fd has been
created.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/pid.h |  1 +
 kernel/pid.c        | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 998ae7d24450..70d4725cf8da 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
 struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
+extern struct file *pidfd_create_file(struct pid *pid);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 2278e249141d..2a34db290128 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -521,6 +521,28 @@ static int pidfd_create(struct pid *pid)
 	return fd;
 }
 
+/**
+ * pidfd_create_file() - Create a new pidfd file.
+ *
+ * @pid:  struct pid that the pidfd will reference
+ *
+ * This creates a new pidfd file.
+ *
+ * Return: On success, a cloexec pidfd file is returned
+ *         On error, an err ptr will be returned.
+ */
+struct file *pidfd_create_file(struct pid *pid)
+{
+	struct file *f;
+
+	f = anon_inode_getfile("[pidfd]", &pidfd_fops, get_pid(pid),
+			       O_RDWR | O_CLOEXEC);
+	if (IS_ERR(f))
+		put_pid(pid);
+
+	return f;
+}
+
 /**
  * pidfd_open() - Open new pid file descriptor.
  *
-- 
2.20.1

