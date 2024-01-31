Return-Path: <linux-fsdevel+bounces-9655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C0844122
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBBC1C22131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FB82879;
	Wed, 31 Jan 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja5+l7rC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1A80C17;
	Wed, 31 Jan 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709418; cv=none; b=U0/EtVMkuRDMepgGZXocWEEOhh+VCXd5cBLCS6OuI2uDPRbLYxkJKk+jl1wBYraUl2vR/VomjSk0YgcehH3jc7WkLWu76D2C6xFA+78cmfbG2gq06r+V4m+FJ8xpMLuNxhhsE2wN+kg/zmH6U5a8jxg65F/BSLz+YheJqDlaT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709418; c=relaxed/simple;
	bh=HuuAyQQ12q3DA4tE1JpaaSXKtPB7sv8TvPPlcbuuvXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4tLUbx/ezEaJ+jneS2Sc/Y3qHpicJCJhwq/aT5qq3nfjqN5YkOLzhvivwum70rqxBvC+5vYAz0X9uQ9o5tgDERrwGOdsrCqYVSu23zVd/R7irLh1X5Je0yRtG/7LV0R2xnS1/oRQ+2gJS7tEab4oObvkWfoD4Hrq+RS7Mn+2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja5+l7rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95936C433C7;
	Wed, 31 Jan 2024 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706709417;
	bh=HuuAyQQ12q3DA4tE1JpaaSXKtPB7sv8TvPPlcbuuvXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja5+l7rC1shfB5lStw+89OxcqylF41IzuOefT55OIVsYzovyWPz8eHPvKJE9OxP4Z
	 qD/UHcr0aJqH66/X74Lm+FfmNnXRpaAqjISwGHft8SHxwQcPTJC6ug6vmT9cG+GgkQ
	 Xb+mMEU2zTTsjj+aNjtJK6kd2BsYktsJLYGxztpsL+1Kvc+LYJQ6KZkKHb2avewDGy
	 IJk6zRH3o6KFgzCsdj/I9N2TD+zqkL145bO1x3DRRAZRf6Q/qjjfI+qy0WSaNuXFwa
	 hNa6GiFehD4jFapcDE0D5f8FZ5r9RBPS/aQugX5YPXhLyp6W14MeCy7/Vw/zXrGUaw
	 iixrDJ5YKtVvA==
Date: Wed, 31 Jan 2024 14:56:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v9 01/19] fs: Fix rw_hint validation
Message-ID: <20240131-skilift-decken-cf3d638ce40c@brauner>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130214911.1863909-2-bvanassche@acm.org>

On Tue, Jan 30, 2024 at 01:48:27PM -0800, Bart Van Assche wrote:
> Reject values that are valid rw_hints after truncation but not before
> truncation by passing an untruncated value to rw_hint_valid().
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 5657cb0797c4 ("fs/fcntl: use copy_to/from_user() for u64 types")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

The fs parts of this should go through a vfs tree as this is vfs infra.
I can then give you a stable tag that you can merge and base the big
block and scsci bits on. It'll minimize merge conflicts and makes it
easier to coordinate imho.

>  fs/fcntl.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index c80a6acad742..3ff707bf2743 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -268,7 +268,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
>  }
>  #endif
>  
> -static bool rw_hint_valid(enum rw_hint hint)
> +static bool rw_hint_valid(u64 hint)
>  {
>  	switch (hint) {
>  	case RWH_WRITE_LIFE_NOT_SET:
> @@ -288,19 +288,17 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
>  {
>  	struct inode *inode = file_inode(file);
>  	u64 __user *argp = (u64 __user *)arg;
> -	enum rw_hint hint;
> -	u64 h;
> +	u64 hint;
>  
>  	switch (cmd) {
>  	case F_GET_RW_HINT:
> -		h = inode->i_write_hint;
> -		if (copy_to_user(argp, &h, sizeof(*argp)))
> +		hint = inode->i_write_hint;
> +		if (copy_to_user(argp, &hint, sizeof(*argp)))
>  			return -EFAULT;
>  		return 0;
>  	case F_SET_RW_HINT:
> -		if (copy_from_user(&h, argp, sizeof(h)))
> +		if (copy_from_user(&hint, argp, sizeof(hint)))
>  			return -EFAULT;
> -		hint = (enum rw_hint) h;
>  		if (!rw_hint_valid(hint))
>  			return -EINVAL;
>  

