Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995F148CA28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 18:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiALRql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 12:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355936AbiALRqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:46:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821C4C06173F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2mZtHdjbIat3c+/tmBHUW44wgGkNwhsML0tnmjI65+I=; b=RWFQpGiucu82sruTzvMG5Kp2x5
        uA6xG0+x4NIhbSQD75/oV0cAaJR9D9Dsbu9OeRs0NJWsjY+Iy5FpptKxDn/79BJZDuWjj0Isa6oq0
        x6aX7oFUjXtDcrzIxhk3OE6X+LbJSg0RRh1290sd+516keGkvwC5fkskIVMSQjI+mpGCmldbQEBA2
        1Ok/r0xBZQ6MV5EdJtKRZiSrfiyGvv/sDDnNv/+h+FByub73SBKsfvNabAU4CTQ9KP70Ab7L/7gSf
        DbIqNkq3/hgVDaq3YBKZUwWV7Sdhb/IrS30frtPBmTVMBuEE+kVkKOtX25W5BUU8ehdJJ0wLMv9/S
        F3KMtIfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7hhX-004HsR-UV; Wed, 12 Jan 2022 17:46:23 +0000
Date:   Wed, 12 Jan 2022 17:46:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: unusual behavior of loop dev with backing file in tmpfs
Message-ID: <Yd8T7xbV+2zEqJA8@casper.infradead.org>
References: <20211126075100.gd64odg2bcptiqeb@work>
 <5e66a9-4739-80d9-5bb5-cbe2c8fef36@google.com>
 <20220112171937.GA19154@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112171937.GA19154@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:19:37AM -0800, Darrick J. Wong wrote:
> I for one wouldn't mind if tmpfs no longer instantiated cache pages for
> a read from a hole -- it's a little strange, since most disk filesystems
> (well ok xfs and ext4, haven't checked the others) don't do that.
> Anyone who really wants a preallocated page should probably be using
> fallocate or something...

We don't allocate disk blocks, but we do allocate pages.

filemap_read()
  filemap_get_pages()
    page_cache_sync_readahead()
      page_cache_sync_ra()
        ondemand_readahead()
	  do_page_cache_ra()
	    page_cache_ra_unbounded()
	      __page_cache_alloc()
	      add_to_page_cache_lru()

At this point, we haven't called into the filesystem, so we don't
know that we're allocating pages for a hole.

Although tmpfs doesn't take this path; it has its own
shmem_file_read_iter() instead of calling filemap_read().  I do rather
regret that because it means that tmpfs doesn't take advantage of
readahead, which means that swapping back _in_ is rather slow.

It's on my list of things to look at ... eventually.
