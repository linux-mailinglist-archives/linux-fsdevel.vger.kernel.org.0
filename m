Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78DEA46AC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 02:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfIAAwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 20:52:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfIAAwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 20:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jXXM66EKtvmEAYvb1Llji9/A136eINaxlL5uqBe0OBY=; b=eBz5M1QVpKJZMQDzXUQ9MXhMT
        rIK2EkzUbSraojFclMxJ7OU+sf7tbq9mwzo0REl3yaDUt2YpbGdUBXr1PBULu2aic9sZuNzSPwoCp
        owngjkSk9HrwVrtscNCYj+aZ/17/cGG88hXmrwj3PKy0BJCvg4ElKAVolJU/MnnAZSwlpMqAmc62e
        AMUhgpKdATQQ056Kf77qv58BUxrXE6ktixwa0beiRV9gpk+ZAtbCCa1VAH88gCyyf5jTc6PxLSazv
        wV7o8Fq43JPBfe5nZRIUcQcvYRvRzMraHjUnFk9kNgyg6rLAwcalK0UgYckSGwX3KhjlxftyTplES
        EIwb3V+yg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4E69-0007JD-OE; Sun, 01 Sep 2019 00:52:05 +0000
Date:   Sat, 31 Aug 2019 17:52:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <20190901005205.GA2431@bombadil.infradead.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com>
 <20190828194607.GB6590@bombadil.infradead.org>
 <20190829073921.GA21880@dhcp22.suse.cz>
 <0100016ce39e6bb9-ad20e033-f3f4-4e6d-85d6-87e7d07823ae-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016ce39e6bb9-ad20e033-f3f4-4e6d-85d6-87e7d07823ae-000000@email.amazonses.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:41:46PM +0000, Christopher Lameter wrote:
> On Thu, 29 Aug 2019, Michal Hocko wrote:
> > > There are many places in the kernel which assume alignment.  They break
> > > when it's not supplied.  I believe we have a better overall system if
> > > the MM developers provide stronger guarantees than the MM consumers have
> > > to work around only weak guarantees.
> >
> > I absolutely agree. A hypothetical benefit of a new implementation
> > doesn't outweigh the complexity the existing code has to jump over or
> > worse is not aware of and it is broken silently. My general experience
> > is that the later is more likely with a large variety of drivers we have
> > in the tree and odd things they do in general.
> 
> The current behavior without special alignment for these caches has been
> in the wild for over a decade. And this is now coming up?

In the wild ... and rarely enabled.  When it is enabled, it may or may
not be noticed as data corruption, or tripping other debugging asserts.
Users then turn off the rare debugging option.

> There is one case now it seems with a broken hardware that has issues and
> we now move to an alignment requirement from the slabs with exceptions and
> this and that?

Perhaps you could try reading what hasa been written instead of sticking
to a strawman of your own invention?

> If there is an exceptional alignment requirement then that needs to be
> communicated to the allocator. A special flag or create a special
> kmem_cache or something.

The only way I'd agree to that is if we deliberately misalign every
allocation that doesn't have this special flag set.  Because right now,
breakage happens everywhere when these debug options are enabled, and
the very people who need to be helped are being hurt by the debugging.
