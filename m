Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42F13AEB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgANQMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANQMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qvys4y5BuENtlHq/fQJ5HpYZJz7aH8HDgIfuuwBY89Q=; b=hZ2uCty81+cLZZ+AsRSBc8RzcG
        kC15Kg6m7XjWGXt8bZwI3hFaj/SqYbm/8p3j7EuKhk/rJCCyXz7IoovhUGraWUO/P7TvsGWnYCwm9
        D8mmmN/0rqoay7ZV2O/4AxayCcPF41tBPGAXRySkvtmkorPeP9n+3KUZwDnMogNsudXoZFlEUTdF/
        a5QKf9ajqV5tgHOeo+IVo0cqkhwkqF+QX8Ay9IhuNEGb6SxJe0O9IFxQYXB0xmJVKK8EJSgFINc4f
        5aAkHc3tOjML58DMTOlXPrFqR2DhdRp6/Vf4K6W1SJZMZvNid2zZazualtOvqFH0qifjtLd7pI/mb
        i98/ibWg==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOnu-00007I-4k; Tue, 14 Jan 2020 16:12:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 01/12] mm: fix a comment in sys_swapon
Date:   Tue, 14 Jan 2020 17:12:14 +0100
Message-Id: <20200114161225.309792-2-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

claim_swapfile now always takes i_rwsem.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bb3261d45b6a..fe6e4c1add0b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3157,7 +3157,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	mapping = swap_file->f_mapping;
 	inode = mapping->host;
 
-	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
+	/* will take i_rwsem; */
 	error = claim_swapfile(p, inode);
 	if (unlikely(error))
 		goto bad_swap;
-- 
2.24.1

