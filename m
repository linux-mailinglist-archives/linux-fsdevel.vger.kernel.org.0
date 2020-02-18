Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B821634B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgBRVVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:21:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRVVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0HtJTFPkdLwAcbGGhAHyzxa8a1mSgpc758IYlfDOg/k=; b=L9ufQZtGybPYd67zmz67Xgy4Tn
        mZsneK5DIi4+EdZSTDy3qMq6jC4G9yjF4A0m3HKQqgfmPcf89rxgAlz7TflzrDt+lPKQjG8DBB0Nc
        hFwG4XwkG9NeYBz6KYBZ58AKe0IfPIrYhHeqqinr+nlcKs9GdGtB8jhCcawcvPy3icitqNTTzH4jP
        ZCAGflog5kL6wL3IvL71BWNMv5PaAXyucj7tYF+EQU4HI4NEjXGWh1T+shXyemzhRpUXmIabqr29C
        5LaP21DN5DNYTONx+gIE3+S5Zr0Asg51I2iJBLolcYDkCch1kyQ608fu1c/WOZsk9fwFBAcPrEAy8
        FZTOuLoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4AIt-0003y5-Bi; Tue, 18 Feb 2020 21:21:15 +0000
Date:   Tue, 18 Feb 2020 13:21:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 01/19] mm: Return void from various readahead functions
Message-ID: <20200218212115.GG24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-2-willy@infradead.org>
 <29d2d7ca-7f2b-7eb4-78bc-f2af36c4c426@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d2d7ca-7f2b-7eb4-78bc-f2af36c4c426@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:05:29PM -0800, John Hubbard wrote:
> This is an easy review and obviously correct, so:
> 
>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks

> Thoughts for the future of the API:
> 
> I will add that I could envision another patchset that went in the
> opposite direction, and attempted to preserve the information about
> how many pages were successfully read ahead. And that would be nice
> to have (at least IMHO), even all the way out to the syscall level,
> especially for the readahead syscall.

Right, and that was where I went initially.  It turns out to be a
non-trivial aount of work to do the book-keeping to find out how many
pages were _attempted_, and since we don't wait for the I/O to complete,
we don't know how many _succeeded_, and we also don't know how many
weren't attempted because they were already there, and how many weren't
attempted because somebody else has raced with us and is going to attempt
them themselves, and how many weren't attempted because we just ran out
of memory, and decided to give up.

Also, we don't know how many pages were successfully read, and then the
system decided to evict before the program found out how many were read,
let alone before it did any action based on that.

So, given all that complexity, and the fact that nobody actually does
anything with the limited and incorrect information we tried to provide
today, I think it's fair to say that anybody who wants to start to do
anything with that information can delve into all the complexity around
"what number should we return, and what does it really mean".  In the
meantime, let's just ditch the complexity and pretense that this number
means anything.
