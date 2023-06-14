Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2167303FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbjFNPja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjFNPj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:39:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FDA123;
        Wed, 14 Jun 2023 08:39:24 -0700 (PDT)
X-UUID: 9838dc480ac911ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4NuQo0gKBxrcZxtYCs5sMJl+CvnlRB73xhVEIlMdfzM=;
        b=D+afP+TbkHa+ign/9qntY9pl89G+SWOpEVA7xnu7KLjvKS2WYRpD2aiahD7wXy7S/8LRFk8OH5iTSweUMYBS1YJ4bFbp5aVYC+zO+BtTQd0U0f6JNki9h88I3/MDnhPK0yQDhDHOerHs+M7voqqLP5/0LpmMf4twtpFFus/SEL8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:0cd6b2c6-be35-4d6c-81cb-cca38bd23cdc,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:cb9a4e1,CLOUDID:66f8116f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9838dc480ac911ee9cb5633481061a41-20230614
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 186060915; Wed, 14 Jun 2023 23:39:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 23:39:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 23:39:04 +0800
From:   Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
To:     <lkp@intel.com>
CC:     <Wei-chin.Tsai@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <ivan.tseng@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <matthias.bgg@gmail.com>, <mel.lee@mediatek.com>,
        <oe-kbuild-all@lists.linux.dev>, <wsd_upstream@mediatek.com>
Subject: [PATCH v3 1/1] memory: Fix export symbol twice compiler error for "export symbols for memory related functions" patch
Date:   Wed, 14 Jun 2023 23:39:02 +0800
Message-ID: <20230614153902.26206-1-Wei-chin.Tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <202306142030.GjGWnIkY-lkp@intel.com>
References: <202306142030.GjGWnIkY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

User could not add the export symbol "arch_vma_name"
in arch/arm/kernel/process.c and kernel/signal.c both.
It would cause the export symbol twice compiler error
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
---
 arch/arm/kernel/process.c | 3 +++
 kernel/signal.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index df91412a1069..d71a9bafb584 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -343,7 +343,10 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	return is_gate_vma(vma) ? "[vectors]" : NULL;
 }
+
+#ifdef CONFIG_ARM
 EXPORT_SYMBOL_GPL(arch_vma_name);
+#endif
 
 /* If possible, provide a placement hint at a random offset from the
  * stack for the sigpage and vdso pages.
diff --git a/kernel/signal.c b/kernel/signal.c
index a1abe77fcdc3..f7d03450781e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4700,7 +4700,10 @@ __weak const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	return NULL;
 }
+
+#ifdef CONFIG_ARM64
 EXPORT_SYMBOL_GPL(arch_vma_name);
+#endif
 
 static inline void siginfo_buildtime_checks(void)
 {
-- 
2.18.0

