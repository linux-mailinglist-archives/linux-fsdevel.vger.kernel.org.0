Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4842E538E6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245619AbiEaKCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiEaKA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632C0880C7;
        Tue, 31 May 2022 03:00:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er5so16782195edb.12;
        Tue, 31 May 2022 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JruBtp3H6AJykO9OR/eL1GiHC7q7udWmPGM/sruwocU=;
        b=gblxCfTt5pOw7A9YHZEJV+r2VG2ChUPoOQENqtkp2cD9u6jNXJgjxv2GFFFMsM/j1v
         Q2bAWtuYoHVtOWqHe7hjKmrV3TsMB+pNFCxXxg98Hxoy145vOkyrtRBbQ1b4zZpA+A1+
         m3vrIpLanU3qXFTpv1WHgWerwCM08gLxzMyuLrfLY2BLdTpWmtpZZCIA8VnGVxQPJSGw
         xqv5Ii2BDXG3LKm7eR73P/dCNDyy1at1PARvuyUQJ4QUTBg+DKyDnVUw6Iop+kGwRAzR
         hJvsA8R/+LW94eBMAMh3wccqPVIx8QKXEc5XbXbso3UNdF0HbknOCrBEyS28rXYGBpJ4
         wTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JruBtp3H6AJykO9OR/eL1GiHC7q7udWmPGM/sruwocU=;
        b=FU0CaP1yyNOiUsROoOGnE/GK2s/hqKZMFHlJhUAgsLPCB3qEYItB6R7D1Kjm6v/T+E
         zum1YSidMEMbK6cZNH3ty8eorbktpCQgiKuW/OVLXoOMiInins7NoI7NkrYleizQ698c
         hh5WHfAKgRvF9UoXkNb13D2Hr+9ZHmBj1iNWjIE7oy0VNYWNq5j0hbk3JjtV5iReUeLy
         Ixfw14MhPg7Jy16I5LVvCseQ66sN69+upFxOXsfu/yNpIV0EJ0Rlo9A8labBjO9etHJL
         thNlelDrwvI8R8RgXk7FyMFOCpFl8abmH9UpNKMSkr1lxCfbETxsaOGIP9Vfmcjecciz
         aG1w==
X-Gm-Message-State: AOAM532yIh4+RSgwwzUBRLyNrCcqzR3QF4foOkP/J1Jozk4tGazrYyAN
        aWkSk1gOICm39QkHUH+Hz/Rby0HZmUrofw==
X-Google-Smtp-Source: ABdhPJxrLNkOBCK22JKPARmcl5BjmY6TUTpFvEk9uA+1n3mHpJJ9+WrPqf1O6PJKP4JfkZxzMsKPKw==
X-Received: by 2002:a05:6402:350b:b0:42d:d565:a62a with SMTP id b11-20020a056402350b00b0042dd565a62amr7607557edd.172.1653991225974;
        Tue, 31 May 2022 03:00:25 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:25 -0700 (PDT)
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
Subject: [PATCH 11/13] drm/omap: use drm_oom_badness
Date:   Tue, 31 May 2022 12:00:05 +0200
Message-Id: <20220531100007.174649-12-christian.koenig@amd.com>
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
 drivers/gpu/drm/omapdrm/omap_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index eaf67b9e5f12..ca2c484f48ca 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -684,6 +684,7 @@ static const struct file_operations omapdriver_fops = {
 	.poll = drm_poll,
 	.read = drm_read,
 	.llseek = noop_llseek,
+	.oom_badness = drm_oom_badness,
 };
 
 static const struct drm_driver omap_drm_driver = {
-- 
2.25.1

