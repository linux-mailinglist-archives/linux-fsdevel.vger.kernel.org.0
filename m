Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3E4A3CE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 05:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357592AbiAaEWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 23:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiAaEWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:22:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9617C061714;
        Sun, 30 Jan 2022 20:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OLdzjKeQbAZ/xufoUOt+WpAslfh1hvc6hLdQ1kOi3Gs=; b=ho9BSG2IZhWlh0U5/kITCAulfO
        FbXaBXt8TzCbX2L4KRlFN3z48OolajKBQZNZLV5AXovZjARGAaZYQc1HD+7+vHTJaZT3qigW/CSs4
        YcwOh70Rv5WZpt5/zAWqu22VwCXZfSVJ+x4QNA+yKbnjz+X0Xi2DQ7SHkdvE1RXMH0abbt6oynLxc
        LS2QsDoseyoMZYIpNOiVUcVhVD+K0daCBMV0HOa8Lc20fGXDTAOcZpAcCqifPHLZLUcOh/Itd7Nt3
        HOuvJaTWwoeMUA2VJBk9y9uFIAuD9/r/Rr16Lhi3ztiPacF3dV/s2ys6xrNzVB06OxtGdAnA6tGr/
        NsBq18pQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEOD4-009Fmn-1e; Mon, 31 Jan 2022 04:22:34 +0000
Date:   Mon, 31 Jan 2022 04:22:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nfs: remove reliance on bdi congestion
Message-ID: <YfdkCsxyu0jpo+98@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183350.4233.691070075155620959.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164360183350.4233.691070075155620959.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:03:53PM +1100, NeilBrown wrote:
>  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
>     and the flag is set.

Is this actually useful?  I ask because Dave Chinner believes
the call to ->writepage in vmscan to be essentially unused.
See commit 21b4ee7029c9, and I had a followup discussion with him
on IRC:

<willy> dchinner: did you gather any stats on how often ->writepage was
	being called by pageout() before "xfs: drop ->writepage completely"
	was added?
<dchinner> willy: Never saw it on XFS in 3 years in my test environment...
<dchinner> I don't ever recall seeing the memory reclaim guards we put on
	->writepage in XFS ever firing - IIRC they'd been there for the best
	part of a decade.
<willy> not so much the WARN_ON firing but the case where it actually calls
	iomap_writepage
<dchinner> willy: I mean both - I was running with a local patch that warned
	on writepage for a long time, regardless of where it was called from.

I can believe things are different for a network filesystem, or maybe
XFS does background writeback better than other filesystems, but it
would be intriguing to be able to get rid of ->writepage altogether
(or at least from pageout(); migrate.c may be a thornier proposition).
