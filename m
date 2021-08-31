Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD53FC610
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbhHaKjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbhHaKi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:38:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF42C0612E7
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m26so14633207pff.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkhRtVDUgb41zlq5OfgVAHJFRMwL0PptQO/kVg6fccA=;
        b=wb1QmOQoMFVShBMn9y6KTytH5q1BZ0H1hJ3YO5uXgTFjLoGaoSepJJ5OlbhccHu/AJ
         wAiGO67xMVtU0t2LrJWcMBK/NhTSX6ZkR3DOqmyntbAg6jf+Cr1K9Cw8Xhb1KbRfFq5f
         0PiM2QpjLxqt7Y8TQAgsTNp6GYrUDvE9Lh/oajmuWt89WT4dDtxIROjBFBxpqguUKBU7
         LLMz+DXMsZEm4Eg593FHxtTTvCsA6fIWSzAN4+6DPx7X3FPKVNWqVAX/Kck7QYFDzzcC
         d2NfPV00YlGSbPc1qoUeYTZUD6zpXTRPBo7PsZ9aFWAnnS/G89GxBIlH9Z/mgTPMxFx/
         rbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkhRtVDUgb41zlq5OfgVAHJFRMwL0PptQO/kVg6fccA=;
        b=fHs625L4SDIo+Lg0uT9Fx8wlsXSUKJ4lhuqv7SlsonLRpWONCRwwTQWOkGckXk4ANg
         woHS66P1cb5lSQ2qYIGa5x1eQJ1NotzIN4/05TC7hvWG+MNTaC+rGn++kpTLzHUIs5Aj
         kAzXBJcoO4HdlAqDJl3EpxYaQ2320N4C7aniLmPHKVLoa9ghfgqGl3Vvabg+6GHWxe2y
         uwEayzxrcTEE/HRO0o3aJOPxkc6ChREPd5OtsDY4ilVpmiaqIFTkBvFop398ipMOHpgC
         qYyrTxrr13kEbTh9Vg0ktKP2U/A16u6o9aNh2t9QHN5B4IijDn09XHr+9ebBbS8EtlkO
         RA+g==
X-Gm-Message-State: AOAM531/tUPyEuG/ACd2PaX+/xeMep4r/J+L7jRJ/3fcOoPpvHLZsN5H
        j+UXYyEFWsRY3GBsGXSxahkv
X-Google-Smtp-Source: ABdhPJzBeHb26ioOoBceC1KZUNqQKw0qJ8cn0b2Nhenwq0dSjkYw4fqu/cKwDwROR4HestxrtqNmDQ==
X-Received: by 2002:aa7:999c:0:b0:3f2:8100:79c2 with SMTP id k28-20020aa7999c000000b003f2810079c2mr22685875pfh.80.1630406235060;
        Tue, 31 Aug 2021 03:37:15 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 15sm2641504pjw.39.2021.08.31.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:37:14 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        will@kernel.org, john.garry@huawei.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 03/13] file: Export receive_fd() to modules
Date:   Tue, 31 Aug 2021 18:36:24 +0800
Message-Id: <20210831103634.33-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export receive_fd() so that some modules can use
it to pass file descriptor between processes without
missing any security stuffs.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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

