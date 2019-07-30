Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46ACA7B4A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfG3U5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:57:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34693 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbfG3U5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:57:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so29382934plt.1;
        Tue, 30 Jul 2019 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsIRGkPWeq5HvTZzTxF/TGZYHjIKFiRIBMhKcsnvtic=;
        b=L70HGCBpUUMrWcTYYa1tWt0fRX779kjwbp/s6gA95+/zzmpU3IMR+36XPu6QXWYkEz
         GEPYR7mAV3vyjYSmzzWYu6kjt+nQg1Jg4SangC+yzRJwehG6MkWlg16U5uguv1hf3kWq
         9Tqg0UJEIPLTyulc+AA/95D7pCfaH+LelJn5KxT6KTVfpFGLIfvySPSKZsZzkMs9nKuh
         QWj9L9d1BZ5D59hL8WBrevhlL1w7quzW43CxLhBc+4AyG43JuFNBmQt/xX6gXlBUF1zH
         xpHnUvhHUuhY3ZdNfG7F8rbdZ5KLVsX0Zf+N41sRw4UH+rRhS++YLT9LEFo089KwaEs6
         02wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsIRGkPWeq5HvTZzTxF/TGZYHjIKFiRIBMhKcsnvtic=;
        b=BNDDyNpWM8RqVFjZU7vHTTOgLoE2xN/PSxuHQqNyd58sqDtSY3A76C+aHKjMzbBTjm
         srHzqGjl1wjYTWA5MlZRBgz/A1FbjseEAzjN7nvbPCJTDNvDW+irk5QcC+/+KKGABXL6
         xfzTMka8UVZFlN6hK+2FeVdtpLSg3ZaB21cuaAe+Sn4Gae2aRc/wEQwutErP6r/U0Ets
         lKb7bCWxGCefz9xyMLEFGhvtsYGorJLsQQm666GER88Lb45pVrdQQSAsAXL8pJ6jpqfU
         i/ZLwELGO57hdipV2Bvr2DNQd7HOHklwemZqlxJb+MNvc80PDgtVkXEUxBwkHFJD8HT6
         cDJw==
X-Gm-Message-State: APjAAAXRnXqC4UvTsJM+chLgWpcHpnsKU1RKmyaIIAIOz/1qrwN8/ETe
        q7/mm94zhSamBeVNFi9e+UQ=
X-Google-Smtp-Source: APXvYqyy6VjZJUb9Skq0KrIp0ivrFjlnCTe9JAlvBAw+0GWE4YicDO+sW1ZwlcZNdADtE6J1EDk0/A==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr114922168plb.26.1564520231026;
        Tue, 30 Jul 2019 13:57:11 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 137sm80565678pfz.112.2019.07.30.13.57.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 13:57:10 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 2/3] drivers/gpu/drm/via: convert put_page() to put_user_page*()
Date:   Tue, 30 Jul 2019 13:57:04 -0700
Message-Id: <20190730205705.9018-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730205705.9018-1-jhubbard@nvidia.com>
References: <20190730205705.9018-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Also reverse the order of a comparison, in order to placate
checkpatch.pl.

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/drm/via/via_dmablit.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/via/via_dmablit.c b/drivers/gpu/drm/via/via_dmablit.c
index 062067438f1d..b5b5bf0ba65e 100644
--- a/drivers/gpu/drm/via/via_dmablit.c
+++ b/drivers/gpu/drm/via/via_dmablit.c
@@ -171,7 +171,6 @@ via_map_blit_for_device(struct pci_dev *pdev,
 static void
 via_free_sg_info(struct pci_dev *pdev, drm_via_sg_info_t *vsg)
 {
-	struct page *page;
 	int i;
 
 	switch (vsg->state) {
@@ -186,13 +185,8 @@ via_free_sg_info(struct pci_dev *pdev, drm_via_sg_info_t *vsg)
 		kfree(vsg->desc_pages);
 		/* fall through */
 	case dr_via_pages_locked:
-		for (i = 0; i < vsg->num_pages; ++i) {
-			if (NULL != (page = vsg->pages[i])) {
-				if (!PageReserved(page) && (DMA_FROM_DEVICE == vsg->direction))
-					SetPageDirty(page);
-				put_page(page);
-			}
-		}
+		put_user_pages_dirty_lock(vsg->pages, vsg->num_pages,
+					  (vsg->direction == DMA_FROM_DEVICE));
 		/* fall through */
 	case dr_via_pages_alloc:
 		vfree(vsg->pages);
-- 
2.22.0

