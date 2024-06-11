Return-Path: <linux-fsdevel+bounces-21441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47734903EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522321C22E01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED117D8AC;
	Tue, 11 Jun 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGrjD9ej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3D17B42B;
	Tue, 11 Jun 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116110; cv=none; b=QszkVnnFTnqQbxwnuTiTCjI3lA3Ho/+ZxUgIedAb6p5c/gf80w+cfXGbfSRc05BSzBJeIQeexhKBI0Tsm0xo17A148R0t843cNXN2zw7Zgq4IcHWZEqBVo2MbEE66mf5rRPSVa3h73qOljgDCfzzGcGrLA/AwxpelzXwJm8tS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116110; c=relaxed/simple;
	bh=u6IPxDchDXd4e1F8IfxVMsgtYMnGEwTTN8nDGvge/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzoFRhNsqZGx9rOIutoIkJuXpO9wCTX4DBIntCfzKpGLjarFryZqt3i+I+KTcn7MosaqmXi7WRNqTsiDi24WE5Wg5q1v2u8BcrK7Rv9u08bSbaQbDMTs4A8WlDbiR9q8xRaFvZg4c6zVW1OYHY6XHopTRVvh6HJvfZK7sFuVSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGrjD9ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36295C2BD10;
	Tue, 11 Jun 2024 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116110;
	bh=u6IPxDchDXd4e1F8IfxVMsgtYMnGEwTTN8nDGvge/mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGrjD9ejdq2ZY0D6fhhoXuAdwQkd6ho9NU+Mq6pzK3fQjKvs4gy6LS5N/Xs0xS2wX
	 z9uVJMQUU+iHSKPrLjYlvsDEdhmH3EgwwW43kbJN0y9cIZN7kl+GTLyJzqKKAHGDIQ
	 kbCdaprZKgpEe5pL7hKigA95eyi2Y5m5Ud+tnBpAJh8W7FAKCO0UIfpTwPptUJZVzm
	 SDGE1iIz59SJoDHeZLn/MOkvJi1syGluHg1+zZczR0CTpHyNjPb0/mDo96PZb9YyGG
	 XXXcugQH0wm0qAASFDhB8qb6ALKfhttxqJMyJM7CcSs3gNjd3raVREDqRv4NMhhkdX
	 txfcsE5RVFT3A==
Date: Tue, 11 Jun 2024 07:28:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 1/5] common: move mread() to generic helper _mread()
Message-ID: <20240611142829.GG52977@frogsfrogsfrogs>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-2-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611030203.1719072-2-mcgrof@kernel.org>

On Mon, Jun 10, 2024 at 08:01:58PM -0700, Luis Chamberlain wrote:
> We want a shared way to use mmap in a way that we can test
> for the SIGBUS, provide a shared routine which other tests can
> leverage.
> 
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc         | 28 ++++++++++++++++++++++++++++
>  tests/generic/574 | 36 ++++--------------------------------
>  2 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 163041fea5b9..fa7942809d6c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -52,6 +52,34 @@ _pwrite_byte() {
>  	$XFS_IO_PROG $xfs_io_args -f -c "pwrite -S $pattern $offset $len" "$file"
>  }
>  
> +_round_up_to_page_boundary()
> +{
> +	local n=$1
> +	local page_size=$(_get_page_size)
> +
> +	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
> +}
> +
> +_mread()
> +{
> +	local file=$1
> +	local offset=$2
> +	local length=$3
> +	local map_len=$(_round_up_to_page_boundary $(_get_filesize $file))
> +
> +	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
> +	# causing the shell to print "Bus error" to stderr.  To allow this
> +	# message to be redirected, execute xfs_io in a new shell instance.
> +	# However, for this to work reliably, we also need to prevent the new
> +	# shell instance from optimizing out the fork and directly exec'ing
> +	# xfs_io.  The easiest way to do that is to append 'true' to the
> +	# commands, so that xfs_io is no longer the last command the shell sees.
> +	# Don't let it write core files to the filesystem.
> +	bash -c "trap '' SIGBUS; ulimit -c 0; $XFS_IO_PROG -r $file \
> +		-c 'mmap -r 0 $map_len' \
> +		-c 'mread -v $offset $length'; true"
> +}
> +
>  # mmap-write a byte into a range of a file
>  _mwrite_byte() {
>  	local pattern="$1"
> diff --git a/tests/generic/574 b/tests/generic/574
> index cb42baaa67aa..d44c23e5abc2 100755
> --- a/tests/generic/574
> +++ b/tests/generic/574
> @@ -52,34 +52,6 @@ setup_zeroed_file()
>  	cmp $fsv_orig_file $fsv_file
>  }
>  
> -round_up_to_page_boundary()
> -{
> -	local n=$1
> -	local page_size=$(_get_page_size)
> -
> -	echo $(( (n + page_size - 1) & ~(page_size - 1) ))
> -}
> -
> -mread()
> -{
> -	local file=$1
> -	local offset=$2
> -	local length=$3
> -	local map_len=$(round_up_to_page_boundary $(_get_filesize $file))
> -
> -	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
> -	# causing the shell to print "Bus error" to stderr.  To allow this
> -	# message to be redirected, execute xfs_io in a new shell instance.
> -	# However, for this to work reliably, we also need to prevent the new
> -	# shell instance from optimizing out the fork and directly exec'ing
> -	# xfs_io.  The easiest way to do that is to append 'true' to the
> -	# commands, so that xfs_io is no longer the last command the shell sees.
> -	# Don't let it write core files to the filesystem.
> -	bash -c "trap '' SIGBUS; ulimit -c 0; $XFS_IO_PROG -r $file \
> -		-c 'mmap -r 0 $map_len' \
> -		-c 'mread -v $offset $length'; true"
> -}
> -
>  corruption_test()
>  {
>  	local block_size=$1
> @@ -142,7 +114,7 @@ corruption_test()
>  	fi
>  
>  	# Reading the full file via mmap should fail.
> -	mread $fsv_file 0 $file_len >/dev/null 2>$tmp.err
> +	_mread $fsv_file 0 $file_len >/dev/null 2>$tmp.err
>  	if ! grep -q 'Bus error' $tmp.err; then
>  		echo "Didn't see SIGBUS when reading file via mmap"
>  		cat $tmp.err
> @@ -150,7 +122,7 @@ corruption_test()
>  
>  	# Reading just the corrupted part via mmap should fail.
>  	if ! $is_merkle_tree; then
> -		mread $fsv_file $zap_offset $zap_len >/dev/null 2>$tmp.err
> +		_mread $fsv_file $zap_offset $zap_len >/dev/null 2>$tmp.err
>  		if ! grep -q 'Bus error' $tmp.err; then
>  			echo "Didn't see SIGBUS when reading corrupted part via mmap"
>  			cat $tmp.err
> @@ -174,10 +146,10 @@ corrupt_eof_block_test()
>  	head -c $zap_len /dev/zero | tr '\0' X \
>  		| _fsv_scratch_corrupt_bytes $fsv_file $file_len
>  
> -	mread $fsv_file $file_len $zap_len >$tmp.out 2>$tmp.err
> +	_mread $fsv_file $file_len $zap_len >$tmp.out 2>$tmp.err
>  
>  	head -c $file_len /dev/zero >$tmp.zeroes
> -	mread $tmp.zeroes $file_len $zap_len >$tmp.zeroes_out
> +	_mread $tmp.zeroes $file_len $zap_len >$tmp.zeroes_out
>  
>  	grep -q 'Bus error' $tmp.err || diff $tmp.out $tmp.zeroes_out
>  }
> -- 
> 2.43.0
> 
> 

