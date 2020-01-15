Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D314D13C7F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 16:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAOPgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 10:36:18 -0500
Received: from verein.lst.de ([213.95.11.211]:51570 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgAOPgS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:36:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B420968B20; Wed, 15 Jan 2020 16:36:14 +0100 (CET)
Date:   Wed, 15 Jan 2020 16:36:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200115153614.GA31296@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114192700.GC22037@ziepe.ca> <20200115065614.GC21219@lst.de> <20200115132428.GA25201@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115132428.GA25201@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:24:28AM -0400, Jason Gunthorpe wrote:
> > Your requirement seems a little different, and in fact in many ways
> > similar to the percpu_ref primitive.
> 
> I was interested because you are talking about allowing the read/write side
> of a rw sem to be held across a return to user space/etc, which is the
> same basic problem.
> 
> precpu refcount looks more like a typical refcount with a release that
> is called by whatever context does the final put. The point above is
> to basically move the release of a refcount into a synchrnous path by
> introducing some barrier to wait for the refcount to go to zero. In
> the above the barrier is the down_write() as it is really closer to a
> rwsem than a refcount.

No, percpu_ref is a little different than the name suggests, as it has
a magic initial reference, and then the other short term reference.  To
actually tear it down now just a normal put of the reference is needed,
but an explicit percpu_ref_kill or percpu_ref_kill_and_confirm.  Various
callers (including all I added) would like that operation to be
synchronous and currently hack that up, so a version of the percpu_ref
that actually waits for the other references to away like we hacked
up various places seems to exactly suit your requirements.
