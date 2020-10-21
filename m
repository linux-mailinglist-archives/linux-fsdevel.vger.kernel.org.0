Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3DD29532D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 21:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440856AbgJUT5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 15:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbgJUT5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:57:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF5BC0613CE;
        Wed, 21 Oct 2020 12:57:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q199so3295865qke.10;
        Wed, 21 Oct 2020 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0YC4BvPBquELqN4U/yt26xXMXATDVMvfJgJXMoN9ZLc=;
        b=JzRhrs9BWFo54og2fzNKayxe9JH5sc6cl1mWPbqnlRWqLhXr0Xq/XHTsQOT6qFYOGs
         DIWo8XMQ4qV3ZaW0HGEa86Q22eeZ33E8UpZXk+7Ns1KYEjfL+K6RQmoqHT6LccIiu1Eo
         Hfd3iNc0zRDRyXZbee0s1s2FoEgcOMqNbznq6jBclCx9vKFMNiNGisa3ssZRLU2jpzxB
         3q3ObZ/EncApGdzANbR5K//epn+dr6lwVqA5VkUeybrCw8ZjFQGJGvoiZk/5x7WaW2Qa
         p52m/wVQ2SipNnFUhrnjWxhdgOkkVFSEfiVv5CFUSe/rT1onh1wW0VqHM1AM+SdfoRm9
         4Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YC4BvPBquELqN4U/yt26xXMXATDVMvfJgJXMoN9ZLc=;
        b=qvw3oHgzhUdka94sbBDapYdjVDhWTH1wGDnSupnK7CSZXSZKh7vMf9Mo1AL/fzly7W
         fmAsM+drP46D2mVVguxcTDfOTXGOpyBzPIGimjLmnhF1rLzavraUmeiaEP65J0RlHAbd
         EF09GqJXQs++fDMhLzbcx5ekgMwacrF7+LIGxAtabx5k/i0LOHmQsCjHGlwMOawll8gI
         kDDqsry8NM3G3obwuJdCpE06UTWl0WL/KPRMRGzLAMZ4N92fUmPrj1elxwrcHRkaqda7
         sTgvZbTIJJ11iponPAx8pfpt9LxjQKhAWAHSHvx12ZI5Bt1Gi/znznjCcX5hj3aZHmyv
         s+4A==
X-Gm-Message-State: AOAM531c7XWYPGZTyZRwPPdYlWN/H4xj5nc0pA56neB2TcIsMRIGjMY7
        t58baOnsplM6D9RhP642jshiTDR/o7J9
X-Google-Smtp-Source: ABdhPJxFXEbZzBU8mDHF3y4OF+jDAQZ41i9EYVh5wk8WNBYjX3oOuf8ABwhancXDrGDae2pig2kxnA==
X-Received: by 2002:a37:6285:: with SMTP id w127mr4933366qkb.454.1603310273364;
        Wed, 21 Oct 2020 12:57:53 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id 124sm1867603qkn.47.2020.10.21.12.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:57:52 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 1/2] cifs: convert to add_to_page_cache()
Date:   Wed, 21 Oct 2020 15:57:44 -0400
Message-Id: <20201021195745.3420101-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021195745.3420101-1-kent.overstreet@gmail.com>
References: <20201021195745.3420101-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just open coding add_to_page_cache(), and the next patch will
delete add_to_page_cache_locked().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/cifs/file.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index be46fab4c9..b3ee790532 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4296,20 +4296,11 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 
 	page = lru_to_page(page_list);
 
-	/*
-	 * Lock the page and put it in the cache. Since no one else
-	 * should have access to this page, we're safe to simply set
-	 * PG_locked without checking it first.
-	 */
-	__SetPageLocked(page);
-	rc = add_to_page_cache_locked(page, mapping,
-				      page->index, gfp);
+	rc = add_to_page_cache(page, mapping, page->index, gfp);
 
 	/* give up if we can't stick it in the cache */
-	if (rc) {
-		__ClearPageLocked(page);
+	if (rc)
 		return rc;
-	}
 
 	/* move first page to the tmplist */
 	*offset = (loff_t)page->index << PAGE_SHIFT;
@@ -4328,12 +4319,9 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 		if (*bytes + PAGE_SIZE > rsize)
 			break;
 
-		__SetPageLocked(page);
-		rc = add_to_page_cache_locked(page, mapping, page->index, gfp);
-		if (rc) {
-			__ClearPageLocked(page);
+		rc = add_to_page_cache(page, mapping, page->index, gfp);
+		if (rc)
 			break;
-		}
 		list_move_tail(&page->lru, tmplist);
 		(*bytes) += PAGE_SIZE;
 		expected_index++;
-- 
2.28.0

