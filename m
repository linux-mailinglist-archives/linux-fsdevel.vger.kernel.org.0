Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8325820AEB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFZJDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgFZJDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:03:16 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B9DC08C5C1;
        Fri, 26 Jun 2020 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S16fz6lo9KryqIgQOCLtuAMJm3zEkBOc3oSqDZv4FDI=; b=uZ5YHRupN53fy0Q7TGZ81ef3mj
        RwajTvvDVxXo97RTwKcwHYn0Ft4Psidug4IqSqdZm1Ho21Bb0FeKzkyIgO312i1QSZOTDmSxte4WA
        ZP6D5s6rl9shXGLjtc7RmG+Sgim+rqk8YuRKvnFX1oMGVv6/FSO7dhGOainjzdsuE8oxXYE1GQJjB
        lcvfjIV0V+/x3v8/yynAoj9YVz9GLueHzDazgQEsK58lHlsAojkvF5UWzfaGUWjl+l5gITKgW7w6h
        CPAtnxKAT9l+TIIT3mTxDcxuIsRwI/BNv+AJky1IxMTD8FKDpFLQ9haUxNkEv4WLTDNqiUPnbOlz3
        Jv8BHQcw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jokG2-0001Jo-FB; Fri, 26 Jun 2020 09:02:50 +0000
Date:   Fri, 26 Jun 2020 10:02:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, mhocko@kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, akpm@linux-foundation.org, bfoster@redhat.com,
        vbabka@suse.cz, holger@applied-asynchrony.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] xfs: reintroduce PF_FSTRANS for transaction
 reservation recursion protection
Message-ID: <20200626090250.GC30103@infradead.org>
References: <1593011142-10209-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593011142-10209-1-git-send-email-laoar.shao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:05:42AM -0400, Yafang Shao wrote:
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> means to avoid filesystem reclaim recursion. That change is subtle.
> Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> PF_MEMALLOC_NOFS is not proper.
> 
> Bellow comment is quoted from Dave,
> > It wasn't for memory allocation recursion protection in XFS - it was for
> > transaction reservation recursion protection by something trying to flush
> > data pages while holding a transaction reservation. Doing
> > this could deadlock the journal because the existing reservation
> > could prevent the nested reservation for being able to reserve space
> > in the journal and that is a self-deadlock vector.
> > IOWs, this check is not protecting against memory reclaim recursion
> > bugs at all (that's the previous check [1]). This check is
> > protecting against the filesystem calling writepages directly from a
> > context where it can self-deadlock.
> > So what we are seeing here is that the PF_FSTRANS ->
> > PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> > about what type of error this check was protecting against.
> 
> [1]. Bellow check is to avoid memory reclaim recursion.
> if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> 	PF_MEMALLOC))
> 	goto redirty;
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>

This generally looks sane, but:

 - adds a bunch of overly long lines for no good reason
 - doesn't really hide this behind a useful informatin, e.g. a
   xfs_trans_context_start/end helpers for the normal case, plus
   an extra helper with kswapd in the name for that case.

The latter should also help to isolate a bit against the mm-area
changes to the memalloc flags proposed.
