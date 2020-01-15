Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F113BA00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 07:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgAOG4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 01:56:18 -0500
Received: from verein.lst.de ([213.95.11.211]:49228 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgAOG4S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:56:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E956E68AFE; Wed, 15 Jan 2020 07:56:14 +0100 (CET)
Date:   Wed, 15 Jan 2020 07:56:14 +0100
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
Message-ID: <20200115065614.GC21219@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114192700.GC22037@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114192700.GC22037@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 03:27:00PM -0400, Jason Gunthorpe wrote:
> I've seen similar locking patterns quite a lot, enough I've thought
> about having a dedicated locking primitive to do it. It really wants
> to be a rwsem, but as here the rwsem rules don't allow it.
> 
> The common pattern I'm looking at looks something like this:
> 
>  'try begin read'() // aka down_read_trylock()
> 
>   /* The lockdep release hackery you describe,
>      the rwsem remains read locked */
>  'exit reader'()
> 
>  .. delegate unlock to work queue, timer, irq, etc ..
> 
> in the new context:
> 
>  're_enter reader'() // Get our lockdep tracking back
> 
>  'end reader'() // aka up_read()
> 
> vs a typical write side:
> 
>  'begin write'() // aka down_write()
> 
>  /* There is no reason to unlock it before kfree of the rwsem memory.
>     Somehow the user prevents any new down_read_trylock()'s */
>  'abandon writer'() // The object will be kfree'd with a locked writer
>  kfree()
> 
> The typical goal is to provide an object destruction path that can
> serialize and fence all readers wherever they may be before proceeding
> to some synchronous destruction.
> 
> Usually this gets open coded with some atomic/kref/refcount and a
> completion or wait queue. Often implemented wrongly, lacking the write
> favoring bias in the rwsem, and lacking any lockdep tracking on the
> naked completion.
> 
> Not to discourage your patch, but to ask if we can make the solution
> more broadly applicable?

Your requirement seems a little different, and in fact in many ways
similar to the percpu_ref primitive.
