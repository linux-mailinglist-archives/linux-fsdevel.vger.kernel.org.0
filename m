Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA9605F40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiJTLu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiJTLuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:50:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBE1D57F8;
        Thu, 20 Oct 2022 04:50:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q1so18963365pgl.11;
        Thu, 20 Oct 2022 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgep5zV9HzhLSzJsiAfm1on8PjtUjPgtsj5tiSHBYS0=;
        b=ErcmIy8kWrhYdXLY8odI9k9JS4ZjEPdsuXaKnTO5EXrui5h5AVtWyIyoWG0lZJ6pwP
         B7IquTDz25QQH9lSCtlQQlPJscCFEH9fnOQ4blxaP/Jo5P2Xuz74M+tg/uhe/m3WIOYZ
         4H7S6fp/IcWi2r1GW4mrtsQMwm7nJhqyMpPTix2DLNQKN5Jmhr+4P4T3WJZrRraQp6Gs
         9Fbe734CpS09mY7pCpvcPC8Ca5im4Atd65Nf5+7pgpmRXRPnMFLxvSTJiXU6ZytETrAj
         0zYODuu1X70bXhITapKfdiWXW1RsmtFquYwPb/C6rQ3u/7e/EbSS4/EvhTcU+RDZahHE
         Cd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgep5zV9HzhLSzJsiAfm1on8PjtUjPgtsj5tiSHBYS0=;
        b=ov/FuePUBdhGG61HtAGZ/zC7PwMc4xixwnrb9nFGhHneovaMrGcN6i4q/DpcwXcvDH
         +rPdHXstPSXtfAvE8OaaO7JF2KZs/1mlsTJ0U5G8MxKzIGrUNqM1HrMkdAB0zTkTe9ri
         u9IAAlEMX/NxHcuRmlDetAm++AxuYVxOtaQ6Enyg2wpcVsotxECHslex9xA7mGVUgnO7
         fpD/C3O2VtBJA9cV/EbpHYYEI2Qj1e2FOV08bflhZMc25CemcbmEUDrpiFWsMyH5nY0s
         JNmB+WgCnHa8+vQlJ17bEWaFUplR2vVAYdX4AZtwk13YaGkyJs9k06NpFMT/nlFsphaL
         ovNA==
X-Gm-Message-State: ACrzQf1aRpSMyrX/o6Hg0KIXBmKX03tr2x6xeMx3cJW4uQ54TNTZw2pw
        QKI9/lPYRlW3EdW+dahSZw8mIkxJlVAkXw==
X-Google-Smtp-Source: AMsMyM6XRbZl6uwY1KSMcZWm/dC3tQWdpmYZaBEsLlFXSfDp+VCWgX+Cc9Pk85k2Y2q3sooL381xYg==
X-Received: by 2002:a05:6a00:174c:b0:565:c73a:9117 with SMTP id j12-20020a056a00174c00b00565c73a9117mr13410309pfc.23.1666266615678;
        Thu, 20 Oct 2022 04:50:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902e48400b00176c6738d13sm12550247ple.169.2022.10.20.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:50:15 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     bcrl@kvack.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] aio: Replace IS_ERR() with IS_ERR_VALUE()
Date:   Thu, 20 Oct 2022 11:50:10 +0000
Message-Id: <20221020115010.400289-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Avoid type casts that are needed for IS_ERR() and use
IS_ERR_VALUE() instead.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5b2ff20ad322..978bbfb8dcac 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -556,7 +556,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 				 PROT_READ | PROT_WRITE,
 				 MAP_SHARED, 0, &unused, NULL);
 	mmap_write_unlock(mm);
-	if (IS_ERR((void *)ctx->mmap_base)) {
+	if (IS_ERR_VALUE(ctx->mmap_base)) {
 		ctx->mmap_size = 0;
 		aio_free_ring(ctx);
 		return -ENOMEM;
-- 
2.25.1

