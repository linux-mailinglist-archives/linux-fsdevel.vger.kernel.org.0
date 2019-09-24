Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70552BD3F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633466AbfIXVCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 17:02:23 -0400
Received: from gentwo.org ([3.19.106.255]:49460 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633461AbfIXVCX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:02:23 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 1036D3E9FC; Tue, 24 Sep 2019 20:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 0F13B3E9E5;
        Tue, 24 Sep 2019 20:52:52 +0000 (UTC)
Date:   Tue, 24 Sep 2019 20:52:52 +0000 (UTC)
From:   cl@linux.com
X-X-Sender: cl@www.lameter.com
To:     David Sterba <dsterba@suse.cz>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
In-Reply-To: <20190923171710.GN2751@twin.jikos.cz>
Message-ID: <alpine.DEB.2.21.1909242048020.17661@www.lameter.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz> <20190923171710.GN2751@twin.jikos.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Sep 2019, David Sterba wrote:

> As a user of the allocator interface in filesystem, I'd like to see a
> more generic way to address the alignment guarantees so we don't have to
> apply workarounds like 3acd48507dc43eeeb each time we find that we
> missed something. (Where 'missed' might be another sort of weird memory
> corruption hard to trigger.)

The alignment guarantees are clearly documented and objects are misaligned
in debugging kernels.

Looking at 3acd48507dc43eeeb:Looks like no one tested that patch with a
debug kernel or full debugging on until it hit mainline. Not good.

The consequence for the lack of proper testing is to make the production
kernel contain the debug measures?
