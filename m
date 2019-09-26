Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26FBBE967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfIZAQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 20:16:04 -0400
Received: from gentwo.org ([3.19.106.255]:49668 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbfIZAQE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:16:04 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 753313EEC6; Thu, 26 Sep 2019 00:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 73A743E86C;
        Thu, 26 Sep 2019 00:16:03 +0000 (UTC)
Date:   Thu, 26 Sep 2019 00:16:03 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
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
In-Reply-To: <34a45e87-5bad-5f01-7dcb-8a3f6cf37281@suse.cz>
Message-ID: <alpine.DEB.2.21.1909260015140.1508@www.lameter.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz> <20190923171710.GN2751@twin.jikos.cz> <alpine.DEB.2.21.1909242048020.17661@www.lameter.com>
 <20190924165425.a79a2dafbaf37828a931df2b@linux-foundation.org> <34a45e87-5bad-5f01-7dcb-8a3f6cf37281@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 25 Sep 2019, Vlastimil Babka wrote:

> Most of the new code is for SLOB, which has no debugging and yet
> misaligns. For SLUB and SLAB, it's just passing alignment argument to
> kmem_cache_create() for kmalloc caches, which means just extra few
> instructions during boot, and no extra code during kmalloc/kfree itself.

SLOB follows the standards for alignments in slab allocators and will
correctly align if you ask the allocator for a properly aligned object.

