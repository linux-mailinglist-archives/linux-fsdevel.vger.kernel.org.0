Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34326BD59F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 01:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442135AbfIXXy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 19:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442070AbfIXXy1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:54:27 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347D8206DD;
        Tue, 24 Sep 2019 23:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569369266;
        bh=77LgG7sH8ZOfn/RzxREA78GWTNS60M2eU3Gg2LZZdpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CFO304w0y4Fr7/j+umJCvtwPWv7SS5ZLtX3xcGFmOMnWdGOFDsQHVh3Dg/H0OkPSm
         VuUbswWYLalvFIXCA8dOGD6gAsdrEfG47lwYmUHNWLai2zcWU6tC/nScCvlXG9rvyO
         NliXcizh1hyn+s2NY5x+Vc48EG5aI2akmcTSgqLM=
Date:   Tue, 24 Sep 2019 16:54:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cl@linux.com
Cc:     David Sterba <dsterba@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-Id: <20190924165425.a79a2dafbaf37828a931df2b@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1909242048020.17661@www.lameter.com>
References: <20190826111627.7505-1-vbabka@suse.cz>
        <20190826111627.7505-3-vbabka@suse.cz>
        <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
        <20190923171710.GN2751@twin.jikos.cz>
        <alpine.DEB.2.21.1909242048020.17661@www.lameter.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Sep 2019 20:52:52 +0000 (UTC) cl@linux.com wrote:

> On Mon, 23 Sep 2019, David Sterba wrote:
> 
> > As a user of the allocator interface in filesystem, I'd like to see a
> > more generic way to address the alignment guarantees so we don't have to
> > apply workarounds like 3acd48507dc43eeeb each time we find that we
> > missed something. (Where 'missed' might be another sort of weird memory
> > corruption hard to trigger.)
> 
> The alignment guarantees are clearly documented and objects are misaligned
> in debugging kernels.
> 
> Looking at 3acd48507dc43eeeb:Looks like no one tested that patch with a
> debug kernel or full debugging on until it hit mainline. Not good.
> 
> The consequence for the lack of proper testing is to make the production
> kernel contain the debug measures?

This isn't a debug measure - it's making the interface do that which
people evidently expect it to do.  Minor point.

I agree it's a bit regrettable to do this but it does appear that the
change will make the kernel overall a better place given the reality of
kernel development.

Given this, have you reviewed the patch for overall implementation
correctness?

I'm wondering if we can avoid at least some of the patch's overhead if
slab debugging is disabled - the allocators are already returning
suitably aligned memory, so why add the new code in that case?

