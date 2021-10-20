Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39EC4349C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJTLLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhJTLLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB94AC06161C;
        Wed, 20 Oct 2021 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bkwCMh1L283zu+NfIJRFcbJeljr6wS5Wxo/xoHye8V0=; b=qs3LMa2vVLIf+lJ7FoOL5f1hPx
        HEmWfTaYB8JoNXenwGFzUALEnFQKeMXjhKlAbc6DQX7/HBpz+oN6GiMSlzqIH6iuYmvJDzlX1JnAy
        H0iymAL0ShIkDqkn7ybPkjNgO0tVIxvyyI2ZZ8jc2EM0NpT5VV0vzV6xzqrM06KnnewYwZcd4NGK7
        7LZeYo8yWTzpvfbswfHOBnyYjn7VcVmacTAWAdLFLyOdeEvWzsxnSrtcaRKYXbVGfgThMyGCHUQZG
        h0eRCRSxZhZGSSegjttcOVjVHLu1bDy1Af/5kTewfWFpdwftlbHeDqG/U9FEqPnw9FoB+U61eMw4K
        xiyoHe2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9QJ-00CRJI-I7; Wed, 20 Oct 2021 11:06:49 +0000
Date:   Wed, 20 Oct 2021 12:06:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     kent.overstreet@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Stop filemap_read() from grabbing a superfluous
 page
Message-ID: <YW/4K6Rm+WX5aKbf@casper.infradead.org>
References: <163472463105.3126792.7056099385135786492.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163472463105.3126792.7056099385135786492.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:10:31AM +0100, David Howells wrote:
> Under some circumstances, filemap_read() will allocate sufficient pages to
> read to the end of the file, call readahead/readpages on them and copy the
> data over - and then it will allocate another page at the EOF and call
> readpage on that and then ignore it.  This is unnecessary and a waste of
> time and resources.
> 
> filemap_read() *does* check for this, but only after it has already done
> the allocation and I/O.  Fix this by checking before calling
> filemap_get_pages() also.
> 
> Changes:
>  v2) Break out of the loop immediately rather than going to put_pages (the
>      pvec is unoccupied).  Setting isize is then unnecessary.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Kent Overstreet <kent.overstreet@gmail.com>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jeff Layton <jlayton@redhat.com>
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/160588481358.3465195.16552616179674485179.stgit@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk/

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
