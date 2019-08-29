Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012ABA12B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 09:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfH2HjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 03:39:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfH2HjY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:39:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78FB3B03B;
        Thu, 29 Aug 2019 07:39:22 +0000 (UTC)
Date:   Thu, 29 Aug 2019 09:39:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190829073921.GA21880@dhcp22.suse.cz>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com>
 <20190828194607.GB6590@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828194607.GB6590@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-08-19 12:46:08, Matthew Wilcox wrote:
> On Wed, Aug 28, 2019 at 06:45:07PM +0000, Christopher Lameter wrote:
[...]
> > be suprising and it limits the optimizations that slab allocators may use
> > for optimizing data use. The SLOB allocator was designed in such a way
> > that data wastage is limited. The changes here sabotage that goal and show
> > that future slab allocators may be similarly constrained with the
> > exceptional alignents implemented. Additional debugging features etc etc
> > must all support the exceptional alignment requirements.
> 
> While I sympathise with the poor programmer who has to write the
> fourth implementation of the sl*b interface, it's more for the pain of
> picking a new letter than the pain of needing to honour the alignment
> of allocations.
> 
> There are many places in the kernel which assume alignment.  They break
> when it's not supplied.  I believe we have a better overall system if
> the MM developers provide stronger guarantees than the MM consumers have
> to work around only weak guarantees.

I absolutely agree. A hypothetical benefit of a new implementation
doesn't outweigh the complexity the existing code has to jump over or
worse is not aware of and it is broken silently. My general experience
is that the later is more likely with a large variety of drivers we have
in the tree and odd things they do in general.
-- 
Michal Hocko
SUSE Labs
