Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55E4C5A3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 10:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiB0Jf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 04:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiB0JfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:35:24 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12183AA70;
        Sun, 27 Feb 2022 01:34:47 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h13so10137255qvk.12;
        Sun, 27 Feb 2022 01:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItEq05ZSN1A4hvZTi4QQudlRbzhu6qS+hrN6bdKB7cI=;
        b=PZBjPgxyjRX0Or72xti11PNZ7haqtTUPt+l6GSVDIjPZvvHFsuzjj7D3LZpd2dlpuI
         QDBarJXEQFKVIDhBbsFsDTJyelJD1y+jkqX4QIJBbstGPEW9bNw3Mhxz2Sik5EOa4Vap
         1Y9yLi5/mhlvOIJws68gsbtd9FOSaFcfZPIZzZe56mv7cJ5I1xpv2K/+kRldOPg5pFfy
         fp1XHYBBzolf8lr3/PZ9ccGYD+Et5/folofDnHM/8wny4qSLItKGNhYaeSkRR1F0h3RS
         TLQ+YwNORWbEjLneJOR03aiX2RAeaRgvo6Iw5rkoztgQICzpVEs9hhgA89D1X0DA80Xj
         zWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItEq05ZSN1A4hvZTi4QQudlRbzhu6qS+hrN6bdKB7cI=;
        b=24BPCDW5LAf3sgvDHimQMo86PKtsXjjUSgCrUmmTT+QqcFyq0qHczfsTA/rN1O0fXN
         NuftRmXhE0O5wnyJ+81ZmNIhipOEoMQ7vaOQ6tFnCTo3pn0aXzwZkJPZdBkXt/F8YpjV
         bixB6/cqDRA56UfW93Iix8qvJSK2fn+EJOFkK0ORvKfW+2r08Xnolb0YRHkq5FtpahBZ
         T+O8w1PYHTinrNC+fOcxIfuWI+CyMKvkBdqIyecPwmHflSm/af+iJZJb3OK1qNWvnNAD
         qtBgV2jCVZ72wSyH+tHP6f2QZ/5h1pf8kMx4bit90XKdQSxUGT2aMkgpAK7kBvgtRXNc
         AO0w==
X-Gm-Message-State: AOAM533MP3RZ5FsjVMdCfWGqCWRusnxcPRXX9q6pxyepwsAfMxoMhLAi
        syMW3DgLpgAYJwdXa82GqLk=
X-Google-Smtp-Source: ABdhPJzG6l0z2OorcknGPNxVbjfzbPk10PdLFwWxQT69r0yaHLiCk0a02692yrZUIxBpFRCVItUsNg==
X-Received: by 2002:a05:6214:4103:b0:42d:7ad0:44ff with SMTP id kc3-20020a056214410300b0042d7ad044ffmr10910530qvb.42.1645954486813;
        Sun, 27 Feb 2022 01:34:46 -0800 (PST)
Received: from sandstorm.attlocal.net (76-242-90-12.lightspeed.sntcca.sbcglobal.net. [76.242.90.12])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm469815qtk.91.2022.02.27.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:34:46 -0800 (PST)
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
Subject: [PATCH 2/6] iov_iter: new iov_iter_pin_pages*(), for FOLL_PIN pages
Date:   Sun, 27 Feb 2022 01:34:30 -0800
Message-Id: <20220227093434.2889464-3-jhubbard@nvidia.com>
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

Provide two new specialized routines that only handle user space pages,
and invoke pin_user_pages_fast() on them: iov_iter_pin_pages() and
iov_iter_pin_pages_alloc().

This allows subsequent patches to convert various callers of
iov_iter_get_pages*(), to the new calls, without having to attempt a
mass conversion all at once.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/uio.h |  4 +++
 lib/iov_iter.c      | 78 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..208020c2b75a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -236,6 +236,10 @@ ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
+ssize_t iov_iter_pin_pages(struct iov_iter *i, struct page **pages,
+			size_t maxsize, unsigned int maxpages, size_t *start);
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i, struct page ***pages,
+			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..e64e8e4edd0c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1560,6 +1560,41 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages);
 
+ssize_t iov_iter_pin_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned int maxpages,
+		   size_t *start)
+{
+	size_t len;
+	int n, res;
+
+	if (maxsize > i->count)
+		maxsize = i->count;
+	if (!maxsize)
+		return 0;
+
+	WARN_ON_ONCE(!iter_is_iovec(i));
+
+	if (likely(iter_is_iovec(i))) {
+		unsigned int gup_flags = 0;
+		unsigned long addr;
+
+		if (iov_iter_rw(i) != WRITE)
+			gup_flags |= FOLL_WRITE;
+		if (i->nofault)
+			gup_flags |= FOLL_NOFAULT;
+
+		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
+		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		res = pin_user_pages_fast(addr, n, gup_flags, pages);
+		if (unlikely(res <= 0))
+			return res;
+		return (res == n ? len : res * PAGE_SIZE) - *start;
+	}
+
+	return -EFAULT;
+}
+EXPORT_SYMBOL(iov_iter_pin_pages);
+
 static struct page **get_pages_array(size_t n)
 {
 	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
@@ -1696,6 +1731,49 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc);
 
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	struct page **p;
+	size_t len;
+	int n, res;
+
+	if (maxsize > i->count)
+		maxsize = i->count;
+	if (!maxsize)
+		return 0;
+
+	WARN_ON_ONCE(!iter_is_iovec(i));
+
+	if (likely(iter_is_iovec(i))) {
+		unsigned int gup_flags = 0;
+		unsigned long addr;
+
+		if (iov_iter_rw(i) != WRITE)
+			gup_flags |= FOLL_WRITE;
+		if (i->nofault)
+			gup_flags |= FOLL_NOFAULT;
+
+		addr = first_iovec_segment(i, &len, start, maxsize, ~0U);
+		n = DIV_ROUND_UP(len, PAGE_SIZE);
+		p = get_pages_array(n);
+		if (!p)
+			return -ENOMEM;
+		res = pin_user_pages_fast(addr, n, gup_flags, p);
+		if (unlikely(res <= 0)) {
+			kvfree(p);
+			*pages = NULL;
+			return res;
+		}
+		*pages = p;
+		return (res == n ? len : res * PAGE_SIZE) - *start;
+	}
+
+	return -EFAULT;
+}
+EXPORT_SYMBOL(iov_iter_pin_pages_alloc);
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-- 
2.35.1

