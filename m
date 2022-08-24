Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4F59F2B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 06:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiHXElH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 00:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXElG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:41:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB782FAC;
        Tue, 23 Aug 2022 21:41:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f21so15925057pjt.2;
        Tue, 23 Aug 2022 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Jt/G83ni7I/FU67eFbWq1WL9BdjfSCuvjzHq4MUmPEs=;
        b=q1XIf8ztW5mT9Sh2FdsF9dkp7at9wmuUtHs7Av1YAgmiTtmG6WZUs0+SUrfEYPDpQo
         6oe6YnWx7Sk6v2rJg79rpBc2hQ9108SMJMziJ7P6rzmg4MrA9I220VYwz+6YrC3GSVsE
         f1MZnUr6IiM22JgngydNpGMo7q6vWG0ZQNT29sEOKTnZqrMEMfRATKwK9dQWf4wwKkrg
         rOZ4cbprq7pmkkCghzJu5CB+Bwzt9z+H6lpGFJXov6GbtI3cUGwDWcus9hYkmVVX9prB
         XKtVmeL3guur/Xp+a+XpxgZaGFV4Ykx1D/a37yZqeBprGDQCiK26FGmLlurP9ep6WqDS
         D8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Jt/G83ni7I/FU67eFbWq1WL9BdjfSCuvjzHq4MUmPEs=;
        b=FBIK9m1vQhkXi+CF+JD+tNtFgc3KGzVlZIZZT+GtLdpYKajOKWWncXDmajHL5kuhgU
         r1/BrCYlp4MNPaBZlaVU+KvMaBgBYX+kK2spmjcxd+oZhYbfsIt9SDjIAQ+MZJNJN7uD
         Z5GUiEnVOW3+JKNnXfrEe9IaNWiPOBn3TcapiHG9Z0xPQ3Hrvf55it3eLhdRxcXX07Cf
         Dj+Q3fZ5cwS8Djov3OrkVjyZPCJbijrlJJjxsCt6r+KxoCQbcOECBXfM7RDExbu7MixM
         +mIXTvEjkX/X35NDD542krR8S4JFqr8q3kLVFQxSVAZvj5/dtMT7BBIMfRi68XXvV4rE
         jpXA==
X-Gm-Message-State: ACgBeo1ws3v+6YIOuIPHQUK0n/wYAxFD+SXKO5Dg7K3LR40YlPvdQIWw
        qMyYBDL/BfacqljdPcWUWoH1GFWQ1Pw=
X-Google-Smtp-Source: AA6agR4y83+GFBiVnDjmvYo0cbNHn+OGbaSKsWoLdo6c8JA1AqWsywufMRb7rrB6FtrkxBmKBkYVfQ==
X-Received: by 2002:a17:902:c94a:b0:16f:81c1:255a with SMTP id i10-20020a170902c94a00b0016f81c1255amr26475771pla.35.1661316064937;
        Tue, 23 Aug 2022 21:41:04 -0700 (PDT)
Received: from localhost.localdomain ([218.150.75.42])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902ebc700b00172b27404a2sm7551512plg.120.2022.08.23.21.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:41:04 -0700 (PDT)
From:   Juhyung Park <qkrwngud825@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        chrome-platform@lists.linux.dev, len.brown@intel.com,
        kaleshsingh@google.com, Juhyung Park <qkrwngud825@gmail.com>
Subject: [PATCH] PM: suspend: select SUSPEND_SKIP_SYNC too if PM_USERSPACE_AUTOSLEEP is selected
Date:   Wed, 24 Aug 2022 13:40:13 +0900
Message-Id: <20220824044013.29354-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 2fd77fff4b44 ("PM / suspend: make sync() on suspend-to-RAM build-time
optional") added an option to skip sync() on suspend entry to avoid heavy
overhead on platforms with frequent suspends.

Years later, commit 261e224d6a5c ("pm/sleep: Add PM_USERSPACE_AUTOSLEEP
Kconfig") added a dedicated config for indicating that the kernel is subject to
frequent suspends.

While SUSPEND_SKIP_SYNC is also available as a knob that the userspace can
configure, it makes sense to enable this by default if PM_USERSPACE_AUTOSLEEP
is selected already.

Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 kernel/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 60a1d3051cc7..5725df6c573b 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -23,6 +23,7 @@ config SUSPEND_SKIP_SYNC
 	bool "Skip kernel's sys_sync() on suspend to RAM/standby"
 	depends on SUSPEND
 	depends on EXPERT
+	default PM_USERSPACE_AUTOSLEEP
 	help
 	  Skip the kernel sys_sync() before freezing user processes.
 	  Some systems prefer not to pay this cost on every invocation
-- 
2.37.2

