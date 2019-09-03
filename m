Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0280A75B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfICUxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:53:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfICUxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9j9Ys3SKrunuUdWnpddWrlF3hlzVX+dYskTpGsMVRdg=; b=q6PKtm2qHXC4ZxDd1oWAesGqt
        mkef31ksS0DE/m+V94xxk8mY4E4NK7/D6yceAd4IMOYEtng6UUMmitBiFDXkmyC3VsZShsSIDhDxA
        spbPZghZh0gaSPUEaq9m2Id0riRmEJzPcniu1pE5CxkkCA32WDRJ3NzR/05hgewKmdlszxQcADztH
        z19osbBcPHxeseNqIEdEFRXQ1AGIdZ5S6kJBEUtzqgvVeooolY2oxTjjKG+adYErsSQPK+86v+0qP
        AK7u61q/Rmd8W04N+VU/Ik4OalyMQ207Yu/0eA5EaNXbWRdvGCZGHdJNie5vvkiHaECkD4l0efUVb
        n2xH0iMQA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Fnc-0005w9-SY; Tue, 03 Sep 2019 20:53:12 +0000
Date:   Tue, 3 Sep 2019 13:53:12 -0700
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
Message-ID: <20190903205312.GK29434@bombadil.infradead.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com>
 <20190828194607.GB6590@bombadil.infradead.org>
 <20190829073921.GA21880@dhcp22.suse.cz>
 <0100016ce39e6bb9-ad20e033-f3f4-4e6d-85d6-87e7d07823ae-000000@email.amazonses.com>
 <20190901005205.GA2431@bombadil.infradead.org>
 <0100016cf8c3033d-bbcc9ba3-2d59-4654-a7c2-8ba094f8a7de-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016cf8c3033d-bbcc9ba3-2d59-4654-a7c2-8ba094f8a7de-000000@email.amazonses.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 08:13:45PM +0000, Christopher Lameter wrote:
> On Sat, 31 Aug 2019, Matthew Wilcox wrote:
> 
> > > The current behavior without special alignment for these caches has been
> > > in the wild for over a decade. And this is now coming up?
> >
> > In the wild ... and rarely enabled.  When it is enabled, it may or may
> > not be noticed as data corruption, or tripping other debugging asserts.
> > Users then turn off the rare debugging option.
> 
> Its enabled in all full debug session as far as I know. Fedora for
> example has been running this for ages to find breakage in device drivers
> etc etc.

Are you telling me nobody uses the ramdisk driver on fedora?  Because
that's one of the affected drivers.

> > > If there is an exceptional alignment requirement then that needs to be
> > > communicated to the allocator. A special flag or create a special
> > > kmem_cache or something.
> >
> > The only way I'd agree to that is if we deliberately misalign every
> > allocation that doesn't have this special flag set.  Because right now,
> > breakage happens everywhere when these debug options are enabled, and
> > the very people who need to be helped are being hurt by the debugging.
> 
> That is customarily occurring for testing by adding "slub_debug" to the
> kernel commandline (or adding debug kernel options) and since my
> information is that this is done frequently (and has been for over a
> decade now) I am having a hard time believing the stories of great
> breakage here. These drivers were not tested with debugging on before?
> Never ran with a debug kernel?

Whatever is being done is clearly not enough to trigger the bug.  So how
about it?  Create an option to slab/slub to always return misaligned
memory.

