Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEED390D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 02:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhEZAxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 20:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhEZAxa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 20:53:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 703AE61417;
        Wed, 26 May 2021 00:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621990319;
        bh=2MAR2fkh7Y4btLRFfu9Lw9CjQS3ZmsTeR2N15bjo0Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q39EHKre+YBQYdNaH964l3gjJ4vlFdrDNO7Zt0VA/GKvG+bfw0tJ4o9LUrnpc6fgU
         RaStUduo9FMAkSu+0uiCc1PDUlgPKbS7F3Nvhd6XBwF/uzuCfvqav4avBZbb2KAIgN
         bHfTU3sOCirhgoQvfOx3qq4zKcDLhyPO4xy7D6MXdMEtD8HYMGQXktzE5vy3EFEPcu
         eMT5xAVZnr57SUKkDMrAkqxbx0zbrBl0ldBLwdFKfoP6Pg/10O0PCf52J5pYqxBrYk
         5GdvEZDT0BqtoogAyMofviulr/qbwafNwo+Rut9QrQ9LKKSSbFajRY4ih/GZOXhwrm
         RuGUiLDEjK0SA==
Date:   Tue, 25 May 2021 17:51:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v6 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210526005159.GF202144@locust>
References: <20210519060045.1051226-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519060045.1051226-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 02:00:38PM +0800, Shiyang Ruan wrote:
> This patchset is attempt to add CoW support for fsdax, and take XFS,
> which has both reflink and fsdax feature, as an example.

Soooo... how close are we to enabling reflink for DAX?

I <cough> got rid of the lockouts in xfs_super.c and ran a quick
fstests, which showed a number of odd regressions where dedupe tests
that were supposed to fail with EBADE didn't and a bunch of clonerange
tests failed with EINVAL:

generic/122     - output mismatch (see /var/tmp/fstests/generic/122.out.bad)
    --- tests/generic/122.out   2021-05-13 11:47:55.665860364 -0700
    +++ /var/tmp/fstests/generic/122.out.bad    2021-05-25 17:24:03.333270522 -0700
    @@ -4,7 +4,8 @@
     5e3501f97fd2669babfcbd3e1972e833  TEST_DIR/test-122/file2
     Files 1-2 do not match (intentional)
     (Fail to) dedupe the middle blocks together
    -XFS_IOC_FILE_EXTENT_SAME: Extents did not match.
    +deduped 131072/131072 bytes at offset 262144
    +128 KiB, 1 ops; 0.0000 sec (12.207 GiB/sec and 100000.0000 ops/sec)
     Compare sections
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/122.out /var/tmp/fstests/generic/122.out.bad'  to see the entire diff)
generic/136     - output mismatch (see /var/tmp/fstests/generic/136.out.bad)
    --- tests/generic/136.out   2021-05-13 11:47:55.668860355 -0700
    +++ /var/tmp/fstests/generic/136.out.bad    2021-05-25 17:24:05.773367756 -0700
    @@ -7,7 +7,8 @@
     Dedupe the last blocks together
     1->2
     1->3
    -XFS_IOC_FILE_EXTENT_SAME: Extents did not match.
    +deduped 37/37 bytes at offset 65536
    +37.000000 bytes, 1 ops; 0.0000 sec (1.960 MiB/sec and 55555.5556 ops/sec)
     c4fd505be25a0c91bcca9f502b9a8156  TEST_DIR/test-136/file1
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/136.out /var/tmp/fstests/generic/136.out.bad'  to see the entire diff)
generic/164     - output mismatch (see /var/tmp/fstests/generic/164.out.bad)
    --- tests/generic/164.out   2021-05-13 11:47:55.674860338 -0700
    +++ /var/tmp/fstests/generic/164.out.bad    2021-05-25 17:25:33.339738197 -0700
    @@ -2,4 +2,1028 @@
     Format and mount
     Initialize files
     Reflink and reread the files!
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/164.out /var/tmp/fstests/generic/164.out.bad'  to see the entire diff)
generic/165     - output mismatch (see /var/tmp/fstests/generic/165.out.bad)
    --- tests/generic/165.out   2021-05-13 11:47:55.674860338 -0700
    +++ /var/tmp/fstests/generic/165.out.bad    2021-05-25 17:25:45.247685323 -0700
    @@ -2,4 +2,1028 @@
     Format and mount
     Initialize files
     Reflink and dio reread the files!
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/165.out /var/tmp/fstests/generic/165.out.bad'  to see the entire diff)
generic/175     - output mismatch (see /var/tmp/fstests/generic/175.out.bad)
    --- tests/generic/175.out   2021-05-13 11:47:55.676860332 -0700
    +++ /var/tmp/fstests/generic/175.out.bad    2021-05-25 17:29:55.060917807 -0700
    @@ -3,3 +3,4 @@
     Create a one block file
     Create extents
     Reflink the big file
    +XFS_IOC_CLONE_RANGE: Invalid argument
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/175.out /var/tmp/fstests/generic/175.out.bad'  to see the entire diff)
generic/327     - output mismatch (see /var/tmp/fstests/generic/327.out.bad)
    --- tests/generic/327.out   2021-05-13 11:47:55.704860251 -0700
    +++ /var/tmp/fstests/generic/327.out.bad    2021-05-25 17:35:22.338448231 -0700
    @@ -7,6 +7,6 @@
     root 0 0 0
     fsgqa 2048 0 1024
     Try to reflink again
    -cp: failed to clone 'SCRATCH_MNT/test-327/file3' from 'SCRATCH_MNT/test-327/file1': Disk quota exceeded
    +cp: failed to clone 'SCRATCH_MNT/test-327/file3' from 'SCRATCH_MNT/test-327/file1': Invalid argument
     root 0 0 0
     fsgqa 2048 0 1024
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/327.out /var/tmp/fstests/generic/327.out.bad'  to see the entire diff)
generic/516     - output mismatch (see /var/tmp/fstests/generic/516.out.bad)
    --- tests/generic/516.out   2021-05-13 11:47:55.739860150 -0700
    +++ /var/tmp/fstests/generic/516.out.bad    2021-05-25 17:41:58.144177193 -0700
    @@ -4,7 +4,8 @@
     39578c21e2cb9f6049b1cf7fc7be12a6  TEST_DIR/test-516/file2
     Files 1-2 do not match (intentional)
     (partial) dedupe the middle blocks together
    -XFS_IOC_FILE_EXTENT_SAME: Extents did not match.
    +deduped XXXX/XXXX bytes at offset XXXX
    +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     Compare sections
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/516.out /var/tmp/fstests/generic/516.out.bad'  to see the entire diff)
generic/517     - output mismatch (see /var/tmp/fstests/generic/517.out.bad)
    --- tests/generic/517.out   2021-05-13 11:47:55.739860150 -0700
    +++ /var/tmp/fstests/generic/517.out.bad    2021-05-25 17:41:59.352000318 -0700
    @@ -33,8 +33,7 @@
     0786532
     wrote 100/100 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -deduped 100/100 bytes at offset 655360
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +XFS_IOC_FILE_EXTENT_SAME: Invalid argument
     File content after second deduplication:
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/517.out /var/tmp/fstests/generic/517.out.bad'  to see the entire diff)
generic/518      1s
generic/540     - output mismatch (see /var/tmp/fstests/generic/540.out.bad)
    --- tests/generic/540.out   2021-05-13 11:47:55.743860139 -0700
    +++ /var/tmp/fstests/generic/540.out.bad    2021-05-25 17:42:01.999613949 -0700
    @@ -7,8 +7,9 @@
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-540/file3
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-540/file3.chk
     reflink across the transition
    +XFS_IOC_CLONE_RANGE: Invalid argument
     Compare files
     bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-540/file1
     5a5221017d3ab8fd7583312a14d2ba80  SCRATCH_MNT/test-540/file2
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/540.out /var/tmp/fstests/generic/540.out.bad'  to see the entire diff)
generic/541     - output mismatch (see /var/tmp/fstests/generic/541.out.bad)
    --- tests/generic/541.out   2021-05-13 11:47:55.743860139 -0700
    +++ /var/tmp/fstests/generic/541.out.bad    2021-05-25 17:42:03.623377997 -0700
    @@ -8,9 +8,10 @@
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-541/file3
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-541/file3.chk
     reflink across the transition
    +XFS_IOC_CLONE_RANGE: Invalid argument
     Compare files
     bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-541/file1
    -51a300aae3a4b4eaa023876a397e01ef  SCRATCH_MNT/test-541/file2
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/541.out /var/tmp/fstests/generic/541.out.bad'  to see the entire diff)
generic/542     - output mismatch (see /var/tmp/fstests/generic/542.out.bad)
    --- tests/generic/542.out   2021-05-13 11:47:55.743860139 -0700
    +++ /var/tmp/fstests/generic/542.out.bad    2021-05-25 17:42:05.487108030 -0700
    @@ -7,8 +7,9 @@
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-542/file3
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-542/file3.chk
     reflink across the transition
    +XFS_IOC_CLONE_RANGE: Invalid argument
     Compare files
     bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-542/file1
     5a5221017d3ab8fd7583312a14d2ba80  SCRATCH_MNT/test-542/file2
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/542.out /var/tmp/fstests/generic/542.out.bad'  to see the entire diff)
generic/543     - output mismatch (see /var/tmp/fstests/generic/543.out.bad)
    --- tests/generic/543.out   2021-05-13 11:47:55.744860136 -0700
    +++ /var/tmp/fstests/generic/543.out.bad    2021-05-25 17:42:07.386833815 -0700
    @@ -8,9 +8,10 @@
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-543/file3
     6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-543/file3.chk
     reflink across the transition
    +XFS_IOC_CLONE_RANGE: Invalid argument
     Compare files
     bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-543/file1
    -d93123af536c8c012f866ea383a905ce  SCRATCH_MNT/test-543/file2
    ...
    (Run 'diff -u /tmp/fstests/tests/generic/543.out /var/tmp/fstests/generic/543.out.bad'  to see the entire diff)

That's all the failures to the end of the generic group; I cut it off so
that I could schedule my regular nightly testing runs.

--D

> 
> Changes from V5:
>  - Fix the lock order of xfs_inode in xfs_mmaplock_two_inodes_and_break_dax_layout()
>  - move dax_remap_file_range_prep() to fs/dax.c
>  - change type of length to uint64_t in dax_iomap_cow_copy()
>  - fix mistake in dax_iomap_zero()
> 
> Changes from V4:
>  - Fix the mistake of breaking dax layout for two inodes
>  - Add CONFIG_FS_DAX judgement for fsdax code in remap_range.c
>  - Fix other small problems and mistakes
> 
> One of the key mechanism need to be implemented in fsdax is CoW.  Copy
> the data from srcmap before we actually write data to the destance
> iomap.  And we just copy range in which data won't be changed.
> 
> Another mechanism is range comparison.  In page cache case, readpage()
> is used to load data on disk to page cache in order to be able to
> compare data.  In fsdax case, readpage() does not work.  So, we need
> another compare data with direct access support.
> 
> With the two mechanisms implemented in fsdax, we are able to make reflink
> and fsdax work together in XFS.
> 
> Some of the patches are picked up from Goldwyn's patchset.  I made some
> changes to adapt to this patchset.
> 
> 
> (Rebased on v5.13-rc2 and patchset[1])
> [1]: https://lkml.org/lkml/2021/4/22/575
> 
> Shiyang Ruan (7):
>   fsdax: Introduce dax_iomap_cow_copy()
>   fsdax: Replace mmap entry in case of CoW
>   fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
>   iomap: Introduce iomap_apply2() for operations on two files
>   fsdax: Dedup file range to use a compare function
>   fs/xfs: Handle CoW for fsdax write() path
>   fs/xfs: Add dax dedupe support
> 
>  fs/dax.c               | 216 ++++++++++++++++++++++++++++++++++++-----
>  fs/iomap/apply.c       |  52 ++++++++++
>  fs/iomap/buffered-io.c |   2 +-
>  fs/remap_range.c       |  36 +++++--
>  fs/xfs/xfs_bmap_util.c |   3 +-
>  fs/xfs/xfs_file.c      |  11 +--
>  fs/xfs/xfs_inode.c     |  57 +++++++++++
>  fs/xfs/xfs_inode.h     |   1 +
>  fs/xfs/xfs_iomap.c     |  38 +++++++-
>  fs/xfs/xfs_iomap.h     |  24 +++++
>  fs/xfs/xfs_iops.c      |   7 +-
>  fs/xfs/xfs_reflink.c   |  15 +--
>  include/linux/dax.h    |  11 ++-
>  include/linux/fs.h     |  12 ++-
>  include/linux/iomap.h  |   7 +-
>  15 files changed, 431 insertions(+), 61 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
> 
