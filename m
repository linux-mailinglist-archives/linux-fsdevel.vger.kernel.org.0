Return-Path: <linux-fsdevel+bounces-48980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47224AB711D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72EE1B66C8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEEB27A139;
	Wed, 14 May 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0D3aXik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B230278161;
	Wed, 14 May 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239683; cv=none; b=qI09KJX/8NiNahzaHxrozG5hAbIx1w4MIjb0f9CfPC7qJvYvJtEUtdN4A4iJHPV++CCXhG+ywv0wBvB3dHofz734MuX8A+qxYyGZITqHsm7qZuNSEucdvRPOXH6yO9vfSFAfWGbcPHdLmLH/tTmqT2jdyQ2XlERnS00uEGoY19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239683; c=relaxed/simple;
	bh=PQ9MwKOQ5q9Z6XCumQ1t8CjUKmfnYWJasCHJsQBE6dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsahCn6W3LScelyUmV+vw9mLaiM2RiLXl4y8LOv7AEnCTLw+35IupG0BiT3Hoa3HRLUMBiuU5B5IXUHVymCOZTgtGRbwfXP42oNhWO0b3lpivTz8X0fXvRbOYA+L7lY7fK/X4dO4RwIYKmwJ9B4zYQrR7p1/sdu073EzgyyBxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0D3aXik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCC5C4CEE3;
	Wed, 14 May 2025 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239683;
	bh=PQ9MwKOQ5q9Z6XCumQ1t8CjUKmfnYWJasCHJsQBE6dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0D3aXik8sBqjt5g9cI2Szb0mnt91k3exPp4noakjRW/EcC+bIp1ZbokfeqIS4xvg
	 3QEpHuKJ1o61nAnKYA5AgHCWZiuWwgciWTjZeMXARIBo7wH8VF0Q4jDXAsI5CZP+2Z
	 aG41w+3WhlcELxFE0A4PqxeCG/56/f2tDY1GWBGlR4uu0T/axy6cpUWe1E5kfg+6q2
	 v3VPzlcCcNj6lvUTZredq5FFV00fN6hLpSXGrqsdY1DlBxaLDcNQ6qTKZVvp4eRIO6
	 R+vi6Y+pucfU7xcvgNd9nx2YMjxqgjgWGVJb8OHrcyrAxY5xfLRNW4pGTot+g0Mu9j
	 WVt95FzYoSW/g==
Date: Wed, 14 May 2025 09:21:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ext4: Enable support for ext4 multi-fsblock
 atomic write using bigalloc
Message-ID: <20250514162122.GI25655@frogsfrogsfrogs>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <71c65793ebc15d59e8ff4112f47df85f3ed766e3.1746734746.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c65793ebc15d59e8ff4112f47df85f3ed766e3.1746734746.git.ritesh.list@gmail.com>

On Fri, May 09, 2025 at 02:20:36AM +0530, Ritesh Harjani (IBM) wrote:
> Last couple of patches added the needed support for multi-fsblock atomic
> writes using bigalloc. This patch ensures that filesystem advertizes the
> needed atomic write unit min and max values for enabling multi-fsblock
> atomic write support with bigalloc.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/super.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 181934499624..508ea5cff1c7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4442,12 +4442,12 @@ static int ext4_handle_clustersize(struct super_block *sb)
>  /*
>   * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
>   * @sb: super block
> - * TODO: Later add support for bigalloc
>   */
>  static void ext4_atomic_write_init(struct super_block *sb)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct block_device *bdev = sb->s_bdev;
> +	unsigned int clustersize = sb->s_blocksize;
>  
>  	if (!bdev_can_atomic_write(bdev))
>  		return;
> @@ -4455,9 +4455,12 @@ static void ext4_atomic_write_init(struct super_block *sb)
>  	if (!ext4_has_feature_extents(sb))
>  		return;
>  
> +	if (ext4_has_feature_bigalloc(sb))
> +		clustersize = EXT4_CLUSTER_SIZE(sb);

Doesn't EXT4_CLUSTER_SIZE return EXT4_BLOCK_SIZE(sb) (aka s_blocksize)
for !bigalloc filesystems?

Looks fine to me otherwise
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
>  	sbi->s_awu_min = max(sb->s_blocksize,
>  			      bdev_atomic_write_unit_min_bytes(bdev));
> -	sbi->s_awu_max = min(sb->s_blocksize,
> +	sbi->s_awu_max = min(clustersize,
>  			      bdev_atomic_write_unit_max_bytes(bdev));
>  	if (sbi->s_awu_min && sbi->s_awu_max &&
>  	    sbi->s_awu_min <= sbi->s_awu_max) {
> -- 
> 2.49.0
> 
> 

