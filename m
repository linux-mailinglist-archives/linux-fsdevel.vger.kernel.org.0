Return-Path: <linux-fsdevel+bounces-38663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67714A062BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BDF3A7212
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C81FF7BB;
	Wed,  8 Jan 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrMV3bYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B31FF61B;
	Wed,  8 Jan 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355379; cv=none; b=g4dz0gIu325OlD3yjusAlDQp7Pm7Jlxb7RFr4N9iwMebXq3Vm31Ks3ckZZjlSXwOYIqrLpemRsYQdSLJmIEgqVVcRuGdAXcxvtfYe6dlLJbHUqevTzKJvZeqd1KmQAJQEvueIvHSFGZfeWXtLrR2PMs+iafU5HPzDYFIlI+hTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355379; c=relaxed/simple;
	bh=26oTvqxCuPsCjfFB/yaN73dcKA/l+qJt8dtwka37Ryk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjUXWMsb6NlloDjXGVOzvCXLaFNz4d1wf+jdKrkDMTfEbRZeGJh8hyJKw72M/tTLSOZKnPw1TDaL7WAUfIFB5J7dXeZMR65DhazGWAp9/wwu6DK5K5WOFf2rsxKlHJRWVXC2RqdNcbuAO+CLoeqmi3bZBKf0XYFWC7+fTIBlw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrMV3bYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE046C4CED3;
	Wed,  8 Jan 2025 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736355378;
	bh=26oTvqxCuPsCjfFB/yaN73dcKA/l+qJt8dtwka37Ryk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrMV3bYsMEEgZyn8+BwQymgp8rg7Ez+wTQ+cJuEITvjpEORKx3F8LqWejRGtmfvH7
	 sSr+If1L5+geNu57lOV8qZdeIzrxFGrXoyMIyCcvDLJPsEx9Qoi4nNxyBLkuAvmFv7
	 I8SIP4soFcTSe1w4Evy+pqLoPSrG99DN7kzdn3YySYWSsyvLHL8nBLbRk+zlmSzDYc
	 TdWNgV2nPV9zr29GubHyNhW4di4n8c6UNQiTeElfXyGxZX2RRxQaO9/gCGBxTf7Lvk
	 gd18ZwFKUUa2lfui9x8ZQprhqC2QwzaVHC6SdPK6CbDVw0979sH1db4cCjNhuOD6BU
	 f/kX1KJIdsRjQ==
Date: Wed, 8 Jan 2025 08:56:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH v3] generic: add a partial pages zeroing out test
Message-ID: <20250108165618.GD1251194@frogsfrogsfrogs>
References: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>

On Wed, Jan 08, 2025 at 04:44:07PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial page
> zeroing in ext4 which the block size is smaller than the page size [1].
> Add a new test which is expanded upon generic/567, this test performs a
> zeroing range test that spans two partial pages to cover this case, and
> also generalize it to work for non-4k page sizes.
> 
> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

LGTM now, thanks for setting this up!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> v2->v3:
>  - Put the verifyfile in $SCRATCH_MNT and remove the overriding
>    _cleanup.
>  - Correct the test name.
> v1->v2:
>  - Add a new test instead of modifying generic/567.
>  - Generalize the test to work for non-4k page sizes.
> v2: https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
> 
>  tests/generic/758     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/758.out |  3 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
> 
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..bf0a342b
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. 758
> +#
> +# Test mapped writes against zero-range to ensure we get the data
> +# correctly written. This can expose data corruption bugs on filesystems
> +# where the block size is smaller than the page size.
> +#
> +# (generic/567 is a similar test but for punch hole.)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw zero
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +
> +verifyfile=$SCRATCH_MNT/verifyfile
> +testfile=$SCRATCH_MNT/testfile
> +
> +pagesz=$(getconf PAGE_SIZE)
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_dump_files()
> +{
> +	echo "---- testfile ----"
> +	_hexdump $testfile
> +	echo "---- verifyfile --"
> +	_hexdump $verifyfile
> +}
> +
> +# Build verify file, the data in this file should be consistent with
> +# that in the test file.
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +		$verifyfile | _filter_xfs_io >> /dev/null
> +
> +# Zero out straddling two pages to check that the mapped write after the
> +# range-zeroing are correctly handled.
> +$XFS_IO_PROG -t -f \
> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +	-c "mmap -rw 0 $((pagesz * 3))" \
> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "close"      \
> +$testfile | _filter_xfs_io > $seqres.full
> +
> +echo "==== Pre-Remount ==="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match pre-remount."
> +	_dump_files
> +fi
> +_scratch_cycle_mount
> +echo "==== Post-Remount =="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match post-remount."
> +	_dump_files
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/758.out b/tests/generic/758.out
> new file mode 100644
> index 00000000..d01c1959
> --- /dev/null
> +++ b/tests/generic/758.out
> @@ -0,0 +1,3 @@
> +QA output created by 758
> +==== Pre-Remount ===
> +==== Post-Remount ==
> -- 
> 2.39.2
> 
> 

