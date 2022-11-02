Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9677616759
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiKBQLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiKBQLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599DA2B1A4;
        Wed,  2 Nov 2022 09:11:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 128so16663848pga.1;
        Wed, 02 Nov 2022 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbrAaY6idpkhBtxaaJGwUptujZ0EZql70PDCszR9xSI=;
        b=b22oyujJhcmEnIoOWyXlmdwFsWtvDDEbrYWi+tTl/IKQZadCXIum/ufaWsfiuhgQWs
         P0ejMWAXsFFxmUJWgjcqRWL6iDvmTJOBHMdvrWNuXSDSGhujg7k49tnS+xBECZ0DDC1D
         QEeKOjhkuj2U1fYHa3KM1TSvYvE4FrIPOrf/CN/DjK2k7Ii76jHakZpfzft8GgAI2TOi
         3dtL4HfeEfRRNgP7Mp0GAgu1ZDeKvnGqK9CY4nsrmEB3lEEy5PFMtwvBwHVV7JaSQ4Oc
         JqTTGwFIB+4o1Aa2ylRSznqsjRcz5BF5gANEbFRauGWLvr7/47QbInfDSn9b5QQsOYI/
         8XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbrAaY6idpkhBtxaaJGwUptujZ0EZql70PDCszR9xSI=;
        b=bZr6SYFBhkg2VMPqctbSETcwnfQl7anND/+vJLe0zdxMHOnOklnyfCxLdCly8B7WDB
         /JT/PmwbiTrND26z6HdJI6+4Kyn9h2gZICOkH5jmqLY4SwG1HVn8ffhEw2Xyp4C6Q8Z9
         FDk5l/bVr0JdPA6T1Wg/UP3ftoieVLW9m8/xbxIlLBbqHYI4A+delvZNH7ZA8anuXLX3
         C7PTnlqaHE9WqAe522eFeuqedReN6Z9+8V42oznMt/85JC2KchhRPbudbYEJ+vOZjFaO
         eJjYeQEPlCdsLH+PjnH3pKJWJneZuYlDfqjA5S1VsWV8OIWKJJ1PuSB6hJjYIrufDxqz
         BjLg==
X-Gm-Message-State: ACrzQf0Hud1OdEkphoDf60hwbg9/iDjP6R0qU96/ZpL5U39kErGr4+hC
        ZhxNHn2Iojxd2IvFLpe/gIAF2fpiXae8uQ==
X-Google-Smtp-Source: AMsMyM4joqcseRqaAlvGrQuZzcj3D8bSzB3ystEOG//zbMspTew1XCkFbHiKN+JLHdCdJZX/wxsOQg==
X-Received: by 2002:a05:6a00:1253:b0:56d:8742:a9ff with SMTP id u19-20020a056a00125300b0056d8742a9ffmr15514058pfi.5.1667405468483;
        Wed, 02 Nov 2022 09:11:08 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:08 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 01/23] pagemap: Add filemap_grab_folio()
Date:   Wed,  2 Nov 2022 09:10:09 -0700
Message-Id: <20221102161031.5820-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
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

Add function filemap_grab_folio() to grab a folio from the page cache.
This function is meant to serve as a folio replacement for
grab_cache_page, and is used to facilitate the removal of
find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bbccb4044222..74d87e37a142 100644
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
2.38.1

