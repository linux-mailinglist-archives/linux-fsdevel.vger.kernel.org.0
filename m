Return-Path: <linux-fsdevel+bounces-10680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016EC84D5A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841CAB28E39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050EF149DEF;
	Wed,  7 Feb 2024 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC66U84L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CE149DE1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343649; cv=none; b=JpdYYGhg73orWlbx/4w8zBt/clJqiw4OKZJodYUnrjVPDu22eEvvB9IrpEeVsLHvyed/ZRC/hSJW5IMfKxt/avz1Lqq+/OnEJLVemGbnPDN4+8+Nb/o2UC1EZT/SO9MlVBgbKNPz7ADRXfLdicuzq5eZKqVIgEpz1pB2sK8rrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343649; c=relaxed/simple;
	bh=u9OMmhxX0s42oLm7vizz1zDQD3vd1KooHH9Xj369KHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvGnTJL2MhmOeM22ivDTiaSb0Z81VmYZUqhGZVO9Nc3/fxvZj00/geQdm2rK8eIPIFw8J4KKzoqPLqtSpEPtkQbUIiPL7gG1ujwfPlHlZ9TJEYXfIIWXeGRkscWPQfwiHa26FRwoArP+I5hgvVRE69W+5kMXkdJRsjYWMQe9R+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC66U84L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54AAC433F1;
	Wed,  7 Feb 2024 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707343648;
	bh=u9OMmhxX0s42oLm7vizz1zDQD3vd1KooHH9Xj369KHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QC66U84L3Mqk9dBRZJZezgEGcxBzKPxRiX96y9gE95sxyPkEe41NlO4L2El+zUT8h
	 6ppsYlm+EwAgJz96Y4ztP+0HaJhbJNfKGwP61WNCThcg2bRkk98e/OXfbfAM3X/Nrg
	 EArm+ADVb1DOG1GGNfIRMzwUnKtHNj3PVsHhywn8LTskKnWQdrT6BPFMXnyDqPN++E
	 BHKin5u6p4a/rBV3gb66+XZHTOw/989ZGSFj/2k+G5GC7Cj7Had2IFKdf/MNSIoT7s
	 NEEopsGSKNCvLq6KNoMn7rMKshPm2ENh9ojLZgXmh5QjUgXgRK6r0AbJp76gAy9heM
	 Go+83s3fQe6Qw==
Date: Wed, 7 Feb 2024 14:07:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Timur Tabi <ttabi@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] debufgs: debugfs_create_blob can set the file size
Message-ID: <20240207220728.GL6184@frogsfrogsfrogs>
References: <20240207200619.3354549-1-ttabi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207200619.3354549-1-ttabi@nvidia.com>

On Wed, Feb 07, 2024 at 02:06:19PM -0600, Timur Tabi wrote:
> debugfs_create_blob() is given the size of the blob, so use it to
> also set the size of the dentry.  For example, efi=debug previously
> showed
> 
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_code0
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_code1
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data0
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data1
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data2
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data3
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data4
> 
> but with this patch it shows
> 
> -r-------- 1 root root  12783616 Feb  7 13:26 boot_services_code0
> -r-------- 1 root root    262144 Feb  7 13:26 boot_services_code1
> -r-------- 1 root root  41705472 Feb  7 13:26 boot_services_data0
> -r-------- 1 root root  23187456 Feb  7 13:26 boot_services_data1
> -r-------- 1 root root 110645248 Feb  7 13:26 boot_services_data2
> -r-------- 1 root root   1048576 Feb  7 13:26 boot_services_data3
> -r-------- 1 root root      4096 Feb  7 13:26 boot_services_data4
> 
> Signed-off-by: Timur Tabi <ttabi@nvidia.com>
> ---
>  fs/debugfs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index c6f4a9a98b85..d97800603a8f 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1152,7 +1152,14 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>  				   struct dentry *parent,
>  				   struct debugfs_blob_wrapper *blob)
>  {
> -	return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
> +	struct dentry *dentry;
> +
> +	dentry = debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
> +	if (!IS_ERR(dentry))
> +		d_inode(dentry)->i_size = blob->size;

Aren't you supposed to use i_size_write for this?

--D

> +
> +	return dentry;
> +
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_blob);
>  
> -- 
> 2.34.1
> 
> 

