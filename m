Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8B16B3A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 23:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgBXWRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 17:17:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXWRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SD1yx0YoAU9Bzlni+o86AkG96/rc/8SSS4sRPjtuIYU=; b=pB+5oZWVTu+RlW3J/EESOvRbJB
        BhenyWBT/6m8GOFdFElQJCxMbpx1xaeKthjka5pjD6jbGH4Yb4isWW678N/C1jEWJrUjOlo+gO3Wr
        Fc+GPx4uW5jDWOEduKUpXye86IX3XAlQeX17eAH1O9MrALkq72vBwumB3SryCX1PQ21Cu5rjB+LH+
        LFNujmpdrRUyH0LpGKYHkHsi54xutUiobEdAg4riDPA5mRYuMsyFoBP03wVQn0kFpk94BKaabAiRg
        qtA4ThIZJjuV+zv0m358v08Y+jltVma43bg6qDq7T97btYMe7X25tdyvSveobCz77SFx4CC7cEIkX
        lGoig/Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6M2v-00087x-1f; Mon, 24 Feb 2020 22:17:49 +0000
Date:   Mon, 24 Feb 2020 14:17:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200224221749.GA22231@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
 <20200220154741.GB19577@infradead.org>
 <20200220162404.GY24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220162404.GY24185@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:24:04AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 07:47:41AM -0800, Christoph Hellwig wrote:
> > On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > By putting the 'have we reached the end of the page' condition at the end
> > > of the loop instead of the beginning, we can remove the 'submit the last
> > > page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> > > didn't return 0, which would lead to an endless loop.
> > 
> > I'm obviously biassed a I wrote the original code, but I find the new
> > very much harder to understand (not that the previous one was easy, this
> > is tricky code..).
> 
> Agreed, I found the original code hard to understand.  I think this is
> easier because now cur_page doesn't leak outside this loop, so it has
> an obvious lifecycle.

I really don't like this patch, and would prefer if the series goes
ahead without it, as the current sctructure works just fine even
with the readahead changes.
