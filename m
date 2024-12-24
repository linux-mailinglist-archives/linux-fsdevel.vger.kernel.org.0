Return-Path: <linux-fsdevel+bounces-38107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220779FC1BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 20:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B1616664D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F0212D80;
	Tue, 24 Dec 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4owqoRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B93EA76;
	Tue, 24 Dec 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735069243; cv=none; b=O17eEmX064i9+ttaXLFiwzE+y2KThMk3aEjTCRXjFrEyhF53wIyXPes9D1momDKDu2mE11I2sFg0h8bOiHRMSCx9AjpHyraxUaAOUAblfl0TFST9iGcO7+Y5q1dpLU2+i7KauAw4fsYKpTXbEpwmEP8ug+ydCt7HVIM8tsRRMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735069243; c=relaxed/simple;
	bh=vEycTSXI+W6mTxGFVZ3mn61JWGMaoIbTDtU5oUgQ+9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzgsHd/5CaTA4QLzC8x1J33Zcptjpmnm5Nv3/C9N3u6pRamCLx/JBiDv0HAHH6z12Q3d93YjQbcEpqV08hwHouPjzaiyvj+fIw37q2dEcJAOTZjp6JfLGcoIXbBbyPgC3zNAXqXP/3SM8weNneZTieDE7h6cbhcVIYEikT8f8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4owqoRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087C5C4CED0;
	Tue, 24 Dec 2024 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735069243;
	bh=vEycTSXI+W6mTxGFVZ3mn61JWGMaoIbTDtU5oUgQ+9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4owqoRoq2e15hs3wakc6cO5xPfST1xfXwefMGRd1KrHRQqEQ1wwEYq7Enxlsrk0Z
	 aqGaa/eMqlJ7j9KdTAm30oMQJ01NX9i8f8KU1KsahioVisNOgGbL2+zHkCzYbkGZEw
	 OjvtrC1FTSTaRp5qL85eo/OpjeToeuYER1wVen/7BsbhOdZfqDGJ2xhBZE6qBol8GL
	 bmImn7Zk4jcPBJDTfVRWkGw0ZIuCgfnQHLKHJEAp2swjFq0nqpjBQJ6soMOnWH8R51
	 Y/+G2U5u/RWpUSDMnAjEyQppZvGoY/DhuNMCmP2DnZNCUp3NOoinRaIf52Xe2DxKg2
	 LgmoMvb8UdhgQ==
Date: Tue, 24 Dec 2024 11:40:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
Message-ID: <20241224194042.GH6156@frogsfrogsfrogs>
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>

On Mon, Dec 23, 2024 at 10:39:30AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial page
> zeroing in ext4 which the block size is smaller than the page size [1].
> Expand this test to include a zeroing range test that spans two partial
> pages to cover this case.
> 
> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  tests/generic/567     | 50 +++++++++++++++++++++++++------------------
>  tests/generic/567.out | 18 ++++++++++++++++
>  2 files changed, 47 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/generic/567 b/tests/generic/567
> index fc109d0d..756280e8 100755
> --- a/tests/generic/567
> +++ b/tests/generic/567
> @@ -4,43 +4,51 @@
>  #
>  # FS QA Test No. generic/567
>  #
> -# Test mapped writes against punch-hole to ensure we get the data
> -# correctly written. This can expose data corruption bugs on filesystems
> -# where the block size is smaller than the page size.
> +# Test mapped writes against punch-hole and zero-range to ensure we get
> +# the data correctly written. This can expose data corruption bugs on
> +# filesystems where the block size is smaller than the page size.
>  #
>  # (generic/029 is a similar test but for truncate.)
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw punch
> +_begin_fstest auto quick rw punch zero
>  
>  # Import common functions.
>  . ./common/filter
>  
>  _require_scratch
>  _require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fzero"

Please don't overload an existing test.  Filesystems such as gfs2,
hugetblfs, nfs, ntfs3, and ocfs2 support fpunch but don't support fzero.
This change opens a testing gap for those filesystems.

--D

>  testfile=$SCRATCH_MNT/testfile
>  
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> -# Punch a hole straddling two pages to check that the mapped write after the
> -# hole-punching is correctly handled.
> -
> -$XFS_IO_PROG -t -f \
> --c "pwrite -S 0x58 0 12288" \
> --c "mmap -rw 0 12288" \
> --c "mwrite -S 0x5a 2048 8192" \
> --c "fpunch 2048 8192" \
> --c "mwrite -S 0x59 2048 8192" \
> --c "close"      \
> -$testfile | _filter_xfs_io
> -
> -echo "==== Pre-Remount ==="
> -_hexdump $testfile
> -_scratch_cycle_mount
> -echo "==== Post-Remount =="
> -_hexdump $testfile
> +# Punch a hole and zero out straddling two pages to check that the mapped
> +# write after the hole-punching and range-zeroing are correctly handled.
> +_straddling_test()
> +{
> +	local test_cmd=$1
> +
> +	$XFS_IO_PROG -t -f \
> +		-c "pwrite -S 0x58 0 12288" \
> +		-c "mmap -rw 0 12288" \
> +		-c "mwrite -S 0x5a 2048 8192" \
> +		-c "$test_cmd 2048 8192" \
> +		-c "mwrite -S 0x59 2048 8192" \
> +		-c "close"      \
> +	$testfile | _filter_xfs_io
> +
> +	echo "==== Pre-Remount ==="
> +	_hexdump $testfile
> +	_scratch_cycle_mount
> +	echo "==== Post-Remount =="
> +	_hexdump $testfile
> +}
> +
> +_straddling_test "fpunch"
> +_straddling_test "fzero"
>  
>  status=0
>  exit
> diff --git a/tests/generic/567.out b/tests/generic/567.out
> index 0e826ed3..df89b8f3 100644
> --- a/tests/generic/567.out
> +++ b/tests/generic/567.out
> @@ -17,3 +17,21 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>  *
>  003000
> +wrote 12288/12288 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +==== Pre-Remount ===
> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
> +*
> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +003000
> +==== Post-Remount ==
> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
> +*
> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +003000
> -- 
> 2.46.1
> 
> 

