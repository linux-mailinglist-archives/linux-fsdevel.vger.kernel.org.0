Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F69379AA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 01:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEJXTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 19:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhEJXSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 19:18:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A5C06175F;
        Mon, 10 May 2021 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BW26sTae1TuwCrPQcAIuja8vE5ngJppHhl5QwuMgUgw=; b=RBQ1JR4S5T9WsAErivz3mXmyXq
        61FxgaT5cOHkvLW3xNizmRJGm4V9/KLa0xEdSTh5bY6ek/9bPJQ8zA9tPevkS00PSO7tk7SmyYww7
        yyY9EpJ/aMkCihtFa+ng+GeP1+4YnEbqSqInLTmG8EhFusn2LegxT3pnHh5Num6Rg3sapJZc2vjC6
        3mGftV02NZOdzabpzAnBp3diTC2dZNPsY+4mh/GL2+TacmSJOvqYcTTM0beOPrnVHcHliL+fZNvuJ
        HVoM+9ZcQQAqa0irZBrRs9sKGPw3Q+GFbm2FiVx/nUaAc+cbHlwQkqUpZi4zHUyEZtjyJAohGnO3Z
        mqq8XEVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgF9I-006fzl-UW; Mon, 10 May 2021 23:17:22 +0000
Date:   Tue, 11 May 2021 00:17:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Fix readahead return types
Message-ID: <YJm+/IFdA4xe1oie@casper.infradead.org>
References: <20210510201201.1558972-1-willy@infradead.org>
 <20210510222756.GI8582@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510222756.GI8582@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 03:27:56PM -0700, Darrick J. Wong wrote:
> On Mon, May 10, 2021 at 09:12:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > A readahead request will not allocate more memory than can be represented
> > by a size_t, even on systems that have HIGHMEM available.  Change the
> > length functions from returning an loff_t to a size_t.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Looks reasonable to me; is this a 5.13 bugfix or just something that
> doesn't look right (i.e. save it for 5.14)?
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks!  Linus was unhappy about it, and I promised to fix it.  I leave
it up to Andrew whether he wants to see this in 5.13 or 5.14.

https://lore.kernel.org/linux-btrfs/CAHk-=wj1KRvb=hie1VUTGo1D_ckD+Suo0-M2Nh5Kek1Wu=2Ppw@mail.gmail.com/

(I went a little beyond what he was directly unhappy with and reviewed
all the readahead.*length users for unnecessary loff_t usage)
