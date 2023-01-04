Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA365DEE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjADVPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjADVPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD971D0E6;
        Wed,  4 Jan 2023 13:15:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c2so9656887plc.5;
        Wed, 04 Jan 2023 13:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5rMPwcVI+xSSROnSv680xsAXd0L9APPXdNmyKQVwfk=;
        b=V1E1lT+81O0Bma5i45Jhgrf33b8ZyAtb2k6sBn232f4UkEzENvpQBKf03VCx514eGY
         A6/X8hia12tEOrxhlqm2jbfpueF7iUxDQK73Qfx/HnU0C1qeC98Y/FJf4DdEA7/pzkhJ
         0R9L0J423oCq4U1iJLCVDadB2Wt5+nvV5hLoYRWJbhwd1xBn6WpVA0bJU8YE7e7wpuN2
         7595aSPavZoug9A+uF4GQmMXauKv9jF+a45BkfZqX76YcFFkYKhW2/vAA8fJsRJSuef8
         gAsMn3ncTXpb8uuk1BimZcT4C8iNt/aS5nfn00OIYDqHLLwCBHXgWFjBa8QQEThwOWQl
         z5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5rMPwcVI+xSSROnSv680xsAXd0L9APPXdNmyKQVwfk=;
        b=kVksEYPrpIq4yErZ/4cGA1sZ0eEBiIj9hs3n3S3LhJSDu8sVldFAn44T3DoAt0ohfP
         DdTR7ddR6g3VRwR9N91oS3or9VodmhB0YGQL5icrxQ92ASCdwEMZSL8TagGFY7hdSw2R
         20/a2ym4JjxiHL7F551LMWzeVL5d6dkIUmlvNswlaqP8Ti6Si2OCcYSqJCGjiU/pNQ/V
         E1xfjieZagONsO5+QX97M+gU0o0ZKlmd+skU6mVvAGSjFq9PzomZgEcEHd4mP+XTr8HJ
         37hoKK0YkOxah2AKM8JcScFG8G3hIrUeGG4zwEoq3fos3XSWcVT9pNTNpmtlOsl4ji++
         V0mw==
X-Gm-Message-State: AFqh2kq5Vk+vLakHlyPpD3p3ucaBxnEk6jRxRFuh6U15WVtViH8Dkjur
        zsSVOdyOYkb/04wBsMZf6KMJLbxgY7bmrA==
X-Google-Smtp-Source: AMrXdXu6t3Nt2/819SMAwDAr2w3gRs9/WxQKALxtb70CxJaSaRfG2mUZCKyO3UNaiTmg39rKgXBHzw==
X-Received: by 2002:a05:6a20:cf62:b0:ab:ee20:b003 with SMTP id hz34-20020a056a20cf6200b000abee20b003mr46906430pzb.14.1672866909161;
        Wed, 04 Jan 2023 13:15:09 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:08 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v5 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:34 -0800
Message-Id: <20230104211448.4804-10-vishal.moola@gmail.com>
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

This is in preparation for the removal of find_get_pages_range_tag(). Now also
supports the use of large folios.

Since tofind might be larger than the max number of folios in a
folio_batch (15), we loop through filling in wdata->pages pulling more
batches until we either reach tofind pages or run out of folios.

This function may not return all pages in the last found folio before
tofind pages are reached.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/cifs/file.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 22dfc1f8b4f1..8cdd2f67af24 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2527,14 +2527,40 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
 			  unsigned int *found_pages)
 {
 	struct cifs_writedata *wdata;
-
+	struct folio_batch fbatch;
+	unsigned int i, idx, p, nr;
 	wdata = cifs_writedata_alloc((unsigned int)tofind,
 				     cifs_writev_complete);
 	if (!wdata)
 		return NULL;
 
-	*found_pages = find_get_pages_range_tag(mapping, index, end,
-				PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
+	folio_batch_init(&fbatch);
+	*found_pages = 0;
+
+again:
+	nr = filemap_get_folios_tag(mapping, index, end,
+				PAGECACHE_TAG_DIRTY, &fbatch);
+	if (!nr)
+		goto out; /* No dirty pages left in the range */
+
+	for (i = 0; i < nr; i++) {
+		struct folio *folio = fbatch.folios[i];
+
+		idx = 0;
+		p = folio_nr_pages(folio);
+add_more:
+		wdata->pages[*found_pages] = folio_page(folio, idx);
+		folio_get(folio);
+		if (++*found_pages == tofind) {
+			folio_batch_release(&fbatch);
+			goto out;
+		}
+		if (++idx < p)
+			goto add_more;
+	}
+	folio_batch_release(&fbatch);
+	goto again;
+out:
 	return wdata;
 }
 
-- 
2.38.1

