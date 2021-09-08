Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFB403636
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbhIHIkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348087AbhIHIkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:40:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F6C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 01:38:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t1so1856247pgv.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nryVc2RURt+3fLSRG7C2d4DCjUnaowb5XLwssDn/Pco=;
        b=p2+pnmtbBujD94iPSUdYojHOOKO6aXt59K82FGC05YoPDiq3wvHC+9ee5SaNycjbDm
         x6JqU/xf2LQciIEfaNjnlOgC57WH+KA+lTl3VCSywnPLHNHM8YHl2EsPx55/+vk94WhP
         lSWjfvZsdCwPJzYRr5n5EPBQ/bNroLXHVUk3gOe46JWOAD1OpuQLGpdf+6vPaenJoln+
         dOrrQRoQCdufQwVW0Q6zjBeeXhj3NBRkxvtVeOkV5u3EnoGeDwCMVqpjoCt3RVYolCUW
         MXAi5y+qbP/b+gVouImyuWrBSQVI8ycOkJe8D64d5BmKFP3FOy3RzH/0j958ppXYYzVS
         EZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nryVc2RURt+3fLSRG7C2d4DCjUnaowb5XLwssDn/Pco=;
        b=fRtp6/MXk4DlKe7DIJvxqf4+kv3p7PmJhJ3sAlcIReD7h//9pkLB0cCYNt5IPNwm9F
         zwx5YmAgyHcT7yNCJLefRn1/YKUqvUqY9kxzqweYNHwXbAUWfZPIWu2YkuHM2FAK2mlE
         9fKnuuVgottA0RFnDTtA6VXL/xkkElNe8FKbO4kC+qiGw0TKgi0CfuPmlaCu9lMJHaAE
         exdIAFp7FwV9MLj3P/G2rH7TorwhN7WbF8cxqKgSj/ovduA8R7xbBj5VabHfXXFOQEX1
         gMFkXV4OahI/ph+Ik9ZsPh+tf63MBEmgazMD/KZVIv+1yItdE4h8/q4EbnUSkPErhWVm
         xzmA==
X-Gm-Message-State: AOAM532nkcQysXL+UmEfgUsoCsYzxgDtUlahN0mt2nXHM90+nYzt4zvv
        h+rKCSIxJunn7SSVKBRDHLa5q+I3JXfOltKo
X-Google-Smtp-Source: ABdhPJxjalGODkdzjyOo5Q4Np0xMahMDU3Mp0N/5gOYXX156TqVQhEbRO0wh2iLc+3SRFOJwsVtgWg==
X-Received: by 2002:a62:9293:0:b0:3f3:bb99:5d34 with SMTP id o141-20020a629293000000b003f3bb995d34mr2649089pfd.9.1631090333372;
        Wed, 08 Sep 2021 01:38:53 -0700 (PDT)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id l185sm1518889pfd.62.2021.09.08.01.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 01:38:53 -0700 (PDT)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH]  fuse: Use kmap_local_page()
Date:   Wed,  8 Sep 2021 16:38:28 +0800
Message-Id: <20210908083828.47995-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Due to the introduction of kmap_local_*, the storage of slots
used for short-term mapping has changed from per-CPU to per-thread.
kmap_atomic() disable preemption, while kmap_local_*() only disable
migration.
There is no need to disable preemption in several kamp_atomic
places used in fuse.
The detailed introduction of kmap_local_*d can be found here:
https://lwn.net/Articles/836144/

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/dev.c     | 8 ++++----
 fs/fuse/ioctl.c   | 4 ++--
 fs/fuse/readdir.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dde341a6388a..491c092d427b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -756,7 +756,7 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
 	if (val) {
-		void *pgaddr = kmap_atomic(cs->pg);
+		void *pgaddr = kmap_local_page(cs->pg);
 		void *buf = pgaddr + cs->offset;
 
 		if (cs->write)
@@ -764,7 +764,7 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 		else
 			memcpy(*val, buf, ncpy);
 
-		kunmap_atomic(pgaddr);
+		kunmap_local(pgaddr);
 		*val += ncpy;
 	}
 	*size -= ncpy;
@@ -949,10 +949,10 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
 			}
 		}
 		if (page) {
-			void *mapaddr = kmap_atomic(page);
+			void *mapaddr = kmap_local_page(page);
 			void *buf = mapaddr + offset;
 			offset += fuse_copy_do(cs, &buf, &count);
-			kunmap_atomic(mapaddr);
+			kunmap_local(mapaddr);
 		} else
 			offset += fuse_copy_do(cs, NULL, &count);
 	}
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 546ea3d58fb4..fbc09dab1f85 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -286,11 +286,11 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		    in_iovs + out_iovs > FUSE_IOCTL_MAX_IOV)
 			goto out;
 
-		vaddr = kmap_atomic(ap.pages[0]);
+		vaddr = kmap_local_page(ap.pages[0]);
 		err = fuse_copy_ioctl_iovec(fm->fc, iov_page, vaddr,
 					    transferred, in_iovs + out_iovs,
 					    (flags & FUSE_IOCTL_COMPAT) != 0);
-		kunmap_atomic(vaddr);
+		kunmap_local(vaddr);
 		if (err)
 			goto out;
 
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index bc267832310c..e38ac983435a 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -76,11 +76,11 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	    WARN_ON(fi->rdc.pos != pos))
 		goto unlock;
 
-	addr = kmap_atomic(page);
+	addr = kmap_local_page(page);
 	if (!offset)
 		clear_page(addr);
 	memcpy(addr + offset, dirent, reclen);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
 	fi->rdc.pos = dirent->off;
 unlock:
-- 
2.27.0

