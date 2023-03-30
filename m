Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002B26D0BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjC3Qrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjC3QrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:16 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49981CDF5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3230125dde5so718475ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KesrPkm/FsQKVOBkTbitXewEYIv5YwFi8+M44L5LLdQ=;
        b=AGfMQZPkWVTEs3aOmgnBWo/PeGwtbErkgDdA6/YaAI+IZ6uDY2mW0Ec7Rraove81AB
         uS8Sw9Y0zuV0j/K+TAJ4H5RH+97WdruqR5hP0ZH25sgTUTPSWUQGvcp4pR4fqYLVy/PO
         dbfqrPQ7HNaZ2N8j2X1UZUcVGVY+sSSeRZdYs+quOy34Mv5AtRSa7osFNcaBHoafvAYz
         XRw2sK939o1XWoz+C5kdSghNBzFduRD2gUDOf0O79TN5vvndESZFFk16RajAtvd5mRHB
         icAWvL9eBQMWpuE4UkAN8csipnEP//RPGRx57edYpGBSr+uk0uKiUBTYKQ4MUu0284Fp
         aLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KesrPkm/FsQKVOBkTbitXewEYIv5YwFi8+M44L5LLdQ=;
        b=mQIyaiY/ApZgP8kLze/LBAV4xOLzD+P/X4AqBqqcTmtr9FtCLNmI6+CZBturF8C4B5
         ZUdeYk/Wl9ScCDWE0fkrxvZKCAg2WnOqTwcF8DbpoDCwww6UmyJawQf392tRjr4g1Uir
         3GVkQZK8MhOLKEXlZqgl/nz2aklmLLpmEjjVUv3s2krtSVpJy4xXAw7SI66I5R7zIe5E
         R67RidxuWa6jG08egwcEKkVpHX0UeIcbYa5RRxjBz7/Sn+VGZW3T/JKgFl4+MvLup8Ff
         RHcMkYuQ34liTo+nbxEGqZy1eT630yMfGdVcsN6HMxl2C0prD8BSp2X5LJqPQklvl/zi
         gKSw==
X-Gm-Message-State: AAQBX9dqaiNMUSO09Erm5LZsHMv/mp2GHXshp8rYxrZKYHWEMPbCFP+U
        dC45lT0WjFjU/ivhyOWi/ERmbMXeukOvWCOO/nzHDg==
X-Google-Smtp-Source: AKy350anKqmXtvPXiIO7zceHnf43PvO+c2gmUm2JOPZpvAMxxc1UUn2HLS86ghMDOPFuom05jt0nWQ==
X-Received: by 2002:a05:6e02:48a:b0:325:e065:8bf8 with SMTP id b10-20020a056e02048a00b00325e0658bf8mr1794099ils.0.1680194834412;
        Thu, 30 Mar 2023 09:47:14 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] iov_iter: overlay struct iovec and ubuf/len
Date:   Thu, 30 Mar 2023 10:47:00 -0600
Message-Id: <20230330164702.1647898-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
References: <20230330164702.1647898-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an internal struct iovec that we can return as a pointer, with the
fields of the iovec overlapping with the ITER_UBUF ubuf and length
fields.

Then we can have iter_iov() check for the appropriate type, and return
&iter->__ubuf_iovec for ITER_UBUF and iter->__iov for ITER_IOVEC and
things will magically work out for a single segment request regardless
of either type.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5dbd2dcab35c..ed35f4427a0a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -49,15 +49,35 @@ struct iov_iter {
 		size_t iov_offset;
 		int last_offset;
 	};
-	size_t count;
+	/*
+	 * Hack alert: overlay ubuf_iovec with iovec + count, so
+	 * that the members resolve correctly regardless of the type
+	 * of iterator used. This means that you can use:
+	 *
+	 * &iter->__ubuf_iovec or iter->__iov
+	 *
+	 * interchangably for the user_backed cases, hence simplifying
+	 * some of the cases that need to deal with both.
+	 */
 	union {
-		/* use iter_iov() to get the current vec */
-		const struct iovec *__iov;
-		const struct kvec *kvec;
-		const struct bio_vec *bvec;
-		struct xarray *xarray;
-		struct pipe_inode_info *pipe;
-		void __user *ubuf;
+		/*
+		 * This really should be a const, but we cannot do that without
+		 * also modifying any of the zero-filling iter init functions.
+		 * Leave it non-const for now, but it should be treated as such.
+		 */
+		struct iovec __ubuf_iovec;
+		struct {
+			union {
+				/* use iter_iov() to get the current vec */
+				const struct iovec *__iov;
+				const struct kvec *kvec;
+				const struct bio_vec *bvec;
+				struct xarray *xarray;
+				struct pipe_inode_info *pipe;
+				void __user *ubuf;
+			};
+			size_t count;
+		};
 	};
 	union {
 		unsigned long nr_segs;
@@ -69,7 +89,13 @@ struct iov_iter {
 	};
 };
 
-#define iter_iov(iter)	(iter)->__iov
+static inline const struct iovec *iter_iov(const struct iov_iter *iter)
+{
+	if (iter->iter_type == ITER_UBUF)
+		return (const struct iovec *) &iter->__ubuf_iovec;
+	return iter->__iov;
+}
+
 #define iter_iov_addr(iter)	(iter_iov(iter)->iov_base + (iter)->iov_offset)
 #define iter_iov_len(iter)	(iter_iov(iter)->iov_len - (iter)->iov_offset)
 
-- 
2.39.2

