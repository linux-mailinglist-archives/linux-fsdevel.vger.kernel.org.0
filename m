Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA232702A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIRQyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIRQyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:54:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4959C0613CE;
        Fri, 18 Sep 2020 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U2yqhATh469FbDly7syN3rKKW+iwO250g/2CjxLDmtI=; b=ROme0mFVxDZSgrRNFEFIxL6/8A
        ArTRK20g+7K9Q9tXa/G//66RDG5jyFigLCIC0vnwXnR2CCwrmkNsxe26BmRESCL6ws/6ikSZSk65+
        zHvCeNSY73SiJoz1Co26kx/fJc/htbLneezbnG/fmEJj7xhQqkirjT0RkCvNTi/c6qAYE7+ZHulq+
        DRqOCjQB5V8+AywJpvea7dUu2QnbfavNyNn6d3CYko2wqZMYEJ+KEnZrL5z92t2bdLoXm7Q1KM40e
        M2Egh54rCd8iTHrbkEayA8TkVBrUIk2ilqg1wbhhqOtEsmM1u991O82Rqk8ZFDaQN6UpshtdIRwMP
        GSyXr9BA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJJec-00083C-PC; Fri, 18 Sep 2020 16:54:34 +0000
Date:   Fri, 18 Sep 2020 17:54:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH v5 03/10] fs/ntfs3: Add bitmap
Message-ID: <20200918165434.GG32101@casper.infradead.org>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-4-almaz.alexandrovich@paragon-software.com>
 <d1dc86f2792d3e64d1281fc2b5fddaca5fa17b5a.camel@perches.com>
 <20200914023845.GJ6583@casper.infradead.org>
 <1cb55e79c5a54feb82cf4850486890df@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb55e79c5a54feb82cf4850486890df@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 04:35:11PM +0000, Konstantin Komarov wrote:
> > That was only just renamed.  More concerningly, the documentation is
> > quite unambiguous:
> > 
> >  * This function is for filesystems to call when they want to start
> >  * readahead beyond a file's stated i_size.  This is almost certainly
> >  * not the function you want to call.  Use page_cache_async_readahead()
> >  * or page_cache_sync_readahead() instead.
> 
> Hi Matthew! it's not so clear for us by several reasons (please correct
> if this is wrong):
> page_cache_sync_readahead() seems applicable as a replacement, but
> it doesn't seem to be reasonable as readahead in this case gives perf
> improvement because of it's async nature. The 'async' function is incompatible
> replacement based on the arguments list.

I think the naming has confused you (so I need to clarify the docs).
The sync function is to be called when you need the page which is being
read, and you might want to take the opportunity to read more pages.
The async version is to be called when the page you need is in cache,
but you've noticed that you're getting towards the end of the readahead
window.  Neither version waits for I/O to complete; you have to wait for
the page to become unlocked and then you can check PageUptodate.

Looking at what you're doing, you don't have a file_ra_state because
you're just trying to readahead fs metadata, right?  I think you want
to call force_page_cache_readahead(mapping, NULL, start, nr_pages);
The prototype for it is in mm/internal.h, but I think moving it to
include/linux/pagemap.h is justifiable.
