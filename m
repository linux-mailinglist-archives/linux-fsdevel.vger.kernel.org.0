Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF6B3DB473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhG3HZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbhG3HZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:25:47 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05E8C0613C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:25:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 129so8574925qkg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jkYXHYQOJwdYcrKEK9MjpwYhNSueJb3fc8wKTs2YDzo=;
        b=MnYv4B4ahWeK8EelXwid43sUxDgsWADeVSOhfvddZrBPkswJK5Et+CtJWb+1DpLpwA
         dJxKP4tIc+aR6szsW9Lj/v66BEXLzd94E7bNJu1Qv1OUyxB+6RVhP7wlqaRXjwuQMRxn
         pr4uQKsGvfWn5CQjX4TZC+h5ZSYjlqNl8ghcCklzv30T9zSJOLkgfBRgJn4Mnl9FHJjc
         5xY3HwHZ6ZhzzS1dkQQTof7vNMZVM8qYC1xMtDJVq2VqMGeUWb4XpvYSVM3lFW/hJJeQ
         c9HZP2vLmNhDzpObKtkmUZSZAx/7AMfQgfv6CjmnYWAD7b7wiotN3Ekace0xWNMNXI+D
         fYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jkYXHYQOJwdYcrKEK9MjpwYhNSueJb3fc8wKTs2YDzo=;
        b=KwO4ANO2QVFB6+60KKyaCdEGlLhJy0vu8sO7rd6Msz49PgQSPH1N2CP7i/mHuuJGME
         X4134FU0N8ZpVXvkxL4l8jWRM9LNngIdRY0WR0y6ydOxCqDcnFArSk1OlWeS9mGMQ+IX
         36SN2eC8ysHiuueN+lfprBLE+2414mSk8fCu85a2qqeKdpqnCQ/NnOKPnWiTkQHoySYI
         uw6M7Mc0vfEMcCPTbVtOSJSmb8/OZW8/15gKF871kMS05UZ/8hOO/0XbKVTYgqINTh+a
         4+BGjiGnon7KywiDZAdQzIQj6aRkMR0E/R8r8Asl3STdINKW2ByUk97AcKqZ4Gsk0oOh
         A6qg==
X-Gm-Message-State: AOAM530EY7PoAMZMPuT0NlpC1tC1RYk5t6Srq3OYNSOIW/wLQY7tjHCO
        rz3loCibmXaNob3/Rpddv67kcA==
X-Google-Smtp-Source: ABdhPJwqYYV/p4qw44eoD0Ui59yNPpX+r3lsn/zvr7f6iY0IIpj9pmMIxxqRvhwlEzpGikFmo1z2LQ==
X-Received: by 2002:ae9:e90e:: with SMTP id x14mr992985qkf.118.1627629941526;
        Fri, 30 Jul 2021 00:25:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5sm524075qko.53.2021.07.30.00.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:25:40 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:25:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 01/16] huge tmpfs: fix fallocate(vanilla) advance over huge
 pages
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <af71608e-ecc-af95-3511-1a62cbf8d751@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

shmem_fallocate() goes to a lot of trouble to leave its newly allocated
pages !Uptodate, partly to identify and undo them on failure, partly to
leave the overhead of clearing them until later.  But the huge page case
did not skip to the end of the extent, walked through the tail pages one
by one, and appeared to work just fine: but in doing so, cleared and
Uptodated the huge page, so there was no way to undo it on failure.

Now advance immediately to the end of the huge extent, with a comment on
why this is more than just an optimization.  But although this speeds up
huge tmpfs fallocation, it does leave the clearing until first use, and
some users may have come to appreciate slow fallocate but fast first use:
if they complain, then we can consider adding a pass to clear at the end.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 70d9ce294bb4..0cd5c9156457 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2736,7 +2736,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	inode->i_private = &shmem_falloc;
 	spin_unlock(&inode->i_lock);
 
-	for (index = start; index < end; index++) {
+	for (index = start; index < end; ) {
 		struct page *page;
 
 		/*
@@ -2759,13 +2759,26 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			goto undone;
 		}
 
+		index++;
+		/*
+		 * Here is a more important optimization than it appears:
+		 * a second SGP_FALLOC on the same huge page will clear it,
+		 * making it PageUptodate and un-undoable if we fail later.
+		 */
+		if (PageTransCompound(page)) {
+			index = round_up(index, HPAGE_PMD_NR);
+			/* Beware 32-bit wraparound */
+			if (!index)
+				index--;
+		}
+
 		/*
 		 * Inform shmem_writepage() how far we have reached.
 		 * No need for lock or barrier: we have the page lock.
 		 */
-		shmem_falloc.next++;
 		if (!PageUptodate(page))
-			shmem_falloc.nr_falloced++;
+			shmem_falloc.nr_falloced += index - shmem_falloc.next;
+		shmem_falloc.next = index;
 
 		/*
 		 * If !PageUptodate, leave it that way so that freeable pages
-- 
2.26.2

