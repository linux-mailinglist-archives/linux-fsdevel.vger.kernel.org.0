Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826511C352E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgEDJAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 05:00:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728284AbgEDJAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 05:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GipQquvXdS60T0xD4t06gmL9kKohzWhQBgW2pGftGs=;
        b=PKJVgZXNvlWSYlaTb61x/tZvtm8hQO/BHg6SvlHwmjNzzGe1xsqOestX1FyVQwDzkEsbup
        PYioLX8hEsd+SkoSN0GGxoewqT2eKLrfRM/ruUL0ny9Py81pMSzT09G9TjVMfevB86KSRh
        TvDQf50iChcAhpOV/JTRSrtbZ9usxxo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-eOOMp-KrP0eY5jYSnGivdw-1; Mon, 04 May 2020 05:00:44 -0400
X-MC-Unique: eOOMp-KrP0eY5jYSnGivdw-1
Received: by mail-wr1-f72.google.com with SMTP id f15so10477491wrj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 02:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5GipQquvXdS60T0xD4t06gmL9kKohzWhQBgW2pGftGs=;
        b=Lkhs8sWnYQ9y/rNT3fAIhr0UfhjPbNbTtm+yt6niSVG5Xxc5V03zvA9RKoq091OxFX
         u4n1LcEXDzBPtmqu3K9EPz8raHPvinUtNdccFQItKUBZrF6FDxKuVAxbmEUgcru/k7fi
         jV7mi43/iO5bW7ozYypSJUW+mNamycn1D+5bYqd7SpyyStZNptXmER6VrnbcjGom9+/Z
         mJndh9fCkVHP8aPT3xk3y2l/2uWHBtB3SAL8gitBNtJaKSDLbtV44rqaeKWlybPaHyJQ
         /iyLPM+U62tLaYv4jFdSJibBs8ukG2M5AugediNsPygPDrOWxTmqvuV8SJgvL6IOLxXw
         lvtw==
X-Gm-Message-State: AGi0PuYkUYcpRn9EQqT4c0L5sdb47t2Vaxrlaoe60DIW1xDQWH5NFODq
        LUfbMpd/GQno74YcTE6xkSRVw1ZSFw9OgJ6+AlRs08x05+MZYRhHMBRny8bH5+uq7cZtHmZPQV3
        VD45fNy/4fnkLFqlqHQVTGcWQyQ==
X-Received: by 2002:a05:600c:2c47:: with SMTP id r7mr13294625wmg.50.1588582842760;
        Mon, 04 May 2020 02:00:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKnkgYUOxz4pXmyqTdraQ5ct2LjW+Ji2dA+XQpsGvh8Pgxejs/odcq1JJnrY6xlHgIOTFS2bA==
X-Received: by 2002:a05:600c:2c47:: with SMTP id r7mr13294602wmg.50.1588582842536;
        Mon, 04 May 2020 02:00:42 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id u127sm12984720wme.8.2020.05.04.02.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:00:42 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 4/7] libfs: add alloc_anon_inode wrapper
Date:   Mon,  4 May 2020 11:00:29 +0200
Message-Id: <20200504090032.10367-5-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504090032.10367-1-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

libfs.c has many functions that are useful to implement dentry and inode
operations, but not many at the filesystem level. Start adding file
creation wrappers, the simplest returns an anonymous inode.

There is no functional change intended.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 drivers/gpu/drm/drm_drv.c       |  2 +-
 drivers/misc/cxl/api.c          |  2 +-
 drivers/scsi/cxlflash/ocxl_hw.c |  2 +-
 fs/libfs.c                      | 10 +++++++++-
 include/linux/fs.h              |  2 ++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e29424d64874..1854f760ad39 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -539,7 +539,7 @@ static struct inode *drm_fs_inode_new(void)
 		return ERR_PTR(r);
 	}
 
-	inode = alloc_anon_inode(drm_fs.mount->mnt_sb);
+	inode = simple_alloc_anon_inode(&drm_fs);
 	if (IS_ERR(inode))
 		simple_release_fs(&drm_fs);
 
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 67e4808bce49..57672abb6223 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -72,7 +72,7 @@ static struct file *cxl_getfile(const char *name,
 		goto err_module;
 	}
 
-	inode = alloc_anon_inode(cxl_fs.mount->mnt_sb);
+	inode = simple_alloc_anon_inode(&cxl_fs);
 	if (IS_ERR(inode)) {
 		file = ERR_CAST(inode);
 		goto err_fs;
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 7fa98dd4fa28..0e9f2ae7eebf 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -85,7 +85,7 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
 		goto err2;
 	}
 
-	inode = alloc_anon_inode(ocxlflash_fs.mount->mnt_sb);
+	inode = simple_alloc_anon_inode(&ocxlflash_fs);
 	if (IS_ERR(inode)) {
 		rc = PTR_ERR(inode);
 		dev_err(dev, "%s: alloc_anon_inode failed rc=%d\n",
diff --git a/fs/libfs.c b/fs/libfs.c
index 3fa0cd27ab06..5c76e4c648dc 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -741,7 +741,15 @@ void simple_release_fs(struct simple_fs *fs)
 }
 EXPORT_SYMBOL(simple_release_fs);
 
-
+/**
+ * simple_alloc_anon_inode - wrapper for alloc_anon_inode
+ * @fs: a pointer to a struct simple_fs containing a valid vfs_mount pointer
+ **/
+struct inode *simple_alloc_anon_inode(struct simple_fs *fs)
+{
+	return alloc_anon_inode(fs->mount->mnt_sb);
+}
+EXPORT_SYMBOL(simple_alloc_anon_inode);
 
 /**
  * simple_read_from_buffer - copy data from the buffer to user space
diff --git a/include/linux/fs.h b/include/linux/fs.h
index de2577df30ae..5e93de72118b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3373,6 +3373,8 @@ struct simple_fs {
 extern int simple_pin_fs(struct simple_fs *, struct file_system_type *);
 extern void simple_release_fs(struct simple_fs *);
 
+extern struct inode *simple_alloc_anon_inode(struct simple_fs *fs);
+
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
-- 
2.25.2

