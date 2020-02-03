Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87040150EDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgBCRqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 12:46:44 -0500
Received: from verein.lst.de ([213.95.11.211]:57186 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbgBCRqo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:46:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 66CB768B20; Mon,  3 Feb 2020 18:46:41 +0100 (CET)
Date:   Mon, 3 Feb 2020 18:46:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200203174641.GA20035@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200118092838.GB9407@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118092838.GB9407@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 08:28:38PM +1100, Dave Chinner wrote:
> I think it's pretty gross, actually. It  makes the same mistake made
> with locking in the old direct IO code - it encodes specific lock
> operations via flags into random locations in the DIO path. This is
> a very slippery slope, and IMO it is an layering violation to encode
> specific filesystem locking smeantics into a layer that is supposed
> to be generic and completely filesystem agnostic. i.e.  this
> mechanism breaks if a filesystem moves to a different type of lock
> (e.g. range locks), and history teaches us that we'll end up making
> a horrible, unmaintainable mess to support different locking
> mechanisms and contexts.
> 
> I think that we should be moving to a model where the filesystem
> provides an unlock method in the iomap operations structure, and if
> the method is present in iomap_dio_complete() it gets called for the
> filesystem to unlock the inode at the appropriate point. This also
> allows the filesystem to provide a different method for read or
> write unlock, depending on what type of lock it held at submission.
> This gets rid of the need for the iomap code to know what type of
> lock the caller holds, too.

I'd rather avoid yet another method.  But I think with a little
tweaking we can move the unlock into the ->end_io method.
