Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A862A4A17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgKCPmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKCPmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:42:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FCC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pFgyl3GrEZYaf8JQc2yA1SIpCFCjDU9Ec1IBTDiqJ1I=; b=MADYyCRNOSDjuQi9beNoE1jpa1
        IDNFvx9m3rOnrCbVCwj8nlHD34lZaoU2Qnec4eLiQvhTd4jdOnfmnSS6TWJ/WtXN6xE46MWKf8Qyf
        TnIAKCawD8BHlztZwcatXo0g/2fgT7SNwwGlX4OhdH3XuKJdwi6+Y0/xZACJp7duD7+wHDtctgCq3
        1C4yFHLXt2npRFS6Su1MahLcOvUhc0anYNMw1Jm8C/PvBOwcKsxjb9Jvg2S/rmThpYiDyJfB5asLp
        AIJGmXPv9LqtDcJb8ppbkHzms2Bi4zsAaxtp7yKEriO44oFa3qj9HGpAptBgl04bjHz87qIWUaXVr
        2+Hd+c0A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZyS9-0000C5-Vo; Tue, 03 Nov 2020 15:42:34 +0000
Date:   Tue, 3 Nov 2020 15:42:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 11/17] mm/filemap: Add filemap_range_uptodate
Message-ID: <20201103154233.GC27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-12-willy@infradead.org>
 <20201103074944.GK8389@lst.de>
 <20201103151847.GZ27442@casper.infradead.org>
 <20201103153118.GC10928@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103153118.GC10928@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 04:31:18PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 03, 2020 at 03:18:47PM +0000, Matthew Wilcox wrote:
> > I have a simplification in mind that gets rid of the awkward 'first'
> > parameter.  In filemap_get_pages(), do:
> > 
> >                 if ((iocb->ki_flags & IOCB_WAITQ) && (pagevec_count(pvec) > 1))
> >                         iocb->ki_flags |= IOCB_NOWAIT;
> > 
> > before calling filemap_update_page().  That matches what Kent did in
> > filemap_read():
> 
> Yes, that makes a lot of sense.  No need for the second pair of inner
> braces, though :)

I wrote it as
		if ((iocb->ki_flags & IOCB_WAITQ) && pagevec_count(pvec) > 1)
originally, and then talked myself into putting the unnecessary brackets
in to make it look more symmetric ;-)
