Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013736F4DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 01:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjEBX4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEBX4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 19:56:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF030E2
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 16:56:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-556011695d1so75245257b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 16:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683071767; x=1685663767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIxhAVAgYS5mapIdI8ZTL33+hofUrDA3Fj2JnyUnXTo=;
        b=dNZZa0LeBYDZrFKtDX5qs0Huzpekye+DGENcdzJGQDDEmBIXmSv36HWyWunH74mYvv
         IYPkV9Yol53BLGWLbst9q5taC4QG822qYbdKdjNOZLs5p2TJmEPhbjh66IcJTvBUA5SP
         kUPBtZngsyGsJXYWzbuqy/qAcQIPsfW6qYuE6xxKyYqL6ThrIh2fNwHEeRKouUsYon2A
         mRtSyLBzArQDmBie63b74T6C2w2V0kJcF5RAHMQ5ytpNzPR7bzzivdKenxaQveRH8kfk
         76sucra8VLmAZHJqkCPmWEHri4ZaUVqTJhTvZT50Xvoa8ThsdZG2UvcJP9ETia91jzUg
         aWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071767; x=1685663767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIxhAVAgYS5mapIdI8ZTL33+hofUrDA3Fj2JnyUnXTo=;
        b=OfSFE8FH9Gf5t6XwgmNCb/BiZqYqOVYIWM1sPFjYlzAI9esBF/phvImdGXcgXHkCYE
         N8ai73Nksp/3kPTTlKWUa2rjMSHgMx84GG7pYbKtz9nJieQFbDTQQJ78n++zLYWOWVf0
         rj593eoVR+6qvAK+QEHTizEyhZV6xBlzB2egk5yhqQQDasCUKrRZyB9m0nWK6zwjvg91
         p6VhvcKTkpTqbguHUaq1XfwhoxMVyn01A3deNevfhhKnHCO+sCvMo2W5LFuQBNjaJvf2
         Fo7taAX1pYuiKIu2EQU+fVtgVphsSVpwXqD8lpGsqbQ1/Gb8AGZxUYtoK4cY+pK8dR7r
         NuRg==
X-Gm-Message-State: AC+VfDysXbmrh82SYRJ0mlozK8xy8uzpee6TJWl2nMU7u1DfuLhbqmLd
        lkGbnQ6BLzd0H6HjiMR99J0K7hvaSAOADcSy/Q==
X-Google-Smtp-Source: ACHHUZ4q9/YhcCBGN0gQnRI8Ol1Z4ZZs3Rm5jmAnbsCWwCheFAJAc64ACgZuO2mDTRSg0K7U9fnxqYL2vTo7g2S1Ng==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a81:7653:0:b0:54f:a60c:12eb with SMTP
 id j19-20020a817653000000b0054fa60c12ebmr10693783ywk.1.1683071767464; Tue, 02
 May 2023 16:56:07 -0700 (PDT)
Date:   Tue,  2 May 2023 23:56:02 +0000
In-Reply-To: <cover.1683069252.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1683069252.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <98624c2f481966492b4eb8272aef747790229b73.1683069252.git.ackerleytng@google.com>
Subject: [PATCH 1/2] mm: filemap: Add filemap_has_folio function
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        jhubbard@nvidia.com
Cc:     vannapurve@google.com, erdemaktas@google.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_has_folio() will return whether there is a folio at a given
index in a mapping. This function does not affect the folio refcount.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..e49f07cdbff7 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -508,6 +508,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
 
+bool filemap_has_folio(struct address_space *mapping, pgoff_t index);
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..a7a6e229e33d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1835,6 +1835,23 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  * folio_put().
  */
 
+/**
+ * filemap_has_folio - Check if filemap has a folio at given index
+ * @mapping: The address_space to search.
+ * @index: The page index.
+ *
+ * Unlike filemap_get_entry, this does not increment refcount of the folio.
+ *
+ * Return: true if folio exists else false.
+ */
+bool filemap_has_folio(struct address_space *mapping, pgoff_t index)
+{
+	void *entry = xa_load(&mapping->i_pages, index);
+
+	return entry && !xa_is_value(entry);
+}
+EXPORT_SYMBOL(filemap_has_folio);
+
 /*
  * filemap_get_entry - Get a page cache entry.
  * @mapping: the address_space to search
-- 
2.40.1.495.gc816e09b53d-goog

