Return-Path: <linux-fsdevel+bounces-33375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF29B858C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA71F254ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363C1CF29C;
	Thu, 31 Oct 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwsUkA+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF751CCB30;
	Thu, 31 Oct 2024 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410977; cv=none; b=ZNF6qdqCeeex0aZUNC0Vy1AgIQ84bDtWWUJHcQ38rKghvbSeDn+dptsO+hufS4dBHpyXcUwCPUlM6uJFLY6F9S56FqLZIvOaE9YnZRSCs5TYAzF0FeimSqKRxx5RkZt//4Lzp/ta8S/d/w5H18dBW58SB/XyOuIUBNMRwefHKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410977; c=relaxed/simple;
	bh=MYvmrLwuV4l/KseAM5AyCMyT1nhV2e0VoKyUYjY1eeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+zvzCob9bfcvrROqLwK/xFu4xVsZANUozRaD9ucJXrl8vnIRo9MVEyobDWEZtBe8oUwtW0ynomWZgErKjOpmr+GkwL0A1FtmzycwLJZeaS66HUTceNLSXic7zbzo8s2sH8TyLyzh6SsrHyR0pNVhG4T0PxtQIAmaUo2LFeRNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwsUkA+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7058C4CEC3;
	Thu, 31 Oct 2024 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730410976;
	bh=MYvmrLwuV4l/KseAM5AyCMyT1nhV2e0VoKyUYjY1eeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwsUkA+WRMNvCIebn01lku+IRWN9Qei67/CRFSuH6YOmd2OQ2GBCTGNYvhTJ6Scyk
	 whuqpc0TEUDzobhudgitGxO5SvTpKLvI5w12PdwCTi2tSKTWMj98Ig2+BCyrFOVBFx
	 8eRA1FdS9hiCrLgjDbbm63iex/ighYIGFpJlCsn2P+9OnSIzBtBxyhRMCl0HLYLIw+
	 WM1xfZyslX/06eBSIORclHD1TaMl9vncOimuWsHphpN8ioVOXIhtQwwvgJaRMOM57v
	 7egvgCvCM3BEjsUDE65oCc+7ytzDRWjUfWlURwO75EOygqwSYWagJUVPSC1PPRtgdI
	 VhR5gkSygw/1A==
Date: Thu, 31 Oct 2024 14:42:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] ext4: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <20241031214256.GE21832@frogsfrogsfrogs>
References: <cover.1730286164.git.ritesh.list@gmail.com>
 <6324c2a6d7cda24d72cb271e2a46a0b0df721d0a.1730286164.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6324c2a6d7cda24d72cb271e2a46a0b0df721d0a.1730286164.git.ritesh.list@gmail.com>

On Wed, Oct 30, 2024 at 09:27:40PM +0530, Ritesh Harjani (IBM) wrote:
> FS needs to add the fmode capability in order to support atomic writes
> during file open (refer kiocb_set_rw_flags()). Set this capability on
> a regular file if ext4 can do atomic write.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index a7b9b9751a3f..8116bd78910b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -898,6 +898,9 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>  			return ret;
>  	}
>  
> +	if (S_ISREG(inode->i_mode) && ext4_can_atomic_write(inode->i_sb))

Modulo my comment earlier about ext4_can_atomic_write, this looks ok to
me.  With either variant, I say:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
> +
>  	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
>  	return dquot_file_open(inode, filp);
>  }
> -- 
> 2.46.0
> 
> 

