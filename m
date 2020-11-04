Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9742A6E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgKDT7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 14:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDT7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:59:51 -0500
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Nov 2020 11:59:50 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC6BC0613D3;
        Wed,  4 Nov 2020 11:59:50 -0800 (PST)
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 8B8D988844B;
        Wed,  4 Nov 2020 20:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1604519583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hiZt2WITfKG7+QNvYDbl1KNbn6nbu5pALnEYxLoMuDo=;
        b=uY54IW8QF7niyKZ3TIoHQiz4ES7gQf81HJS8GQmQ9Mm5ocWUd+lLseZxIsdG36cuGrTRsP
        6FH4rgyUqLvLFVcIVxz3seCOeHI4CIidRhHBy6d6NbizfubJSLNywH/cdp+i+63QOsNDfE
        pgUozdVlnRWF77W4RegEFUkkdGXJXNc=
MIME-Version: 1.0
Date:   Wed, 04 Nov 2020 20:53:03 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: bcachefs-for-review
In-Reply-To: <20201027200433.GA449905@moria.home.lan>
References: <20201027200433.GA449905@moria.home.lan>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <913f15a9f74615d6243391452206db53@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

On 27.10.2020 21:04, Kent Overstreet wrote:
> Here's where bcachefs is at and what I'd like to get merged:
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-review

Please excuse my ignorance if I missed things in other discussions, but 
if this is what's expected to be reviewed, why the submission is not 
splitted into reviewable patches?

> 
> Non bcachefs prep patches:
> 
>       Compiler Attributes: add __flatten
>       locking: SIX locks (shared/intent/exclusive)
>       mm: export find_get_pages_range()
>       mm: Add a mechanism to disable faults for a specific mapping
>       mm: Bring back vmalloc_exec
>       fs: insert_inode_locked2()
>       fs: factor out d_mark_tmpfile()
>       block: Add some exports for bcachefs
>       block: Add blk_status_to_str()
>       bcache: move closures to lib/
>       closures: closure_wait_event()
> 
>  block/bio.c                                    |   2 +
>  block/blk-core.c                               |  13 +-
>  drivers/md/bcache/Kconfig                      |  10 +-
>  drivers/md/bcache/Makefile                     |   4 +-
>  drivers/md/bcache/bcache.h                     |   2 +-
>  drivers/md/bcache/super.c                      |   1 -
>  drivers/md/bcache/util.h                       |   3 +-
>  fs/dcache.c                                    |  10 +-
>  fs/inode.c                                     |  40 ++
>  include/linux/blkdev.h                         |   1 +
>  {drivers/md/bcache => include/linux}/closure.h |  39 +-
>  include/linux/compiler_attributes.h            |   5 +
>  include/linux/dcache.h                         |   1 +
>  include/linux/fs.h                             |   1 +
>  include/linux/sched.h                          |   1 +
>  include/linux/six.h                            | 197 +++++++++
>  include/linux/vmalloc.h                        |   1 +
>  init/init_task.c                               |   1 +
>  kernel/Kconfig.locks                           |   3 +
>  kernel/locking/Makefile                        |   1 +
>  kernel/locking/six.c                           | 553 
> +++++++++++++++++++++++++
>  kernel/module.c                                |   4 +-
>  lib/Kconfig                                    |   3 +
>  lib/Kconfig.debug                              |   9 +
>  lib/Makefile                                   |   2 +
>  {drivers/md/bcache => lib}/closure.c           |  35 +-
>  mm/filemap.c                                   |   1 +
>  mm/gup.c                                       |   7 +
>  mm/nommu.c                                     |  18 +
>  mm/vmalloc.c                                   |  21 +
>  30 files changed, 937 insertions(+), 52 deletions(-)
>  rename {drivers/md/bcache => include/linux}/closure.h (94%)
>  create mode 100644 include/linux/six.h
>  create mode 100644 kernel/locking/six.c
>  rename {drivers/md/bcache => lib}/closure.c (89%)
> 
> New since last posting that's relevant to the rest of the kernel:
>  - Re: the DIO cache coherency issue, we finally have a solution that 
> hopefully
>    everyone will find palatable. We no longer try to do any fancy 
> recursive
>    locking stuff: if userspace issues a DIO read/write where the buffer 
> points
>    to the same address space as the file being read/written to, we just 
> return
>    an error.
> 
>    This requires a small change to gup.c, to add the check after the 
> VMA lookup.
>    My patch passes the mapping to check against via a new task_struct 
> member,
>    which is ugly because plumbing a new argument all the way to 
> __get_user_pages
>    is also going to be ugly and if I have to do that I'm likely to go 
> on a
>    refactoring binge, which gup.c looks like it needs anyways.
> 
>  - vmalloc_exec() is needed because bcachefs dynamically generates x86 
> machine
>    code - per btree node unpack functions.
> 
> Bcachefs changes since last posting:
>  - lots
>  - reflink is done
>  - erasure coding (reed solomon raid5/6) is maturing; I have declared 
> it ready
>    for beta testers and gotten some _very_ positive feedback on its 
> performance.
>  - btree key cache code is done and merged, big improvements to 
> multithreaded
>    write workloads
>  - inline data extents
>  - major improvements to how the btree code handles extents (still 
> todo:
>    re-implement extent merging)
>  - huge improvements to mount/unmount times on huge filesystems
>  - many, many bugfixes; bug reports are slowing and the bugs that are 
> being
>    reported look less and less concerning. In particular repair code is 
> getting
>    better and more polished.
> 
> TODO:
>  - scrub, repair of replicated data when one of the replicas fail the 
> checksum
>    check
>  - erasure coding needs repair code (it'll do reconstruct reads, but we 
> don't
>    have code to rewrite bad blocks in a stripe yet. this is going to be 
> a hassle
>    until we get backpointers)
>  - fsck isn't checking refcounts of reflinked extents yet
>  - bcachefs tests in ktest need to be moved to xfstests
>  - user docs are still very minimal
> 
> So that's roughly where things are at. I think erasure coding is going 
> to to be
> bcachefs's killer feature (or at least one of them), and I'm pretty 
> excited
> about it: it's a completely new approach unlike ZFS and btrfs, no write 
> hole (we
> don't update existing stripes in place) and we don't have to fragment 
> writes
> either like ZFS does. Add to that the caching that we already do and 
> it's
> turning into a pretty amazing tool for managing a whole bunch of mixed 
> storage.

-- 
   Oleksandr Natalenko (post-factum)
