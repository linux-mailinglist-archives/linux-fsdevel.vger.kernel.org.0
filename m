Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67B0A3D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfH3Rlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 13:41:47 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:43362 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727914AbfH3Rlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1567186906;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=O4l8bfyB+VvL+95TNWx4FpZqRMWRe8LWpmXp151rZPQ=;
        b=jOwxuN0/GsY64oKXgfJmdwBB+AXtX2WpGHqJuhQjx2ptbH8DVIIqkqyXxRD8yOn8
        GV8ejswyFu4wYPPvC5trc2TJ+u/8YK8DHJOysSHUEOvy5EY/yEQJyv85OgQB3tVrNRO
        oEjKdNcHWMyjIds//broy3iaTxgNIeqHLNuDl3dY=
Date:   Fri, 30 Aug 2019 17:41:46 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Michal Hocko <mhocko@kernel.org>
cc:     Matthew Wilcox <willy@infradead.org>,
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
In-Reply-To: <20190829073921.GA21880@dhcp22.suse.cz>
Message-ID: <0100016ce39e6bb9-ad20e033-f3f4-4e6d-85d6-87e7d07823ae-000000@email.amazonses.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com> <20190828194607.GB6590@bombadil.infradead.org>
 <20190829073921.GA21880@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.08.30-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Aug 2019, Michal Hocko wrote:

> > There are many places in the kernel which assume alignment.  They break
> > when it's not supplied.  I believe we have a better overall system if
> > the MM developers provide stronger guarantees than the MM consumers have
> > to work around only weak guarantees.
>
> I absolutely agree. A hypothetical benefit of a new implementation
> doesn't outweigh the complexity the existing code has to jump over or
> worse is not aware of and it is broken silently. My general experience
> is that the later is more likely with a large variety of drivers we have
> in the tree and odd things they do in general.


The current behavior without special alignment for these caches has been
in the wild for over a decade. And this is now coming up?

There is one case now it seems with a broken hardware that has issues and
we now move to an alignment requirement from the slabs with exceptions and
this and that?

If there is an exceptional alignment requirement then that needs to be
communicated to the allocator. A special flag or create a special
kmem_cache or something.
