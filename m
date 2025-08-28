Return-Path: <linux-fsdevel+bounces-59489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895BCB39D66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D581C2553D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6517C30FC20;
	Thu, 28 Aug 2025 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2BS0PF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6D30F937;
	Thu, 28 Aug 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384554; cv=none; b=pPdH7bZmRQFuby1czSXTnmiG+B2RjH9CRjgdoH/CttkORYDG4yE1whTUXM2+EdmbGxHAP/Z7M0+tAc+L5nlKCxtGQ5yGKub1ydHisHjWgRUXf5lSvIrncKAOedCA2z3a3edU1GYdRfDjDHJdrW1iE64JfO84fFiUcicoJC4JgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384554; c=relaxed/simple;
	bh=IDminVuXFCLI4B969mEyqWsnd3Aa+pLqtK2BNYQ1ZQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZt+Q87rgiXgNnvM9yxaC5oTwG8QUVI2K+ViBRsfpyx7/Dhn24j+z0sCe72Qa6YrMYgrhOdScdY+SP8hd3sZ9GF1m/nE2gBDlRcmFddbNxVuo45OH+fXt2bwyAdi0DMMZM0nSf82YNhCeCxhbj+bbykWZe0sGsuYTdjmrBt8mxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2BS0PF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A4CC4CEF6;
	Thu, 28 Aug 2025 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384554;
	bh=IDminVuXFCLI4B969mEyqWsnd3Aa+pLqtK2BNYQ1ZQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2BS0PF0v2MJovso2mkRO7QWGECFNvby2Mbqw7yooKIxegv0sYrzWR8mIQ3adxwk5
	 VlIzdqGvCF8RCvsS4UB356ijy1I1tm5bQC1sfgTgwuIXbPwkx5WZCinVtbnvf/0bE+
	 zcgGHsZQ0/nZ8Px+LrIBynG89zvwTUUPJmwZHEAzoMGoDp+vaxIm25nLjEr0w+Nozl
	 Q0UU9IhkIfoChTW7/00c/iru+JsugVdu4MDqIS+/AnP03aKZfj0FP35657eT+cmLqW
	 wKL3c/TOrHbd7o0IENDpb2kAjV2DfmMSWSjn96FSKqFlrg6NuqBzQcksogP/296Bjy
	 CL280DiYOwgng==
Date: Thu, 28 Aug 2025 14:35:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 39/54] fs: remove I_WILL_FREE|I_FREEING check from
 dquot.c
Message-ID: <20250828-mundtot-gedacht-577d180facf7@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <e2c8fe9fa28fb6e52d0e47e38d2ef93c9527b84f.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2c8fe9fa28fb6e52d0e47e38d2ef93c9527b84f.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:39AM -0400, Josef Bacik wrote:
> We can use the reference count to see if the inode is live.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/quota/dquot.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index df4a9b348769..90e69653c261 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1030,14 +1030,16 @@ static int add_dquot_ref(struct super_block *sb, int type)
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> -		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		if ((inode->i_state & I_NEW) ||
>  		    !atomic_read(&inode->i_writecount) ||
>  		    !dqinit_needed(inode, type)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -		__iget(inode);
>  		spin_unlock(&inode->i_lock);
> +
> +		if (!igrab(inode))
> +			continue;

Using this to drop a comment that I mentioned to you. I think we should
have an iterator for this because we have the exact same pattern in so
many places it's annoying.

