Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EEF1C578C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgEENz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729165AbgEENz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 09:55:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF2C0610D5
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 06:55:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so1680898lja.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9W+5Jm1b81UkwC63+rGAZ2lTBixHqKEHTO4R5ClYteM=;
        b=mEWDTOsvRfH8ej77W5x3aLADfUstdTw6WfDghmv/Zkfa8SB4RMzBaziHPDJ5p3x3dw
         7Dm4RQuOT4V1GffWyPxuMAT7l2ovGSh6LqZCI00mh05SP8aV5/fGZzfuF1f8IJbIhv5W
         cx89leMpPTfjAg/KVbmWmQki2ryF8mHz3DddN76pv7OPWhwlfMf+PP7yISHf/1HO5Ag4
         55DEYLd3k3ZVRwrK6U2M3xrcHTt8ja3dboNFFlZ0eIt+vZbS8MaxIpProcXDIyiQ7O2/
         46u71QHnQDhmcSM3yx/4VeoPp8QHhBWvXzZ011t1Gt0dzDpVGWM6RjtTxcU3zWOEZeYX
         SJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9W+5Jm1b81UkwC63+rGAZ2lTBixHqKEHTO4R5ClYteM=;
        b=NePTus2oVuA/j6AZ+T2lTXacSLukH7LsaxvZidoxB3kD/uimUFgJb5sAco/3hVKpV9
         MkVsNwLEKuSbJXzqN9AibZrr1uH2USZiY0ogrTVCQN3NmUtMxjn1IpASSTR1I1MGCxAj
         5w8RTHGYXTTQM9ysT4RufAMbFzYkIGjiD5r8Rn793LWWuYvf2wQpHjVmSF6Gy/lYyBWW
         IwJPf90kf4NvL4FtsZQS6WlAVXP1ckNHDNSLaVK3PCAp1ub/BlZBJ6D+/NMzFG8cj/IC
         B3BoMyCuRaGRg3Q6tGVferpwy3BIdyEjRMF4BjzBWEsS+ChLONiocNqXnYyPdXMMy+XB
         Qmlg==
X-Gm-Message-State: AGi0PuZNnq7jMYyDQCoY5Nkfe08JBnYlu+BH4liirWFg/g5ObxTLCOyl
        y2o0YMDkvRVmh0AQImg+QhAVtzt2H+xroJYqLNtxNw==
X-Google-Smtp-Source: APiQypKWE2FCFxKV2s9wAYb49OyHcE3r3lTHSIiwCOLimy5/O6x2crNpb4pMbTs0tmwgyWjKOUYCCNEguBVeAM1ggek=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr1852440ljo.168.1588686925417;
 Tue, 05 May 2020 06:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area> <20200429022732.GA401038@cmpxchg.org>
 <20200505062946.GH2005@dread.disaster.area>
In-Reply-To: <20200505062946.GH2005@dread.disaster.area>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 May 2020 06:55:14 -0700
Message-ID: <CALvZod6b8o3rtgvbR6LVBtSmynTiWomyvKdbN_Dyg58Th5Yk-A@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 4, 2020 at 11:30 PM Dave Chinner <david@fromorbit.com> wrote:
>
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

Before responding, I want to make it clear that the OOM behavior which
you are objecting to is already present in the kernel and is
independent of this patch series. This patch series is only connecting
the charging links which were missing for the loop device.

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

A few queries to better understand your objection:

Let's forget about the cgroup for a second. Let's suppose I am running
this script on a system/VM having 64 MiB. In your opinion what should
happen?

Next let's add the swap to the 64 MiB system/VM/cgroup and re-run the
script, what should be the correct behavior?

Next replace the tmpfs with any other disk backed file system and
re-run the script in a 64 MiB system/VM/cgroup, what should be the
correct behavior?

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
>
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
>
> So why should the same error - running out of tmpfs space vs running
> out of CGROUP quota space on tmpfs be handled differently? Either
> they are both ENOSPC IO errors, or they are both OOM kill vectors
> because tmpfs space has run out...
>
> See the problem here? We report storage resource shortages
> (whatever the cause) by IO errors, not by killing userspace
> processes. Userspace may be able to handle the IO error sanely; it
> has no warning or choice when you use OOM kill to report ENOSPC
> errors...
>
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
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
