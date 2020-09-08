Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72353261151
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgIHM17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbgIHLwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:52:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20FC061757;
        Tue,  8 Sep 2020 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OSVXaZ7xzAGl2y+0kyr1xPePoywMfRGlGnRHQW50WBQ=; b=LRkfQQ8yd07Ax6ojzKhfHj7+0A
        FTi44s8/UGMuRw82gtO8hdQHFqCf2bzBGN9sMV6OoyMqY7tGLMQgr/2ZR261dJQwQzt0V244x5wIE
        87dPrBo1GLe0NP/MRZTu4cuX+bbCj3qcabyq91YmfpvAWezxrztATWfKbS/5bvFQdZXQMLubauv+Y
        g03mML64IJUg7HVM5QVS/qY16Ae/S2Adys/l28GgaBecNaV5y0bdy7948yiqiZbBdv/G0isiJMBB/
        VRXeMhLpPS80RgZVN3e7BacR2RsXsY4UIt8LF64P8v7qADDseQrTeWc171yhVBxDkldyEZ14ow1tf
        qDMS+w0w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFc24-0001RH-GR; Tue, 08 Sep 2020 11:43:28 +0000
Date:   Tue, 8 Sep 2020 12:43:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        david@fromorbit.com, yukuai3@huawei.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Splitting an iomap_page
Message-ID: <20200908114328.GE27537@casper.infradead.org>
References: <20200821144021.GV17456@casper.infradead.org>
 <20200904033724.GH14765@casper.infradead.org>
 <20200907113324.2uixo4u5elveoysf@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907113324.2uixo4u5elveoysf@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 07, 2020 at 02:33:24PM +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 04, 2020 at 04:37:24AM +0100, Matthew Wilcox wrote:
> > Kirill, do I have the handling of split_huge_page() failure correct?
> > It seems reasonable to me -- unlock the page and drop the reference,
> > hoping that somebody else will not have a reference to the page by the
> > next time we try to split it.  Or they will split it for us.  There's a
> > livelock opportunity here, but I'm not sure it's worse than the one in
> > a holepunch scenario.
> 
> The worst case scenario is when the page is referenced (directly or
> indirectly) by the caller. It this case we would end up with endless loop.
> I'm not sure how we can guarantee that this will never happen.

I don't see a way for that to happen at the moment.  We're pretty
careful not to take references on multiple pages at once in these paths.
I've fixed the truncate paths to only take one reference per THP too.

I was thinking that if livelock becomes a problem, we could (ab)use the
THP destructor mechanism somewhat like this:

Add
	[TRANSHUGE_PAGE_SPLIT] = split_transhuge_page,
to the compound_page_dtors array.

New function split_huge_page_wait() which, if !can_split_huge_page()
first checks if the dtor is already set to TRANSHUGE_PAGE_SPLIT.  If so,
it returns to its caller, reporting failure (so that it will put its
reference to the page).  Then it sets the dtor to TRANSHUGE_PAGE_SPLIT
and sets page refcount to 1.  It goes to sleep on the page.

split_transhuge_page() first has to check if the refcount went to 0
due to mapcount being reduced.  If so, it resets the refcount to 1 and
returns to the caller.  If not, it freezes the page and wakes the task
above which is sleeping in split_huge_page_wait().

It's complicated and I don't love it.  But it might solve livelock, should
we need to do it.  It wouldn't prevent us from an indefinite wait if the
caller of split_huge_page_wait() has more than one reference to this page.
That's better than a livelock though.
