Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B291C21FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfI3NcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 09:32:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3NcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jwTg4fslkkXzfCclLjZOgIaOdnKQRQ6WQVeTB5C7GPs=; b=GTsAp7UQvIcIvL7TkWfOBSdUl
        M6EGMhlYfNT8cjQLHe/X55q53qvVOm4qHmblR+q079BsjQ5IJL6GR7NCHXZopzNuDhg6Olt9GWJZf
        TuWtjBJdrVKCPCz5dV157Ng6PX7X3d2OWKAE5dWwmbqm+fPiwDYPLZRIsGT9W7P5WF0RA/+YKwg1V
        ZOHTI5PeaKSpRxD64+n/Vso0SEIefZGFuhgMefh1Jc8e4GkOyMi2owWOVqPMkF1L4tFxZx/S6CMm1
        CGRE7n3xBfoaoO/5xJs2pNSfHxGZzfESSdFdPlS3AMKKj3NdKP8XJoGmGlhxMVZVMbWyoc+BXXz04
        KjNnO/TQQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEvmW-0007wp-1A; Mon, 30 Sep 2019 13:32:04 +0000
Date:   Mon, 30 Sep 2019 06:32:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190930133203.GA26804@bombadil.infradead.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
 <20190923171710.GN2751@twin.jikos.cz>
 <alpine.DEB.2.21.1909242048020.17661@www.lameter.com>
 <20190924165425.a79a2dafbaf37828a931df2b@linux-foundation.org>
 <alpine.DEB.2.21.1909260005060.1508@www.lameter.com>
 <6a28a096-0e65-c7ea-9ca9-f72d68948e10@suse.cz>
 <alpine.DEB.2.21.1909272251190.21341@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909272251190.21341@www.lameter.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 28, 2019 at 01:12:49AM +0000, Christopher Lameter wrote:
> However, the layout may be different due to another allocator that prefers
> to arrange things differently (SLOB puts multiple objects of different
> types in the same page to save memory), if we need to add data to these
> objects (debugging info, new metadata about the object, maybe the memcg
> pointer, maybe other things that may come up), or other innovative
> approaches (such as putting data of different kmem caches that are
> commonly used together in the same page to improve locality).

If we ever do start putting objects of different sizes that are commonly
allocated together in the same page (eg inodes & dentries), then those
aren't going to be random kmalloc() allocation; they're going to be
special kmem caches that can specify "I don't care about alignment".

Also, we haven't done that.  We've had a slab allocator for twenty years,
and nobody's tried to do that.  Maybe the co-allocation would be a net
loss (I suspect).  Or the gain is too small for the added complexity.
Whatever way, this is a strawman.

> The cost is an unnecessary petrification of the data layout of the memory
> allocators.

Yes, it is.  And it's a cost I'm willing to pay in order to get the
guarantee of alignment.

