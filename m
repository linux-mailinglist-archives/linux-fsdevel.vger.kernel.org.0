Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4E3FF988
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 06:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhICEam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 00:30:42 -0400
Received: from verein.lst.de ([213.95.11.211]:53529 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhICEak (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:30:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4019668AFE; Fri,  3 Sep 2021 06:29:37 +0200 (CEST)
Date:   Fri, 3 Sep 2021 06:29:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.15
Message-ID: <20210903042937.GA21466@lst.de>
References: <20210831211847.GC9959@magnolia> <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com> <87wnnybxkb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnnybxkb.ffs@tglx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 09:13:24PM +0200, Thomas Gleixner wrote:
> > I'm only throwing this out as a reaction to this - I'm not sure
> > another interface would be good or worthwhile, but that "enum
> > cpuhp_state" is ugly enough that I thought I'd rope in Thomas for CPU
> > hotplug, and the percpu memory allocation people for comments.
> 
> It's not only about memory. 
> 
> > IOW, just _maybe_ we would want to have some kind of callback model
> > for "percpu_alloc()" and it being explicitly about allocations
> > becoming available or going away, rather than about CPU state.
> 
> The per cpu storage in XFS does not go away. It contains a llist head
> and the queued work items need to be moved from the dead CPU to an alive
> CPU and exposed to a work queue for processing. Similar to what we do
> with timers, hrtimers and other stuff.
> 
> If there are callbacks which are doing pretty much the same thing, then
> I'm all for a generic infrastructure for these.

In the block layer we've added a new per-cpu bio list, for which
the dead callback literally does nothing but free some memory.
For that case a simple callback would be neat, but I'm not sure how
common that is.
