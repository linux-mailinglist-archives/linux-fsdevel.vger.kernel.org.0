Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28C134FB23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhCaIGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhCaIGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:06:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A92C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t18so9096309pjs.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qd7q0+7mMIaCO7kNrN03miiLmUUotvU02ar15rGLAYA=;
        b=TC4wgya5iSyGQZApckwILsZ07cID8JY+wSUKJkkjSK6QenG/Nmjt6rFLbaVUVwLWuR
         qZUC8Y0GjUhiGVid8GxHZKbu9gf4fU+lvhfmVfPgGy+5jgQjVK7BNWsvr6SfgOEkycaZ
         5vq2ipI4hpOZ0O2rO+5j+j/r4ClYjWkyP2C+gZCHd4C/hmSUIOJRWa8irRXib6jNL6bu
         kD4W62kB3IbxjCgNwxzpm1RKEIwtcxPZUTI1DX3Y9RXd+XOhqYwQUafQpdnDpvkcgH0M
         D8Gqf8VvrAIYcVLhc6Mm5fymUe/OERG1iFMO5tcrA4RGKFIGu9cfuHfcaCK9xR+LNdNI
         8BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qd7q0+7mMIaCO7kNrN03miiLmUUotvU02ar15rGLAYA=;
        b=k+pqyLbXcByFFb5dzbNWVrOiQhirr5cDdtf+nnq7V20fwehNZGPTdUlBkl1eClY88E
         EgEkPI/TILiVH+4WmywVreR3eNZz+/Wx0gAosBid1Z1XP5ofS0MDq19uOtm8g6n9Ppak
         Zh+QLrlJ+nrqvk89GIQGHebbK4n24da/zrN1L0BXbfEHPZVmCwEfijZFQNwoTqMVYJSY
         TzPWKwZdx5Ze0lwaYFiiZ1kIl4m6f5sWcdlwJ7i6KEFEtGkdj8osPHbm6kV0Bzjo3s+t
         Tj5Ht/FzR4xkK6RVyt6Qrcgl7hwNerByZsy7jY/y/26/I4+IRuYPm9h1p4TJurrwqm/D
         0eJg==
X-Gm-Message-State: AOAM531Y3i4zRaPpoLqkKYyj2ksA2ewi7NGQeaNuHf7C0GRoXvrz8yu9
        UZDpVg1Dt7VDtMuW1tmxyVgJ
X-Google-Smtp-Source: ABdhPJydrF0nk0d3cE3vx8KgidDGa8Zfry5KovS8f39HDenv+8gD9ih8HKxbhTFZ2J9TJmZpWj0qlg==
X-Received: by 2002:a17:90a:fb83:: with SMTP id cp3mr2363661pjb.33.1617177981360;
        Wed, 31 Mar 2021 01:06:21 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 23sm1644744pgo.53.2021.03.31.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 01:06:20 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 01/10] file: Export receive_fd() to modules
Date:   Wed, 31 Mar 2021 16:05:10 +0800
Message-Id: <20210331080519.172-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331080519.172-1-xieyongji@bytedance.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
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
index dab120b71e44..d7d957217576 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1108,6 +1108,12 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
 	return new_fd;
 }
 
+int receive_fd(struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(-1, file, NULL, o_flags);
+}
+EXPORT_SYMBOL(receive_fd);
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

