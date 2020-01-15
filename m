Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5913CCCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 20:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAOTHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 14:07:48 -0500
Received: from verein.lst.de ([213.95.11.211]:52404 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgAOTHs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:07:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9783D68B20; Wed, 15 Jan 2020 20:07:44 +0100 (CET)
Date:   Wed, 15 Jan 2020 20:07:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200115190744.GA2628@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114192700.GC22037@ziepe.ca> <20200115065614.GC21219@lst.de> <20200115132428.GA25201@ziepe.ca> <20200115143347.GL2827@hirez.programming.kicks-ass.net> <20200115144948.GB25201@ziepe.ca> <849239ff-d2d1-4048-da58-b4347e0aa2bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849239ff-d2d1-4048-da58-b4347e0aa2bd@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:03:22PM -0500, Waiman Long wrote:
> >> (1) no unlocking by another process than the one that acquired it
> >> (2) no return to userspace with locks held
> > As an example flow: obtain the read side lock, schedual a work queue,
> > return to user space, and unlock the read side from the work queue.
> 
> We currently have down_read_non_owner() and up_read_non_owner() that
> perform the lock and unlock without lockdep tracking. Of course, that is
> a hack and their use must be carefully scrutinized to make sure that
> there is no deadlock or other potentially locking issues.

That doesn't help with returning to userspace while the lock is held.
