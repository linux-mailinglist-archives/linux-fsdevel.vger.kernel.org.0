Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB7658A41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiL2INV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiL2INT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:13:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B353111A10
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so17979529pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97i6P/h7b+1gvIVRYO+DX34CDfR4Yqv0wh8jpsVN6uA=;
        b=J3UxtnO0lRODuALIZIbXFjggUs9csqzYnLWy6fCUhVcEssVoXOgvKDKzSKMFzlyrjx
         IAcfKrnfFQdpsDZbxkBzRb3HsHRv4Zx0R+LRjDqk5C1MorbFDuEtB4dQo6e2wnJcboJU
         lOoPqaeq28xjwQUyT3StdCsVbKKsSKUNoIs8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97i6P/h7b+1gvIVRYO+DX34CDfR4Yqv0wh8jpsVN6uA=;
        b=1gRjt3Xs0VC5nI3vmMmlPT361TGMLcAUc8FeTLU7uGY5jvqldC413TDk5awGI77SLH
         J/zaEa/cYhCvpPjOU2YUPjMciaFnRRSXUVRq94SCiLZOoDSzu5jU1bFDrwdr/WIxOviO
         I0UQfiq16hkfDdSpw+nZTUVK01rj5ySmQaH8CztqdPVHG6vrZbxj4HRTxCETgdeyD9Ld
         Jj5R3tVGbi9DKyzNN2/dRq1+JGSQzpAe2trjeTOzNiCL3+DMZv8UgP5I0/zYIXVjd0Jd
         OJiOMvDvjUanKvsLvvaPe5MoGZaDlDIPs8cBZ4+5G5WRW0VnuSSEmPHPJlKNbKIPB+2/
         Yy/g==
X-Gm-Message-State: AFqh2kpn75yS0zuOAYGxr4BQkrlywSBNYFe+DgTX9vqeEcwRKPfZ0I+8
        fvwkAAwb3s+lrD1QpmzDwude3g==
X-Google-Smtp-Source: AMrXdXuG8djGml0FmIoeHtIQvCDtglHyJ1RnAJ0w5NvdgLWhnB8c6w6P+S+xrI2iEBZecvFqN4EojA==
X-Received: by 2002:a17:902:9687:b0:192:9ab2:fd1c with SMTP id n7-20020a170902968700b001929ab2fd1cmr2910136plp.26.1672301586179;
        Thu, 29 Dec 2022 00:13:06 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:13:05 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
Date:   Thu, 29 Dec 2022 00:12:48 -0800
Message-Id: <20221229081252.452240-4-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229081252.452240-1-sarthakkukreti@chromium.org>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FALLOC_FL_PROVISION is a new fallocate() allocation mode that
sends a hint to (supported) thinly provisioned block devices to
allocate space for the given range of sectors via REQ_OP_PROVISION.

The man pages for both fallocate(2) and posix_fallocate(3) describe
the default allocation mode as:

```
The default operation (i.e., mode is zero) of fallocate()
allocates the disk space within the range specified by offset and len.
...
subsequent writes to bytes in the specified range are guaranteed
not to fail because of lack of disk space.
```

For thinly provisioned storage constructs (dm-thin, filesystems on sparse
files), the term 'disk space' is overloaded and can either mean the apparent
disk space in the filesystem/thin logical volume or the true disk
space that will be utilized on the underlying non-sparse allocation layer.

The use of a separate mode allows us to cleanly disambiguate whether fallocate()
causes allocation only at the current layer (default mode) or whether it propagates
allocations to underlying layers (provision mode) for thinly provisioned filesystems/
block devices. For devices that do not support REQ_OP_PROVISION, both these
allocation modes will be equivalent. Given the performance cost of sending provision
requests to the underlying layers, keeping the default mode as-is allows users to
preserve existing behavior.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c                | 15 +++++++++++----
 include/linux/falloc.h      |  3 ++-
 include/uapi/linux/falloc.h |  8 ++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..01bde561e1e2 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |	\
+		 FALLOC_FL_PROVISION)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		goto fail;
+	if (mode != FALLOC_FL_PROVISION) {
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+	}
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
@@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
+	case FALLOC_FL_PROVISION:
+		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
+					       len >> SECTOR_SHIFT, GFP_KERNEL);
+		break;
 	default:
 		error = -EOPNOTSUPP;
 	}
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index f3f0b97b1675..b9a40a61a59b 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -30,7 +30,8 @@ struct space_resv {
 					 FALLOC_FL_COLLAPSE_RANGE |	\
 					 FALLOC_FL_ZERO_RANGE |		\
 					 FALLOC_FL_INSERT_RANGE |	\
-					 FALLOC_FL_UNSHARE_RANGE)
+					 FALLOC_FL_UNSHARE_RANGE |	\
+					 FALLOC_FL_PROVISION)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 51398fa57f6c..2d323d113eed 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -77,4 +77,12 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
+ * blocks for the range/EOF.
+ *
+ * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
+ */
+#define FALLOC_FL_PROVISION		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
-- 
2.37.3

