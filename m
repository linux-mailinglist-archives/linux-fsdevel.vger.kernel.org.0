Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D58BF3A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 15:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfIZNCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 09:02:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:45980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfIZNCf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:02:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BE7CAEAE;
        Thu, 26 Sep 2019 13:02:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 55364DA8E5; Thu, 26 Sep 2019 15:02:52 +0200 (CEST)
Date:   Thu, 26 Sep 2019 15:02:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     cl@linux.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, dsterba@suse.cz,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190926130252.GP2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, cl@linux.com,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
 <20190923171710.GN2751@twin.jikos.cz>
 <20190923175146.GT2229799@magnolia>
 <alpine.DEB.2.21.1909242045250.17661@www.lameter.com>
 <20190924205133.GK1855@bombadil.infradead.org>
 <alpine.DEB.2.21.1909242053010.17661@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909242053010.17661@www.lameter.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:55:02PM +0000, cl@linux.com wrote:
> n Tue, 24 Sep 2019, Matthew Wilcox wrote:
> 
> > > There was a public discussion about this issue and from what I can tell
> > > the outcome was that the allocator already provides what you want. Which
> > > was a mechanism to misalign objects and detect these issues. This
> > > mechanism has been in use for over a decade.
> >
> > You missed the important part, which was *ENABLED BY DEFAULT*.  People
> > who are enabling a debugging option to debug their issues, should not
> > have to first debug all the other issues that enabling that debugging
> > option uncovers!
> 
> Why would you have to debug all other issues? You could put your patch on
> top of the latest stable or distro kernel for testing.

This does not work in development branches. They're based on some stable
point but otherwise there's a lot of new code that usually has bugs and
it's quite important be able to understand where the bug comes from.

And the debugging instrumentation is there to add more sanity checks and
canaries to catch overflows, assertions etc. If it's unreliable, then
there's no point using it during development, IOW fix all bugs first and
then see if there are more left after turning the debugging.
