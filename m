Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E976CF256
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjC2SlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjC2SlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5DE10DB
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id o12so3563316ilh.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0VcraBYDXC4QOd32aPXOd6FdUFJG3e+L8qS4/nO0PQ=;
        b=GN+TKYHX/Fk+/Qti8rTPVEFBex+/1+wEWvE9Jzxwk/K2eeFunZMbT4WXIm4GVZTGji
         E5RRzkrmdR6s//ZFA9rsI5hQSUIlUJrkC+xHQrkYdYOLYJcYxMCJR9r7w6tr6WGqI7hw
         Zz04B959Dew8wUE+JyQBmVDUOMXt/K35xxRsZ9XOuk44H4S88MolZwz3O9vJkfI9TgrN
         zJrWWvFXn0mRrChzxRSTkgggNzUcibrFumpIbQBrpJRKW5pEyLJspPAIniwGRiCg2zd4
         td0qlk654bXVlRhRhiQxNwThWkn0rsyJCWLgvz3xwDFUNaklcRw/mYOvWP+yeoWFHDGc
         0eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0VcraBYDXC4QOd32aPXOd6FdUFJG3e+L8qS4/nO0PQ=;
        b=hYIsooCZDoanhGh+94yVKp3YyWYuRXrpzQWccuMU/nRrbiiSityASfZDtHKA6RSx0K
         /oOwVW3u3J6i37L4Dz/iCI718yRjU/cKp8Im2iqk0YFTAbC0GwSOyGWwW4nPoK1fH7QM
         zBy+VUT7XxC2hitAD3wVgosQ/r5gDviJHzrCs8hZqTE8dCH6qqGFjKfkA/0qk3NxCPDb
         BoHh9pRlrxMsC25sGbD8giTbWQzIbGO1CH7oMa6xKtKfDLo9/sjKCyYjTPXISHWggZtB
         XePnPSmFvbYnqCy6Vk5/QbJID0k4uBRyiuq1Lw+40Zv7D2PukdJnuEKnxNOcXDinEnrk
         puPw==
X-Gm-Message-State: AAQBX9eNik0sV8+6D9Gry2mbNvbGeqdq0xT5kXIMgA7nSNc3uvGDpQAk
        eBC/lVc1w62HV5sUW2PW/OaAyomnEnocMFcFDUr8VA==
X-Google-Smtp-Source: AKy350aY7ZrWWrk34HMjbkMzQNGa6Bu1NC/lty11c8FWPIpBH4kzB40UoUzvVOF6cUPvcEjsMXCbpA==
X-Received: by 2002:a92:cda6:0:b0:31f:9b6e:2f52 with SMTP id g6-20020a92cda6000000b0031f9b6e2f52mr12817037ild.0.1680115265705;
        Wed, 29 Mar 2023 11:41:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
Date:   Wed, 29 Mar 2023 12:40:50 -0600
Message-Id: <20230329184055.1307648-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329184055.1307648-1-axboe@kernel.dk>
References: <20230329184055.1307648-1-axboe@kernel.dk>
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
 include/linux/uio.h | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5dbd2dcab35c..361688b86291 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -49,15 +49,30 @@ struct iov_iter {
 		size_t iov_offset;
 		int last_offset;
 	};
-	size_t count;
+	/*
+	 * Hack alert: overlay ubuf_iovec with iovec + count, so
+	 * that the members resolve correctly regardless of the type
+	 * of iterator used. This means that you can use:
+	 *
+	 * &iter->ubuf or iter->iov
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
@@ -69,7 +84,13 @@ struct iov_iter {
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

