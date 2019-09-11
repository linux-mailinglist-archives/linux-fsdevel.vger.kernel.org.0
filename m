Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2237AAF487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 04:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfIKCwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 22:52:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfIKCv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PNNRbBM+ZsiFh/QzrWWJo+0Oaes86g1L+e4LhQmEhqk=; b=LRu6iD6ZpZkWtc3muCv5IpCHca
        ATXFJ7baQ1s0PJaPodE7T5TpCUji2Dsyx7KBeo/oYjefxqF9TQuZlJkVWaXg4ldVX0mst/PraGHOS
        J9f6r0LgVWtCl/onz/gkvz1iHEeYktQYLo1Knqn8UoVM65uWhjvTg23NqrYEq65F27IT2mHP6fXB1
        oyMoCbw311mN1anXKXttFPb5deo6F1LpabmaPw3/C80evhPwHj7rBVKBPLxW5lJsEVFemizp32aSD
        +eQD7zcs06MCYxi0ELC/N+7FczQZbnuokJsC9kGK6VM/ulRovQvY1Z5wE/c8H9xszq9RXQjRjJz3I
        3wpLmOuw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7sje-0007ys-6T; Wed, 11 Sep 2019 02:51:58 +0000
Date:   Tue, 10 Sep 2019 19:51:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: filemap_fault can lose errors
Message-ID: <20190911025158.GG29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


If we encounter an error on a page, we can lose the error if we've
dropped the mmap_sem while we wait for the I/O.  That can result in
taking the fault multiple times, and retrying the read multiple times.
Spotted by inspection.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")

diff --git a/mm/filemap.c b/mm/filemap.c
index d0cf700bf201..37bd4aedfccf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2615,6 +2615,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		if (!PageUptodate(page))
 			error = -EIO;
 	}
+	if (error < 0)
+		ret |= VM_FAULT_SIGBUS;
 	if (fpin)
 		goto out_retry;
 	put_page(page);
@@ -2622,9 +2624,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (!error || error == AOP_TRUNCATED_PAGE)
 		goto retry_find;
 
-	/* Things didn't work out. Return zero to tell the mm layer so. */
+	/* Things didn't work out. */
 	shrink_readahead_size_eio(file, ra);
-	return VM_FAULT_SIGBUS;
+	return ret;
 
 out_retry:
 	/*

