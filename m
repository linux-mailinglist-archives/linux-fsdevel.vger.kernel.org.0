Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0984DA077
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349326AbiCOQxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350301AbiCOQw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC260574BA;
        Tue, 15 Mar 2022 09:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5BD6140F;
        Tue, 15 Mar 2022 16:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BADC340EE;
        Tue, 15 Mar 2022 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363103;
        bh=0OCWPWNP51yJ7yrh0jSupXw6ERwIlBLi3oJqb8npluQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=td/qq3j3gUe+aRGgXEAGi10/wEBrsIMUARKl43nGKBoLmtlGGy6eUSLeZ9Vyvxupo
         iS5B57ImG0q6S4wCQ53bzLn3Vb+7x5KlUwwF7WL/88sucdks51ktHdWS5ReADTPJSn
         z/sDHPS9e+mlGEGsCFPV7cAI8KUqu68E+Bk9dVwA9H9ZgxZQj82LkqUflQ04poCOoV
         2H7OGu9ZLmiQD3GaIERcn4eZCDSFlMOWDw34NmJe95eeESWYjsbXj+yaavE4/tsabV
         8FelYsanBjIdHbfbABx/7ju3rfl53zFfjV5uO2Sp2yz7EQBCHkZ/xIC6SqKYyA8NaH
         Y4osaLRhIaxkA==
Date:   Tue, 15 Mar 2022 09:51:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/4] generic/468: Add another falloc test entry
Message-ID: <20220315165143.GB8200@magnolia>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
 <08bd90fa8c291a4ccba2e5d6182a8595b7e6d7ab.1647342932.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08bd90fa8c291a4ccba2e5d6182a8595b7e6d7ab.1647342932.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 07:58:56PM +0530, Ritesh Harjani wrote:
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
>  tests/generic/468     | 4 ++++
>  tests/generic/468.out | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tests/generic/468 b/tests/generic/468
> index 95752d3b..cbef9746 100755
> --- a/tests/generic/468
> +++ b/tests/generic/468
> @@ -34,6 +34,9 @@ _scratch_mkfs >/dev/null 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
>  _scratch_mount
> 
> +blocksize=4096

What happens if the file blocksize isn't 4k?  Does fastcommit only
support one block size?  I didn't think it has any such restriction?

> +fact=18

This needs a bit more explanation -- why 18?  I think the reason is that
you need the fallocate to cross into another flexbg, and flexbgs (by
default) are 16bg long, right?

If that's the case, then don't you need to detect the flexbg size so
that this is still an effective test if someone runs fstests with
MKFS_OPTIONS='-G 32' or something?

--D

> +
>  testfile=$SCRATCH_MNT/testfile
> 
>  # check inode metadata after shutdown
> @@ -85,6 +88,7 @@ for i in fsync fdatasync; do
>  	test_falloc $i "-k " 1024
>  	test_falloc $i "-k " 4096
>  	test_falloc $i "-k " 104857600
> +	test_falloc $i "-k " $((32768*$blocksize*$fact))
>  done
> 
>  status=0
> diff --git a/tests/generic/468.out b/tests/generic/468.out
> index b3a28d5e..a09cedb8 100644
> --- a/tests/generic/468.out
> +++ b/tests/generic/468.out
> @@ -5,9 +5,11 @@ QA output created by 468
>  ==== falloc -k 1024 test with fsync ====
>  ==== falloc -k 4096 test with fsync ====
>  ==== falloc -k 104857600 test with fsync ====
> +==== falloc -k 2415919104 test with fsync ====
>  ==== falloc 1024 test with fdatasync ====
>  ==== falloc 4096 test with fdatasync ====
>  ==== falloc 104857600 test with fdatasync ====
>  ==== falloc -k 1024 test with fdatasync ====
>  ==== falloc -k 4096 test with fdatasync ====
>  ==== falloc -k 104857600 test with fdatasync ====
> +==== falloc -k 2415919104 test with fdatasync ====
> --
> 2.31.1
> 
