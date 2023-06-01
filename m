Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3C71A285
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjFAPZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjFAPZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAEF180;
        Thu,  1 Jun 2023 08:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B83A645FD;
        Thu,  1 Jun 2023 15:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6280C433D2;
        Thu,  1 Jun 2023 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685633136;
        bh=6vSgMN5Z4SCWUKhar46fFDRuM46IKZ/1Fs+WQHVYK7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3PKCMDH2r3qpbMMAEtM2A7s2nqT/DRsLLB2mToqNx3hSAY+u0Gws16OcD5NzDgAF
         ym+5DRO5DVXPOdB4VHTizZaN35fW5vz8lUZiAOTew4tDmC5ck0kM3Ds+nOQjbEJ7rL
         DuzSRKySJul/VX450E/NvOmzyCAmPbRAINOhD7cg/3sjhWrzmF+KgHjXMjbiuuOamu
         KbN6hEATBav4BaEJf4iAL0aSjYcCQ4RJ2u8xOYap7VJp1hCjW77HS3UaeFuKQ210QK
         eHD6uS9QB5ThmaKpKVs+1GwdHRyV67AQihWZbFybw2DRypHYR+bYDLluqYCbk7VeKS
         kmW6zaH3ucJLQ==
Date:   Thu, 1 Jun 2023 08:25:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230601152536.GA16856@frogsfrogsfrogs>
References: <20230601094224.1350253-1-hch@lst.de>
 <20230601094224.1350253-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094224.1350253-2-hch@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:42:23AM +0200, Christoph Hellwig wrote:
> Test the removal of the underlying device when the file system still
> has dirty data.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/729     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/729.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/generic/729
>  create mode 100644 tests/generic/729.out
> 
> diff --git a/tests/generic/729 b/tests/generic/729
> new file mode 100755
> index 00000000..e3b52a51
> --- /dev/null
> +++ b/tests/generic/729
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
> +# Copyright (c) 2023 Christoph Hellwig
> +#
> +# Test proper file system shut down when the block device is removed underneath
> +# and there is dirty data.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	cd /
> +	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
> +	_put_scsi_debug_dev
> +	rm -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/scsi_debug
> +
> +_supported_fs generic
> +_require_scsi_debug
> +
> +physical=`blockdev --getpbsz $SCRATCH_DEV`
> +logical=`blockdev --getss $SCRATCH_DEV`

These two tests need to _notrun if SCRATCH_DEV is not a blockdev or if
SCRATCH_MNT is not a directory.  Normally _require_scratch_nocheck takes
care of that.

Other than that they look ok.

--D

> +
> +SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
> +test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> +echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
> +
> +_mkfs_dev $SCSI_DEBUG_DEV
> +
> +_mount $SCSI_DEBUG_DEV $SCRATCH_MNT
> +
> +# create a test file
> +$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/testfile >>$seqres.full
> +
> +# open a file descriptor for reading the file
> +exec 3< $SCRATCH_MNT/testfile
> +
> +# delete the scsi debug device while it still has dirty data
> +echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete
> +
> +# try to read from the file, which should give us -EIO
> +cat <&3 > /dev/null
> +
> +# close the file descriptor to not block unmount
> +exec 3<&-
> +
> +status=0
> +exit
> diff --git a/tests/generic/729.out b/tests/generic/729.out
> new file mode 100644
> index 00000000..8abf2b3c
> --- /dev/null
> +++ b/tests/generic/729.out
> @@ -0,0 +1,2 @@
> +QA output created by 729
> +cat: -: Input/output error
> -- 
> 2.39.2
> 
