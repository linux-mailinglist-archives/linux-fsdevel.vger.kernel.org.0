Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1595A59619A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiHPRyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiHPRxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B0B80EA4;
        Tue, 16 Aug 2022 10:53:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so9892180pls.4;
        Tue, 16 Aug 2022 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/CfNnOMJk6G65551bZckVmJ3kjJ/k4Yc+qvoAg65GHU=;
        b=kqIejtorBX4FPW47cUeP/ByJWQrYcj2ywHGo1YwUpKu3wlfgwOtH92PDuSGWsSr0nC
         SyaGY3GrNkDx25FDJPPQWuoQGGYTz+T/RQ/YGQokcrzuV/lGrTyIu2XsSjU0eLIkyu8R
         wA915ZmTNXVqBC13s6yt6NusLaeqy3Ri6jn5WxqH9mt0LbtYnY/4Auiks7IDIfTzjAw6
         jMkAarr30hWP/fHq03/hXSuZBHRSKOkjOkBqXz12EehkRA4uZ4TqOdDFQ8KUeg7LMgi1
         ZeH8HR8m4hK7VBBRkXiakq+KH0S1fV8B96ZdcNh9yDU/3Nn3++VacUTVJveG+6hPMoL5
         rVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/CfNnOMJk6G65551bZckVmJ3kjJ/k4Yc+qvoAg65GHU=;
        b=MPBORTKNyPvevKhSl9zPNBMkNDsnwoDkzFJNYW41e+d5QnShQk0oEVFVlSXiIShrXi
         N3D44+4ZfAuGYif6Az8dGXiGmmaXYfoJXkqOTtvFHAP5h9t1emH4YO/+AAVD2nnp60Me
         ImgJB71md1l0WhrqCMd2/qAzy35B4yXG5lvbLXWJmVS8ZQFBAvqdrGlRmdYLjz84QdQZ
         AibZcG2MxgmBLP7rdRX2dJ2ujsn/tu3TnKnKlR7GegN/k/E873H3l4ZFMMVAeGHVPRiX
         F0NukRqqWitBgBVpvc/yIyPbnas6ifhqfsy6Ry0OynY/vWggAmJaBYQBpaDpagTn8859
         PRuQ==
X-Gm-Message-State: ACgBeo3CkXMlFFKSPx178Q1Grx0D8dYMUBOYgMpWiYbvmQiOA/qF8I/g
        mbbIfbDv+cCDoqtMHHwj6lF85NfPPY8PjqS8
X-Google-Smtp-Source: AA6agR6KWskv5w3DSEJDue1RncLYUny5eN3qY42Nd7sluyseRT6JQY3OH6l7hMcINwYDTG2mrRERaw==
X-Received: by 2002:a17:903:481:b0:172:715f:69d9 with SMTP id jj1-20020a170903048100b00172715f69d9mr9791577plb.5.1660672418478;
        Tue, 16 Aug 2022 10:53:38 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:37 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 7/7] filemap: Remove find_get_pages_contig()
Date:   Tue, 16 Aug 2022 10:52:46 -0700
Message-Id: <20220816175246.42401-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220816175246.42401-1-vishal.moola@gmail.com>
References: <20220816175246.42401-1-vishal.moola@gmail.com>
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
index 951936a2be1d..a04a645b64e9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -722,8 +722,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
-unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
-			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 8167bcc96e37..af5a4b5f866d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2269,66 +2269,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
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

