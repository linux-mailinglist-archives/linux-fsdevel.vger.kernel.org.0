Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875A85594F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiFXIF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiFXIFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465C6E781;
        Fri, 24 Jun 2022 01:05:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c13so2291785eds.10;
        Fri, 24 Jun 2022 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/E6hWEFQyi25CxFeEuPVoEVkNjsUA/fW4bkRRrhTG8=;
        b=e8Okw9V9KyZY0LQ9UKvtkO1+tj9txF7SZgjxfu0nIPVJ7UHFSFPajh1LcrrR+mc/Ax
         7Xcml0b3DTzx3T2bMsv8lp7T6q7E8SECtadIf2BbI5ZWp1CKCCjXMJ+X+N3gB+Fbk+hI
         b31Ng6R/qrQ8N6LOuGNRH4RuKGuBjnKOVPxxK7EXBtqVHECTyUdENgmbiNMStYeqtDEf
         i8j/Pv/qCpjDot+5YbNEf4ExwNPa/ehQnPHUm9ruLn2IZbJZpd2tKFDQwHw3MDtpAITE
         BVAJdg6xrEucAqwIZovpm02Nb/tWQUOGD/LUv75bzOhZfpRKGHx3/vDdg1//bFowy+2C
         xUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/E6hWEFQyi25CxFeEuPVoEVkNjsUA/fW4bkRRrhTG8=;
        b=xcSJEDOXPAGHi7pQi7dlxuqnjdNCFyltRPjhoTWVhhew7dF4BlG9thdo3/UCN43sRO
         v9i6FEjfncVt0qpH+bs79+Hsv9sekj0LuU9qRZAzwERorjAoa1gUYX4b0mHOofvHyZ6G
         3trv7VjXR8Z3x/qhTSc3O2R56G8Khk0AOaNh+sGtxyLqu69h/3wVYu8lAAYHa6spCb8i
         BirPWGjsPXFGC8BpvDvgbQ/1iLsdhRKE4l04vO7Apq56uoknSnV6HZKQjvviZsWqPIjO
         TZc2fQU0hhCjDnRYOtR2EoHX/28RzMIjjkbB08H7Pl3WYxiY3sxc8lTMzjyeAojZggYR
         49Qw==
X-Gm-Message-State: AJIora+94LClQCdjGzaq1XT6T6HFmjssCSZLkAiGz7m5JfyjxFtDzOOS
        QzAxLC3FNmg/vi6MHj0QCquE8fHrqog=
X-Google-Smtp-Source: AGRyM1sPm1PtPb+HeXcaBFnsmjeMMONuCGOa4UKNnvwqlpKNsvibmM7CXbEqPCXHhwwP42+MiDXxcw==
X-Received: by 2002:a05:6402:5c9:b0:420:aac6:257b with SMTP id n9-20020a05640205c900b00420aac6257bmr15655024edx.128.1656057900060;
        Fri, 24 Jun 2022 01:05:00 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:59 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org
Cc:     mhocko@suse.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 10/14] drm/i915: use drm_file_rss
Date:   Fri, 24 Jun 2022 10:04:40 +0200
Message-Id: <20220624080444.7619-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624080444.7619-1-christian.koenig@amd.com>
References: <20220624080444.7619-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows the OOM killer to make a better decision which process to reap.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 90b0ce5051af..fc269055a07c 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1741,6 +1741,7 @@ static const struct file_operations i915_driver_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = i915_drm_client_fdinfo,
 #endif
+	.file_rss = drm_file_rss,
 };
 
 static int
-- 
2.25.1

