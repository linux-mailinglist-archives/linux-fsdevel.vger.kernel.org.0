Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B7B5357F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 04:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiE0Czr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 22:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiE0Czm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 22:55:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752DEEAD14
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 19:55:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 190so3451404qkj.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 19:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AUlysgyDAL5M9imkvDAX/EZEtCGp/B57KfY/usHuzGA=;
        b=kPXdVYjRvhZodLa5+GXUsmWnrTe2KPuFWBIwsWiuytjw0zrwoz8zcgtGReAuGdac21
         3dSjZnos5DqRCsWGUSr1JYj+fO7qNjn6BvDt80K3Hk9N3XRVfonaPgnTLccTIuwVkPYh
         nsmy1calBX2Z4O8gZdkyixBbPJvBGJX9fugNxhXUD3c3oqBDqOhCFwxW6cco2QcouzMO
         /hem+98Rngle242xeioy7dZxONTTmbBFQLapkwmctSot2G9eitQE/uEbejXfMDq6xZVF
         V8ye6L3lXx+kB/i1s+fU1SPQKxnf2SZd28SspA8duIsv2N7a5qVeErjy+2vi7K5eGzFc
         jnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUlysgyDAL5M9imkvDAX/EZEtCGp/B57KfY/usHuzGA=;
        b=hffoBaR1akII1YLQ3Lkp7aTxHKtYcDsqmKPjw3i/SwoMIJwVxpKetNEsW4d6ivWCE3
         TdbLwc4DLCVgNSfJkl4ZxVD2M7dXSUuOss2G/3TuVck3KB20Wndw5kz9u09QhC+dpm1c
         9zavS+RubEAwYaSYHrCiQaPm62h5v+XgZGMyAxXdMkSls0tchkM7sqqoe8XyZOw1BfOd
         pOsF3mzDb8e9JOCTWoUKTzznmvHpxsJ1LyI++H61ynJT7z9wdMh+2aYw3r7pA0IZIPEd
         a6BmrXo9kYqhMd7/d0bW6acH/2rfSd0zsWXn/ou8/a8lnsNfh+v1R8xQfmtjSnfO/qgo
         zBOA==
X-Gm-Message-State: AOAM533hzsW0DhNOOWZcAFTcru+khj93MUGobBOOURJUqPOGn+uCBATD
        FqQQKr5NB5WWZkv93fC/eFTN9w==
X-Google-Smtp-Source: ABdhPJzZdfwzG5RdmK3Rp9m3BPQqsUYok+6kuCjDjU7io1+wHbA0R9cctbgOjFFCkbcyfgI10mTbYQ==
X-Received: by 2002:a05:620a:2903:b0:6a0:4d8f:8b88 with SMTP id m3-20020a05620a290300b006a04d8f8b88mr26710901qkp.328.1653620140596;
        Thu, 26 May 2022 19:55:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id r129-20020ae9dd87000000b0069fc13ce224sm2129672qkf.85.2022.05.26.19.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:55:40 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, rburanyi@google.com, gthelen@google.com,
        viro@zeniv.linux.org.uk, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
Date:   Fri, 27 May 2022 02:55:35 +0000
Message-Id: <20220527025535.3953665-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In some case initrd can be large. For example, it could be a netboot
image loaded by u-root, that is kexec'ing into it.

The maximum size of initrd is arbitrary set to 2G. Also, the limit is
not very obvious because it is hidden behind a generic INT_MAX macro.

Theoretically, we could make it LONG_MAX, but it is safer to keep it
sane, and just increase it to 4G.

Increase the size to 4G, and make it obvious by having a new macro
that specifies the maximum file size supported by kexec_file_load()
syscall: KEXEC_FILE_SIZE_MAX.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..f00cf70d82b9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -31,6 +31,9 @@
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
+/* Maximum size in bytes for kernel/initrd files. */
+#define KEXEC_FILE_SIZE_MAX	min_t(s64, 4LL << 30, SSIZE_MAX)
+
 /*
  * Currently this is the only default function that is exported as some
  * architectures need it to do additional handlings.
@@ -223,11 +226,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
 			     unsigned long cmdline_len, unsigned flags)
 {
-	int ret;
+	ssize_t ret;
 	void *ldata;
 
 	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
-				       INT_MAX, NULL, READING_KEXEC_IMAGE);
+				       KEXEC_FILE_SIZE_MAX, NULL,
+				       READING_KEXEC_IMAGE);
 	if (ret < 0)
 		return ret;
 	image->kernel_buf_len = ret;
@@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
-					       INT_MAX, NULL,
+					       KEXEC_FILE_SIZE_MAX, NULL,
 					       READING_KEXEC_INITRAMFS);
 		if (ret < 0)
 			goto out;
-- 
2.36.1.124.g0e6072fb45-goog

