Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09204615117
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKARx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiKARx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:53:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896D1C43D;
        Tue,  1 Nov 2022 10:53:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id io19so14255135plb.8;
        Tue, 01 Nov 2022 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL8HvCZz9dSb2yNioMucyaNDmIRb4Dn4rkrcpThzugo=;
        b=N/5n/6/dEchQiUPQn4ILuSW0qhF4oGND1gECuxKepZ/5xh2x6iJagwhf8ZnLvpfb5n
         IVKFjbTElEwjtCFiWWomqbCdrTL3jxyfcNfmRkFWGrNBalcxZUeq4pL1RgDghi9aVAxj
         /rBag8qMIA8cBJK2PiR1fgcp3PUUBxjs3MRdhBTyQFOs+mWiigk5zpa6U5KKjwZj7AVd
         x9MjxtqOYf4K134z7WyeIXb9KnKVYNvTDRnTF0yd/edBvbLzTY+UgjSwpPRu6JZ38L0g
         9qSW/FKlxyBMVc3RKpBMksYuJpScfFAGLcFavweU4t1PzF4PfCi2CRnmLc+anngs8yRJ
         bT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL8HvCZz9dSb2yNioMucyaNDmIRb4Dn4rkrcpThzugo=;
        b=WuO5gPpmYlAWJz+o3EN+WL9yzTVFsB70N8Zls5iSAOTFYuvr1VQl2+/oGB7LofX9ek
         EdDim3N6g8BlPq7CJESIdqCE/mOTP/D0f759DeVd+EIPVd34aT0/mY2IKVDSW0HLLHx0
         bOi4AeMYHW+375nnPi8wN6yuV4+41kcKLhNluxdsr1gild5dj1HZ7hwZaQ5jt1Z+56EN
         VySmN0HjivC2pvjKyc/DuyAgRmD+n3Vc56J7OMiPEmeMhmT9E50Qpjnj1m/jRtgEcA5A
         RuuPef/1zfO484TN0EbuU86P2uLzBRXAPRwtcq67sGQZFM4lRNtOiA7F7+CHexHzC01a
         OrPQ==
X-Gm-Message-State: ACrzQf0Su0g1I50I16eQNe4JDWWknEVAVN6m5yszd092ONHhPg7S0LgO
        PUI/pI79sMl1l+WC/O5oPF/niZOF03VJ0A==
X-Google-Smtp-Source: AMsMyM6C1f+mV994BjbsV8kHe2UGkzBklv03r5VTJO+o24yiXYT9etxuz+hC6lPxfT1+bQnnM3TC4A==
X-Received: by 2002:a17:90b:3b44:b0:213:34f7:facb with SMTP id ot4-20020a17090b3b4400b0021334f7facbmr38966874pjb.150.1667325234783;
        Tue, 01 Nov 2022 10:53:54 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id e26-20020a056a0000da00b0056b9124d441sm6797987pfj.218.2022.11.01.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:53:54 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, miklos@szeredi.hu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/5] fuse: Convert fuse_try_move_page() to use folios
Date:   Tue,  1 Nov 2022 10:53:23 -0700
Message-Id: <20221101175326.13265-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101175326.13265-1-vishal.moola@gmail.com>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
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

Converts the function to try to move folios instead of pages. Also
converts fuse_check_page() to fuse_get_folio() since this is its only
caller. This change removes 15 calls to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/fuse/dev.c | 55 ++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 26817a2db463..204c332cd343 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -764,11 +764,11 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 	return ncpy;
 }
 
-static int fuse_check_page(struct page *page)
+static int fuse_check_folio(struct folio *folio)
 {
-	if (page_mapcount(page) ||
-	    page->mapping != NULL ||
-	    (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
+	if (folio_mapped(folio) ||
+	    folio->mapping != NULL ||
+	    (folio->flags & PAGE_FLAGS_CHECK_AT_PREP &
 	     ~(1 << PG_locked |
 	       1 << PG_referenced |
 	       1 << PG_uptodate |
@@ -778,7 +778,7 @@ static int fuse_check_page(struct page *page)
 	       1 << PG_reclaim |
 	       1 << PG_waiters |
 	       LRU_GEN_MASK | LRU_REFS_MASK))) {
-		dump_page(page, "fuse: trying to steal weird page");
+		dump_page(&folio->page, "fuse: trying to steal weird page");
 		return 1;
 	}
 	return 0;
@@ -787,11 +787,11 @@ static int fuse_check_page(struct page *page)
 static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 {
 	int err;
-	struct page *oldpage = *pagep;
-	struct page *newpage;
+	struct folio *oldfolio = page_folio(*pagep);
+	struct folio *newfolio;
 	struct pipe_buffer *buf = cs->pipebufs;
 
-	get_page(oldpage);
+	folio_get(oldfolio);
 	err = unlock_request(cs->req);
 	if (err)
 		goto out_put_old;
@@ -814,35 +814,36 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (!pipe_buf_try_steal(cs->pipe, buf))
 		goto out_fallback;
 
-	newpage = buf->page;
+	newfolio = page_folio(buf->page);
 
-	if (!PageUptodate(newpage))
-		SetPageUptodate(newpage);
+	if (!folio_test_uptodate(newfolio))
+		folio_mark_uptodate(newfolio);
 
-	ClearPageMappedToDisk(newpage);
+	folio_clear_mappedtodisk(newfolio);
 
-	if (fuse_check_page(newpage) != 0)
+	if (fuse_check_folio(newfolio) != 0)
 		goto out_fallback_unlock;
 
 	/*
 	 * This is a new and locked page, it shouldn't be mapped or
 	 * have any special flags on it
 	 */
-	if (WARN_ON(page_mapped(oldpage)))
+	if (WARN_ON(folio_mapped(oldfolio)))
 		goto out_fallback_unlock;
-	if (WARN_ON(page_has_private(oldpage)))
+	if (WARN_ON(folio_has_private(oldfolio)))
 		goto out_fallback_unlock;
-	if (WARN_ON(PageDirty(oldpage) || PageWriteback(oldpage)))
+	if (WARN_ON(folio_test_dirty(oldfolio) ||
+				folio_test_writeback(oldfolio)))
 		goto out_fallback_unlock;
-	if (WARN_ON(PageMlocked(oldpage)))
+	if (WARN_ON(folio_test_mlocked(oldfolio)))
 		goto out_fallback_unlock;
 
-	replace_page_cache_folio(page_folio(oldpage), page_folio(newpage));
+	replace_page_cache_folio(oldfolio, newfolio);
 
-	get_page(newpage);
+	folio_get(newfolio);
 
 	if (!(buf->flags & PIPE_BUF_FLAG_LRU))
-		lru_cache_add(newpage);
+		folio_add_lru(newfolio);
 
 	/*
 	 * Release while we have extra ref on stolen page.  Otherwise
@@ -855,28 +856,28 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (test_bit(FR_ABORTED, &cs->req->flags))
 		err = -ENOENT;
 	else
-		*pagep = newpage;
+		*pagep = &newfolio->page;
 	spin_unlock(&cs->req->waitq.lock);
 
 	if (err) {
-		unlock_page(newpage);
-		put_page(newpage);
+		folio_unlock(newfolio);
+		folio_put(newfolio);
 		goto out_put_old;
 	}
 
-	unlock_page(oldpage);
+	folio_unlock(oldfolio);
 	/* Drop ref for ap->pages[] array */
-	put_page(oldpage);
+	folio_put(oldfolio);
 	cs->len = 0;
 
 	err = 0;
 out_put_old:
 	/* Drop ref obtained in this function */
-	put_page(oldpage);
+	folio_put(oldfolio);
 	return err;
 
 out_fallback_unlock:
-	unlock_page(newpage);
+	folio_unlock(newfolio);
 out_fallback:
 	cs->pg = buf->page;
 	cs->offset = buf->offset;
-- 
2.38.1

