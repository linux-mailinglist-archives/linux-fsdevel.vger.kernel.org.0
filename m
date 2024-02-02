Return-Path: <linux-fsdevel+bounces-10065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9D84770F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D294F1F2A2E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344014C5B1;
	Fri,  2 Feb 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sck0oP5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943D5FDD3;
	Fri,  2 Feb 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897181; cv=none; b=p0qD/TXOETAAxccGo+vnfN/PUNUQuja0v2wdfaKCUaPN3nK4REB7qd/SrLz0T8qmbSuxXW2Ko1myMoPiuiwAkurohgA0Zm82YSrodGydmudKXtK9Gg4B+VRbLYd7r5gNecPhdwgm4xEzA9rmor4117R/5XtdKAtgoVVVlbhRvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897181; c=relaxed/simple;
	bh=TK5YLwgxljxDowRQ0eNue0g/31dajW0hxOviA7WNyFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSIe/RxrKxjIqNVphrNFvUjU2tUd5jRzeKT0ZFkVtsR+4VMlFE1OG8GqL2FfMDAB7oUTlciAUCKNRM1yKtuO1dz5qpvja0cINDMqC1V3SPb2AiclzUWK3FTAd5/LZs9RiL1fpYw1lbjr9Nc2wlPlovDxJ6EiuIfv0iXRmuuXXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sck0oP5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D828C433F1;
	Fri,  2 Feb 2024 18:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706897180;
	bh=TK5YLwgxljxDowRQ0eNue0g/31dajW0hxOviA7WNyFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sck0oP5bBBnPHycfzsEoWFs5jT+4JemF8pU2m+bPdgc0DYc3x3+94uXLOA/TMZPAf
	 6vI2D9hSJX+lQ2YRL+KD/NQ3SEFmuPU3kTRxgjx7e/qovN3I+YCHEBkU9br/NS1JUT
	 NfQkk/sMy+h7jJB2u19X0xK7HUPO5az7inrmmq8LcQulT7lAHGHRbv+fyYgwusfyMn
	 yLueG7Cd4JUR0HMCPZyuH0YY1SUNQlXEebWT2Th2URhjV+wk29PGsMh1J3ywSkZnv8
	 JX+1rJGaVf9Y6DXzPVP/+73zgPHbY88i4+t/+r9N/4cOoKZxtBBKjQdVx1ue8GPaeF
	 caeENVq28jkZg==
Date: Fri, 2 Feb 2024 10:06:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for
 FS_XFLAG_ATOMICWRITES set
Message-ID: <20240202180619.GK6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-7-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 02:26:45PM +0000, John Garry wrote:
> For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
> flag.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index e33e5e13b95f..1375d0089806 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1232,6 +1232,8 @@ xfs_file_open(
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
>  			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
> +	if (xfs_inode_atomicwrites(XFS_I(inode)))

Shouldn't we check that the device supports AWU at all before turning on
the FMODE flag?

--D

> +		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
>  }
>  
> -- 
> 2.31.1
> 
> 

