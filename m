Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5A268AF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgINM3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 08:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgINM1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:27:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B6C0612F2;
        Mon, 14 Sep 2020 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sovkMljeHeE8QiqrRubge8NYzTKoGU5H5cGDXKlh4Do=; b=vUB6uayCQphbQuNntBPspugAbh
        jOnkcmA2i0c1bK3N378QEG6urxYN2R7PkOVb1UBFygrhBxVKmvJMjSakYenuJpOACgtx48gHNx+Og
        OjV/0iCsw0wHglN8SOZU9DcEQyzQl7SWZIGlWIHGw1wA20VEHpisZSEb6BLPX8fG7L7A+/Cetvyyo
        hvCQE07SWyK0xzyh330bETJW80DBj35QKQDo5dF7JehFVwCkWjyJWZWIyUfDCpjhryV40uYeeZUag
        tRBzRfTAjPKaeFXjbX7UurmQrcJmocUWXkD10jTTSuoo42EsMmxfEZeOH34uT3zkVyXpjvEMBB6N5
        QVntRK2g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHn5T-0007T5-Al; Mon, 14 Sep 2020 11:55:59 +0000
Date:   Mon, 14 Sep 2020 12:55:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        gandalf@winds.org, Qian Cai <cai@lca.pw>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: RIP:
 0010:shmem_getpage_gfp.isra.0+0x470/0x750
Message-ID: <20200914115559.GN6583@casper.infradead.org>
References: <CA+G9fYvmut-pJT-HsFRCxiEzOnkOjC8UcksX4v8jUvyLYeXTkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvmut-pJT-HsFRCxiEzOnkOjC8UcksX4v8jUvyLYeXTkQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:49:43PM +0530, Naresh Kamboju wrote:
> While running LTP fs on qemu x86 and qemu_i386 these kernel BUGs noticed.

I actually sent the fix for this a couple of days ago [1], but I think Andrew
overlooked it while constructing the -mm tree.  Here's a fix you can
apply to the -mm tree:

[1] https://lore.kernel.org/linux-mm/20200912032042.GA6583@casper.infradead.org/

diff --git a/mm/shmem.c b/mm/shmem.c
index d2a46ef7df43..58bc9e326d0d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1793,7 +1793,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	struct mm_struct *charge_mm;
 	struct page *page;
 	enum sgp_type sgp_huge = sgp;
-	pgoff_t hindex;
+	pgoff_t hindex = index;
 	int error;
 	int once = 0;
 	int alloced = 0;
@@ -1822,6 +1822,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return error;
 	}
 
+	if (page)
+		hindex = page->index;
 	if (page && sgp == SGP_WRITE)
 		mark_page_accessed(page);
 
@@ -1832,6 +1834,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		unlock_page(page);
 		put_page(page);
 		page = NULL;
+		hindex = index;
 	}
 	if (page || sgp == SGP_READ)
 		goto out;
@@ -1982,7 +1985,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		goto unlock;
 	}
 out:
-	*pagep = page + index - page->index;
+	*pagep = page + index - hindex;
 	return 0;
 
 	/*
