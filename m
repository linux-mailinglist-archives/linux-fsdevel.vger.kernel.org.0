Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0EC65DE46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbjADVPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbjADVO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:14:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1851CFC3;
        Wed,  4 Jan 2023 13:14:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o2so32016978pjh.4;
        Wed, 04 Jan 2023 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo+m9KCho02Llmwjmz5bDSbKVzw32DqjrZ5KrSHhgyc=;
        b=bjZkMxIPNZ3wmKI3QGSepT81I5OzcwJOIb/dnupKeJzgemoOZcjM4yfreHA+pwVbeP
         HOd/bgUCet0z9B/XX2tfep3wWWWYLyeCIHFa1NDUjFWQdX5A572uwUJHv92lvCUSn0jH
         nDD1ayF0cF1sYXZY6D7okVUr906wpDImdUvSkzV/8th2CAYrKdz3orCKBweWTHnMlK4j
         8Q9LXTwaogmTrXs5Gj4PAGJAZD90/jRoTwO/o58iZ0J59ckgaPVRY99HTFyy5G/KNc7Q
         k+iq8jJPMbsMV3H/So6AzW1W8RbB4qBsSsxHHBAFfFQVhi108BAllJmmP6SyPMsZeGbG
         6mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo+m9KCho02Llmwjmz5bDSbKVzw32DqjrZ5KrSHhgyc=;
        b=cQ669PKHaCAe+x5Fr2EBb0p8SMbQOlx6cyePucjInMnPn3wIO4CBnRCPxufRb6CthH
         QavCqqoovn+vLDMAZtHyOTq+Zg0L0xs/VfXSFNRLEqsX5oV7Vv3LABR3NcmiynUif17b
         cyU9Mou/ehAIj0o8UdG0Q/o9r5ZQl2IHFg5QfiILK6REK7e1W7ln5nnicOoGzjS97rT4
         CpvJ5crel+I4z2qk0PbdyHghRQ05/rtoeCAjQY/ZaE7yEq5S3r2icpEASblnHhczDgRZ
         QhcAfTfRxu8I3gTuHwskmhbojkBSBx1SM+5pMnoHx4mkGoAERPLFX25R7eU1tWFm/60J
         YMuQ==
X-Gm-Message-State: AFqh2krsdY6/B7lSY9+rINQ09FXqTHvwdAmXj/+nzcAIStw5Y05azCqE
        YddCMnUeCLrDysoCNbVhdcmng10Y9eVPTQ==
X-Google-Smtp-Source: AMrXdXtzyCslo5KrrtE6aj4KE0tZMImyQpChectqYz62yJ5Pkw2zwmGtohmj+/DGwHCRBdZk95hgJQ==
X-Received: by 2002:a17:90b:92:b0:225:eda7:13e with SMTP id bb18-20020a17090b009200b00225eda7013emr35757516pjb.40.1672866896879;
        Wed, 04 Jan 2023 13:14:56 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:14:56 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 01/23] pagemap: Add filemap_grab_folio()
Date:   Wed,  4 Jan 2023 13:14:26 -0800
Message-Id: <20230104211448.4804-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
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
index 29e1f9e76eb6..468183be67be 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -546,6 +546,26 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
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

