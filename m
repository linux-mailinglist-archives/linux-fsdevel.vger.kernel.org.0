Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29823355556
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhDFNiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhDFNiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:38:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B40C06174A;
        Tue,  6 Apr 2021 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=adZ0C3cJ4lKQ8eG5ef+dmxnQo6NCZF8rtMgKAkFVbGA=; b=su4rnebOFB0EX6o6PmYWp05R/8
        AeHyBIFkxxLWf2bzlXH1bYtGWgyiz89SlKo3dieqkCuGtRbIfo6jFVtQMU6bKeqeHpT9QhlWUcNnz
        LGrNqnHzmLdr9LyPPTSKPIwBL3LHI6JVWWkI2uR/Ich8su5XtvON5yYWmmfMFQX7MTO7+h8qoI5Ru
        1kuH+1UJSU4/rzGUW4vpCxT560GTybyMsMcQm7RSz+1PKCtuHlonUb9EiclUAvDgOa3Utqqu0Mqmk
        3RxPjJVPePD8odi5kCAkM5OAtEqnTkVpVIXOJ8Sja/ESOJCrhBHXOYUQ3FYUF1jFUasqjN7yItfv/
        FmSNlgyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTltd-00Cs71-Vz; Tue, 06 Apr 2021 13:37:40 +0000
Date:   Tue, 6 Apr 2021 14:37:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 09/27] mm: Handle per-folio private data
Message-ID: <20210406133733.GH3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:10PM +0100, Matthew Wilcox (Oracle) wrote:
> Add folio_private() and set_folio_private() which mirror page_private()
> and set_page_private() -- ie folio private data is the same as page
> private data.  The only difference is that these return a void *
> instead of an unsigned long, which matches the majority of users.
> 
> Turn attach_page_private() into attach_folio_private() and reimplement
> attach_page_private() as a wrapper.  No filesystem which uses page private
> data currently supports compound pages, so we're free to define the rules.
> attach_page_private() may only be called on a head page; if you want
> to add private data to a tail page, you can call set_page_private()
> directly (and shouldn't increment the page refcount!  That should be
> done when adding private data to the head page / folio).
> 
> This saves 597 bytes of text with the distro-derived config that I'm
> testing due to removing the calls to compound_head() in get_page()
> & put_page().

Except that this seems to be the first patch that uses a field in the
non-struct page union leg in struct folio, which could be trivially
avoided this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
