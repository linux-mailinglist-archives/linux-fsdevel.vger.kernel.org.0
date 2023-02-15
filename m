Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C6697CE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjBONO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjBONO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:14:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F32411B;
        Wed, 15 Feb 2023 05:14:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k13so20256065plg.0;
        Wed, 15 Feb 2023 05:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ92//1CYUXg/EOFNQaLei1Hlqjfjc15Vri++4R1MPw=;
        b=HedbWDOiOInXt3cAUraWEEqc/cXhPfoZZg8b9v2C+BeTlunbUlGE05GYuKZlm+g9mP
         iZFYf27tC0dskRBKpCY8ASZWzQ5NSkj38P4zuYsAVUsLLWmNfZWSogcr7tCW65evalCg
         auyxWgX7TclkLdHBskczVHVLhUA0H66RD0iQThR5ppaf3pFccGFViUTK7ZlI6XGhWA8x
         CHbeLfh8+CjqgKyGY0SnDatG8zODhf1huz1YmsnpfLWeuIVoIKUbLtX6uvGuG4iwq7Sz
         18IwMtmfR3zPcm8vKKeSQ14wvrJu1ivRhxg6kUewypD6DegPVPLGW3LXlXHJs9lvI2Ax
         o6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQ92//1CYUXg/EOFNQaLei1Hlqjfjc15Vri++4R1MPw=;
        b=UfaSdLtk4QL5rEkzhlRoTUHBaW18kc/XghY9+MyxlG0BXrVviSwudXUonvBu5Kgm4E
         rZaLdUHTwa1PhEYxeLh8SdFuhOUy1jUqOyo7zXbJZP3L/AmGDzE8BZXR2TjiJ0h6BTv2
         O65ytK/Kj0gDjodx1Yi04HCEN2Wasw2zA5kBolRdFtrOB2yKi7DBg/zZR229XtMKED1N
         K48ymWT9Y9okywcESBzvSndUm03/jQIvTvzD8+4PQL1D7X1GmJ6gkRCj2f1GZ0QLKFnH
         4A68ivD3lVMIZPdNYQ+iWZasAOoUMx1Vox/CRE01IQpFAZHZL6i2XwS2HvnsSDEl+rSi
         CGfw==
X-Gm-Message-State: AO0yUKX+1oIj9ET/oMyXyyYAKzyTbt4OJwMuejdR+WrkuTfplBFH07bY
        bjPfxh1/Ti+4kmx3QJ+7sfynwgFUvAA/eHmm
X-Google-Smtp-Source: AK7set/OfOPJseQbgUg052Z9tKaTG/2RDHQkp9NlfAKUj/OR6mY+I8Uo5jKqfBHybf1Wd0a8KdlHuA==
X-Received: by 2002:a17:90b:3892:b0:233:fdfd:710c with SMTP id mu18-20020a17090b389200b00233fdfd710cmr2786878pjb.37.1676466862208;
        Wed, 15 Feb 2023 05:14:22 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090a931000b0022698aa22d9sm1420873pjo.31.2023.02.15.05.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 05:14:21 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        void0red <void0red@gmail.com>
Subject: [PATCH] xa_load() needs a NULL check before locking check
Date:   Wed, 15 Feb 2023 21:14:17 +0800
Message-Id: <20230215131417.150170-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: void0red <void0red@gmail.com>
---
 include/linux/pagemap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bbccb4044222..f1ddee3571de 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1250,6 +1250,10 @@ static inline struct folio *__readahead_folio(struct readahead_control *ractl)
 	}
 
 	folio = xa_load(&ractl->mapping->i_pages, ractl->_index);
+	if (!folio) {
+		VM_BUG_ON(!folio);
+		return NULL;
+	}
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	ractl->_batch_count = folio_nr_pages(folio);
 
-- 
2.34.1

