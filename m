Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B15AA1F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiIAWCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiIAWCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:02:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038052DF4;
        Thu,  1 Sep 2022 15:02:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5so307741pjs.0;
        Thu, 01 Sep 2022 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=;
        b=ghwmH7OBtODEG3q6T97VdwhOtKpgroD8O6/eJME6RxcE0RCt6y1f0k8Z+Nf438szjC
         f1Tz2jCtqotWMYX7jAfk8pOks8r2uw1MbNfVxQq0DoggwzPzqUI1rjL/zYCVH96CDWOv
         6N+BySbmSBpBiAynr3+ZISEA0FDbCfqFR2qcMY0YXtQvpxu9mYXWpYrIjN0m8121kRUK
         taJIkqf7L0HTr7GIXny4HPFg0cC9mjsMx0m7GnMMBPB1n6WD1zCiOVAj8NMqjbSN/CwY
         UiWg2L5Utibhg+ppDHvNeQZKqE6Q7TMiSRDWsRr05n+F5Hbq6n90JrOCXpSrF4pvJHUr
         61YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=;
        b=RyPd/IZivJLqcgFTHt9JZz1I2Sc5LDb/fV8EJKfCIsqeHMCI8g9SsLXQtiRr/LMclN
         79Yi4XgGe37Mx4qxv15fQtkvmEP9U+Kv/X35CHsY7bkkSTnV6zt635XE6qXuRZZyrFhE
         NUO/Z8QRTwrnu7ywruXra4rmvTcCiC+3xgW6Fm8vcdw2BRUSQh4QW9jii/TB7kwlZdXf
         GrPrgioTubPp83E73dsLlZbIvwhPZ7NLRMjLxUD36/fZdo9pkVNHRZWeqHnqnGstmXG0
         agkMrn6HTBSe1ph/6sR4GlEKIwHJYgTXm8pIorbrBnsV0CVrt87dODv+MFAWxUvTFi0U
         c3gg==
X-Gm-Message-State: ACgBeo0MWOJmNjLLObonPlADmCHJTsm3G2et9vvKcdBUXTfYabk82Xyp
        5S+AeOvtJtEbYXJdENleIcRxt/CfK5SZOg==
X-Google-Smtp-Source: AA6agR66279h5kRGOp1743YusbEZncu2V+e3ESCBIyAmjv+FQyjI4ExArRN8AnvHyGVWNl+1uieWjw==
X-Received: by 2002:a17:902:e88c:b0:175:2471:8d8a with SMTP id w12-20020a170902e88c00b0017524718d8amr13575643plg.0.1662069755764;
        Thu, 01 Sep 2022 15:02:35 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:35 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 01/23] pagemap: Add filemap_grab_folio()
Date:   Thu,  1 Sep 2022 15:01:16 -0700
Message-Id: <20220901220138.182896-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
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

Add function filemap_grab_folio() to grab a folio from the page cache.
This function is meant to serve as a folio replacement for
grab_cache_page, and is used to facilitate the removal of
find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..4d3092d6b2c0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -547,6 +547,26 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
 	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
 }
 
+/**
+ * filemap_grab_folio - grab a folio from the page cache
+ * @mapping: The address space to search
+ * @index: The page index
+ *
+ * Looks up the page cache entry at @mapping & @index. If no folio is found,
+ * a new folio is created. The folio is locked, marked as accessed, and
+ * returned.
+ *
+ * Return: A found or created folio. NULL if no folio is found and failed to
+ * create a folio.
+ */
+static inline struct folio *filemap_grab_folio(struct address_space *mapping,
+					pgoff_t index)
+{
+	return __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping));
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
-- 
2.36.1

