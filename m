Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2483B563F0D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 10:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiGBIHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 04:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiGBIHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 04:07:22 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCFB52496F
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Jul 2022 01:07:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CE9325ECEFC;
        Sat,  2 Jul 2022 18:07:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o7Y9m-00DaJT-Ua; Sat, 02 Jul 2022 18:07:11 +1000
Date:   Sat, 2 Jul 2022 18:07:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     James Yonan <james@openvpn.net>
Cc:     linux-fsdevel@vger.kernel.org, neilb@suse.de, amir73il@gmail.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] namei: implemented RENAME_NEWER_MTIME flag for
 renameat2() conditional replace
Message-ID: <20220702080710.GB3108597@dread.disaster.area>
References: <a4ea9789-6126-e058-8f55-6dfc8a3f30c3@openvpn.net>
 <20220701092326.1845210-1-james@openvpn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701092326.1845210-1-james@openvpn.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62bffcb3
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=uDo-SIiEAAAA:8 a=7-415B0cAAAA:8
        a=skXxjZ357ps82uG1LdEA:9 a=CjuIK1q_8ugA:10 a=Rkhf4GTZPwEC63LfVcCP:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:23:26AM -0600, James Yonan wrote:
> RENAME_NEWER_MTIME is a new userspace-visible flag for renameat2(), and
> stands alongside existing flags such as RENAME_NOREPLACE, RENAME_EXCHANGE,
> and RENAME_WHITEOUT.
> 
> RENAME_NEWER_MTIME is a conditional variation on RENAME_NOREPLACE, and
> indicates that if the target of the rename exists, the rename or exchange
> will only succeed if the source file is newer than the target (i.e. source
> mtime > target mtime).  Otherwise, the rename will fail with -EEXIST
> instead of replacing the target.  When the target doesn't exist,
> RENAME_NEWER_MTIME does a plain rename like RENAME_NOREPLACE.
> 
> RENAME_NEWER_MTIME can also be combined with RENAME_EXCHANGE for
> conditional exchange, where the exchange only occurs if source mtime >
> target mtime.  Otherwise, the operation will fail with -EEXIST.
> 
> RENAME_NEWER_MTIME is very useful in distributed systems that mirror a
> directory structure, or use a directory as a key/value store, and need to
> guarantee that files will only be overwritten by newer files, and that all
> updates are atomic.

You need to cc linux-api and write a renameat2() man page update
that documents how this option behaves for application developers.
The bits where it will appear to randomly fail are especially
important to document properly...

> RENAME_NEWER_MTIME is implemented in vfs_rename(), and we lock and deny
> write access to both source and target inodes before comparing their
> mtimes, to stabilize the comparison.
> 
> So one question to ask is could this functionality be implemented in
> userspace without adding a new renameat2() flag?  I think you could
> attempt it with iterative RENAME_EXCHANGE, but it's hackish, inefficient,
> and not atomic, because races could cause temporary mtime backtracks.
> How about using file locking?  Probably not, because the problem we want
> to solve is maintaining file/directory atomicity for readers by creating
> files out-of-directory, setting their mtime, and atomically moving them
> into place.  The strategy to lock such an operation really requires more
> complex locking methods than are generally exposed to userspace.  And if
> you are using inotify on the directory to notify readers of changes, it
> certainly makes sense to reduce unnecessary churn by preventing a move
> operation based on the mtime check.
> 
> While some people might question the utility of adding features to
> filesystems to make them more like databases, there is real value in the
> performance, atomicity, consistent VFS interface, multi-thread safety, and
> async-notify capabilities of modern filesystems that starts to blur the
> line, and actually make filesystem-based key-value stores a win for many
> applications.
> 
> Like RENAME_NOREPLACE, the RENAME_NEWER_MTIME implementation lives in
> the VFS, however the individual fs implementations do strict flags
> checking and will return -EINVAL for any flag they don't recognize.
> At this time, I have enabled and tested RENAME_NEWER_MTIME on ext2, ext3,
> ext4, xfs, btrfs, and tmpfs.
> 
> I did not notice a general self-test for renameat2() at the VFS
> layer (outside of fs-specific tests), so I created one, though
> at the moment it only exercises RENAME_NEWER_MTIME and RENAME_EXCHANGE.
> The self-test is written to be portable to the Linux Test Project,
> and the advantage of running it there is that it automatically runs
> tests on multiple filesystems.  See comments at the beginning of
> renameat2_tests.c for more info.
> 
> Build and run the self-test with:
> 
>   make -C tools/testing/selftests TARGETS=renameat2 run_tests
> 
> Questions:
> 
> Q: Why use mtime and not ctime for timestamp comparison?
> 
> A: I think the "use a directory as a key/value store" use case
>    cares about the modification time of the file content rather
>    than metadata.  Also, the rename operation itself modifies
>    ctime, making it less useful as a reference timestamp.
>    In any event, this patch creates the infrastructure for
>    conditional rename/exchange based on inode timestamp, so a
>    subsequent patch to add RENAME_NEWER_CTIME would be a mostly
>    trivial exercise.
> 
> Q: Why compare mtimes when some systems have poor system clock
>    accuracy and resolution?
> 
> A: So in the "use a directory as a key/value store" use case
>    in distributed systems, the file mtime is actually determined
>    remotely by the file content creator and is set locally
>    via futimens() rather than the local system clock.  So this gives
>    you nanosecond-scale time resolution if the content creator
>    supports it, even if the local system clock has less resolution.

That's not a useful answer to an application developer wondering if
he can use this feature in his application. This answer is the
justification of why *your application doesn't care* about poor
timestamp resolution, not an explanation of how some other
application can detect and/or address the problem when it arises...

.....

> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index de11992dc577..34226dfbca7a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -54,6 +54,7 @@ TARGETS += proc
>  TARGETS += pstore
>  TARGETS += ptrace
>  TARGETS += openat2
> +TARGETS += renameat2
>  TARGETS += resctrl
>  TARGETS += rlimits
>  TARGETS += rseq
> diff --git a/tools/testing/selftests/renameat2/.gitignore b/tools/testing/selftests/renameat2/.gitignore
> new file mode 100644
> index 000000000000..79bbdf497559
> --- /dev/null
> +++ b/tools/testing/selftests/renameat2/.gitignore
> @@ -0,0 +1 @@
> +renameat2_tests
> diff --git a/tools/testing/selftests/renameat2/Makefile b/tools/testing/selftests/renameat2/Makefile
> new file mode 100644
> index 000000000000..c39f5e281a5d
> --- /dev/null
> +++ b/tools/testing/selftests/renameat2/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS = -g -Wall -O2
> +CFLAGS += $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS := renameat2_tests
> +
> +include ../lib.mk
> +
> +$(OUTPUT)/renameat2_tests: renameat2_tests.c
> diff --git a/tools/testing/selftests/renameat2/renameat2_tests.c b/tools/testing/selftests/renameat2/renameat2_tests.c
> new file mode 100644
> index 000000000000..1fdb908cf428
> --- /dev/null
> +++ b/tools/testing/selftests/renameat2/renameat2_tests.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Written by James Yonan <james@openvpn.net>
> + * Copyright (c) 2022 OpenVPN, Inc.
> + */
.....

Please add the test in a separate patch. You probably also want to
write tests for fstests so that it gets exercised regularly by
filesystem developers who will notice when it breaks on their
filesystem......

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
