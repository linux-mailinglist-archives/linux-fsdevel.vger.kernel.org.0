Return-Path: <linux-fsdevel+bounces-34161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 597EA9C33ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E0DB20C3A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7013AA53;
	Sun, 10 Nov 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb35O84S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2617C91;
	Sun, 10 Nov 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731258758; cv=none; b=jdmcUjQqQSzbtbGpuDOOKzceikpy+E5C9NExCc6DNDGQD5oZZmFBD2oI+j0GIZjOYpni2fjcWJgZwMSWjaEGlzMvA5AbWtnSfIT5E3cvAsBP3dXKzTtf8d/ZfpbzjqNA7qFMywqcjaGG6V3Tdyb1G030ptwCGmxxCQaxiMvPams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731258758; c=relaxed/simple;
	bh=f+xJQK8qTxKaBoNsqvHUio0u/tyW7z+uPR0etrMifvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY+Nq4MJgkA6GOEoKi/ttx4+PJLoyMfdmMvKHxoGK+PZ4FLJRVCTcH2ITSC9CaAhYwkqR5bIlYHMzLeJQFLG/HnPaplHYN8Hq7FHjQkfzhgwmiyIEGD77FaZFkFmrxghgl+VgpbfD89VZ64mxulDn6qgwGMEWgtTcUB7xBBMJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb35O84S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBC8C4CECD;
	Sun, 10 Nov 2024 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731258757;
	bh=f+xJQK8qTxKaBoNsqvHUio0u/tyW7z+uPR0etrMifvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qb35O84S4/dlUpuzaNYBWgqQZ0NaJ/qIgDwm9VpchJBYt5mTo0XbuF04yYMQeucrf
	 XD2smO2O1cjwLUkRXxD8KH4IKpizNfgZ29dJQBGqqGToDu5V+nvVMpRjxl466IhpLN
	 GaIY+73kLlCkd2Y9mbMLNKLLNEyP2NJLAnZE5p4AIZgMWLyCjiW09eoSqZAbJDbM3O
	 hK1qJaeLxMTtNitUm3MnRVVDAJiZGfnfa+Bdc4EjtRsLK0txO7C788YTqVHe/dC42h
	 ZCejshQd6nEZ8FH1Rg61tTyclNc3uQe3EAFIzFaR5kcOL76Ik0r3iqb56QF4gOaQnW
	 dAwboE0c5bHuA==
Date: Sun, 10 Nov 2024 12:12:36 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: trondmy@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH RESEND] filemap: Fix bounds checking in filemap_read()
Message-ID: <ZzDphC-x1XEFlDvD@kernel.org>
References: <f875d790e335792eca5b925d0c2c559c4e7fa299.1729859474.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f875d790e335792eca5b925d0c2c559c4e7fa299.1729859474.git.trond.myklebust@hammerspace.com>

On Fri, Oct 25, 2024 at 08:32:57AM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the caller supplies an iocb->ki_pos value that is close to the
> filesystem upper limit, and an iterator with a count that causes us to
> overflow that limit, then filemap_read() enters an infinite loop.
> 
> This behaviour was discovered when testing xfstests generic/525 with the
> "localio" optimisation for loopback NFS mounts.
> 
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Fixes: c2a9737f45e2 ("vfs,mm: fix a dead loop in truncate_inode_pages_range()")
> Tested-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 36d22968be9a..56fa431c52af 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2625,7 +2625,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  	if (unlikely(!iov_iter_count(iter)))
>  		return 0;
>  
> -	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
> +	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
>  	folio_batch_init(&fbatch);
>  
>  	do {
> -- 
> 2.47.0
> 
> 

Hi,

This mm fix is still needed for 6.12.  Otherwise we're exposed to an
infinite loop that is easily triggered by xfstests generic/525 when
running against 6.12's new NFS LOCALIO feature.

The irony of the original "dead loop" fix (commit c2a9737f45e2) itself
having introduced the potential for infinite loop is amusing.

Thanks,
Mike

