Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6153281044
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 04:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfHEC0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 22:26:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfHEC0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:26:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so38784853pfq.12;
        Sun, 04 Aug 2019 19:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcnoyc82zBJmK7HyZZ9/xYHIo+nvY1F0Vc3WAAWFXf4=;
        b=bjxN1i855euNnjUnIRlcEX0LvYqx3HxLcGznZolbzXrZ9h2uenhVqHuurr9ZBo0Mdn
         BEsRrms5VOqtu/pZu/TaKYkRFrpT11Va6g+49pLA5OWY+SZ0hMDbYRKwmWmxzMDhbb8f
         GTQVuKdH4sre765l2YwqLwgEj5U5TCxJ11dgPQgtD9/F7nITzsxx1q+K6fPt8AJTwZ51
         SXQT/3NcHGnARj71eCFz2j1ZKbUjtfQuqmAtbXa6juripZelfrT7KMWdgAkVhlhszJJH
         Qh8QWc4/xPlfmZB6bDU1IsGkYlb7ALstwyWPJLnNFIgVmfoptlw3rJFEc3KpcOW6cCi6
         uYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcnoyc82zBJmK7HyZZ9/xYHIo+nvY1F0Vc3WAAWFXf4=;
        b=S0rVlATrvU8RMWzbpL7Xv04NbyuyMvm6YmbevRTA0AHYfiAPPVYty2Sden3le34y7d
         jYJG4/OJ4yCC5Lyosd4gzMRfjWTJB8HwTOaKUnYiHTEGAzA9BbLMEQ845gS8VUFr2fAI
         C+9b1GU7qsml9wbCjo7kvv1//0NyNDSzpSlnVuzAY7UKQsrytCRHeYJj3PeabTC0fmi+
         XtqMGoumeWWtDpqmOKNLjJnYqJc+DKNl934vExR2J5U2IOt8/wDHnbvMH5InsR3mH4+U
         v2AZFVTaNZlatV40yj65HQ+M2EGsXfoDAPWqMpyLZkAWxEj3WcbgzdtJYLLE+MsG8b+B
         lqtQ==
X-Gm-Message-State: APjAAAV3r9DyLFs//17PCzX+TCb6Q4cBWWSE24NzQ2UU4HVupa5FVHyt
        k3YKUca63gEDa0p8IuBoRJI=
X-Google-Smtp-Source: APXvYqz56Uy3OWp9yKpnmoBerTa/QncOG/6somzUXYkyfxRhF/JGW0ZcxzT4FIvpzsPEHyTa4Zvc7A==
X-Received: by 2002:a63:2004:: with SMTP id g4mr128483482pgg.97.1564971989557;
        Sun, 04 Aug 2019 19:26:29 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id s6sm122624067pfs.122.2019.08.04.19.26.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 19:26:29 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] security/tomoyo: convert put_page() to put_user_page*()
Date:   Sun,  4 Aug 2019 19:26:26 -0700
Message-Id: <20190805022626.13291-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
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

Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 security/tomoyo/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 8526a0a74023..6887beecfb6e 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -931,7 +931,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	}
 	/* Same with put_arg_page(page) in fs/exec.c */
 #ifdef CONFIG_MMU
-	put_page(page);
+	put_user_page(page);
 #endif
 	return true;
 }
-- 
2.22.0

