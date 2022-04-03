Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018174F0D06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376709AbiDCXpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 19:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376705AbiDCXpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:45:15 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 722462E9CC;
        Sun,  3 Apr 2022 16:43:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A710653435A;
        Mon,  4 Apr 2022 09:43:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nb9sM-00DSAi-2u; Mon, 04 Apr 2022 09:43:18 +1000
Date:   Mon, 4 Apr 2022 09:43:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 4/4] generic/679: Add a test to check unwritten extents
 tracking
Message-ID: <20220403234318.GU1609613@dread.disaster.area>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <c9a40292799a83e52924b7b748701b3b0aa31c46.1648730443.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a40292799a83e52924b7b748701b3b0aa31c46.1648730443.git.ritesh.list@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=624a3117
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=VnNF1IyMAAAA:8 a=7-415B0cAAAA:8
        a=OHNP50dCb2NrX2JaUOMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:24:23PM +0530, Ritesh Harjani wrote:
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> With these sequence of operation (in certain cases like with ext4 fast_commit)
> could miss to track unwritten extents during replay phase
> (after sudden FS shutdown).
> 
> This fstest adds a test case to test this.
> 
> 5e4d0eba1ccaf19f
> ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/generic/679     | 65 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/679.out |  6 ++++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/679
>  create mode 100644 tests/generic/679.out
> 
> diff --git a/tests/generic/679 b/tests/generic/679
> new file mode 100755
> index 00000000..4f35a9cd
> --- /dev/null
> +++ b/tests/generic/679
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 679
> +#
> +# Test below sequence of operation which (w/o below kernel patch) in case of
> +# ext4 with fast_commit may misss to track unwritten extents.
> +# commit 5e4d0eba1ccaf19f
> +# ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log shutdown recoveryloop
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}

Same as default.

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/punch
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +_require_xfs_io_command "fiemap"
> +_require_scratch_shutdown
> +
> +t1=$SCRATCH_MNT/t1
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +
> +_scratch_mount >> $seqres.full 2>&1
> +
> +bs=$(_get_file_block_size $SCRATCH_MNT)
> +
> +# create and write data to t1
> +$XFS_IO_PROG -f -c "pwrite 0 $((100*$bs))" $t1 | _filter_xfs_io_numbers
> +
> +# fsync t1
> +$XFS_IO_PROG -c "fsync" $t1
> +
> +# fzero certain range in between
> +$XFS_IO_PROG -c "fzero -k  $((40*$bs)) $((20*$bs))" $t1
> +
> +# fsync t1
> +$XFS_IO_PROG -c "fsync" $t1
> +
> +# shutdown FS now for replay of journal to kick during next mount
> +_scratch_shutdown -v >> $seqres.full 2>&1
> +
> +_scratch_cycle_mount
> +
> +# check fiemap reported is valid or not
> +$XFS_IO_PROG -c "fiemap -v" $t1 | _filter_fiemap_flags $bs
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/679.out b/tests/generic/679.out
> new file mode 100644
> index 00000000..4d3c3377
> --- /dev/null
> +++ b/tests/generic/679.out
> @@ -0,0 +1,6 @@
> +QA output created by 679
> +wrote XXXX/XXXX bytes at offset XXXX
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +0: [0..39]: none
> +1: [40..59]: unwritten
> +2: [60..99]: nonelast

This is a subset of the the previous test, and looks like it should
be tested first before adding the second file and punch operation
the previous test adds to this write/zero operations. IOWs, they
look like they could easily be combined into a single test without
losing anything except having an extra test that has to be run...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
