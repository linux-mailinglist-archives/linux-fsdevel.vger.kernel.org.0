Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2715B6085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiILS0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiILSZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:25:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62E1C118;
        Mon, 12 Sep 2022 11:25:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so9382856plz.7;
        Mon, 12 Sep 2022 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
        b=CMK8yl635va04HaezlxwqGhnc+NtummcvVNmTRj+Aw0HdTOOjXrLWIHc/0WvZVthz9
         bzWNt4H/6kQaZG8pah0JB/zkRrjO2mSmUA4YdG+oM60f4pwLDpVOwTiFSDJmLRBSSkqW
         EEW2Wo57bBwPulyzdO9DrvL55rSoSkqNNPVgL8G8YFmqICIR1UW6FDiPSgv2lsM+Q0m6
         /oU7NxbfHNZ8dpXgDc+YLPWC34LYvTWZ2BfNI54J83f2NzdnRxeNf+B0Hi7YTy4uPL/r
         upU0ewURmuwmSgNW8yL4rSBCTkMXuY32/p+GZ9IWURvmoFbJFCIyPmyZRHOiuWFLgtsj
         nOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
        b=pjRzC42RR7YG7dfYiFIxNadIG/qar3ZIWrTicKzyMoLmgytTfM9Qh+8SWK+v3Kw+v7
         XpJNaXbDvYv270gO6k9CKay0WKc7zdFgZW8NB3OFi/u9ul+1yExfOrUBAKRTI68qKWda
         zcBO2atX03Dl1fBl6T75iRztD57EdK86h54I5YOm8MSkwwTfe5wrXczV4VcfkW97F53I
         OvB8lWYJrzLQ+qhrHoHOcUiXal4autK3rEsfEJRguWKuNMJNTkEJ/DUOcMe0Li8PvmAu
         LzlR8lb9PsLJ3TDNqeHco1oL6Xcfk/4DCSLRCq05iuaZZtGeSe0OnPB8+qxVXykQ960W
         a1Sw==
X-Gm-Message-State: ACgBeo0PE85UlI3BAcQMTwPNrxy+6ppLp48C0EAXjhU4ohp8v+4pvPP6
        xNjx+gZGA00KNzMzplO7IsbfbtuTX7pdTQ==
X-Google-Smtp-Source: AA6agR7XZwnzw2DppXNHM2jt00EgZHgdqYAADme8SoBB2ov63KPo6ZhrqFFvSytcKiLABstme34owQ==
X-Received: by 2002:a17:90a:6783:b0:1fd:ab56:5af7 with SMTP id o3-20020a17090a678300b001fdab565af7mr25916929pjj.39.1663007136527;
        Mon, 12 Sep 2022 11:25:36 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:36 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:10 -0700
Message-Id: <20220912182224.514561-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
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

Convert function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). Now also supports the use of large
folios.

Since tofind might be larger than the max number of folios in a
folio_batch (15), we loop through filling in wdata->pages pulling more
batches until we either reach tofind pages or run out of folios.

This function may not return all pages in the last found folio before
tofind pages are reached.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/cifs/file.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index fa738adc031f..c4da53b57369 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2517,14 +2517,41 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
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
+		if (++*found_pages == tofind) {
+			folio_batch_release(&fbatch);
+			goto out;
+		}
+		if (++idx < p) {
+			folio_ref_inc(folio);
+			goto add_more;
+		}
+	}
+	folio_batch_release(&fbatch);
+	goto again;
+out:
 	return wdata;
 }
 
-- 
2.36.1

