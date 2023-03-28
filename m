Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4897B6CC95E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjC1Rg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjC1RgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF46DBD6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d14so5680324ion.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024980; x=1682616980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITran+xi/3uKyeWNClmpzkXO9DoPYyKa0CIb3OZWNrM=;
        b=vsw4esRMjg+z7gi9PKRbC4LXLWIgHZMp2lgvrsAnQoJPHVZwAs4NbKKBPPDxfQyXjX
         8JhP90Dtpxb3jpFob/3AM3QlVclwYf9Ef8b9yqV5klxoIcrWCLPm8oj5NmoIrgtiPGAe
         3t1lAWLJ++7TpCNXI3lD6qWwLrv5WzyLytNGT0SJ6gBRECqLuwtJk05aiV5PRhw134O+
         IXOF7W6IJ0Rlz2V9FRkPaP7Jkd8Kb+b6/pL9A5SPqP0pfYXPvGD4FuAmABiI413usGp0
         1naoUsUxpk2Ke0JXIU17KBFX74GVHir2cLklcQ2YPITf9kTsHSvCh5rV6Wtl+uSaOGmy
         AvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024980; x=1682616980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITran+xi/3uKyeWNClmpzkXO9DoPYyKa0CIb3OZWNrM=;
        b=oIBFWhZ2PVIwPaoloc9yPow2bM5kF6xbjS1t3sK2IovT5xbqxzni2zZMjyxhxRYzp7
         mwMzo4XzwzE3om5wl4YDFCBBvfETy5HMw1X6cX198DBsMY7+j2JbX07y6RohjkiZGPow
         mWjtSr4Si/wYFvS8Bx8s/7llIraGYwZLaYj3V2tLbIy/1KU1v3bWPon+GT+T90RiBV95
         wfVRdRopIa3G3X9PRW1qgek47X+Yf0POk/BloYAd6tOayd9hVHWpI6qPxwQvKpVsqoGB
         DrySPHw/9zM3phZHCaLaZs+nbABI1rRg93jME9w9JVG5d+eCQm/kOZsC/gGXhXIw4U28
         A2Bg==
X-Gm-Message-State: AO0yUKWks52us/dPqs0TFf4Bh0tvAOe37gVTR5zZ8E+l95LtJdaMe384
        1U6IAsFtUrN6Moln+pUQ5AFP6hD7nK+LI1N8UgddAQ==
X-Google-Smtp-Source: AK7set+91vfEdHeIwMKTyqR/zJ8vM/oNyI5UXLMrDxpABWWmb8kC2UAmV/sad0GxlhA7XLBhkgGgTA==
X-Received: by 2002:a05:6602:2dcf:b0:758:6517:c621 with SMTP id l15-20020a0566022dcf00b007586517c621mr12819350iow.2.1680024980416;
        Tue, 28 Mar 2023 10:36:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] snd: make snd_map_bufs() deal with ITER_UBUF
Date:   Tue, 28 Mar 2023 11:36:09 -0600
Message-Id: <20230328173613.555192-5-axboe@kernel.dk>
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

This probably doesn't make any sense, as it's reliant on passing in
different things in multiple segments. Most likely we can just make
this go away as it's already checking for ITER_IOVEC upon entry, and
it looks like nr_segments == 2 is the smallest legal value. IOW, any
attempt to readv/writev with 1 segment would fail with -EINVAL already.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 sound/core/pcm_native.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 925d96343148..05913d68923a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3516,23 +3516,28 @@ static void __user **snd_map_bufs(struct snd_pcm_runtime *runtime,
 				  struct iov_iter *iter,
 				  snd_pcm_uframes_t *frames, int max_segs)
 {
+	int nr_segs = iovec_nr_user_vecs(iter);
 	void __user **bufs;
+	struct iovec iov;
 	unsigned long i;
 
 	if (!iter->user_backed)
 		return ERR_PTR(-EFAULT);
-	if (!iter->nr_segs)
+	if (!nr_segs)
 		return ERR_PTR(-EINVAL);
-	if (iter->nr_segs > max_segs || iter->nr_segs != runtime->channels)
+	if (nr_segs > max_segs || nr_segs != runtime->channels)
 		return ERR_PTR(-EINVAL);
-	if (!frame_aligned(runtime, iter->iov->iov_len))
+	iov = iov_iter_iovec(iter);
+	if (!frame_aligned(runtime, iov.iov_len))
 		return ERR_PTR(-EINVAL);
-	bufs = kmalloc_array(iter->nr_segs, sizeof(void *), GFP_KERNEL);
+	bufs = kmalloc_array(nr_segs, sizeof(void *), GFP_KERNEL);
 	if (bufs == NULL)
 		return ERR_PTR(-ENOMEM);
-	for (i = 0; i < iter->nr_segs; ++i)
+	bufs[0] = iov.iov_base;
+	/* we know it's an ITER_IOVEC is nr_segs > 1 */
+	for (i = 1; i < nr_segs; ++i)
 		bufs[i] = iter->iov[i].iov_base;
-	*frames = bytes_to_samples(runtime, iter->iov->iov_len);
+	*frames = bytes_to_samples(runtime, iov.iov_len);
 	return bufs;
 }
 
-- 
2.39.2

