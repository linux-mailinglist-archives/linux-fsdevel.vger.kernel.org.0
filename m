Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2BF46E30E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 08:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhLIHW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 02:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhLIHWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:22:55 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C972C0617A1
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Dec 2021 23:19:22 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id f20so4513484qtb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Dec 2021 23:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=wp7bsIiEGq1v0UzZDarToFJILpj4ru1SGwyQaMb3p4E=;
        b=n+ugZQ1C7dMkoFU9ez645n+AJqXmFaYJgGVuTfIepCmJyDDnCohuhijGr9jGafo/wy
         ke5ok+6E3zz7kA5TnbpKDDfzpnH1mUlESdrcsPQX3rQ/5EWkuzqbXbOcU7kKOUckIgth
         O3HHcGIovw7KB4FOWO0jiUkVl5qccjHYAntQnRbxWffMfENTLHdEbWcJPbTowO9D36lh
         64hdvosY2W7EEQR7dNWhu7EJiIi92GFTNn8C83HMjh4dkXwoXA66KkTp40tVE3kupDAq
         JMqxYPzhj9IyRHZAsGhQpuTwy2HT4CE1oPWh6CbJnqiZk+a9EqxqpKmrpdtx6oHOyez0
         QR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=wp7bsIiEGq1v0UzZDarToFJILpj4ru1SGwyQaMb3p4E=;
        b=FrXbztVCKxqjY+4nVfxcWFJFeb+AK/zIvffgW8xDy3JILPDDfWrKa7kS/RiPr1QGYC
         rZrb0800WvF2JV+eUJGGJZl3CvWpJM8g2f4FAclD3KqsWcDE09wun/2WgqzGRWwZ6vU7
         BjodtyzX3K/6I40Z8rWxR0idcA9w89JrTn+q0MxauMYI/XOQwwC95cQXhgQ8k/9Nhbr2
         pF4sVN836hJrPQurwEUc3STC4fDH7ZcEsa6l4uHx3C0GET9a/nKBEyhQyCQ/eX7tS034
         9fvUes5JCH2WvLX72SY3pT8O6HzrA1713wM/I4sSCfDChSIDCZCiRZtpbsPb6JzIlc5q
         LQTw==
X-Gm-Message-State: AOAM532+jAJNNXspXBSE8SHuNWCIyBwhQ9/gL9zFTfXkODPu8JtouQVd
        y1eb1BYJUS96XhPqXU/MHRH5aA==
X-Google-Smtp-Source: ABdhPJyDk5gwcYkseNoR8GrR8PAhZjoMS9Xyrz93qdo0YVs5eDJPx98/mF7EChyYF/5No6CJchsA8g==
X-Received: by 2002:ac8:580b:: with SMTP id g11mr14831442qtg.268.1639034361429;
        Wed, 08 Dec 2021 23:19:21 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z4sm3382336qtj.42.2021.12.08.23.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 23:19:20 -0800 (PST)
Date:   Wed, 8 Dec 2021 23:19:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: delete unsafe BUG from page_cache_add_speculative()
Message-ID: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is not easily reproducible, but on 5.16-rc I have several times hit
the VM_BUG_ON_PAGE(PageTail(page), page) in page_cache_add_speculative():
usually from filemap_get_read_batch() for an ext4 read, yesterday from
next_uptodate_page() from filemap_map_pages() for a shmem fault.

That BUG used to be placed where page_ref_add_unless() had succeeded,
but now it is placed before folio_ref_add_unless() is attempted: that
is not safe, since it is only the acquired reference which makes the
page safe from racing THP collapse or split.

We could keep the BUG, checking PageTail only when folio_ref_try_add_rcu()
has succeeded; but I don't think it adds much value - just delete it.

Fixes: 020853b6f5ea ("mm: Add folio_try_get_rcu()")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 include/linux/pagemap.h |    1 -
 1 file changed, 1 deletion(-)

--- 5.16-rc4/include/linux/pagemap.h
+++ linux/include/linux/pagemap.h
@@ -285,7 +285,6 @@ static inline struct inode *folio_inode(
 
 static inline bool page_cache_add_speculative(struct page *page, int count)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
 	return folio_ref_try_add_rcu((struct folio *)page, count);
 }
 
