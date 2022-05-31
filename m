Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC09538E6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbiEaKBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245450AbiEaKA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCC87A2D;
        Tue, 31 May 2022 03:00:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f9so25641882ejc.0;
        Tue, 31 May 2022 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fF+SmUCgmGBHMWIupVoHZia80K1ptfL7PQV1qLHe5E=;
        b=pGad9b/BwcaioFOjylZCfm5P6oSeZF3Qa2xsSM2t1mLTeOulJ6Fk7o/kQXSFGfU7lJ
         fp+6f/aeJYjHr4ThwoNMeFWvRYk8Xi3t4V6MuHjD4pXyJ85cRklWkQW6ame4vh7fx+mt
         eaMJgziirhMF0TIu3swNi0t8QcgG/D+TrXhYN/6zpOjgadE1pDN936EPEKG/3T0VKKBY
         eGDD/HmuCJdKW697mwOSCL+AIzK1PpEsB7W8mV3UO/gZVPIZSxHIDtHAeMFs64m0dwsi
         kXbIgj/gmD2mW2jfFnmLmUvUEs8rVjrgUuJi5qMnGsABI9in6Ar4JrgyhpFWFSv1YPAZ
         psrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fF+SmUCgmGBHMWIupVoHZia80K1ptfL7PQV1qLHe5E=;
        b=nTwOKydqhN5bacDl8hSTSRxO1mPqYUXLZErC6ER51tBidOrNfuYj0CuLzySkYKkB3z
         NngECq4ySp5yIsE4TDxsRKv56V97PUusccFdQkDfVOSPEQFeknvcEXdfefogiqormguX
         PlQC90/mbZaIcBDWTA95bBA5diMz79Dll7VaLUXE9kXILsiSKZ9zu/pttLypxfVmkAee
         HYVoJI0T6Hb27oD1Si4iKIpuLb9QbRMVKbtfDD1YplzrVDSFmy/nf+YaDIBrKZcII/1u
         2zksRBSFqJWjRXIYQxZ1XgOPHfrTkqTuOXcEv0htf5DKGJw7n1T1X2ayUVaKKD4CJPS3
         XqcQ==
X-Gm-Message-State: AOAM532cop1F6/v4GdW1dgs3Q7QKNp7SJV0/ymS6rXW6/p5Peq8RztW2
        56+sL7d6/8zDSXZBh3MznR/eDrgR1CxM2g==
X-Google-Smtp-Source: ABdhPJzxN/Ir8FJD89b6qow8Ub7cZ5+SzEkXV/zrFCVZFTH37oV1HNV4o+OUoqVfB6+SbpZEADHJkg==
X-Received: by 2002:a17:907:9482:b0:6f5:171d:f7f5 with SMTP id dm2-20020a170907948200b006f5171df7f5mr53043726ejc.68.1653991221803;
        Tue, 31 May 2022 03:00:21 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:21 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        daniel@ffwll.ch, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, hughd@google.com,
        andrey.grodzovsky@amd.com
Subject: [PATCH 08/13] drm/radeon: use drm_oom_badness
Date:   Tue, 31 May 2022 12:00:02 +0200
Message-Id: <20220531100007.174649-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
References: <20220531100007.174649-1-christian.koenig@amd.com>
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
 drivers/gpu/drm/radeon/radeon_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 956c72b5aa33..7e7308c096d8 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -550,6 +550,7 @@ static const struct file_operations radeon_driver_kms_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = radeon_kms_compat_ioctl,
 #endif
+	.oom_badness = drm_oom_badness,
 };
 
 static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
-- 
2.25.1

