Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF7D5B37BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIIM0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiIIM0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:26:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F912B2B1;
        Fri,  9 Sep 2022 05:26:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k17so1263079wmr.2;
        Fri, 09 Sep 2022 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HIttaRwxS/Q+PzylfGrNDChJUqTkhrFYeQ4fyU+Igeo=;
        b=PBBru7o/5THp7coacVMSU2IXxEHhQPQSLMbTe95cwo2/6QseDKxW3H0nZUUeLEZMOS
         2ZtlKFQ5T4lFVSZpt/Sva5e7PF65xUT8Lu6RDSYxX2OEhlBNgX6g5/kg1qUM/jZaFLFx
         bYjHSkvgoAKjwsOpmKRw7abjdmWvs/mfkS2fcaVZLBnVC2GBMbwfU1DW/XgY9QjT9KiQ
         RU29ZWtEQKkZWv1IMj/WE8J2+J8SqnWgCA9mwH1n1uRwzyDf4y2lt3UPr/6CksCopZO3
         f9uwe1kZst/1R3NjYh+crcUYxV25WU0vrlszt+1XuyEEETubbKaXWQ0emZQYQQT76HMi
         9Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HIttaRwxS/Q+PzylfGrNDChJUqTkhrFYeQ4fyU+Igeo=;
        b=UCkYQdk6YZDT6oIzUVvbtJLd3yYA3KLdcFJFDht6Nn/RSDnGQe8XCYxufkUqzOp9Mg
         9T1ay9YkMgeR2X1ecRQIrMG9m5MwqXPBBZ5pahf6gut+AcZZCHCRoUSxImKTqU/wopnJ
         ZVOhkx7+OzXN8cv2+puSqi1jPEb5//gbXw98pVc7WdLcpPKR2X4Ecn+NqCBwccIB05RO
         U1YR6lWRFakG6pVtEk++UrcqBxwJ4G3azK2EZEzoTGcYlYfCN46mo33oI0oGMXo2fHed
         erpExTR37G2YO/m9bYwiLzINt+7s268oh2yahiobmSqheerVEYdQWVR2nEp/wc05yqCd
         2lWQ==
X-Gm-Message-State: ACgBeo3/CXEUIzn3d45MXr+/wEcsRqQT3mgJx60kGyr6ccrV/3NFXCDX
        MaVlkIrqKnV/xFCPDtEqVBw=
X-Google-Smtp-Source: AA6agR5iFgxtS8kVRXgk1GWHrX0zg9ydSrrNmS/4X2uBJnOf3gOpS4jb3x0wNIuZmPnf2YfPA9Ferg==
X-Received: by 2002:a05:600c:3d11:b0:3a5:cd9b:eb08 with SMTP id bh17-20020a05600c3d1100b003a5cd9beb08mr5465692wmb.82.1662726372865;
        Fri, 09 Sep 2022 05:26:12 -0700 (PDT)
Received: from felia.fritz.box (200116b8261bf1004cd87416af9987ea.dip.versatel-1u1.de. [2001:16b8:261b:f100:4cd8:7416:af99:87ea])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b003a84375d0d1sm544282wmb.44.2022.09.09.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:26:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] proc: make config PROC_CHILDREN depend on PROC_FS
Date:   Fri,  9 Sep 2022 14:25:29 +0200
Message-Id: <20220909122529.1941-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 2e13ba54a268 ("fs, proc: introduce CONFIG_PROC_CHILDREN") introduces
the config PROC_CHILDREN to configure kernels to provide the
/proc/<pid>/task/<tid>/children file.

When one deselects PROC_FS for kernel builds without /proc/, the config
PROC_CHILDREN has no effect anymore, but is still visible in menuconfig.

Add the dependency on PROC_FS to make the PROC_CHILDREN option disappear
for kernel builds without /proc/.

Fixes: 2e13ba54a268 ("fs, proc: introduce CONFIG_PROC_CHILDREN")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/proc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index c930001056f9..32b1116ae137 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -92,6 +92,7 @@ config PROC_PAGE_MONITOR
 
 config PROC_CHILDREN
 	bool "Include /proc/<pid>/task/<tid>/children file"
+	depends on PROC_FS
 	default n
 	help
 	  Provides a fast way to retrieve first level children pids of a task. See
-- 
2.17.1

