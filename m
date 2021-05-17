Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E558A3828F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhEQJ5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbhEQJ5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 05:57:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66870C06138D
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 02:56:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t193so4295731pgb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2jCEx8mi3vXgkJ9kkatzIPCmNDeaAe/ogyF3BNTwbw=;
        b=BIAa64R4y9k3Eg3WHj2S666iigdAlamttMFasFKl0/os5LVtgYGUotdFoSEHugW/Eu
         bPRzaxAW284e8L8yo2K3DDL0/T8tA/l8wgLVMmAmo6+IhFLW/GYToPaLLl355N+97G5L
         XexcA5aHvM9w2PGt9fWa2k/dVGxtVldmNsYPnqawOun42Yk2znLlV60hSNjDq7IYxrSR
         /MfnGeT4tFvQVkSyH11nQ65tEhzqJ/jZPaGxLuLbESIf2R6H7QaYs485JdPrsXqE7dOf
         I4DwWEpiBqfQ6lw4Z+Sbeqdk137WXiyVzbQGXwJPtZ+TTYkfwjFV4U35eCpK8JW0Dmto
         ErvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2jCEx8mi3vXgkJ9kkatzIPCmNDeaAe/ogyF3BNTwbw=;
        b=CusfsWbZVPi7jiYZxU+dbF4FyxaFA3GwsDG8Slmwgc1u03MUlRzWDT6u5I9fI+D2aV
         KZoPnoDGi3XYaz5kswPYo0FsWxq6xyLhtkFzn8qeye7udBZg5W/uIOYe0n9oXOKrJzqT
         Y9XsT5NTRGwkaDu6YyObohJEYdrhqCNnQs4R0lSd2XRhp3wqay8W7fnYo/h/gqua0K/z
         BWqRY+fUYvf/IlTB8endrXZcAj+hESfblnu1/y3KRq5A01b+7eNGP/yhnIzO9kUGCX2Q
         3tAAwAr1DWTSUzgongV9aZlZ6e4Oc8tX8hKkiV8g4gQxO8PA8FAi2qmNlathDvqLo2OS
         8nNw==
X-Gm-Message-State: AOAM531L5JIvvAGovRwKpnh2JB+v/SOkjPTcb9HE3o0cxJ9msZGwIVzP
        W81I0ss23iTpFiVpzmS4NI/f
X-Google-Smtp-Source: ABdhPJxMHtpizSq6PPRichE5BBR0ifuwPYTxOEXD/Wu/CUyxhwu/aKM7AbIbvC3ahRVJo9npK3SCVw==
X-Received: by 2002:a63:d45:: with SMTP id 5mr1321436pgn.72.1621245363924;
        Mon, 17 May 2021 02:56:03 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id gz18sm8486949pjb.19.2021.05.17.02.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:56:03 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/12] file: Export receive_fd() to modules
Date:   Mon, 17 May 2021 17:55:03 +0800
Message-Id: <20210517095513.850-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export receive_fd() so that some modules can use
it to pass file descriptor between processes without
missing any security stuffs.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/file.c            | 6 ++++++
 include/linux/file.h | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index f633348029a5..ef4da2eaf25b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1135,6 +1135,12 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(-1, file, NULL, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 225982792fa2..4667f9567d3e 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(int fd, struct file *file, int __user *ufd,
 			unsigned int o_flags);
+
+extern int receive_fd(struct file *file, unsigned int o_flags);
+
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
@@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
 		return -EFAULT;
 	return __receive_fd(-1, file, ufd, o_flags);
 }
-static inline int receive_fd(struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(-1, file, NULL, o_flags);
-}
 static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
 {
 	return __receive_fd(fd, file, NULL, o_flags);
-- 
2.11.0

