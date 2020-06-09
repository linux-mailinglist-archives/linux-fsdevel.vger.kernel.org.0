Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98471F3E25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgFIOcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgFIOcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:32:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6DBC05BD1E;
        Tue,  9 Jun 2020 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zhFq2jA1ZPqLzkn56asn72ZB62NGUEkdDILPtsxItcQ=; b=DVF+LMYN8NYMF7z90TocnOwlEP
        kW40n+vz9Yc/PlNFM8AFdRS/Bl7dg673bm/gRQBiaaIkJYxelsibx1hARqD4cQ6fYBp9XwltfXTA+
        tY0dnZl5LykE1xqJlSFqrrdsW4kNqixAaO852mDnzHtP59eLjAA/cTPW36MPY6zFYE4esdG1hUuSr
        VzjpBs9hvbCznt0Lo19WWTkDdeJBGjj0fjcAXAcQdQE1MX/JtLQ9GZ8wnxHvqKdccbAjG3ObowVTh
        zLKrmC8gWUvlOvSF7t1qU+Amm+sYdR721hNy2f47jYzbcoBa3U4iyc6BRPj7og5whohWq6J+XGE+2
        gbwq2jng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jifIR-0005rS-FA; Tue, 09 Jun 2020 14:32:11 +0000
Date:   Tue, 9 Jun 2020 07:32:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: avoid deadlock if memory reclaim is triggered
 in writepage path
Message-ID: <20200609143211.GA22303@infradead.org>
References: <1591254347-15912-1-git-send-email-laoar.shao@gmail.com>
 <20200609140304.GA11626@infradead.org>
 <CALOAHbCeFFPCVS-toSC32qtLqQsEF1KG6p0OBXkQb=T2g6YpYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCeFFPCVS-toSC32qtLqQsEF1KG6p0OBXkQb=T2g6YpYw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:28:06PM +0800, Yafang Shao wrote:
> On Tue, Jun 9, 2020 at 10:03 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Jun 04, 2020 at 03:05:47AM -0400, Yafang Shao wrote:
> > > Recently there is a XFS deadlock on our server with an old kernel.
> > > This deadlock is caused by allocating memory in xfs_map_blocks() while
> > > doing writeback on behalf of memroy reclaim. Although this deadlock happens
> > > on an old kernel, I think it could happen on the upstream as well. This
> > > issue only happens once and can't be reproduced, so I haven't tried to
> > > reproduce it on upsteam kernel.
> >
> > The report looks sensible, but I don't think the iomap code is the
> > right place for this.  Until/unless the VM people agree that
> > ->writepages(s) generally should not recurse into the fs I think the
> > low-level file system allocating is the right place, so xfs_map_blocks
> > would seem like the correct place.
> 
> Thanks for your comment.
> That is what I did in the previous version [1].
> So should I resend the v1 ?

Well, v1 won't apply.  But I do prefer the approach there.
