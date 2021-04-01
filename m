Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB8351189
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhDAJJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhDAJJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:09:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F45C0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 02:09:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so1150383pga.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcFW2882TDAB0Szg+grt3QNSfA4PwJpJAwOH20WQc3U=;
        b=fqr736cKPoNsBHMb7WyFTgrU6fRrMvpOOsOByzUKP4cZh5dOqtzEVp+rAvVVFi90cK
         hR/OTVJbXJMRiZJjYfIEPtHdj8DHn+v5moAuKMuYj1nwRUBfXBsHIjGNitslymjxfWa+
         QEpPpnaBpZnj5M71DlPERV2FggpXB6HvhTlwrhQV2PsVXFp5X+bxsPwn5tRLDFSELFTA
         BfO1LaoEDdB95RXDFWQnDiRIqHNHUZPwPVznCpB0BQKQEIJNhVVm95gyKftGfOhGlWdl
         WZ4HsLfCtjlvHWUOnvzTq616lvhjUWNy9Jt6UDQJDaQFGy17UgxmGBtafhTWSFXyUhs+
         J0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcFW2882TDAB0Szg+grt3QNSfA4PwJpJAwOH20WQc3U=;
        b=LjGRcwIjG3fF7MwTXWg27wZFMIkY0Sl9IWjiOaM8KaO3X5WaHdz7a1iI43rYDqArLC
         OsMOfv1T4CAhKkO13bMw6zRepEqPEq9WOO2eXws6H7pl9hFQTxPQ6WxxKnBd9OLL6Cfr
         yaT0ZTJNznQuAr6p5bbMwXLknDyhzzZPcP57aEytYfwDVLAeTbrgEO+o5ap59KxVCyvv
         r6I1nOxAbIjSmxq8ZbrFjSDhlAsYO9Wdlq5FBk/8XAQzgfXiD5PymwvsLLQ9fmHZSpB/
         qzkWmunBsiYrqMcPbObjOP5/qhfGTwAFQal0mkuIrAGWIf699RWCgXSo6LR9Mi4jSiLE
         jnxw==
X-Gm-Message-State: AOAM531BdOCiWGVktSSpeUBTvCGHFjL7eRUQM4JCPV3nsSC2sgFemaUK
        WD+RLHH7n/YXx4TDdddCsUkw
X-Google-Smtp-Source: ABdhPJye1+QSmRDrJtotpPX35xPqPCPC9yfHjqxgCyLsQO2U3Q/jaWMwQ0mXFN6YqGYZgUHLaGEIYQ==
X-Received: by 2002:a65:6414:: with SMTP id a20mr6613866pgv.424.1617268188789;
        Thu, 01 Apr 2021 02:09:48 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id i10sm13946337pjm.1.2021.04.01.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:09:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     christian.brauner@ubuntu.com, hch@infradead.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, hridya@google.com,
        surenb@google.com, viro@zeniv.linux.org.uk, sargun@sargun.me,
        keescook@chromium.org, jasowang@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] file: Export receive_fd() to modules
Date:   Thu,  1 Apr 2021 17:09:31 +0800
Message-Id: <20210401090932.121-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401090932.121-1-xieyongji@bytedance.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export receive_fd() so that some modules can use
it to pass file descriptor across processes without
missing any security stuffs.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/file.c            | 6 ++++++
 include/linux/file.h | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 56986e55befa..2a80c6c3e147 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1107,6 +1107,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(file, NULL, o_flags);
+}
+EXPORT_SYMBOL(receive_fd);
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 2de2e4613d7b..51e830b4fe3a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(struct file *file, int __user *ufd,
 			unsigned int o_flags);
+
+extern int receive_fd(struct file *file, unsigned int o_flags);
+
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
@@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
 		return -EFAULT;
 	return __receive_fd(file, ufd, o_flags);
 }
-static inline int receive_fd(struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(file, NULL, o_flags);
-}
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
 extern void flush_delayed_fput(void);
-- 
2.11.0

