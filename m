Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938332A49D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKCPbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:31:20 -0500
Received: from verein.lst.de ([213.95.11.211]:37958 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgKCPbU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C520D6736F; Tue,  3 Nov 2020 16:31:18 +0100 (CET)
Date:   Tue, 3 Nov 2020 16:31:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, kent.overstreet@gmail.com
Subject: Re: [PATCH 11/17] mm/filemap: Add filemap_range_uptodate
Message-ID: <20201103153118.GC10928@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-12-willy@infradead.org> <20201103074944.GK8389@lst.de> <20201103151847.GZ27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103151847.GZ27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:18:47PM +0000, Matthew Wilcox wrote:
> I have a simplification in mind that gets rid of the awkward 'first'
> parameter.  In filemap_get_pages(), do:
> 
>                 if ((iocb->ki_flags & IOCB_WAITQ) && (pagevec_count(pvec) > 1))
>                         iocb->ki_flags |= IOCB_NOWAIT;
> 
> before calling filemap_update_page().  That matches what Kent did in
> filemap_read():

Yes, that makes a lot of sense.  No need for the second pair of inner
braces, though :)
