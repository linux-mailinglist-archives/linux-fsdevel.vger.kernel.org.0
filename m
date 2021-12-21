Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D26247C707
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 19:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbhLUSxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 13:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbhLUSxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:53:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E09BC061574;
        Tue, 21 Dec 2021 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gwpHtrzIOugNZWMQx41hhR0OAIjfgE+ZuqRIceukEmM=; b=D2vhuElqYArhg+AijxsJfFAeR2
        vJUS7dqklDDbRCMIMKSh692SjhB+K3ojUs6yc/MOqv0Vvqm5SL/6mKIny/YTKoQ1oAPrGeo5lXL4G
        UGnlNN9hcnihZPnDPi6wqtBYamemWq5vLO8LL8ceJemx0mssL8uqI7GlgMalOEgV/d8jpGp9/B5c5
        BmasU8LCDE+edfezHWrdAcbnrAu8cfEA23mnjgr8XcTJA4tZ8Wfaqe6H3TaRWm2ojGQ2MuiTATRwq
        GeLi4YZQyXLY1ry1iUBoyVJpoTcPiy6rWAJ5p8xmrr52E/J2JcDUdTPwDnDXDbC6LmBwaaXD4XKBT
        LChGTR9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzkGL-002jVn-Tw; Tue, 21 Dec 2021 18:53:25 +0000
Date:   Tue, 21 Dec 2021 18:53:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: iomap-folio & nvdimm merge
Message-ID: <YcIipecYCUrqbRBu@casper.infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-17-willy@infradead.org>
 <YcIIbtKhOulAL4s4@casper.infradead.org>
 <20211221184115.GY27664@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221184115.GY27664@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:41:15AM -0800, Darrick J. Wong wrote:
> >     iomap: Inline __iomap_zero_iter into its caller
> > 
> >     To make the merge easier, replicate the inlining of __iomap_zero_iter()
> >     into iomap_zero_iter() that is currently in the nvdimm tree.
> > 
> >     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Looks like a reasonable function promotion to me...
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks, applied that to the commit.

> > Shall I push out a version of this patch series which includes the
> > "iomap: Inline __iomap_zero_iter into its caller" patch I pasted above?
> 
> Yes.
> 
> I've been distracted for months with first a Huge Customer Escalation
> and now a <embargoed>, which means that I've been and continue to be
> very distracted.  I /think/ there are no other iomap patches being
> proposed for inclusion -- Andreas' patches were applied as fixes during
> 5.16-rc, Christoph's DAX refactoring is now in the nvdimm tree, and that
> leaves Matthew's folios refactoring.
> 
> So seeing as (I think?) there are no other iomap patches for 5.17, if
> Matthew wants to add his branch to for-next and push directly to Linus
> (rather than pushing to me to push the exact same branch to Linus) I
> think that would be ... better than letting it block on me.  IIRC I've
> RVB'd everything in the folios branch. :(
> 
> FWIW I ran the 5.17e branch through my fstests cloud and nothing fell
> out, so I think it's in good enough shape to merge to for-next.

Glad to hear it passed that thorough testing.  Stephen, please pick
up a new tree (hopefully just temporarily until Darrick can swim to
the surface):

 git://git.infradead.org/users/willy/linux.git folio-iomap

Hopefully the previous message will give you enough context for
the merge conflict resolution.
