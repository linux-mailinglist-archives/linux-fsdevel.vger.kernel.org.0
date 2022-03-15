Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2444DA093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 17:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350321AbiCOQ5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 12:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiCOQ5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:57:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7CA4CD71;
        Tue, 15 Mar 2022 09:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79197B8122D;
        Tue, 15 Mar 2022 16:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C142C340E8;
        Tue, 15 Mar 2022 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363368;
        bh=PNchmz87ektRRcL0pHOs89tCvETP4cDYQqgB0b4jOl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YR3aPzCQ+f+yMrDWWvlBZc+hrN3j1H3TJHl3vq3jJix+jX6Rrd1i1On/qxHmoGnIy
         3CQMh1o1gsmtjmDEHOnycRogqjw5YK4zIDdsPloiqF+eFgThNi0PwXZqS3J5eJnJqS
         mcX/ShKHZPhRt2q1R9vCMnqD41fa48ltcPMvVn1oTPVrThLe/aEi49fC9GiuNg+abc
         mqpnAEJmZ/zM1+ptJ3PxMGMZMdzob6MrUuIphpGTR7yl8Z0yuyHC0qiOrHsYYhGnKj
         3sLtFmIGi/URLj7i6OMScD+es3G7yRzR53ax9IVfSkb/pp5kldi071gKD39gcVRIVY
         wE24fxjliOVtQ==
Date:   Tue, 15 Mar 2022 09:56:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/4] generic/677: Add a test to check unwritten extents
 tracking
Message-ID: <20220315165607.GD8200@magnolia>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
 <37d65f1026f2fc1f2d13ab54980de93f4fa34c46.1647342932.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d65f1026f2fc1f2d13ab54980de93f4fa34c46.1647342932.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 07:58:59PM +0530, Ritesh Harjani wrote:
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
>  tests/generic/677     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/677.out |  6 ++++
>  2 files changed, 70 insertions(+)
>  create mode 100755 tests/generic/677
>  create mode 100644 tests/generic/677.out
> 
> diff --git a/tests/generic/677 b/tests/generic/677
> new file mode 100755
> index 00000000..e316763a
> --- /dev/null
> +++ b/tests/generic/677
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 677
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
> +
> +t1=$SCRATCH_MNT/t1
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +
> +_scratch_mount >> $seqres.full 2>&1
> +
> +bs=$(_get_block_size $SCRATCH_MNT)

Same comments about blocksize, group names, and
_require_scratch_shutdown as the last patch.

--D

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
> diff --git a/tests/generic/677.out b/tests/generic/677.out
> new file mode 100644
> index 00000000..b91ab77a
> --- /dev/null
> +++ b/tests/generic/677.out
> @@ -0,0 +1,6 @@
> +QA output created by 677
> +wrote XXXX/XXXX bytes at offset XXXX
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +0: [0..39]: none
> +1: [40..59]: unwritten
> +2: [60..99]: nonelast
> --
> 2.31.1
> 
