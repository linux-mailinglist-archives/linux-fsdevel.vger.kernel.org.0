Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D127B167D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1IyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjI1IyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:54:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B06AC0;
        Thu, 28 Sep 2023 01:54:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d935dbc2so2822306b3a.1;
        Thu, 28 Sep 2023 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695891256; x=1696496056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThPN2Hhgrb+6YderOJSJbgdsI3cmBjzcJEFDZEakKYA=;
        b=Rb64nivAshbxJ0CuGmfU28MXYClMm5bf0SWEfsMAzKnkQHAaF3QI2m8NSJasjlDQ4T
         5DSgahZroODaptYh9lbeNppIJWEEa9EtvjHJGD900ftzPWG3AbTOooafRzyYQ0FY8nPU
         qRjaBxxVmnADP/hnzx8XU7sFg7lmoAcrW1RtyiqQ7BZ2cQHPV+C7tJwyuQhN/TOUBdM0
         w4osi/OWK45HVsUmoUsfnLg6qXVOahjinxyvuAI5BXXqgLZMitWjJezk12QhlRVbefK+
         v6JUrXz112LEo8z57qykYtIWmvExGvPfl5mXe/BsdGa/vxUzt6j7+ETtckaIoDpxrypR
         x10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891256; x=1696496056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThPN2Hhgrb+6YderOJSJbgdsI3cmBjzcJEFDZEakKYA=;
        b=a+DZF8+sJnUlYd7lW9e8HIJTbrwMlEQIBKFqHtkyHis7zMWb/4Ql+yCqGDkfEHR82m
         SW9P6BP1NeXLutCmq83zmUa+QWhLGJAiEmOXDAsxkBFmhDCvszxEnYP/CaSeQkXgDHy+
         o6lTUtaPBFl2MwHrnDMtcUd2UB+I1FArNvO9IdNaDGvWIxWfuoEj+HG1VeifQew/lLEZ
         kxjEf/t/tRksCcHGGJEmbp+ltYgD2G436wdqHxNgwLo+mf+sPc7/xkF6j6eJSlVlmNKq
         0FIb6noIpeOnnJsn98CGrYBXoAupbIUF9bs66webql1YgKuMoY8mXSsli6HfV8soGFPQ
         MWyA==
X-Gm-Message-State: AOJu0Yx3FWw4BU5H7WNjmBMpSCfXGkxdoQ1qR6bnuehoerFjjbQg9cTm
        H4merPSYayPiwIL0f4JDosQ=
X-Google-Smtp-Source: AGHT+IHs3z5SBvtWECSkXRBoc6GaYZRFqmJjRBDu6RxFc7AMGEUNzHOmN2+FZujA7gml2D4C4olxHA==
X-Received: by 2002:a05:6a00:2c8d:b0:68e:3eff:e93a with SMTP id ef13-20020a056a002c8d00b0068e3effe93amr562164pfb.2.1695891255701;
        Thu, 28 Sep 2023 01:54:15 -0700 (PDT)
Received: from abhinav-IdeaPad-Slim-5-14ABR8.. ([103.75.161.211])
        by smtp.googlemail.com with ESMTPSA id h11-20020a63574b000000b0056368adf5e2sm12415386pgm.87.2023.09.28.01.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:54:15 -0700 (PDT)
From:   Abhinav <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, david@redhat.com, rppt@kernel.org,
        hughd@google.com, Liam.Howlett@Oracle.com, surenb@google.com,
        usama.anjum@collabora.com, wangkefeng.wang@huawei.com,
        ryan.roberts@arm.com, yuanchu@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Abhinav <singhabhinav9051571833@gmail.com>
Subject: [PATCH] Fixed Kunit test warning message for 'fs' module
Date:   Thu, 28 Sep 2023 14:23:11 +0530
Message-Id: <20230928085311.938163-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/proc/task_mmu : fix warning

All the caller of the function pagemap_scan_backout_range(...) are inside
ifdef preprocessor which is checking for the macro
'CONFIG_TRANSPARENT_HUGEPAGE' is set or not. When it is not set the
function doesn't have a caller and it generates a warning unused
function.

Putting the whole function inside the preprocessor fixes this warning.

Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>
---
 fs/proc/task_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 27da6337d675..88b6b8847cf3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2019,6 +2019,7 @@ static bool pagemap_scan_push_range(unsigned long categories,
 	return true;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
 				       unsigned long addr, unsigned long end)
 {
@@ -2031,6 +2032,7 @@ static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
 
 	p->found_pages -= (end - addr) / PAGE_SIZE;
 }
+#endif
 
 static int pagemap_scan_output(unsigned long categories,
 			       struct pagemap_scan_private *p,
-- 
2.34.1

