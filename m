Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F613D9E86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 09:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhG2HgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 03:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbhG2HgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:36:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F8C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso8016523pjo.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7lCOA+2uHcoDlHpnAPiyr08qHLnKknrRwhD42bW14c=;
        b=L3+zrqxq1jDIch5mBMRlq4aMkZWeJXNgz//RgYj4u3V1lMU7q20ZSp16442c0mWaWo
         3pimykQ5c3xo5hFxpe8YP2kPqJRUDXMEfySemYatlQJMfgm4TKPWnxljrQ4scQVJVmAe
         SgYBeBiHSj6pBrjI7edJBnGY1o6V08/DYlBoSrgQMsrmRK906zgqaAWchZrUKOHWJ1s2
         G28MPqjFEY3cvBXfzP0Rxts8xu3e5wgWbnD4qAUWn0c4JOpCgg0t7ExynJrXsb/Lqv0X
         wvgLL4SNtH3zcQoSC98vHFIPnTb8V3qERqJnvlidDS9Zlh9UapAb0RrBTxogd7yCCZ8j
         K9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7lCOA+2uHcoDlHpnAPiyr08qHLnKknrRwhD42bW14c=;
        b=Heed59gMI6pBZQwJO2JrnNtRO2pYfs3oTx9ZLtuds6Y4XwLGTc7gSabuxyyHulhKvI
         UQr5doiJw4hDyX8+LqDYyfiOa+093LZKSPwGpPODYsiH+9bE1PYK3nvOUxL1rUtU5JLn
         8ysjr9eWIfoIXP19+GBAv1hHmXCK63RV3iRTuC4+dWkxH+4xF5+4x1NPNRZAZr33US5e
         PE1w8DZprMtLymG8h4dlo4NW9UvASHgSjtB/nDyENr753/5/FjyjSTQVq8MZRNsJaQ/4
         wYpZHkN4eq3d+VNmK+rEgCt0bNboxOUSIYagmgJSj9b2l9K1IWCAG79hKNAxRtmSB76Q
         CRxg==
X-Gm-Message-State: AOAM530fWu/JVyyGquPoOWSu9NQZBFgMyjlSoNUvxyEgraredQQOkHNK
        Atl12WRulMpL9PVQUL3BnG2y
X-Google-Smtp-Source: ABdhPJz6gtDSzVbKQwR9fMTMuBAxDE/HudL65A5sjPsB1aFvsDsAWmfl9tE1fqIYigp4LRfAx1lPGg==
X-Received: by 2002:a62:804b:0:b029:328:db41:1f47 with SMTP id j72-20020a62804b0000b0290328db411f47mr3610895pfd.43.1627544168542;
        Thu, 29 Jul 2021 00:36:08 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id y8sm2535031pfe.162.2021.07.29.00.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:36:08 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 02/17] file: Export receive_fd() to modules
Date:   Thu, 29 Jul 2021 15:34:48 +0800
Message-Id: <20210729073503.187-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
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
index 86dc9956af32..210e540672aa 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1134,6 +1134,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(file, NULL, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
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

