Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16588277F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 00:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfHEWUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 18:20:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbfHEWUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:20:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so37019096plt.1;
        Mon, 05 Aug 2019 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5i3Rg5kn+067MlNxvjupwCb7OvZHoHIUYxhc992JlI=;
        b=pKuvlg2hwoarkpfTNR6KpixqG4Wg34fPCZG//9C6ep56sknR9I6vumm0Lj3xNQ1iy7
         An0z5XnlgimFQqRa05txx12NevWhyV2Lb7x7p2vHSDc/vJyL1UMYh04P9z/8PeBlcmof
         KbVsF4kxEcmAWh81dDR0kLUU+u0G+IpIho0ZKDYJ6YObrCosO+58QStFqlNQi3Rqxkwj
         mXW60Rl4Ow9n9Sdcj6VEbxH9m4Ri+EM2o4zS9fB6QgzhPUmrUTRomPfxUofSeQEGClbH
         C3e21QDeVMlfxyNkwOcnJ77HHrUIJvK4WErEgQY92HF4We5BbAHaiz5aLeeZQO3yjwBd
         vyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5i3Rg5kn+067MlNxvjupwCb7OvZHoHIUYxhc992JlI=;
        b=UdScv5nHKQmjLtQFZPKe7e96q2dya7kQYstp0D7/0yvAP6L0uzWSfpw8CZs7GqUTgX
         rWO3HigKH7JVRe7THjM01KeFtrHL4KKnkMG0viTA1CyByocKjsestLgylIeIT589vodm
         XAAqEVnZaHpEGif/zL9jIwwUIiUN3f9mqzlqlBcVd4uwpMuGanfCNa6cd3ktzY/2s5Qa
         TZULpEphkB8w55NLSztbHQi7KeZExDU3Kab1vtqh2JzwfkdIYIL9RgY3oYr3NXdAZ0RC
         U4E+Xm9MMcJFylzgbBiMXpRzEoR8GIyXo77d/D7hHY6fPFIeFnXwgf399QmoJGLjgKtR
         Bg6g==
X-Gm-Message-State: APjAAAXf0rsAT80Krtb86pAsXRpUDEu03pHKSj+YxV2OZ3/hGZfX24yT
        VIbt0hX5ehfwOD7Pf+mp49I=
X-Google-Smtp-Source: APXvYqym5DWO2ynioA/LXqxbhVbEGp7NF1n1NiggZv5NF8aTVSRSKOlyn+2cbWlflhCbI+qCdy/2Cw==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr24420plk.113.1565043623671;
        Mon, 05 Aug 2019 15:20:23 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 185sm85744057pfd.125.2019.08.05.15.20.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 15:20:23 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Rientjes <rientjes@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 2/3] mm/mempolicy.c: convert put_page() to put_user_page*()
Date:   Mon,  5 Aug 2019 15:20:18 -0700
Message-Id: <20190805222019.28592-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805222019.28592-1-jhubbard@nvidia.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
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

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f48693f75b37..76a8e935e2e6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -832,7 +832,7 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
 	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
 	if (err >= 0) {
 		err = page_to_nid(p);
-		put_page(p);
+		put_user_page(p);
 	}
 	if (locked)
 		up_read(&mm->mmap_sem);
-- 
2.22.0

