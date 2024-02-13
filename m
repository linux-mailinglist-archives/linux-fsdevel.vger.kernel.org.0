Return-Path: <linux-fsdevel+bounces-11387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584958535F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95B11F244FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298445F87E;
	Tue, 13 Feb 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiG74dt6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A85D91C;
	Tue, 13 Feb 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841625; cv=none; b=TFn03EWXAIxi+hhUYJ1Y77ECOHcN29xD7YTOaL1wFR6uf38ss4k9slHpw3TU1fQpqtEpYYyPdiQGTM1Be64a94Fhn1CUXrqRlmiAADl66C4zhpNO9+3oQVbi59op+fp6KTlwv+5UxL6GcWuXrnxfPLa0QQr5P/Fox4u3LLfMMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841625; c=relaxed/simple;
	bh=I4j0ct2ZX+hSPlx2NUqgKxHFmaIO2IKKpDrBU5uH/1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJggN+2d+ggQz0ssubvwJvOtwg4wbgQoRdUzSOpfwPKUCEqFhV6muHPE2NYPTok04x2tAg+bi+AkRi/1iC4lwWE7VeURNTPcAsofS+6bm7sTwHF1z1U8L6iKKEA3e0DEc1INf3llbgrRqbD2/GtswqgT3QhgJT3uSbJ27eWCJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiG74dt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BB6C433F1;
	Tue, 13 Feb 2024 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841625;
	bh=I4j0ct2ZX+hSPlx2NUqgKxHFmaIO2IKKpDrBU5uH/1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FiG74dt60bJgg/aftLkydqOKtA4Hv58E9b1DOO9oSnq5kCkUx/WmmqIhjmCLGc/jY
	 /mibd0lq2JXVJql4GDprEpgl8UkiAh8cvZKlaUXiAHuBEdY4QwAZ6/ms76Sty9OMil
	 OKR18SChm/vN4taJNcZ+GaeMF3ABHyaOeAYq5EeAwxpancgtVsvfjk/25tGrH7o/5n
	 hPLkqUMy8QpowQw1tjeOWHB2g0roL76ibATwDBSjSdSzrpFkg7YLFZspp72NGegvCU
	 NeLB93fX+4YeqCJA2YwbtgLEmKSu9IJoGB+jTldkMQpav89jLuZwGvaKruC6zmIiOv
	 /u5nimIGxC4oA==
Date: Tue, 13 Feb 2024 08:27:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [RFC v2 11/14] xfs: expose block size in stat
Message-ID: <20240213162704.GQ6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-12-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-12-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:10AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> For block size larger than page size, the unit of efficient IO is
> the block size, not the page size. Leaving stat() to report
> PAGE_SIZE as the block size causes test programs like fsx to issue
> illegal ranges for operations that require block size alignment
> (e.g. fallocate() insert range). Hence update the preferred IO size
> to reflect the block size in this case.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> [mcgrof: forward rebase in consideration for commit
> dd2d535e3fb29d ("xfs: cleanup calculating the stat optimal I/O size")]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/xfs/xfs_iops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a0d77f5f512e..8791a9d80897 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -515,6 +515,8 @@ xfs_stat_blksize(
>  	struct xfs_inode	*ip)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
> +	unsigned long	default_size = max_t(unsigned long, PAGE_SIZE,
> +					     mp->m_sb.sb_blocksize);

Nit: wonky indentation, but...

>  
>  	/*
>  	 * If the file blocks are being allocated from a realtime volume, then
> @@ -543,7 +545,7 @@ xfs_stat_blksize(
>  			return 1U << mp->m_allocsize_log;
>  	}
>  
> -	return PAGE_SIZE;
> +	return default_size;

...why not return max_t(...) directly here?

--D

>  }
>  
>  STATIC int
> -- 
> 2.43.0
> 
> 

