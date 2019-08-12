Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7510F89542
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 03:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfHLBu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 21:50:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36191 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLBu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 21:50:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id g4so785412plo.3;
        Sun, 11 Aug 2019 18:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//FfBrFJF4GgHRR+yYGohW47iWmsEIpsgR4o2CfLEaI=;
        b=n9WdsBYCNshNyrjNwoA988ZTa5cUmZ3ftfo2srk4qVaeFk/3QoLLi5AAHL4AElSmiI
         XuhzXcej3mP/qZgB3XHsGbTfB/yNKw6cCUUIAPQ+5Nz8QE6P37CaiJAF1juYEdwzcQ7x
         KCBBLQdzMFyQAH/huuHEICl517WeOf9evlQYRM6ra2qmGObt90NYEQrc2g3Hrh2Z96nu
         KDGoR5r30ngur4PCtV8FhCZSZwFtTuDq2bAvEGOaEF6xs7+I2IMBDgXvMsOlYXQ02UbB
         3XrvtA2d2QJxWudzhOEkOmMrqZS8v6TJDdTbi1eDdq4ek8o80TJA5b2A6NTjpOCVITJa
         5I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//FfBrFJF4GgHRR+yYGohW47iWmsEIpsgR4o2CfLEaI=;
        b=s1Tqi5Ho9l68qUnJg2DpDM3hCfFgcjt+i4BWmpcWAcbwnXmk0SrjKXI2sYWQLPbR3k
         Z9Sdw14Zknfcw8zi/tExms3m4rxzuqw7CKOePEzaFhP9Yc5zf3Q6AlL6mWh1YiciSGHe
         0hDpP8McVlJuP0+cFMnEMLtY640SHJJn0iIba0IFsVvjaGuYQik887A3IbK8yiFn3rj7
         0xADGp+v0kVBoarO6LxZLpkxcPrb3/FgHz8eCfPBIM9f+XJYRI53hoJhoI+BDMP/g8K2
         WMEdqZC+s6hpnQ5+S8ZtofKJ0j6wm0CLMXdWQUjo2scsE5EaNCNtcFcgSTXGXrnatl2k
         R2MA==
X-Gm-Message-State: APjAAAXC2ep1QKmxmbbK/yDsvSMgd9r8a3w4P+b+VYQxMLxn//f6OUiH
        Dd3HkhNwS9+vWI61CQwAMmqKpDGv
X-Google-Smtp-Source: APXvYqzT/0PLSkZoDJi/ZIzWxvm8QO/lLOlBRLMJ5/ogboYNq/cgR98nTHd4GJwrVGgRFe2BKV9BHg==
X-Received: by 2002:a17:902:b604:: with SMTP id b4mr15581107pls.94.1565574657032;
        Sun, 11 Aug 2019 18:50:57 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id j20sm100062363pfr.113.2019.08.11.18.50.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 18:50:56 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC PATCH 1/2] mm/gup: introduce FOLL_PIN flag for get_user_pages()
Date:   Sun, 11 Aug 2019 18:50:43 -0700
Message-Id: <20190812015044.26176-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190812015044.26176-1-jhubbard@nvidia.com>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

FOLL_PIN is set by vaddr_pin_pages(). This is different than
FOLL_LONGTERM, because even short term page pins need a new kind
of tracking, if those pinned pages' data is going to potentially
be modified.

This situation is described in more detail in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

FOLL_PIN is added now, rather than waiting until there is code that
takes action based on FOLL_PIN. That's because having FOLL_PIN in
the code helps to highlight the differences between:

    a) get_user_pages(): soon to be deprecated. Used to pin pages,
       but without awareness of file systems that might use those
       pages,

    b) The original vaddr_pin_pages(): intended only for
       FOLL_LONGTERM and DAX use cases. This assumes direct IO
       and therefore is not applicable the most of the other
       callers of get_user_pages(), and

    c) The new vaddr_pin_pages(), which provides the correct
       get_user_pages() flags for all cases, by setting FOLL_PIN.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 1 +
 mm/gup.c           | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 90c5802866df..61b616cd9243 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2663,6 +2663,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_ANON	0x8000	/* don't do file mappings */
 #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
+#define FOLL_PIN	0x40000	/* pages must be released via put_user_page() */
 
 /*
  * NOTE on FOLL_LONGTERM:
diff --git a/mm/gup.c b/mm/gup.c
index 58f008a3c153..85f09958fbdc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2494,6 +2494,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
  * being made against.  Usually "current->mm".
  *
  * Expects mmap_sem to be read locked.
+ *
+ * Implementation note: this sets FOLL_PIN, which means that the pages must
+ * ultimately be released by put_user_page().
  */
 long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
 		     unsigned int gup_flags, struct page **pages,
@@ -2501,7 +2504,7 @@ long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
 {
 	long ret;
 
-	gup_flags |= FOLL_LONGTERM;
+	gup_flags |= FOLL_LONGTERM | FOLL_PIN;
 
 	if (!vaddr_pin || (!vaddr_pin->mm && !vaddr_pin->f_owner))
 		return -EINVAL;
-- 
2.22.0

