Return-Path: <linux-fsdevel+bounces-21569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B589A905D77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 23:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A56B283F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89413126F0A;
	Wed, 12 Jun 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIXhgPtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0E381D1;
	Wed, 12 Jun 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226642; cv=none; b=unwALY3nChCQ4TJL2QTm1d4wAZMOjlzEps4wFLs+2mZtn69DpJxx4ssp8Qbm1Py1TVvf3d2Tshq9JNl05+4n6Mw8eQLvzQ6B/zuzd5fH7hEnOzpdpyhqtYwXq4f1K0UJlrAITEEMVnAQm82e32yKyf9oOnF1sfGXGCJuPzakm8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226642; c=relaxed/simple;
	bh=dqLO371b1vPErmMYi4CgWyvSUCQn8of4qGwTdEMzEhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYZRf0uCnWnQSM6TjSEoHLMs122iF4srQ6UIWWY6tlZGY2zzjxOBufoGz5aBDXYlfPzjFuT64Rc6jiFc5i6DgyX6PG2Cyg8FM1oAUJpPCgT4/XXJzf+IgFdGvf3RBq/mQfjFrVBVcScBUyPyUrUzOw1NG4rXyIVHMVCeFjq0yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIXhgPtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2F4C116B1;
	Wed, 12 Jun 2024 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718226641;
	bh=dqLO371b1vPErmMYi4CgWyvSUCQn8of4qGwTdEMzEhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIXhgPtR71kSyV6/epJDyqhWKsEQEX5yhhZda5PPHpZ+0ARYCCiAtnRSNR1FnlC7P
	 nPXkJq/SepET7ym8thpR7yujnnQ7ZHn3iRsMoIfGobXMy1OJxAIzKKtD9ftmAGl8KN
	 kUltI84OFlF1WwDhedAy43xrdUjP8vTB+P26BCEb3a2HConB/TZUMHytqEARmpH8ln
	 QCY5BssR28eFz1T409YzepxwR+K2C6Zp7Uo+S9MDDNObxIJC8bTjFUTi06cTVT7OeC
	 lTnaI5hdCh11uuYSK3xj94QxhxrNjmNwqI7uE46+z3EGyJoGClyLogjejeb9r2ihDk
	 QMYN4T27nFHOw==
Date: Wed, 12 Jun 2024 14:10:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.com,
	chandan.babu@oracle.com, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
	ritesh.list@gmail.com, mcgrof@kernel.org,
	mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
	miklos@szeredi.hu, martin.petersen@oracle.com
Subject: Re: [PATCH v4 01/22] fs: Add generic_atomic_write_valid_size()
Message-ID: <20240612211040.GJ2764752@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607143919.2622319-2-john.g.garry@oracle.com>

On Fri, Jun 07, 2024 at 02:38:58PM +0000, John Garry wrote:
> Add a generic helper for FSes to validate that an atomic write is
> appropriately sized (along with the other checks).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/linux/fs.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 069cbab62700..e13d34f8c24e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3645,4 +3645,16 @@ bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
>  	return true;
>  }
>  
> +static inline
> +bool generic_atomic_write_valid_size(loff_t pos, struct iov_iter *iter,
> +				unsigned int unit_min, unsigned int unit_max)
> +{
> +	size_t len = iov_iter_count(iter);
> +
> +	if (len < unit_min || len > unit_max)
> +		return false;
> +
> +	return generic_atomic_write_valid(pos, iter);
> +}

Now that I look back at "fs: Initial atomic write support" I wonder why
not pass the iocb and the iov_iter instead of pos and the iov_iter?
And can these be collapsed into a single generic_atomic_write_checks()
function?

--D

> +
>  #endif /* _LINUX_FS_H */
> -- 
> 2.31.1
> 
> 

