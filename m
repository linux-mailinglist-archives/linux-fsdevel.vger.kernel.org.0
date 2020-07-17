Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68E722391F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGQKTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 06:19:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQKTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:19:00 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alberto.milone@canonical.com>)
        id 1jwNSE-0002SI-8v
        for linux-fsdevel@vger.kernel.org; Fri, 17 Jul 2020 10:18:58 +0000
Received: by mail-wm1-f70.google.com with SMTP id e15so8321899wme.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 03:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14N5DXiHHe1mi/NDIvVGMWsa3fcWdoqZSiuK+wzyZS8=;
        b=LRxlSAJCeLsAR2CaM8//wtLrkRwgyF40AqrrzrCAyod3Vad0GR6U0mrxuBukHCxUNb
         COKLFEPCE47i8gR4saXezqOG1L98QVyx6obG5kYc2f/6LPVazru2GvNNMOgvADtdfIwV
         51uX/ttUpyRp/XyENlT2xL8qWRAjhj5xx3moSAkA84lskmd+baFpLCStoKJlFTyMot3y
         67qp2QtC1637z8F7ysa4E3Cq0HnyH2pCuOPgJCSibAwevgVcAnLWvXxA67nfx4qSEV4T
         CPoWAvmz3ItT/P7Jc8zhLOhcTR8RDrPBCvTK6LQKRg+AMZ2mc1Qdo7ZWHDaY6ceYKvWl
         DkOA==
X-Gm-Message-State: AOAM530X/jzJjzoQBJ4n3O9kt6RAQgi8Ab1rHj+FYzR7laJqwVwTVU8p
        SD4XId/9Jair5VgjKbn5nQq28O5iS83mQvrD9zewJKYGG/minaljT8n9q28iAnYwbiDZVfVZzXP
        rZnoNx6yqUrPYCTUrULiQGyZCnRxhTOlOkWxanFBHKJ8=
X-Received: by 2002:a5d:6342:: with SMTP id b2mr9451116wrw.262.1594981137622;
        Fri, 17 Jul 2020 03:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN2avjFXgZ4QN/wI6VEoRIt2TKYXJ9OgvV0v7dQqelpd5B+HjGALgwKpqCrhAOzswaqCMO8A==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr9451085wrw.262.1594981137365;
        Fri, 17 Jul 2020 03:18:57 -0700 (PDT)
Received: from thinkpad.lan (dynamic-adsl-94-34-33-205.clienti.tiscali.it. [94.34.33.205])
        by smtp.gmail.com with ESMTPSA id c25sm12434693wml.18.2020.07.17.03.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:18:56 -0700 (PDT)
From:   Alberto Milone <alberto.milone@canonical.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     mingo@kernel.org, bigeasy@linutronix.de
Subject: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
Date:   Fri, 17 Jul 2020 12:18:48 +0200
Message-Id: <20200717101848.1869465-1-alberto.milone@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit cfa6705d89b6 ("radix-tree: Use local_lock
for protection") replaced a DEFINE_PER_CPU() with an
EXPORT_PER_CPU_SYMBOL_GPL(), which made the
radix_tree_preloads symbol GPL only. All the other
symbols in the file are exported with EXPORT_SYMBOL().

The change breaks the NVIDIA 390 legacy driver.

This commit uses EXPORT_PER_CPU_SYMBOL() for
radix_tree_preloads.

Signed-off-by: Alberto Milone <alberto.milone@canonical.com>
---
 lib/radix-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 34e406fe561f..5f3ec9be6e37 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -61,7 +61,7 @@ struct kmem_cache *radix_tree_node_cachep;
 DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
-EXPORT_PER_CPU_SYMBOL_GPL(radix_tree_preloads);
+EXPORT_PER_CPU_SYMBOL(radix_tree_preloads);
 
 static inline struct radix_tree_node *entry_to_node(void *ptr)
 {
-- 
2.25.1

