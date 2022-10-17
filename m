Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4295B6019A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiJQU1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiJQU0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472434994;
        Mon, 17 Oct 2022 13:24:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i3so12108454pfc.11;
        Mon, 17 Oct 2022 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbkaK1BhnmuuyeEPYHO1j/C42qAqDKaBYuSZ7EsnhRU=;
        b=NQ3KvRSSCU8wPaTgediDqeAMel/vIah0+7k422IToZaKZI3bGfU37b14iH42kEU0X7
         Qzi6EP9hjDaf1fqg1ZQFK32c9ILuCZG+zRyKOIFQp5ZQMoB2jLD4q1Gyr0WQ8mtE2qRq
         m8TScIwF6nHJLl980ya+Sr2hxZTVlJg4LpKy1hFXQBj8kaEyxSareN0Oky9YZM7BiaNw
         2vWb6xBDZgHXAKHRWn3JDalz3e7jNZ/tPokjvwD0EzjqbULHQtABSVFlz/pa4stgqdUZ
         akBnIoIm5M5fDRlS5Fp6GmmllvS/DMn6w9C+Jv33XGjD/jl12SrDdjixrx8PhoYvdeEc
         +A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbkaK1BhnmuuyeEPYHO1j/C42qAqDKaBYuSZ7EsnhRU=;
        b=TQmPzW2b2x4kba0D8LlBoeDh2kaq3YUFE8YnKYHLHP8GpkyqxFBIdac+Q/J6hlrxKg
         M/A+ErL824+z7Lw4b25iykWlqbVOwOUSPu5S0m+UB1NKXQ1Uu6BuwRt8b6PUgLU2mB8G
         QKYvjOw28TQMRVdmJZfLg1rhKgj/5X2DhYokJmFeHyDVgYsun/Ch1oyMIWZJsrXUEQcB
         POiUQfI5asJxYX0NN4BIYPU5RLmcCJpzCYhytS/rLF6vdGgSzIshDxJvNkswYboCBrwW
         YpISmMr341fJUKkwbp+xP/6Nh2HtE53z9IZqdvkf0FbgIqKFdKdi0ZtXGLacRT13Mj22
         qiXA==
X-Gm-Message-State: ACrzQf1vtbJ2zxwUEdsv9GNqsumjhSpzHiOGL6WrKJTBfO07LGrN9YZG
        BikGluhLrJW2ozvE2lLRoLiwh1ClrLy+pQ==
X-Google-Smtp-Source: AMsMyM4YYYiMlGZioccUtzsgvC8/uYYs8dSo4tR5iZYGSvU1XAyZz6D+QISkFp8v5lRsZ6zJPWfGpA==
X-Received: by 2002:a05:6a00:230d:b0:53d:c198:6ad7 with SMTP id h13-20020a056a00230d00b0053dc1986ad7mr14548828pfh.67.1666038295539;
        Mon, 17 Oct 2022 13:24:55 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:24:55 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 01/23] pagemap: Add filemap_grab_folio()
Date:   Mon, 17 Oct 2022 13:24:29 -0700
Message-Id: <20221017202451.4951-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
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
2.36.1

