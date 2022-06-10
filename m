Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33315546F26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 23:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348020AbiFJVRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 17:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiFJVRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:17:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165FC5D5DA;
        Fri, 10 Jun 2022 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dPCOWM5CyDEIdIuBSxjePp4f8SSu/SKCJnmsXTUdDp0=; b=H/uguj+Wl5DQo9Vix4WTb9P9Qz
        L3+C24pFO0kvbIu1KKcP4oVLAW0MPkjH36cSK+5oKXA61lH8Ik4WuTBYal6HxocDDl+IvIKG4CCwL
        qMYlFEtD8mXy6yOt5Sgb3+UVlhpMqyWoPpvjDn3H3qAjkbV7cG6coeM3c8vmcNboFD8Xoap0GQfCH
        198oRccDnDnojUeQZLgFD8CTZuFsqMSEqnlQmY48fZ9D/l9Bs8bop7G9eLDZqxL2TbtpRPL1eiwtg
        Fc6e9lthrSLvnei2DS7h37o1aENF/y3X0CXCwJvu6vkLxR7ewRCMntvOhjp1rS4ybHxIfs6En+aMm
        PTXk3bZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzm0e-00El5e-Cd; Fri, 10 Jun 2022 21:17:36 +0000
Date:   Fri, 10 Jun 2022 22:17:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 06/10] hugetlbfs: Convert remove_inode_hugepages() to use
 filemap_get_folios()
Message-ID: <YqO08Dsq8ZcAcWDQ@casper.infradead.org>
References: <20220605193854.2371230-7-willy@infradead.org>
 <20220610155205.3111213-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610155205.3111213-1-sumanthk@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 05:52:05PM +0200, Sumanth Korikkar wrote:
> To reproduce:
> * clone libhugetlbfs:
> * Execute, PATH=$PATH:"obj64/" LD_LIBRARY_PATH=../obj64/ alloc-instantiate-race shared

... it's a lot harder to set up hugetlb than that ...

anyway, i figured it out without being able to run the reproducer.

Can you try this?

diff --git a/mm/filemap.c b/mm/filemap.c
index a30587f2e598..8ef861297ffb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2160,7 +2160,11 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		if (xa_is_value(folio))
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
-			*start = folio->index + folio_nr_pages(folio);
+			unsigned long nr = folio_nr_pages(folio);
+
+			if (folio_test_hugetlb(folio))
+				nr = 1;
+			*start = folio->index + nr;
 			goto out;
 		}
 	}
