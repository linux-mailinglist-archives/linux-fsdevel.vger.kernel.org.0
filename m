Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8A45AA24C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiIAWEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiIAWDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:03:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3404B9412D;
        Thu,  1 Sep 2022 15:02:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj6so280589pjb.1;
        Thu, 01 Sep 2022 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
        b=GtrGYdGLszgBq1fvi5V2PSfoLOXh1TNyiK0ofvUFGiVvwdQ6PkaGy3Ns4qJwLgF4b3
         aIYdrsYMX+clX1Y+yOXcuDls8w+WiavI/64KPDiJmDgxyBZ4dAulShvhPc4ENInwd3Br
         cmukOGKll48ywyFlU3xTzvvA/EhYiy85fvbJiJhltWdFBrenWV2xIc1tgrmQTV6xVFrr
         kPWQoFcSoXWz75f58hl6lYhesgfwr3gasm4nlqUw3/vIqwimOmHoTKvTQsLxit2YTq1H
         EGgbgkZ8lcymg9dX7HeYXgo7ygr9E+FPEd+ZGk8VSDrPOWMvOyx7zdOCyAyIqsvEGW5B
         7Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YET10ng1nR0ea8GMjh+/irz/Zcx26qfqc4LRuHlkdsg=;
        b=K2UjfDsIFIH9CdDJvhMIxAXe4nuF0KXe5+5sI1x68ShfsMRrr3RSxO6GZ7viOdQusq
         doF4UcFsJpx6+OPPeM/GsBd0LTOKOp9vKfYVivCJHdu7ys6DVxDtDCsuts7e+YITOlii
         Akwr55gdEKnkiEdO8kgb5bGEvvRNjx5j74izm9MggD5k9nC3HEody9BuGSt603ZKlgo7
         JLa/CXJePptTwjHsNICn9UYmMeQRfWDQA5ICy4u/gYSsk13gL/3uGu1/RAM/IJ/1o9yl
         PjCIzk8jMBGCevHolya8UXVVePuhOSxYxkjwzf6q5Zh5guX0Osyq8SuifWFz8nq0A/TU
         MMNw==
X-Gm-Message-State: ACgBeo2HjNObG4UoDtGaMl7ALZ5pz1Xgcxr+NfzNvOrz/OfNpGpar7jS
        7kIInXNDVoQy4XDyI1wp1QRoxQkcjFTsDg==
X-Google-Smtp-Source: AA6agR7dfnvwb+YDcWYBRWPejd1+fbHl6FDcd6aRRcb1reei6qT56P411IPlU9pH3GjxRMm/z5BQBg==
X-Received: by 2002:a17:902:c613:b0:174:7a32:f76 with SMTP id r19-20020a170902c61300b001747a320f76mr24825305plr.165.1662069767428;
        Thu, 01 Sep 2022 15:02:47 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:47 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:24 -0700
Message-Id: <20220901220138.182896-10-vishal.moola@gmail.com>
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

