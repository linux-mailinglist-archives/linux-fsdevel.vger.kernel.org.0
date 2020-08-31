Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCCD258057
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 20:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHaSIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgHaSIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:08:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B90C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:08:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id m1so1977503ilj.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J9kGADiWqBAf6LAoDwc5/F/Og5YLlJpYbgAjEOG8B8Y=;
        b=iol8uoCdy/B0MF3nCdY3BgRUnC3oG2i+b9zc0OPTqn3tX6RXpVbPDQdLmhSxMCQZYU
         rruvA5+UUWIwlMUm+/o6/GK8jGFSbcROx0B+IwVzR0f1Q6bz6R0utEKqcbRlOZbA2iGu
         jNpvS3HpS7w7ZRsG1XYWGUyRfd8jfE4si/0HkG1ApQTSTSpCTZBvQp/DESVlUcneN+5L
         4Waax7OYniJHk0ZTXcR39tZZkG9Q2SgDFONy5l/hAE/NEB8DRGDP0GXCmVlt0fSsVv0U
         Mb88aKA4WNEyKc6NY5mgx+kkZkuLmnh346l1AavkzggBt7EWBu+IJVAXUbeV2xP/f+cB
         B44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J9kGADiWqBAf6LAoDwc5/F/Og5YLlJpYbgAjEOG8B8Y=;
        b=JbeHeKYHVnN7M3F291czbt83Br0PanxtzMhxh5XyngGm9ARptfyqOyI0+JlmwL//8J
         AZV72cqskUfJ2yET3hWMZHdpFWAfcUJxnPPGR1ts++EXv3lZzmizjlEccJf2QPIU87N4
         HHoiW/VuLJp3NAofEH8P+sRlNmGLb1u/FF5zlduCLceGe4XvDHKiuEP6cooSErXvvQkj
         IcS2bsKMfIGSqIu9iR2oct+Fwhde4oaJMdiZZpaCqfVyUmxDOxgXfbrv6ixEdCMkAMBh
         bB3m17etJDMqEG9jduygy94CVm5XEJLnjpuu7Vcue9291Ei+3ogPN3j6FRqYg9DTS5Bx
         QvHQ==
X-Gm-Message-State: AOAM533NYmCsQsSdK6NAmfhujcpv4XXBk6UvvHc/UaU1aDZphQj6BDVu
        L8oGe7dB4eiI3i/ECK2Ixf7K9g==
X-Google-Smtp-Source: ABdhPJyzXw7Ng/qSWMEJMkMJg5hC+14S4EqLGoKAFtOsLR0CPwYlQ/YqT3BVfJHjOPQbZQICCqCXbA==
X-Received: by 2002:a92:194b:: with SMTP id e11mr2451830ilm.133.1598897296539;
        Mon, 31 Aug 2020 11:08:16 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r3sm4354710iov.22.2020.08.31.11.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:08:16 -0700 (PDT)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs: align IOCB_* flags with RWF_* flags
Message-ID: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
Date:   Mon, 31 Aug 2020 12:08:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have a set of flags that are shared between the two and inherired
in kiocb_set_rw_flags(), but we check and set these individually.
Reorder the IOCB flags so that the bottom part of the space is synced
with the RWF flag space, and then we can do them all in one mask and
set operation.

The only exception is RWF_SYNC, which needs to mark IOCB_SYNC and
IOCB_DSYNC. Do that one separately.

This shaves 15 bytes of text from kiocb_set_rw_flags() for me.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..c82360600ae4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -310,17 +310,20 @@ enum rw_hint {
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
 };
 
-#define IOCB_EVENTFD		(1 << 0)
-#define IOCB_APPEND		(1 << 1)
-#define IOCB_DIRECT		(1 << 2)
-#define IOCB_HIPRI		(1 << 3)
-#define IOCB_DSYNC		(1 << 4)
-#define IOCB_SYNC		(1 << 5)
-#define IOCB_WRITE		(1 << 6)
-#define IOCB_NOWAIT		(1 << 7)
+/* Match RWF_* bits to IOCB bits */
+#define IOCB_HIPRI		(__force int) RWF_HIPRI
+#define IOCB_DSYNC		(__force int) RWF_DSYNC
+#define IOCB_SYNC		(__force int) RWF_SYNC
+#define IOCB_NOWAIT		(__force int) RWF_NOWAIT
+#define IOCB_APPEND		(__force int) RWF_APPEND
+
+/* non-RWF related bits - start at 16 */
+#define IOCB_EVENTFD		(1 << 16)
+#define IOCB_DIRECT		(1 << 17)
+#define IOCB_WRITE		(1 << 18)
 /* iocb->ki_waitq is valid */
-#define IOCB_WAITQ		(1 << 8)
-#define IOCB_NOIO		(1 << 9)
+#define IOCB_WAITQ		(1 << 19)
+#define IOCB_NOIO		(1 << 20)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -3317,6 +3320,9 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 {
 	int kiocb_flags = 0;
 
+	/* make sure there's no overlap between RWF and private IOCB flags */
+	BUILD_BUG_ON((__force int) RWF_SUPPORTED & IOCB_EVENTFD);
+
 	if (!flags)
 		return 0;
 	if (unlikely(flags & ~RWF_SUPPORTED))
@@ -3325,16 +3331,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
-		kiocb_flags |= IOCB_NOWAIT | IOCB_NOIO;
+		kiocb_flags |= IOCB_NOIO;
 	}
-	if (flags & RWF_HIPRI)
-		kiocb_flags |= IOCB_HIPRI;
-	if (flags & RWF_DSYNC)
-		kiocb_flags |= IOCB_DSYNC;
+	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
-		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
-	if (flags & RWF_APPEND)
-		kiocb_flags |= IOCB_APPEND;
+		kiocb_flags |= IOCB_DSYNC;
 
 	ki->ki_flags |= kiocb_flags;
 	return 0;

-- 
Jens Axboe

