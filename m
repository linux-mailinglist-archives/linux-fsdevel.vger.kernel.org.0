Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E804BBE963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 02:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfIZAOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 20:14:45 -0400
Received: from gentwo.org ([3.19.106.255]:49630 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733141AbfIZAOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:14:45 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 17D1D3EEC6; Thu, 26 Sep 2019 00:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 150213E86C;
        Thu, 26 Sep 2019 00:14:44 +0000 (UTC)
Date:   Thu, 26 Sep 2019 00:14:44 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     David Sterba <dsterba@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
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
In-Reply-To: <20190924165425.a79a2dafbaf37828a931df2b@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1909260005060.1508@www.lameter.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz> <20190923171710.GN2751@twin.jikos.cz> <alpine.DEB.2.21.1909242048020.17661@www.lameter.com>
 <20190924165425.a79a2dafbaf37828a931df2b@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Sep 2019, Andrew Morton wrote:

> I agree it's a bit regrettable to do this but it does appear that the
> change will make the kernel overall a better place given the reality of
> kernel development.

No it wont.

- It will only work for special cases like the kmalloc array
without extras like metadata at the end of objects.

- It will be an inconsistency in the alignments provided by the allocator.

- It will cause us in the future to constantly consider these exceptional
alignments in the maintenance of the allocators.

- These alignments are only needed in exceptional cases but with the patch
we will provide the alignment by default even if the allocating subsystem
does not need it.

- We have mechanisms to detect alignment problems using debug kernels and
debug options that have been available for years. These were not used for
testing in these cases it seems before the patches hit mainline. Once in
mainly someone ran a debug kernel and found the issue.

> Given this, have you reviewed the patch for overall implementation
> correctness?

Yes, the patch is fine.

> I'm wondering if we can avoid at least some of the patch's overhead if
> slab debugging is disabled - the allocators are already returning
> suitably aligned memory, so why add the new code in that case?

As far as I know this patch is not needed given that we have had the
standards for alignments for a long time now.

Why would the allocators provide specially aligned memory just based on
the size of an object? This is weird and unexpected behavior.
