Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D82774F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgIXPNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbgIXPNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600960391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pyo3BqJobdw3Fesdiv8uTEeEmfJGGPZU40sRlf0Yk88=;
        b=f8L2i5rqUchNR5gj3hZPxDAkECnwva1gSChWjeh/X7bO9gaSW6cQ4Xby61kXDcz6Bd2QAi
        JAxY/CO24U7+qDiKEMO8XFpwON63Q1k09KmJjQy4fzuwJUAmvpiteS8CcQ/ZFfCV1u+f9b
        +Yat4czxxtCBBkrz0JCV5pR8xtzo1uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-bcNwtBvIMKK6Y_js6K0wRA-1; Thu, 24 Sep 2020 11:13:06 -0400
X-MC-Unique: bcNwtBvIMKK6Y_js6K0wRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6976681F02E;
        Thu, 24 Sep 2020 15:13:05 +0000 (UTC)
Received: from bfoster (ovpn-113-130.rdu2.redhat.com [10.10.113.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C83255C1D7;
        Thu, 24 Sep 2020 15:13:01 +0000 (UTC)
Date:   Thu, 24 Sep 2020 11:12:59 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200924151259.GB2603692@bfoster>
References: <20200924125608.31231-1-willy@infradead.org>
 <20200924131235.GA2603692@bfoster>
 <20200924135900.GV32101@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924135900.GV32101@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:59:00PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 24, 2020 at 09:12:35AM -0400, Brian Foster wrote:
> > On Thu, Sep 24, 2020 at 01:56:08PM +0100, Matthew Wilcox (Oracle) wrote:
> > > For filesystems with block size < page size, we need to set all the
> > > per-block uptodate bits if the page was already uptodate at the time
> > > we create the per-block metadata.  This can happen if the page is
> > > invalidated (eg by a write to drop_caches) but ultimately not removed
> > > from the page cache.
> > > 
> > > This is a data corruption issue as page writeback skips blocks which
> > > are marked !uptodate.
> > 
> > Thanks. Based on my testing of clearing PageUptodate here I suspect this
> > will similarly prevent the problem, but I'll give this a test
> > nonetheless. 
> > 
> > I am a little curious why we'd prefer to fill the iop here rather than
> > just clear the page state if the iop data has been released. If the page
> > is partially uptodate, then we end up having to re-read the page
> > anyways, right? OTOH, I guess this behavior is more consistent with page
> > size == block size filesystems where iop wouldn't exist and we just go
> > by page state, so perhaps that makes more sense.
> 
> Well, it's _true_ ... the PageUptodate bit means that every byte in this
> page is at least as new as every byte on storage.  There's no need to
> re-read it, which is what we'll do if we ClearPageUptodate.
> 

Yes, of course. I'm just noting the inconsistent behavior between a full
and partially uptodate page.

Brian

> My original motivation for this was splitting a THP.  In that case,
> we have, let's say, 16 * 4kB pages, and an iop for 64 blocks.  When we
> split that 64kB page into 16 4kB pages, we can't afford to allocate 16
> iops for them, so we just drop the iop and copy the uptodate state from
> the head page to all subpages.
> 
> So now we have 16 pages, all marked uptodate (and with valid data) but
> no iop.  So we need to create an iop for each page during the writeback
> path, and that has to be created with uptodate bits or we'll skip the
> entire page.  When I wrote the patch below, I had no idea we could
> already get an iop allocated for an uptodate page, or I would have
> submitted this patch months ago.
> 
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/bc503912d4a9aad4496a4591e9992f0ada47a9c9
> 

