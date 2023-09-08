Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E042079892A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbjIHOsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjIHOsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:48:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40CF1BF1;
        Fri,  8 Sep 2023 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7xlscfo05JscexfNcziiC+6mff2O4c5hxO5GC5sFXAQ=; b=Yx6BRn4uR/lV4JdnbRIPa6+o6j
        BcX6/AOsunRmMYDzdqG5InlkJU8xBoRu2T5CB/22qcDL5rsl+0gYx0qilgqEiALCUw7NsXJMM+lR8
        dUs7ilc8FIeSZ0gNt7xVM2wttsDqn4uWw9DE6udjWQFN50cK/RzafBoYx8XSeIQHKdIMwFbXiMWp5
        1zDF7aDqohkuyhZBFcyg88QrtfI4IAEna/p1+JkN9li9bR25YT9dXB5SaxgQ5B2zL0vZeFxz6RBDp
        xP1SW4El6etQWHvrsivuxqjNkzruBmEdGOIiDpCe5dQHzgwCZ+E722OeJ2IxeBh8g7tK83d3fYJxy
        JADdLd/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qecmB-000ix0-K2; Fri, 08 Sep 2023 14:48:04 +0000
Date:   Fri, 8 Sep 2023 15:48:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: Why doesn't XFS need ->launder_folio?
Message-ID: <ZPs0I9ZTxfAQtyI9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I want to remove ->launder_folio.  So I'm looking at commit e3db7691e9f3
which introduced ->launder_page.  The race described there is pretty
clear:

     invalidate_inode_pages2() may find the dirty bit has been set on a page
     owing to the fact that the page may still be mapped after it was locked.
     Only after the call to unmap_mapping_range() are we sure that the page
     can no longer be dirtied.

ie this happens:

Task A				Task B
mmaps a file, writes to page A
				open(O_DIRECT)
				read()
				kiocb_invalidate_pages()
				filemap_write_and_wait_range()
				__filemap_fdatawrite_range()
				filemap_fdatawrite_wbc()
				do_writepages()
				iomap_writepages()
				write_cache_pages()
				page A gets cleaned
writes to page A again
				invalidate_inode_pages2_range()
				folio_mapped() is true, so we unmap it
				folio_launder() returns 0
				invalidate_complete_folio2() returns 0
				ret = -EBUSY
				kiocb_invalidate_pages() returns EBUSY

and the DIO read fails, despite it being totally reasonable to return
the now-stale data on storage.  A DIO write would be a different matter;
we really do need to get page A out of cache.

So would it be reasonable to unmap the pages earlier and rely on
invalidate_lock to prevent page faults making the page writable
between the call to filemap_write_and_wait_range() and the call to
invalidate_complete_folio2() ?  Then we could get rid of ->launder_folio()
as well as making DIO a little more reliable when racing with page faults.
