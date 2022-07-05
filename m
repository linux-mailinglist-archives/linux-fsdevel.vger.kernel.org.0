Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF825670DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiGEOW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiGEOWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:22:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD97ECB;
        Tue,  5 Jul 2022 07:22:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so6362671wrd.13;
        Tue, 05 Jul 2022 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//MoCF5LEksIJjTIwC067HezOGBhlWGX2A3GJ8DvRDo=;
        b=p8B5SN/clySs7gQmVVJUpIsXFGVm66o/dM/T5dQ88hMNX0OTzKMiWBnuz57ojwZQUc
         EgQaPTGUDAAQOjbyD2uU8D61j8eQ4vdBLtqkz0/PnrFM/Reu5uiEHx7gUxI9BuHQl+9T
         X0Mt7sggy0idUAGl96ZbA7eqxO/SAvfGtHLy4CkvIp7uqAcbnOAsmhu2E2OBw5uPGrtl
         qIMb59mBvz71XUWieoAmU3nn9DvX6hnKXuFKtzKjv4qO9SC7DR9tIgl9A2XTtHVufjyO
         c4cqC7nBdrk6+uxoLS1K7XKIzYFCP/6WwtkBQ2RIuRmuVnw9CNwRh7wn9kYK3zH0kYYa
         AX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//MoCF5LEksIJjTIwC067HezOGBhlWGX2A3GJ8DvRDo=;
        b=PN7R1uZj8TYXNjZR0mg72zd9+wJnc0KVL+UVp2rOnpxJ+8F4xqCkuO2PpuslZunV65
         4dYitkanWxtT5SSDLQm2UmTdwCWK5gjybm/G7f58Y52sz+jYBnySMBxo1pdrr/J6/7PJ
         oiyezSMY5xNarIrl/kw1wixeZ5Wf2JryvNOP83UFTKPcIh4UW+zKLrMK6b9sZQjS8ab5
         Eq9/73NGjuX9BEi+hRePIKLf8RJ6ddw3VG1z0z1gme6gDkjZ23uGIe1FHHtWvfJEbS+k
         7AEBSxfVMIWaEmySMirccDhnNyfGvBED1N1RcXpPy4C0Pec+oRQhbrdSOhllIVL/PjIE
         iGOw==
X-Gm-Message-State: AJIora+wEi6W3TDU+2uilE//DGOMIaVQpjKlYt5ip1JEs4HAgBfjRnyv
        k1j8sik1DKY5yYtaiM/3OPPAFOHPR9c=
X-Google-Smtp-Source: AGRyM1vDgHx1l8B7BzzwCp7Qv4b1pTj1lUnPkCKsmHSw/95d+83mcC6lmFhpSBsENewec/QOrrGQfA==
X-Received: by 2002:adf:d20e:0:b0:21d:7654:729b with SMTP id j14-20020adfd20e000000b0021d7654729bmr2471668wrh.239.1657030968309;
        Tue, 05 Jul 2022 07:22:48 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a0fb88a197sm22811660wms.16.2022.07.05.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:22:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] zonefs: Call page_address() on page acquired with GFP_KERNEL flag
Date:   Tue,  5 Jul 2022 16:22:02 +0200
Message-Id: <20220705142202.24603-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

zonefs_read_super() acquires a page with alloc_page(GFP_KERNEL). That
page cannot come from ZONE_HIGHMEM, thus there's no need to map it with
kmap().

Therefore, use a plain page_address() on that page.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/zonefs/super.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 053299758deb..bd4e4be97a68 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1687,11 +1687,11 @@ static int zonefs_read_super(struct super_block *sb)
 	if (ret)
 		goto free_page;
 
-	super = kmap(page);
+	super = page_address(page);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
-		goto unmap;
+		goto free_page;
 
 	stored_crc = le32_to_cpu(super->s_crc);
 	super->s_crc = 0;
@@ -1699,14 +1699,14 @@ static int zonefs_read_super(struct super_block *sb)
 	if (crc != stored_crc) {
 		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
 			   crc, stored_crc);
-		goto unmap;
+		goto free_page;
 	}
 
 	sbi->s_features = le64_to_cpu(super->s_features);
 	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
 		zonefs_err(sb, "Unknown features set 0x%llx\n",
 			   sbi->s_features);
-		goto unmap;
+		goto free_page;
 	}
 
 	if (sbi->s_features & ZONEFS_F_UID) {
@@ -1714,7 +1714,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_uid));
 		if (!uid_valid(sbi->s_uid)) {
 			zonefs_err(sb, "Invalid UID feature\n");
-			goto unmap;
+			goto free_page;
 		}
 	}
 
@@ -1723,7 +1723,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_gid));
 		if (!gid_valid(sbi->s_gid)) {
 			zonefs_err(sb, "Invalid GID feature\n");
-			goto unmap;
+			goto free_page;
 		}
 	}
 
@@ -1732,14 +1732,12 @@ static int zonefs_read_super(struct super_block *sb)
 
 	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
 		zonefs_err(sb, "Reserved area is being used\n");
-		goto unmap;
+		goto free_page;
 	}
 
 	import_uuid(&sbi->s_uuid, super->s_uuid);
 	ret = 0;
 
-unmap:
-	kunmap(page);
 free_page:
 	__free_page(page);
 
-- 
2.36.1

