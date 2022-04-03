Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4D4F0CF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 01:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376663AbiDCXaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 19:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376657AbiDCXaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:30:21 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5C81766A;
        Sun,  3 Apr 2022 16:28:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7775210E553B;
        Mon,  4 Apr 2022 09:28:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nb9dv-00DRzz-77; Mon, 04 Apr 2022 09:28:23 +1000
Date:   Mon, 4 Apr 2022 09:28:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 1/4] generic/468: Add another falloc test entry
Message-ID: <20220403232823.GS1609613@dread.disaster.area>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=624a2d98
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=pcpTcb-Ldv-4dz7pLwMA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:24:20PM +0530, Ritesh Harjani wrote:
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Add another falloc test entry which could hit a kernel bug
> with ext4 fast_commit feature w/o below kernel commit [1].
> 
> <log>
> [  410.888496][ T2743] BUG: KASAN: use-after-free in ext4_mb_mark_bb+0x26a/0x6c0
> [  410.890432][ T2743] Read of size 8 at addr ffff888171886000 by task mount/2743
> 
> This happens when falloc -k size is huge which spans across more than
> 1 flex block group in ext4. This causes a bug in fast_commit replay
> code which is fixed by kernel commit at [1].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/generic/468     | 8 ++++++++
>  tests/generic/468.out | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tests/generic/468 b/tests/generic/468
> index 95752d3b..5e73cff9 100755
> --- a/tests/generic/468
> +++ b/tests/generic/468
> @@ -34,6 +34,13 @@ _scratch_mkfs >/dev/null 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
>  _scratch_mount
>  
> +# blocksize and fact are used in the last case of the fsync/fdatasync test.
> +# This is mainly trying to test recovery operation in case where the data
> +# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.
> +blocks=32768
> +blocksize=4096

Block size can change based on mkfs parameters. You should extract
this dynamically from the filesystem the test is being run on.

> +fact=18

What is "fact" supposed to mean?

Indeed, wouldn't this simply be better as something like:

larger_than_ext4_fg_size=$((32768 * $blksize * 18))

And then

>  testfile=$SCRATCH_MNT/testfile
>  
>  # check inode metadata after shutdown
> @@ -85,6 +92,7 @@ for i in fsync fdatasync; do
>  	test_falloc $i "-k " 1024
>  	test_falloc $i "-k " 4096
>  	test_falloc $i "-k " 104857600
> +	test_falloc $i "-k " $(($blocks*$blocksize*$fact))

	test_falloc $i "-k " $larger_than_ext4_fg_size

And just scrub all the sizes from the golden output?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
