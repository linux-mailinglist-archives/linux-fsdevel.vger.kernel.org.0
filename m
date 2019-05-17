Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7681622062
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfEQWhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 18:37:08 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:38982 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728179AbfEQWhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 18:37:08 -0400
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2019 18:37:06 EDT
Received: from [4.30.142.84] (helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hRl91-000BD0-LI; Fri, 17 May 2019 18:16:03 -0400
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, jack@suse.cz,
        jmoyer@redhat.com, tytso@mit.edu, amakhalov@vmware.com,
        anishs@vmware.com, srivatsab@vmware.com,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: CFQ idling kills I/O performance on ext4 with blkio cgroup controller
Message-ID: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
Date:   Fri, 17 May 2019 15:16:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

One of my colleagues noticed upto 10x - 30x drop in I/O throughput
running the following command, with the CFQ I/O scheduler:

dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflags=dsync

Throughput with CFQ: 60 KB/s
Throughput with noop or deadline: 1.5 MB/s - 2 MB/s

I spent some time looking into it and found that this is caused by the
undesirable interaction between 4 different components:

- blkio cgroup controller enabled
- ext4 with the jbd2 kthread running in the root blkio cgroup
- dd running on ext4, in any other blkio cgroup than that of jbd2
- CFQ I/O scheduler with defaults for slice_idle and group_idle


When docker is enabled, systemd creates a blkio cgroup called
system.slice to run system services (and docker) under it, and a
separate blkio cgroup called user.slice for user processes. So, when
dd is invoked, it runs under user.slice.

The dd command above includes the dsync flag, which performs an
fdatasync after every write to the output file. Since dd is writing to
a file on ext4, jbd2 will be active, committing transactions
corresponding to those fdatasync requests from dd. (In other words, dd
depends on jdb2, in order to make forward progress). But jdb2 being a
kernel thread, runs in the root blkio cgroup, as opposed to dd, which
runs under user.slice.

Now, if the I/O scheduler in use for the underlying block device is
CFQ, then its inter-queue/inter-group idling takes effect (via the
slice_idle and group_idle parameters, both of which default to 8ms).
Therefore, everytime CFQ switches between processing requests from dd
vs jbd2, this 8ms idle time is injected, which slows down the overall
throughput tremendously!

To verify this theory, I tried various experiments, and in all cases,
the 4 pre-conditions mentioned above were necessary to reproduce this
performance drop. For example, if I used an XFS filesystem (which
doesn't use a separate kthread like jbd2 for journaling), or if I dd'ed
directly to a block device, I couldn't reproduce the performance
issue. Similarly, running dd in the root blkio cgroup (where jbd2
runs) also gets full performance; as does using the noop or deadline
I/O schedulers; or even CFQ itself, with slice_idle and group_idle set
to zero.

These results were reproduced on a Linux VM (kernel v4.19) on ESXi,
both with virtualized storage as well as with disk pass-through,
backed by a rotational hard disk in both cases. The same problem was
also seen with the BFQ I/O scheduler in kernel v5.1.

Searching for any earlier discussions of this problem, I found an old
thread on LKML that encountered this behavior [1], as well as a docker
github issue [2] with similar symptoms (mentioned later in the
thread).

So, I'm curious to know if this is a well-understood problem and if
anybody has any thoughts on how to fix it.

Thank you very much!


[1]. https://lkml.org/lkml/2015/11/19/359

[2]. https://github.com/moby/moby/issues/21485
     https://github.com/moby/moby/issues/21485#issuecomment-222941103

Regards,
Srivatsa
