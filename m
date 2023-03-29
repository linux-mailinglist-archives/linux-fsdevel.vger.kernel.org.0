Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443386CF259
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjC2SlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjC2SlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4F1BD8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:09 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s1so8568434ild.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115268; x=1682707268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaNE2rJZu9RSwFt75gnITqun68WHqA1LfJU9gOnr41w=;
        b=BsTGsPp7rZFm1zzMckI8g51kniEGARAtpYfBMfRdNevOd53kbbZmqwRVUkgPSNVOPS
         XFywQcl1ix5+emGa1egmiRNDzKpXYBs5h5gzBeG+46Ubo5KG6PkugRLAfTx0PK0hcgfc
         4Yho2kgcQBKhhhwt1R8UCnyv7DkQeRmQd9UVVunF26T+DDmdXHcExKmbZAY/muNTCx5D
         87sJ0ex/enOfZuP8N/U0++82b3z8X77dCPjZsCJeXPQ4QHjw+NfxKKk9KsqApQAudBGF
         SnWHqRmuFTfj303c0KKc5AWZkoee4WTWxAIL/UJ4/baX9UQkLMrahe9PFTril+SPWnIo
         lZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115268; x=1682707268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaNE2rJZu9RSwFt75gnITqun68WHqA1LfJU9gOnr41w=;
        b=stcdere82nsVNt3MVqhFGK7RgQf1s733X5ks9dHBpuSztHwe+PHau83mbS7baGOA4y
         IvAfFlvb2kMyZ8GIDg3nxIC1xxz6YUyxQMwbtneRgc7S4J7WT1YqTgcjhaZ21ykRnQMS
         H9x4ZZ6RMLIVfJyeRTpeW00UYP1zw006vJznTelQ9dfeMu1CQ9RBzOAXITdq4PUAxEKh
         1xdJc8aIDB+J0k8m80SI3JCY3yJ01teVjl0vMPteRS2rnL3cShUrdmsKAgYRj3vIXmsH
         FPh6dqAunyvonRF45DVbvMuPdGVZ4GfyvW+xu6RB35GPAdCBS61d5onovgzVuQ/Azgch
         drMw==
X-Gm-Message-State: AAQBX9eSyXsthFakz5HZM2vPn64hT9ciGUiSGiFtdtWlfv4SOm/sAUWC
        Zs+bYWZpG1PkfR6Jss+T36DcbtbclXUZyCMqbS7ocg==
X-Google-Smtp-Source: AKy350YHOzdvk8olRol4+RINlgxmHYIUvNUbcIpK0FIGtOz3Buj1+cT9Z4GWtv3xu7FiDfseFCE2rQ==
X-Received: by 2002:a92:3652:0:b0:319:5431:5d5b with SMTP id d18-20020a923652000000b0031954315d5bmr10986230ilf.1.1680115268681;
        Wed, 29 Mar 2023 11:41:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] ALSA: pcm: check for user backed iterator, not specific iterator type
Date:   Wed, 29 Mar 2023 12:40:53 -0600
Message-Id: <20230329184055.1307648-10-axboe@kernel.dk>
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

In preparation for switching single segment iterators to using ITER_UBUF,
swap the check for whether we are user backed or not.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 sound/core/pcm_native.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8bb97ee6720d..5868661d461b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3531,7 +3531,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!iter_is_iovec(to))
+	if (!to->user_backed)
 		return -EINVAL;
 	if (to->nr_segs > 1024 || to->nr_segs != runtime->channels)
 		return -EINVAL;
@@ -3571,7 +3571,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!iter_is_iovec(from))
+	if (!from->user_backed)
 		return -EINVAL;
 	if (from->nr_segs > 128 || from->nr_segs != runtime->channels ||
 	    !frame_aligned(runtime, iov->iov_len))
-- 
2.39.2

