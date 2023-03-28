Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B866CC95D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC1Rg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC1RgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86989D53A
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:20 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y85so5665677iof.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CyL6+qOmsnDhD9RFiMpSlzgf9oOvRe6j0pJ/jAF//Y=;
        b=gL4HHW8gGgyPquwp3cG2V70dREieqNxl+qvxP7oaOtLm123KpDpqgWnHeV5YBezQwe
         m/MuU3ZEHpLXCjcYHhYoVkQ8w9vEKw0rfto6GkSxWFiYNJL/z99uTNXH64/wEIkzqVbM
         zl2/sGquRRY2xGov0cjbl+dlPjy/JrbTdIfoeRn5dJS6qKeprNguHpQeu5ICIpqGRGaZ
         PSWanoa0UZgTKlSQKrCHjYRe0/ArTt0WqaHd1OrBvGn5bNDp4fuqfKyYycMx7Mn44HIC
         UiaU3GyW2u/u1hEuq2vDa+xJRPU8eHp5bukyZ6FfFrBguuozA0b/Rc35OgYddT4mo+yc
         S5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CyL6+qOmsnDhD9RFiMpSlzgf9oOvRe6j0pJ/jAF//Y=;
        b=w7CA2+obNF4j1zm93QOoN0fq6GAgnilbzCSDsDDl6G9TRnuUf5RaeuEgKHbyNomUVy
         2YnBUxrHBQtc+lhEhTE1OXB6XwxoHf2XbDzGUB1tUhYflXO/+Ik5BZuY4MLIHaoqSmCP
         vHSuuMm59A75acV3yvRLlsMAKYU3gm+NJol4M9pn6rn7d5WHRr3a5NpgiQ8BviZHJf3R
         DJ9yimGo5gAxd0hWznHytFA2BUlaIBM1nElfC/wLunmXEI9QxQWDsW6U4IW8Vk758/sF
         fGzPzMprmDBmKkKlX2RW4n9sh/XHqeID+6+rLxqI1z84+v4OGgS7fE0wNBWso1C0XJxa
         t1pg==
X-Gm-Message-State: AO0yUKWSWMuahSNMoGNxSQIFunBhulz6Us4CXElg2qxr+6bMj7xtv3Qz
        r7STHAN6t8mhIZzVFGpUgMGHI0BioWbzyjAtioG/Xw==
X-Google-Smtp-Source: AK7set8n1r+fBTFphU6wg4/DSjgq/aWJ7eqxR4OQ+pYFKzWiQlRrN1NXmiDXVxMy5VVnug3jwRCnKw==
X-Received: by 2002:a05:6602:1301:b0:758:6ae8:8e92 with SMTP id h1-20020a056602130100b007586ae88e92mr9360665iov.1.1680024979542;
        Tue, 28 Mar 2023 10:36:19 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] snd: move mapping an iov_iter to user bufs into a helper
Date:   Tue, 28 Mar 2023 11:36:08 -0600
Message-Id: <20230328173613.555192-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328173613.555192-1-axboe@kernel.dk>
References: <20230328173613.555192-1-axboe@kernel.dk>
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

snd_pcm_{readv,writev} both do the same mapping of a struct iov_iter
into an array of buffers. Move this into a helper.

No functional changes intended in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 sound/core/pcm_native.c | 55 ++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 331380c2438b..925d96343148 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3512,13 +3512,36 @@ static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
 	return result;
 }
 
+static void __user **snd_map_bufs(struct snd_pcm_runtime *runtime,
+				  struct iov_iter *iter,
+				  snd_pcm_uframes_t *frames, int max_segs)
+{
+	void __user **bufs;
+	unsigned long i;
+
+	if (!iter->user_backed)
+		return ERR_PTR(-EFAULT);
+	if (!iter->nr_segs)
+		return ERR_PTR(-EINVAL);
+	if (iter->nr_segs > max_segs || iter->nr_segs != runtime->channels)
+		return ERR_PTR(-EINVAL);
+	if (!frame_aligned(runtime, iter->iov->iov_len))
+		return ERR_PTR(-EINVAL);
+	bufs = kmalloc_array(iter->nr_segs, sizeof(void *), GFP_KERNEL);
+	if (bufs == NULL)
+		return ERR_PTR(-ENOMEM);
+	for (i = 0; i < iter->nr_segs; ++i)
+		bufs[i] = iter->iov[i].iov_base;
+	*frames = bytes_to_samples(runtime, iter->iov->iov_len);
+	return bufs;
+}
+
 static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
 	snd_pcm_sframes_t result;
-	unsigned long i;
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
 
@@ -3530,18 +3553,9 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!iter_is_iovec(to))
-		return -EINVAL;
-	if (to->nr_segs > 1024 || to->nr_segs != runtime->channels)
-		return -EINVAL;
-	if (!frame_aligned(runtime, to->iov->iov_len))
-		return -EINVAL;
-	frames = bytes_to_samples(runtime, to->iov->iov_len);
-	bufs = kmalloc_array(to->nr_segs, sizeof(void *), GFP_KERNEL);
-	if (bufs == NULL)
-		return -ENOMEM;
-	for (i = 0; i < to->nr_segs; ++i)
-		bufs[i] = to->iov[i].iov_base;
+	bufs = snd_map_bufs(runtime, to, &frames, 1024);
+	if (IS_ERR(bufs))
+		return PTR_ERR(bufs);
 	result = snd_pcm_lib_readv(substream, bufs, frames);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
@@ -3555,7 +3569,6 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
 	snd_pcm_sframes_t result;
-	unsigned long i;
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
 
@@ -3567,17 +3580,9 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!iter_is_iovec(from))
-		return -EINVAL;
-	if (from->nr_segs > 128 || from->nr_segs != runtime->channels ||
-	    !frame_aligned(runtime, from->iov->iov_len))
-		return -EINVAL;
-	frames = bytes_to_samples(runtime, from->iov->iov_len);
-	bufs = kmalloc_array(from->nr_segs, sizeof(void *), GFP_KERNEL);
-	if (bufs == NULL)
-		return -ENOMEM;
-	for (i = 0; i < from->nr_segs; ++i)
-		bufs[i] = from->iov[i].iov_base;
+	bufs = snd_map_bufs(runtime, from, &frames, 128);
+	if (IS_ERR(bufs))
+		return PTR_ERR(bufs);
 	result = snd_pcm_lib_writev(substream, bufs, frames);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
-- 
2.39.2

