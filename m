Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24D2593D48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbiHOUNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243909AbiHOUJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005AC83F22;
        Mon, 15 Aug 2022 11:56:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso15240941pjq.4;
        Mon, 15 Aug 2022 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1TWw7ByCFm6NhkDCyy6ya2eZRdPaW0G32WpVpASX5vg=;
        b=iFemGX/6S2CEM0vc5Q7ZhA97VMtcnCohjPo5wTK/HWHqxK8N8QD+bkVVv0eRbEzJzH
         HqNnewi3fYbCRLFexc2OOX6LZPISwiwwClyISPUI5KMeUWOZeNZVhgrVNoTh/Ef21AvD
         inPVaZs72ziOBxRoTzzTlm+NfVEF+4Feqy2/CddIRYZtl8QSJ13XwO818UEDaiCRUVwz
         nb4QhvVObgxonTmLBTxLoJJ/T2W7q5OkqOs2FzS77LEHAbNCL5hJhBuhcB2oBU5Jz7is
         ge8YPVEk2wRZ+hVtTUqI862Ct1zgWNCA3b3a8uO8nl7FIulVV3gjzC6wH7UdYYgrFJGP
         GdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1TWw7ByCFm6NhkDCyy6ya2eZRdPaW0G32WpVpASX5vg=;
        b=hz5HnypV3T/LtTrgBjvhd3I8pl/zbE1/pvHAl2M6pupHmitrwAs+L5GRZGa83DVj3f
         R2l7qJaZUDkjxOlAVgmXRScS4AmsVGA1sr+Z1LglZcWAsO8wPdIQHNIbkrOpkupT+ODp
         7kyB+9/wOLiZ08KP42nhesNI5yKkF9bMZ5Ai1gZnX/Be0GhNdMTQPvmTnXivIWwHePtx
         qOAMVrSzIoUPg3q9QZdrPFWym2l63waCpdPbqshnser9qRgU59rQLvxtPTzJaXuBdkQT
         PxU/eSYJU3Frc9hQ6ffVsHJ8vLVdi1pdUMSWC6K95N1A3aSnXYkZjPZngoUTzktLp/Bq
         ht9g==
X-Gm-Message-State: ACgBeo1KDvaerjjaU3fynpu/+pzLYsb2uNFAy8mTLWJ7VF/i4rvpE5Jn
        wH942hEhXexjJNT2V9gsYgSsBEapb282QAlW
X-Google-Smtp-Source: AA6agR42uHmDMa0ZEOjeCzxe7g2crutPG+O6C4nHn1CNeAL6quQVHCY4QkzHACRNyGQNfrTk58qaWw==
X-Received: by 2002:a17:902:cec6:b0:16e:ec03:ff1 with SMTP id d6-20020a170902cec600b0016eec030ff1mr18488768plg.96.1660589765161;
        Mon, 15 Aug 2022 11:56:05 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:56:04 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 7/7] filemap: Remove find_get_pages_contig()
Date:   Mon, 15 Aug 2022 11:54:52 -0700
Message-Id: <20220815185452.37447-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220815185452.37447-1-vishal.moola@gmail.com>
References: <20220815185452.37447-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers of find_get_pages_contig() have been removed, so it is no
longer needed.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 60 -----------------------------------------
 2 files changed, 62 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8689c32d628b..09de43e36a64 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -720,8 +720,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
-unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
-			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 3a497e178fde..100f36c9247c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2267,66 +2267,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 }
 EXPORT_SYMBOL(filemap_get_folios_contig);
 
-/**
- * find_get_pages_contig - gang contiguous pagecache lookup
- * @mapping:	The address_space to search
- * @index:	The starting page index
- * @nr_pages:	The maximum number of pages
- * @pages:	Where the resulting pages are placed
- *
- * find_get_pages_contig() works exactly like find_get_pages_range(),
- * except that the returned number of pages are guaranteed to be
- * contiguous.
- *
- * Return: the number of pages which were found.
- */
-unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
-			       unsigned int nr_pages, struct page **pages)
-{
-	XA_STATE(xas, &mapping->i_pages, index);
-	struct folio *folio;
-	unsigned int ret = 0;
-
-	if (unlikely(!nr_pages))
-		return 0;
-
-	rcu_read_lock();
-	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
-		if (xas_retry(&xas, folio))
-			continue;
-		/*
-		 * If the entry has been swapped out, we can stop looking.
-		 * No current caller is looking for DAX entries.
-		 */
-		if (xa_is_value(folio))
-			break;
-
-		if (!folio_try_get_rcu(folio))
-			goto retry;
-
-		if (unlikely(folio != xas_reload(&xas)))
-			goto put_page;
-
-again:
-		pages[ret] = folio_file_page(folio, xas.xa_index);
-		if (++ret == nr_pages)
-			break;
-		if (folio_more_pages(folio, xas.xa_index, ULONG_MAX)) {
-			xas.xa_index++;
-			folio_ref_inc(folio);
-			goto again;
-		}
-		continue;
-put_page:
-		folio_put(folio);
-retry:
-		xas_reset(&xas);
-	}
-	rcu_read_unlock();
-	return ret;
-}
-EXPORT_SYMBOL(find_get_pages_contig);
-
 /**
  * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
-- 
2.36.1

