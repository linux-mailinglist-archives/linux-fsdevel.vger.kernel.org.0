Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4A570DF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiGKXKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGKXKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:10:37 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40311509DA;
        Mon, 11 Jul 2022 16:10:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 73BF962C645;
        Tue, 12 Jul 2022 09:10:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oB2Xr-00HNYn-S2; Tue, 12 Jul 2022 09:10:27 +1000
Date:   Tue, 12 Jul 2022 09:10:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     James Yonan <james@openvpn.net>
Cc:     linux-fsdevel@vger.kernel.org, neilb@suse.de, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/2] namei: implemented RENAME_NEWER_MTIME flag for
 renameat2() conditional replace
Message-ID: <20220711231027.GB3600936@dread.disaster.area>
References: <20220702080710.GB3108597@dread.disaster.area>
 <20220711191331.2739584-1-james@openvpn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711191331.2739584-1-james@openvpn.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62ccade6
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=6toQ-ixSPVOhMIrCZusA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 01:13:30PM -0600, James Yonan wrote:
> RENAME_NEWER_MTIME is a new userspace-visible flag for renameat2(), and
> stands alongside existing flags including RENAME_NOREPLACE,
> RENAME_EXCHANGE, and RENAME_WHITEOUT.
> 
> RENAME_NEWER_MTIME is a conditional variation on RENAME_NOREPLACE, and
> indicates that if the target of the rename exists, the rename or exchange
> will only succeed if the source file is newer than the target (i.e.
> source mtime > target mtime).  Otherwise, the rename will fail with
> -EEXIST instead of replacing the target.  When the target doesn't exist,
> RENAME_NEWER_MTIME does a plain rename like RENAME_NOREPLACE.
> 
> RENAME_NEWER_MTIME can also be combined with RENAME_EXCHANGE for
> conditional exchange, where the exchange only occurs if source mtime >
> target mtime.  Otherwise, the operation will fail with -EEXIST.
> 
> Some of the use cases for RENAME_NEWER_MTIME include (a) using a
> directory as a key-value store, or (b) maintaining a near-real-time
> mirror of a remote data source.  A common design pattern for maintaining
> such a data store would be to create a file using a temporary pathname,
> setting the file mtime using utimensat(2) or futimens(2) based on the
> remote creation timestamp of the file content, then using
> RENAME_NEWER_MTIME to move the file into place in the target directory.
> If the operation returns an error with errno == EEXIST, then the source
> file is not up-to-date and can safely be deleted. The goal is to
> facilitate distributed systems having many concurrent writers and
> readers, where update notifications are possibly delayed, duplicated, or
> reordered, yet where readers see a consistent view of the target
> directory with predictable semantics and atomic updates.
> 
> Note that RENAME_NEWER_MTIME depends on accurate, high-resolution
> timestamps for mtime, preferably approaching nanosecond resolution.
> 
> RENAME_NEWER_MTIME is implemented in vfs_rename(), and we lock and deny
> write access to both source and target inodes before comparing their
> mtimes, to stabilize the comparison.
> 
> The use case for RENAME_NEWER_MTIME doesn't really align with
> directories, so we return -EISDIR if either source or target is a
> directory.  This makes the locking necessary to stabilize the mtime
> comparison (in vfs_rename()) much more straightforward.
> 
> Like RENAME_NOREPLACE, the RENAME_NEWER_MTIME implementation lives in
> the VFS, however the individual fs implementations do strict flags
> checking and will return -EINVAL for any flag they don't recognize.
> At this time, I have enabled and tested RENAME_NEWER_MTIME on ext2, ext3,
> ext4, xfs, btrfs, and tmpfs.
> 
> I did not notice a general self-test for renameat2() at the VFS
> layer (outside of fs-specific tests),

We have a whole bunch of renameat2() tests in fstests that cover all
the functionality of renameat2(), and fsstress will also exercise it
in stress workloads, too:

$ git grep -l renameat2
.gitignore
common/renameat2
configure.ac
ltp/fsstress.c
src/Makefile
src/renameat2.c
tests/btrfs/247
tests/generic/023
tests/generic/024
tests/generic/025
tests/generic/078
tests/generic/398
tests/generic/419
tests/generic/585
tests/generic/621
tests/generic/626

> so I created one, though
> at the moment it only exercises RENAME_NEWER_MTIME and RENAME_EXCHANGE.
> The self-test is written to be portable to the Linux Test Project,
> and the advantage of running it there is that it automatically runs
> tests on multiple filesystems.  See comments at the beginning of
> renameat2_tests.c for more info.

Ideally, new renameat2 correctness tests should be added to fstests
as per the existing tests (as this is the primary test suite a lot
of fs developers use) so that we don't end up with partial test
coverage fragmented across different test suites. It does us no
favors to have non-overlapping partial coverage in different test
suites - we are better to implement complete coverage in one test
suite and focus our efforts there...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
