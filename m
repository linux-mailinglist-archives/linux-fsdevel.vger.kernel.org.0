Return-Path: <linux-fsdevel+bounces-57017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087BCB1DDBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 21:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E9156099E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18858231C91;
	Thu,  7 Aug 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHscZq3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201A482EB;
	Thu,  7 Aug 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596699; cv=none; b=lco3AJ7XRHHwv+GAGm/fsf3Jq5bxKIls7ma4n4081gVW7dGQDZxxGHtnnRPRNPhv/ulvZ5FkNR3ryxrZfbwDEKeRigOr2+HUVq9FIvnZhnz6PGIe5xAmODY6bGscTzgEmgxrvieviZ2NoAn0XDAxDhZrA2IBbG9B1BUiUqkmj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596699; c=relaxed/simple;
	bh=PRNJdTkg+Cl6Md5MFcIQfJg92u2l/9AkbA/ArJEWtm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSMWbgKDkNUvPH7YaRBDiwfSxdTJTEWyRA8p6V2JdCjBAX7NU/wjxwGieZ0DcS4C0TUImAqn3VeUROGzJR9rR6lea1uuD1/JMMDBP3hH6EqLJFhEYrTfs+HyO7Gby/JtxuGG2MF1db/Re1WMhi1/Ux5p5wezvY9Qd7yJSJ7wdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHscZq3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE28C4CEEB;
	Thu,  7 Aug 2025 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754596699;
	bh=PRNJdTkg+Cl6Md5MFcIQfJg92u2l/9AkbA/ArJEWtm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHscZq3Ji/KNWUPeLmgm/rj+7+w79HIVnvWLbXv6xCPZyY1WCkefgsN6roB+YH5aU
	 Jl8aFRp5QC2UfP42SWdbnJn6gjplgmVmTWdkjNfKmBYAS0R2O5eNpLOahibJdeDWkH
	 gDXpwIYvYqST4nKUK9/pfK8cPx0NFvy82wUG69Y/Ji5R5i6bwAx7o7fomN2zbL5Y11
	 yc+CZdqA4bBxSY+xNpkkvWyEvmxoU+mmACcLwAw/ANExV8WmBDG13z/m4eC699ZuSK
	 LKDPW8dGWCHtYDC4KHmYbBFJ2gyOmBcUiZ5AdOjCMhNEuXR84dGx+yIkdYw1dg1egU
	 ByVrZPsOm3X3g==
Date: Thu, 7 Aug 2025 12:58:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: Fix reserved gdt blocks handling in fsmap
Message-ID: <20250807195818.GT2672022@frogsfrogsfrogs>
References: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>
 <08781b796453a5770112aa96ad14c864fbf31935.1754377641.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08781b796453a5770112aa96ad14c864fbf31935.1754377641.git.ojaswin@linux.ibm.com>

On Tue, Aug 05, 2025 at 02:00:31PM +0530, Ojaswin Mujoo wrote:
> In some cases like small FSes with no meta_bg and where the resize doesn't
> need extra gdt blocks as it can fit in the current one,
> s_reserved_gdt_blocks is set as 0, which causes fsmap to emit a 0 length
> entry, which is incorrect.
> 
>   $ mkfs.ext4 -b 65536 -O bigalloc /dev/sda 5G
>   $ mount /dev/sda /mnt/scratch
>   $ xfs_io -c "fsmap -d" /mnt/scartch
> 
>         0: 253:48 [0..127]: static fs metadata 128
>         1: 253:48 [128..255]: special 102:1 128
>         2: 253:48 [256..255]: special 102:2 0     <---- 0 len entry
>         3: 253:48 [256..383]: special 102:3 128
> 
> Fix this by adding a check for this case.
> 
> Fixes: 0c9ec4beecac ("ext4: support GETFSMAP ioctls")
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I had no idea that this could be zero, so....
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/fsmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index 9d63c39f6077..91185c40f755 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -393,6 +393,14 @@ static unsigned int ext4_getfsmap_find_sb(struct super_block *sb,
>  	/* Reserved GDT blocks */
>  	if (!ext4_has_feature_meta_bg(sb) || metagroup < first_meta_bg) {
>  		len = le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks);
> +
> +		/*
> +		 * mkfs.ext4 can set s_reserved_gdt_blocks as 0 in some cases,
> +		 * check for that.
> +		 */
> +		if (!len)
> +			return 0;
> +
>  		error = ext4_getfsmap_fill(meta_list, fsb, len,
>  					   EXT4_FMR_OWN_RESV_GDT);
>  		if (error)
> -- 
> 2.49.0
> 
> 

