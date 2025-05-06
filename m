Return-Path: <linux-fsdevel+bounces-48306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A97AAD18D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 01:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211F71B64419
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47F21CC68;
	Tue,  6 May 2025 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUzb6/Cg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1ED21D5B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574210; cv=none; b=jTh4kXJnCcMF3Y498i1jTF/kFZtKdxxiRQ5su99ICVqaOgiGYfCFZWRz1g6DRM2Af2efn3tOlW8WbyXC+/KdQxtTUIiXY5FEpg7l8wQc1CGqmb/eUkIFTO9TkMCW/utCFH4AH6FIkyR2E/e/L7lOWaGHYo+zTc+07NBFYMBVnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574210; c=relaxed/simple;
	bh=KXMcgPhKNRt4MH+6WvvoyGgQ1wkfJ1IkK0hCDyefnAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+8jPOQzLAJKb5U5K/StaJjL/IUMzqzE3bVzMuFGOGk1FQ0PMli6ErSjYJyYQ8BZVeaBLqG1olU1YYoWuglKdUqrUDu9tAo9FLOLYO4i6iJ8nuprPc8plkKG/MHDydIbrNQd74w3WhQu6nUR1DrIZr7MtPQsyNMrEetzFEdZsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUzb6/Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD4C4CEE4;
	Tue,  6 May 2025 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746574210;
	bh=KXMcgPhKNRt4MH+6WvvoyGgQ1wkfJ1IkK0hCDyefnAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUzb6/CgUdZ2JrU8tbqoUODwjTgGSDjF2ASJjSWqGg8k1tDo104k410fSHSUPc8TL
	 t++Us9GaWc3QfipZQDamkzXaAEOmdC8dNjU7BkLKa8WyChtr5sK78xMtI39zgjIlcP
	 izW0P6HGOcGs7vL4DQoXK69vkkwzJKZ3/uDwwRfXc0JupXUUy6z92CMiLY0B7o/pFv
	 cE2UI79MMFA7QF87KVdi0CTyx4MqXk2jC7zNqMbbEKOehNZWoxtVPPtTOemDyZvpUd
	 PEGWYXAcRgrL5wC7cRrqqDTNFBggfSh5Pn/19bW/OPVkHC0LGKb0cigRpmXxaWu8Kq
	 ojcOYTFGY/ZhQ==
Date: Tue, 6 May 2025 23:30:08 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 5/7] f2fs: separate the options parsing and options
 checking
Message-ID: <aBqbgLjM_dfFsCN3@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-6-sandeen@redhat.com>
 <aBqGw8lUbNtvdziC@google.com>
 <5eda52cb-995f-4bb7-a896-927bacdd17a2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eda52cb-995f-4bb7-a896-927bacdd17a2@redhat.com>

On 05/06, Eric Sandeen wrote:
> On 5/6/25 5:01 PM, Jaegeuk Kim wrote:
> 
> <snip>
> 
> >> +static int f2fs_check_opt_consistency(struct fs_context *fc,
> >> +				      struct super_block *sb)
> >> +{
> >> +	struct f2fs_fs_context *ctx = fc->fs_private;
> >> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >> +	int err;
> >> +
> >> +	if (ctx_test_opt(ctx, F2FS_MOUNT_NORECOVERY) && !f2fs_readonly(sb))
> >> +		return -EINVAL;
> >> +
> >> +	if (f2fs_hw_should_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
> >> +				&& !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> > Applied.
> > 
> >        if (f2fs_hw_should_discard(sbi) &&
> >                        (ctx->opt_mask & F2FS_MOUNT_DISCARD) &&
> >                        !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> > 
> 
> yes that's nicer
> 
> >> +		f2fs_warn(sbi, "discard is required for zoned block devices");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (f2fs_sb_has_device_alias(sbi)) {
> > Shouldn't this be?
> > 
> > 	if (f2fs_sb_has_device_alias(sbi) &&
> > 			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
> > 
> 
> Whoops, I don't know how I missed that, or how my testing missed it, sorry.
> And maybe it should be later in the function so it doesn't interrupt the=
> discard cases.

No worries. I applied the check after doing the discard cases.

Thanks,

>  
> >> +		f2fs_err(sbi, "device aliasing requires extent cache");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (!f2fs_hw_support_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
> >> +				&& ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> >        if (!f2fs_hw_support_discard(sbi) &&
> >                        (ctx->opt_mask & F2FS_MOUNT_DISCARD) &&
> >                        ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> > 

