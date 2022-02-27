Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F394C5A42
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 10:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiB0Jf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 04:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiB0JfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:35:21 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C968D3AA66;
        Sun, 27 Feb 2022 01:34:45 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j5so10129760qvs.13;
        Sun, 27 Feb 2022 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zKcW8+9Hpd8/WTuKX6kJj19EN0eRYxV6CdPpWTMmWo=;
        b=WOpg9gTO+cqDSlxgj/J7GtxzOfHFwviptZSNq675orbTb9EQJUNbTVROPdbRthWEoM
         Va3EvQ4DJDb8avmBXaWeHbUlEPC25Ikg0lkKu5AE0MNDJypAR4SCaVcamSLf0CSBEZUp
         uRAT1yERfWo6RlRtiepDJN/F0I5lbFwz1pnWyJSNvJiZIxKftwJ4Dk2YRqzR74Cx1VTa
         OOPvCVOfubSkaSQxAMpXLQTkJHqnRTVy5v5WaMXw1JK/rQbwW1Zng1Mc8rVNmfyYSnfz
         1BhBRQ9Xvbb1dVXccO7+B31VNQ4ZWU6knxSwFOWUT2PnH+jL/APNRaedSB05aG1fxw9H
         /kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zKcW8+9Hpd8/WTuKX6kJj19EN0eRYxV6CdPpWTMmWo=;
        b=zQ9xPjdpUhfuqwgD/rp0wGJzG539NeVf5/92K5JQlPPtMYYOHjlmLG8S8cuPQZbObe
         GlQtcN2sXr1fbQUc/Y3o3Yz+ZHn9wwhqiBIvg1BDrV6GM7XdOJoi0CBpE6q2X8Vg8sc6
         yhIi7F62jeuav42uUODO4ZswB5QugPPNFDEkD6BxefNjKW3TiJzHZMj3nh6zbE46dVDL
         tAZo9aDipc+XhrcJsrU9rUZAEE7pUFqaOXaHQGWalLUSS0t+UxLuE89rll+iz/8lZiyF
         wmb4817iCsN9NL2VEOBbh2358QMNJGSSaq88Iq9mjQlFlXFoREky+SH+t0ubQMXFE6wb
         Pf3Q==
X-Gm-Message-State: AOAM530tr1rtMryMvqo1OZGlyXyN/0fa3DpqiDJ0dhyFBWxP0asGo3/A
        kUGgNodTS3mqaJv6U89WE/A=
X-Google-Smtp-Source: ABdhPJwxsNO0VkI2Q6Rc/EsJGY48OCvFsl8Tm4nrId2YTjceZIBaohJzw61Max1v1+ry2LTsRNF0rw==
X-Received: by 2002:ad4:5561:0:b0:432:bbc0:8d5d with SMTP id w1-20020ad45561000000b00432bbc08d5dmr8783186qvy.105.1645954484945;
        Sun, 27 Feb 2022 01:34:44 -0800 (PST)
Received: from sandstorm.attlocal.net (76-242-90-12.lightspeed.sntcca.sbcglobal.net. [76.242.90.12])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm469815qtk.91.2022.02.27.01.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:34:44 -0800 (PST)
From:   jhubbard.send.patches@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/6] mm/gup: introduce pin_user_page()
Date:   Sun, 27 Feb 2022 01:34:29 -0800
Message-Id: <20220227093434.2889464-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227093434.2889464-1-jhubbard@nvidia.com>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

pin_user_page() is an externally-usable version of try_grab_page(), but
with semantics that match get_page(), so that it can act as a drop-in
replacement for get_page(). Specifically, pin_user_page() has a void
return type.

pin_user_page() elevates a page's refcount is using FOLL_PIN rules. This
means that the caller must release the page via unpin_user_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9bada4096ac..367d7fd28fd0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1946,6 +1946,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
 			    struct vm_area_struct **vmas);
+void pin_user_page(struct page *page);
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
 		    struct vm_area_struct **vmas);
diff --git a/mm/gup.c b/mm/gup.c
index 428c587acfa2..13c0dced2aee 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3035,6 +3035,40 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(pin_user_pages);
 
+/**
+ * pin_user_page() - apply a FOLL_PIN reference to a page ()
+ *
+ * @page: the page to be pinned.
+ *
+ * Similar to get_user_pages(), in that the page's refcount is elevated using
+ * FOLL_PIN rules.
+ *
+ * IMPORTANT: That means that the caller must release the page via
+ * unpin_user_page().
+ *
+ */
+void pin_user_page(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
+
+	/*
+	 * Similar to try_grab_page(): be sure to *also*
+	 * increment the normal page refcount field at least once,
+	 * so that the page really is pinned.
+	 */
+	if (folio_test_large(folio)) {
+		folio_ref_add(folio, 1);
+		atomic_add(1, folio_pincount_ptr(folio));
+	} else {
+		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+	}
+
+	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+}
+EXPORT_SYMBOL(pin_user_page);
+
 /*
  * pin_user_pages_unlocked() is the FOLL_PIN variant of
  * get_user_pages_unlocked(). Behavior is the same, except that this one sets
-- 
2.35.1

