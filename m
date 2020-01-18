Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E53141A6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 00:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgARXOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 18:14:22 -0500
Received: from [198.137.202.133] ([198.137.202.133]:45566 "EHLO
        bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbgARXOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 18:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Iv6n9Q/k1eXFbCcvnuAFYhME6UiPb/gjtwI6FiGWHlY=; b=PbuQjafa6FNb0jf4Leo51n0ze
        PRmlAVl5z1ZdMKXv7G8WzQDLeUx/NSuFGo+MqwXrG7HDkYae1p4oEnh9x7xaIytKodpSdON+QIXGk
        9aB/4BmlrVDjiiodkKRX1BmVIQc9QLwaqHJn2icSGn22l1FGl8Jj41EPmXavE7FPgg2opgnWOUBdX
        gIRaoh1MtoSVcJ90zGhhlZ5jYqyNLBFA4AgSEUM+NpmAvD5c7emnIgUgTOZWjNxrGl9yg7fNbj50A
        p9IN4Rmv3GUcOq+C5+7YvaL/ykoedA+kmUKT74Jm2Ills78XY1DyZWKIYJn9p6h7CEpNwGp+IKDcT
        tfYpGlzOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isxHm-0005Lx-Tp; Sat, 18 Jan 2020 23:13:46 +0000
Date:   Sat, 18 Jan 2020 15:13:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [RFC v2 0/9] Replacing the readpages a_op
Message-ID: <20200118231346.GB5583@bombadil.infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 06:38:34PM -0800, Matthew Wilcox wrote:
> This is an attempt to add a ->readahead op to replace ->readpages.  I've
> converted two users, iomap/xfs and cifs.  The cifs conversion is lacking
> fscache support, and that's just because I didn't want to do that work;
> I don't believe there's anything fundamental to it.  But I wanted to do
> iomap because it is The Infrastructure Of The Future and cifs because it
> is the sole remaining user of add_to_page_cache_locked(), which enables
> the last two patches in the series.  By the way, that gives CIFS access
> to the workingset shadow infrastructure, which it had to ignore before
> because it couldn't put pages onto the lru list at the right time.
> 
> v2: Chris asked me to show what this would look like if we just have
> the implementation look up the pages in the page cache, and I managed
> to figure out some things I'd done wrong last time.  It's even simpler
> than v1 (net 104 lines deleted).

I want to discuss whether to change the page refcount guarantees while we're
changing the API.  Currently,

page is allocated with a refcount of 1
page is locked, and inserted into page cache and refcount is bumped to 2
->readahead is called
callee is supposed to call put_page() after submitting I/O
I/O completion will unlock the page after I/O completes, leaving the refcount at 1.

So, what if we leave the refcount at 1 throughout the submission process,
saving ourselves two atomic ops per page?  We have to ensure that after
the page is submitted for I/O, the submission path no longer touches
the page.  So the process of converting a filesystem to ->readahead
becomes slightly more complex, but there's a bugger win as a result.

Opinions?
