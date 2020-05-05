Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56581C5A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgEEPC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729289AbgEEPC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:02:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C81C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 08:02:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c10so2580456qka.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7FjP91SkgrTdYmk4uoRk09PuVQ/Ji8rbi00yg++Yf4U=;
        b=RKuEVxru2LByEM9bQeia+4mJabGJDno/R9rUAInjwZGfh9YKnSSuCDxLcYxGy9TOzw
         0rcQwQcW3xR7BIpr/DREFpixUUJmiEVNXQLle85uNTXW3ddIWv9KeChX3FapZ7aPuGGU
         ponHAXH9g24XomYlw/zn6jraGPFAHTw6bRgXaHdAkI94j7YaiB1i1fGhEFbbA159Jkiw
         fnUiHCHbCr8wPbqC5x/S8p51yP5oZoKLWwcgMhSBqIaKoGHyzbQOTlWJfENuYm6rKmOA
         7q6tit7c1RASFtWztKETHyySqzMrYfJNFchoylbqZ0/hktjMn5vUy+Y6pYG2KBkOPe0B
         Av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7FjP91SkgrTdYmk4uoRk09PuVQ/Ji8rbi00yg++Yf4U=;
        b=dv6i9f478aD9RinHnYTZ4PykaE/B5Jfw0Oe8Rj8DcYPmVF4xtSEj+Rr+xkmNTlLsU6
         YlB91xo5d5Y107cC7xF0f2OLhWkva83bmSCR0f5kNgXvvcqoOIoacYhN3j+wfQ6smr7B
         vQ2ptpn0tcDZO1zgM+v57ZQmbOXfqMxtqyupi1pqESU7d62/VZjG0sTGiJvMi7JNrNie
         V+kjxUlsUVLNuckxjUgRYRQl/vzSVnqsTPARo62dZ5eUEpC2G+R16nbXKvEQm/KMH3Cd
         J0AzcrFa2w22iedOVrl32vJFzl7ajeCAdvUy8xU/R5+uljsl3c/1+3fFSuulUxBwAUAL
         d77A==
X-Gm-Message-State: AGi0Pubi0FkPBwd6oec2TkJJGyIti4sRJiXn2YCWC3OvXUav8pD46Zh0
        ayWm0N1cykeuEg9Kvdqzn1QmwQ==
X-Google-Smtp-Source: APiQypKgpRBdJBUH5vYr9buD5cxFxsKftYnVKJs9ZxvIG0y9aRPVDNXcpfa4cGPTvEHifDzJpopDDA==
X-Received: by 2002:a05:620a:943:: with SMTP id w3mr3796419qkw.71.1588690976818;
        Tue, 05 May 2020 08:02:56 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id e3sm661471qkd.113.2020.05.05.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:02:56 -0700 (PDT)
Date:   Tue, 5 May 2020 11:02:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200505150241.GA58018@cmpxchg.org>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area>
 <20200429022732.GA401038@cmpxchg.org>
 <20200505062946.GH2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505062946.GH2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 04:29:46PM +1000, Dave Chinner wrote:
> On Tue, Apr 28, 2020 at 10:27:32PM -0400, Johannes Weiner wrote:
> > On Wed, Apr 29, 2020 at 07:47:34AM +1000, Dave Chinner wrote:
> > > On Tue, Apr 28, 2020 at 12:13:46PM -0400, Dan Schatzberg wrote:
> > > > This patch series does some
> > > > minor modification to the loop driver so that each cgroup can make
> > > > forward progress independently to avoid this inversion.
> > > > 
> > > > With this patch series applied, the above script triggers OOM kills
> > > > when writing through the loop device as expected.
> > > 
> > > NACK!
> > > 
> > > The IO that is disallowed should fail with ENOMEM or some similar
> > > error, not trigger an OOM kill that shoots some innocent bystander
> > > in the head. That's worse than using BUG() to report errors...
> > 
> > Did you actually read the script?
> 
> Of course I did. You specifically mean this bit:
> 
> echo 64M > $CGROUP/memory.max;
> mount -t tmpfs -o size=512m tmpfs /tmp;
> truncate -s 512m /tmp/backing_file
> losetup $LOOP_DEV /tmp/backing_file
> dd if=/dev/zero of=$LOOP_DEV bs=1M count=256;
> 
> And with this patch set the dd gets OOM killed because the
> /tmp/backing_file usage accounted to the cgroup goes over 64MB and
> so tmpfs OOM kills the IO...
> 
> As I said: that's very broken behaviour from a storage stack
> perspective.
> 
> > It's OOMing because it's creating 256M worth of tmpfs pages inside a
> > 64M cgroup. It's not killing an innocent bystander, it's killing in
> > the cgroup that is allocating all that memory - after Dan makes sure
> > that memory is accounted to its rightful owner.
> 
> What this example does is turn /tmp into thinly provisioned storage
> for $CGROUP via a restricted quota. It has a device size of 512MB,
> but only has physical storage capacity of 64MB, as constrained by
> the cgroup memory limit.  You're dealing with management of -storage
> devices- and -IO error reporting- here, not memory management.
> 
> When thin provisioned storage runs out of space - for whatever
> reason - and it cannot resolve the issue by blocking, then it *must*
> return ENOSPC to the IO submitter to tell it the IO has failed. This
> is no different to if we set a quota on /tmp/backing_file and it is
> exhausted at 64MB of data written - we fail the IO with ENOSPC or
> EDQUOT, depending on which quota we used.
> 
> IOWs, we have solid expectations on how block devices report
> unsolvable resource shortages during IO because those errors have to
> be handled correctly by whatever is submitting the IO. We do not use
> the OOM-killer to report or resolve ENOSPC errors.
>
> Indeed, once you've killed the dd, that CGROUP still consumes 64MB
> of tmpfs space in /tmp/backing_file, in which case any further IO to
> $LOOP_DEV is also going to OOM kill. These are horrible semantics
> for reporting errors to userspace.
>
> And if the OOM-killer actually frees the 64MB of data written to
> /tmp/backing_file through the $LOOP_DEV, then you're actually
> corrupting the storage and ensuring that nobody can read the data
> that was written to $LOOP_DEV.

Right, but that's just tmpfs. It doesn't have much to do with the loop
device or its semantics as a block device. (Although I don't think
most users really see loop as a true block device, but rather as a
namespacing tool that for better or worse happens to be implemented at
the block layer). But remove the loop device indirection and the tmpfs
semantics would be exactly the same.

tmpfs returns -ENOSPC when you run out of filesystem quota, but when
it tries to allocate memory and can't, it'll invoke the OOM killer as
a means to reclaim memory. And when that fails, it'll return -ENOMEM.

Dan's patches don't change the block device semantics of loop. They
just ensure that the chain of causality between writer and memory
allocation isn't broken.

In fact, it barely has anything to do with loop itself. If loop were
to do its redirections synchronously and in the context of the process
that is making requests, we wouldn't have this problem.

The generic problem is that of one process performing work on behalf
of another process with side-effects relevant to the originator. The
generic solution is to have the worker impersonate the process that
created the work in all the various aspects that matter.

Like io_uring and various other kthreads and workers doing use_mm()
when the address space of the process creating the work matters.

> So now lets put a filesystem on $LOOP_DEV in the above example, and
> write out data to the filesystem which does IO to $LOOP_DEV. Just by
> chance, the filesystem does some metadata writes iin the context of
> the user process doing the writes (because journalling, etc) and
> that metadata IO is what pushes the loop device over the cgroup's
> memory limit.
> 
> You kill the user application even though it wasn't directly
> responsible for going over the 64MB limit of space in $LOOP_DEV.
> What happens now to the filesystem's metadata IO?  Did $LOOP_DEV
> return an error, or after the OOM kill did the IO succeed?  What
> happens if all the IO being generated from the user application is
> metadata and that starts failing - killing the user application
> doesn't help anything - the filesystem IO is failing and that's
> where the errors need to be reported.
> 
> And if the answer is "metadata IO isn't accounted to the $CGROUP"
> then what happens when the tmpfs actually runs out of it's 512MB of
> space because of all the metadata the filesystem wrote (e.g. create
> lots of zero length files)? That's an ENOSPC error, and we'll get
> that from $LOOP_DEV just fine.

Well, what happens today if you write to a loop mount backed by tmpfs,
but the machine is *physically* out of memory?

None of these questions are new in the context of this patch set. The
cgroup annotations don't inject anything that isn't already happening.

When you use the loop device on a tmpfs backing today, logically
speaking you're charging the root cgroup. That may not have a user-set
limit, but it's limited by physical RAM.

With or without cgroup annotation, tmpfs needs to allocate memory, and
that can fail. The function that charges to a specific cgroup is just
a few lines below the function that physically allocates the
page. Both can invoke the OOM killer for slightly different reasons
that aren't really relevant to the loop device on top of it.

> So why should the same error - running out of tmpfs space vs running
> out of CGROUP quota space on tmpfs be handled differently? Either
> they are both ENOSPC IO errors, or they are both OOM kill vectors
> because tmpfs space has run out...

Because charging memory has allocation semantics, and tmpfs already
defines what those are.

> > As opposed to before this series, where all this memory isn't
> > accounted properly and goes to the root cgroup - where, ironically, it
> > could cause OOM and kill an actually innocent bystander.
> 
> Johannes, I didn't question the need for the functionality. I
> questioned the implementation and pointed out fundamental problems
> it has as well as the architectural questions raised by needing
> special kthread-based handling for correct accounting of
> cgroup-aware IO.
>
> It's a really bad look to go shoot the messenger when it's clear you
> haven't understood the message that was delivered.

Do I need to point out the irony here? ;)

Maybe let's focus on the technical questions and misunderstandings
first before throwing NAKs around.
