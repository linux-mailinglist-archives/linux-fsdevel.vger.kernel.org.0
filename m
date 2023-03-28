Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA06CCC71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjC1V6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjC1V6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C39D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x15so12201045pjk.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040703; x=1682632703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqXz3jKUOGYMfoB2fVfbZkg4ok5uwxBojJ+q0N/MO50=;
        b=v0kII7enXzDQtsNe2aHoy7IY3IFfasxoRdJul4DcyZBSECh7runwrstcL7201Asqm+
         LHeSN0iSXtlTi6q3uu3/wfU/9nyhrIE/Xc+We/xr2L3w1vGe4org/kxuB0JbpmkldMJK
         WPQRhFKAqlumaNWfG+nItns5jD+Xdd7UqvuNQUWLKf4iCC/UzCEdqvSD2Kjqqz5XmbFp
         TLV8HQ+32BpukpfrUZYAFK2uNB7vyc6MG3do7p9PIFA5L+PmfW7lnl50UyupQFnelorq
         HrHj1CeLVpmntq2Y2R1B5mDeJBMMPcvt7DQ1HAtTQ/dUx/7Hh+wS2X5Ub2aWo8PSdgmH
         HTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040703; x=1682632703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqXz3jKUOGYMfoB2fVfbZkg4ok5uwxBojJ+q0N/MO50=;
        b=qJ0mXv9KouqZyDYFR72aryVU0LApWMZtNXGVcq+YQ4587UxNnEfcb1UUh0U0C9trwC
         xSOg+KB0VRQU7Et71jP2hYScec+vHpV69WAjFbVwlGw2gUfn2jZoblJzxZZIoTDJPpzf
         WuvVbQOU7lLqzEKxnyUONL8wj5GoWFzOxZGUwc4TERTJZl0ZIaO1zG1Jc3SaYeDEygkC
         LxHpw9aG7e0UdEs9FLkEC1VLnKk2IoI9f1wfD7mNpSJC3qc1A+cDgkoGH6P9lWZSZ25w
         nIWZBB+jHUqsad31NjMNRIzyk60Tpz9XnRMFuo4bUr6pzyG7Sj1AVzs+vZejFybRlQHN
         vMXQ==
X-Gm-Message-State: AAQBX9d30Nabfegrioac0GtlOyGOTSo5Q2qxclUnNeuAceYm5f4uUkrV
        nBcj9Tg3WApsJzCQAWbbZdDwg0ZtAEmAWsLPJUJTTw==
X-Google-Smtp-Source: AKy350Ylh4oAVC+KUc9SpRSILAeqF0geA1ZnRnE5IsUVUwKPZC6oReIX3r8V3w5x64cbi230ZciPjg==
X-Received: by 2002:a17:902:9309:b0:1a1:956d:2281 with SMTP id bc9-20020a170902930900b001a1956d2281mr14193655plb.3.1680040703138;
        Tue, 28 Mar 2023 14:58:23 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] ALSA: pcm: check for user backed iterator, not specific iterator type
Date:   Tue, 28 Mar 2023 15:58:09 -0600
Message-Id: <20230328215811.903557-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328215811.903557-1-axboe@kernel.dk>
References: <20230328215811.903557-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
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
index 331380c2438b..8bfc40b358da 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3530,7 +3530,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!iter_is_iovec(to))
+	if (!to->user_backed)
 		return -EINVAL;
 	if (to->nr_segs > 1024 || to->nr_segs != runtime->channels)
 		return -EINVAL;
@@ -3567,7 +3567,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!iter_is_iovec(from))
+	if (!from->user_backed)
 		return -EINVAL;
 	if (from->nr_segs > 128 || from->nr_segs != runtime->channels ||
 	    !frame_aligned(runtime, from->iov->iov_len))
-- 
2.39.2

