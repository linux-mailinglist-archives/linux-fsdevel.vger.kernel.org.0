Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107836D0BB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjC3Qra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjC3QrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:12 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D7CDD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q6so8551555iot.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194830; x=1682786830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaNE2rJZu9RSwFt75gnITqun68WHqA1LfJU9gOnr41w=;
        b=srU9podCLoschbuo8Y8Us2uW+8MgvM/PAFkNpCR2ifflU2MWtZvJ+ntRcFOeu+Qxqn
         D+Jr0PdWjthLhOruH4VIA8s0L9/tq0naIceJrRkiJ0KuT5h6eXNZXRF5DDFhFnzv8QgW
         P9vtkmt7ZSLje0YZPVe2TgOI0nH9bHbUkBMkJJZM9sBD734dkg7fQqI2DMqUyqjZNF65
         fEHRddXmbomcCs7oMOmrTxIQ7AyNl4xvJ/e4vxq2lrfKYRodQWwNHNY1uG2kDQ9oVvU4
         /Ecf1ueQbL4ux/03yVp5cib8bIXSNHxRAtdDttYZJpUNeB9PwgPjzATLpWNymCakG4+r
         yjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194830; x=1682786830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaNE2rJZu9RSwFt75gnITqun68WHqA1LfJU9gOnr41w=;
        b=wGAHYNZfcYVnNjBbSSTojlcDKUDzUugvZxW0eKizu+PFDiXLIXGJwfza2YZlYTQ0Sq
         Z29icGM+6VgPAtvVDFixujGwFXPoGo1lDUoYfEE8bEDT4T0L1xN/elHt0r85SMXnskfd
         1jqDLFr0MMCBm+F+2Fv7gsKM6Gj58rXZLqIXC9RM9q1GLNV/Amx8/jo6hQAMSmeRs0fD
         WIdR3nig2Ljw3Gw+38RCCm3yK3qkv5jII6j4Qt3Z3c+Y3H913/dtZAI6FX5LSL8O081e
         zHZI3b/24axVbTu2t0WkPzSNUf4W3pT2ZTv8YVC9iZ49jISHzVgjJBrlafNoTLj2HUm+
         a3Jw==
X-Gm-Message-State: AAQBX9c9v5nJBeBhZemuYlxayCQsqIbDbCpBP+kxg/95age8P5PzaXo0
        nsBTOIDLrvWLi4B1s7VvIUMc1Pa6H9KydqDEFe1L3Q==
X-Google-Smtp-Source: AKy350YcCFxpC10XeWynzxalLJStttMtbwyfhd/bSB864vkKsJwA9f156WNZEi6n8sIFFXbChM11Lg==
X-Received: by 2002:a05:6602:14c6:b0:758:8b42:ce5a with SMTP id b6-20020a05660214c600b007588b42ce5amr1821499iow.1.1680194830694;
        Thu, 30 Mar 2023 09:47:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] ALSA: pcm: check for user backed iterator, not specific iterator type
Date:   Thu, 30 Mar 2023 10:46:56 -0600
Message-Id: <20230330164702.1647898-6-axboe@kernel.dk>
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

