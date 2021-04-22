Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E38367649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbhDVAiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDVAiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:38:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D466FC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 17:37:36 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 8so11037896qkv.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 17:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zQ3oRqFEaYwUupWBz0Ob+9p/m78IpqRSVRzOwl1NExU=;
        b=YA4YGWCqTJFmMsrOHxlI/UdbFCODBETZ0PKicjaq8W+MO7k74dvfKTRVJ5blFY7Bat
         i4hOjfxV+MY28sfBh7CZQ2S4mSLZcTJzzwU5phkRvU0O95Qp8gQvGugTxKyjvJOTEZ/4
         vYnaIZGmMbA1ipt0DA1S73cMSVJRkDXPuK3n2oFOkJI7QjXuQVL9NNaBxfT3GSKYDU1h
         THOWkOTIgOZnvrWCMm3JEH/LYbRfEoVLD6GZib4mLzDzIvE8WRoIKI7csn9sKv8qET9b
         wuHpi3aE4SL8MkROICgmJxe7MRbe0q72Zyp7h8cUbriKNb5YqtAekLueCKKnBVBzNGPt
         AV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zQ3oRqFEaYwUupWBz0Ob+9p/m78IpqRSVRzOwl1NExU=;
        b=enDqZwgI6RcR8N/RCVJU1vFImd+UzuN83L3+MJRj7In4xt6jW/CAk4OSRutC4P6A95
         5XcJnvN/pzS6acyRg0BMKfzqlMJtlmaJyquqaEnjTnHl0tEIm5O6rwkMNYY6cjemL7jz
         T9DJNDa58pz4J8Srros1l4lN4Y8WFJEVnhrOpxOInPSCX8nQR/Zlo2/7kYYXW1ZCtRFV
         20agFYxufrYTHJ2MuJsNiiKlUbSt60eAKfPRPHgYeqEHpaD7Cj8MTwOFhXAl3s+o8HsY
         D+7IznMhYi9cIKt09fAMe0e5pOfvHunV/0ehrCs2EBflZy8eRDgymH6wFZMdaRwWfSu/
         g7CQ==
X-Gm-Message-State: AOAM531Gjovl3rY4Bw9q3bejgJg2V5SM/AKkUvD13N6qyGWyN2yRX4sO
        YvM+CudQY05wYjYxvobt/tI52w==
X-Google-Smtp-Source: ABdhPJxhPr50cgrqI2sPQlTusR7MLgOC52sKYJ/5T1GklWlbSpBpN1INHypgW+5A+R7wJBx4RtPRvg==
X-Received: by 2002:a37:8bc1:: with SMTP id n184mr1021888qkd.268.1619051855892;
        Wed, 21 Apr 2021 17:37:35 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h65sm933294qkc.128.2021.04.21.17.37.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 21 Apr 2021 17:37:35 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:37:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] mm/filemap: fix find_lock_entries hang on 32-bit THP
In-Reply-To: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2104211735430.3299@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No problem on 64-bit, or without huge pages, but xfstests generic/308
hung uninterruptibly on 32-bit huge tmpfs.  Since 4.13's 0cc3b0ec23ce
("Clarify (and fix) MAX_LFS_FILESIZE macros"), MAX_LFS_FILESIZE is
only a PAGE_SIZE away from wrapping 32-bit xa_index to 0, so the new
find_lock_entries() has to be extra careful when handling a THP.

Fixes: 5c211ba29deb ("mm: add and use find_lock_entries")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/filemap.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- 5.12-rc8/mm/filemap.c	2021-02-26 19:42:39.812156085 -0800
+++ linux/mm/filemap.c	2021-04-20 23:20:20.509464440 -0700
@@ -1969,8 +1969,14 @@ unlock:
 put:
 		put_page(page);
 next:
-		if (!xa_is_value(page) && PageTransHuge(page))
-			xas_set(&xas, page->index + thp_nr_pages(page));
+		if (!xa_is_value(page) && PageTransHuge(page)) {
+			unsigned int nr_pages = thp_nr_pages(page);
+
+			/* Final THP may cross MAX_LFS_FILESIZE on 32-bit */
+			xas_set(&xas, page->index + nr_pages);
+			if (xas.xa_index < nr_pages)
+				break;
+		}
 	}
 	rcu_read_unlock();
 
