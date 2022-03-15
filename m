Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391674DA08F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350315AbiCOQ42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbiCOQ42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E233C57175;
        Tue, 15 Mar 2022 09:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800B36151A;
        Tue, 15 Mar 2022 16:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC74C340E8;
        Tue, 15 Mar 2022 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363314;
        bh=4/4meff/CpbpeDNPdU8cdYwo3SLLEYH924E980n1MDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaqStFCrMp/uSzIr87GGMrRYbG937Mos4z6s0giobTP8u1WAeAevvkPlFmzyfzugg
         BEHzXKV51E+HR7zPsTp57Nb0DfA2UFcSKuy10y/XnkffE2q17/HPDjGuOshN3ZY9on
         9zErblYe+2/TTEvhBRJ6nMsbBhnH57pRx+hd5/jQAuc8ErHXxFAkDS/QZkI3pRH6Hi
         6UUrD9qCyKb5O++gCzpylI6BLHOwIHkz2vfJI1+y+exEWY0/qcT0Jz9jR4T2v9hGI2
         8ogMdE/c13XUEr/693jtGULlHp4ZDZ7CTqH6t8Gwh0Yvs30Kd4BIqZzofGDo7AisX1
         R7L/dQd4TaEFg==
Date:   Tue, 15 Mar 2022 09:55:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/4] generic/676: Add a new shutdown recovery test
Message-ID: <20220315165514.GC8200@magnolia>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
 <3d8c4f7374e97ccee285474efd04b093afe3ee16.1647342932.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8c4f7374e97ccee285474efd04b093afe3ee16.1647342932.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 07:58:58PM +0530, Ritesh Harjani wrote:
> In certain cases (it is noted with ext4 fast_commit feature) that, replay phase
> may not delete the right range of blocks (after sudden FS shutdown)
> due to some operations which depends on inode->i_size (which during replay of
> an inode with fast_commit could be 0 for sometime).
> This fstest is added to test for such scenarios for all generic fs.
> 
> This test case is based on the test case shared via Xin Yin.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/generic/676     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/676.out |  7 +++++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/generic/676
>  create mode 100644 tests/generic/676.out
> 
> diff --git a/tests/generic/676 b/tests/generic/676
> new file mode 100755
> index 00000000..315edcdf
> --- /dev/null
> +++ b/tests/generic/676
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 676
> +#
> +# This test with ext4 fast_commit feature w/o below patch missed to delete the right
> +# range during replay phase, since it depends upon inode->i_size (which might not be
> +# stable during replay phase, at least for ext4).
> +# 0b5b5a62b945a141: ext4: use ext4_ext_remove_space() for fast commit replay delete range
> +# (Based on test case shared by Xin Yin <yinxin.x@bytedance.com>)
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto shutdown quick log recoveryloop

This isn't a looping recovery test.  Maybe we should create a 'recovery'
group for tests that only run once?  I think we already have a few
fstests like that.

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +   _scratch_unmount > /dev/null 2>&1

I think the test harness does this for you already, right?

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
> +_require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fzero"
> +_require_xfs_io_command "fiemap"

_require_scratch_shutdown

> +
> +t1=$SCRATCH_MNT/foo
> +t2=$SCRATCH_MNT/bar
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +
> +_scratch_mount >> $seqres.full 2>&1
> +
> +bs=$(_get_block_size $SCRATCH_MNT)

_get_file_block_size, in case the file allocation unit isn't the same as
the fs blocksize?  (e.g. bigalloc, xfs realtime, etc.)

--D

> +
> +# create and write data to t1
> +$XFS_IO_PROG -f -c "pwrite 0 $((100*$bs))" $t1 | _filter_xfs_io_numbers
> +
> +# fzero certain range in between with -k
> +$XFS_IO_PROG -c "fzero -k  $((40*$bs)) $((20*$bs))" $t1
> +
> +# create and fsync a new file t2
> +$XFS_IO_PROG -f -c "fsync" $t2
> +
> +# fpunch within the i_size of a file
> +$XFS_IO_PROG -c "fpunch $((30*$bs)) $((20*$bs))" $t1
> +
> +# fsync t1 to trigger journal operation
> +$XFS_IO_PROG -c "fsync" $t1
> +
> +# shutdown FS now for replay journal to kick in next mount
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
> diff --git a/tests/generic/676.out b/tests/generic/676.out
> new file mode 100644
> index 00000000..78375940
> --- /dev/null
> +++ b/tests/generic/676.out
> @@ -0,0 +1,7 @@
> +QA output created by 676
> +wrote XXXX/XXXX bytes at offset XXXX
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +0: [0..29]: none
> +1: [30..49]: hole
> +2: [50..59]: unwritten
> +3: [60..99]: nonelast
> --
> 2.31.1
> 
