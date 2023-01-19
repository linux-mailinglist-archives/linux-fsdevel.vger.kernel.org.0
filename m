Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E067361F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 11:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASKzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 05:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjASKzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:55:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF54AA76;
        Thu, 19 Jan 2023 02:54:56 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o20so2658933lfk.5;
        Thu, 19 Jan 2023 02:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6i5x37mYZe3aOy5A75Nxb44pi0Ov9eivp98jLF4Pa0=;
        b=ZKCuIXK3VdjwQ0/R04Tz2nTKeqnbhXdCn5a7oUUQGj70vaAlHMoZrYxBuv/AehWi0R
         Ws4aqhRr3FJhHiOkhSjp6uOtUWmKieUo5nc2YN66b+khDvWTIce6+bG+9JlS9H80H2Zk
         5ElzJuwMWU3xCpYvi+DwyrgPR3PZG2scXssB3MlhsmIRhY5njkaTPmRFzmjlMTdc3Pk3
         /XZF+mAuD5qQF4mShAXs3UxeQjYKeV8xH8sbo2MvP0L68ymQyWbsT/ORJhrlANzz6ngD
         41rSlMxFy7gGF//qOMRMxmCTwHmH5zbYPqXwU/5igRewVmwiqYe8ynoJ97ah6iT5YYRX
         ZDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6i5x37mYZe3aOy5A75Nxb44pi0Ov9eivp98jLF4Pa0=;
        b=lzynhWss1iuMpZ4ic5HDl7BrhBrcyqOJjy8netTb0eDIMf9bPcrf+jp5Tzs+zfeVJx
         hznTvdG0qewqMjc6DjPdB7Qh7WjcalyH4oeRe258M+ZrvcTGzuOLTweVwNJ7/JBXoplq
         HVRgO2E0oiFJ46m1wDRso1tbKWmQoVOBsm6wib9pY/4w6AfBYRZJN6tQIIng25TvfmBk
         TjWVM+N3nfOa2rln0q/pgsjRwVX2wChznxfn+dDNTlyIu7BVm6vD7pt8G10jCMLp1DBO
         pzhuUQwYiCQLQjNT3oM5uxIaa7TICfNGPmwbAvpM0eBBzuKkdAucgz3f9J3GeMjSGDQm
         hoqQ==
X-Gm-Message-State: AFqh2kpT52cdcu1qwFxX2lw/xObeR9DDnYdY7mX/PGgHQ6ZgdQDcc5iO
        9xxpH7vj6zn8wu52eaL82KfPgdnktp7ji17Y
X-Google-Smtp-Source: AMrXdXvOYCbFTjxo2BzJzOvsY4f95Y56RY61m1R8wjzEvyMNgLtSPa3hA0KSKdQR02RXjUH59Q1WnQ==
X-Received: by 2002:ac2:435a:0:b0:4d5:7fad:a042 with SMTP id o26-20020ac2435a000000b004d57fada042mr2311847lfl.41.1674125694887;
        Thu, 19 Jan 2023 02:54:54 -0800 (PST)
Received: from mkor.rasu.local (95-37-60-162.dynamic.mts-nn.ru. [95.37.60.162])
        by smtp.gmail.com with ESMTPSA id n22-20020a0565120ad600b004aac23e0dd6sm5878777lfu.29.2023.01.19.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:54:54 -0800 (PST)
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] writeback: fix call of incorrect macro
Date:   Thu, 19 Jan 2023 13:44:43 +0300
Message-Id: <20230119104443.3002-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 the variable 'history' is of type u16, it may be an error 
 that the hweight32 macro was used for it 
 I guess macro hweight16 should be used

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2a81490811d0 ("writeback: implement foreign cgroup inode detection")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6fba5a52127b..fc16123b2405 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -829,7 +829,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		 * is okay.  The main goal is avoiding keeping an inode on
 		 * the wrong wb for an extended period of time.
 		 */
-		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
+		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
 			inode_switch_wbs(inode, max_id);
 	}
 
-- 
2.37.2

