Return-Path: <linux-fsdevel+bounces-27401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7109613C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4513B1F2413C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09F1CCEFE;
	Tue, 27 Aug 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEpoxL2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C31CBE8F;
	Tue, 27 Aug 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775257; cv=none; b=u04+OKIp8Y8Vn7TJSGV+WmsFXl6WNfMgeJ0PD/E0fdNmSJjllQ3RBv6b+nceBf6S75qjUm7Uz3t+fSIMy3rAS1vdE5nTWEsKztA+QV+C6pz+QaTyrE/1sGcNdrX7+Ttxk/zUS2dtetbMDl4FnzgIsJcZWbPRzGrIWgRT9w82SCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775257; c=relaxed/simple;
	bh=qGZe//87Ad+MQ9pCLChDZiENV5roGQM7RxHylRBQ/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1ecSNRlG9+OfauqRDgSqoJWvyrc+TzT/fU0PqUd4GHcXk38Ez8hUNb4RRCnCqAfCM94ltNZRv0f1Yoa9zquk/g6Ger9daUcaIYPYUCUIKDrjZ3UNdjGy/oM/9TSjST4zBXqx8tSXAGThFQiSsoKxDqFk27S5UOxBd+mU+dgdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEpoxL2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D6DC5383C;
	Tue, 27 Aug 2024 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724775256;
	bh=qGZe//87Ad+MQ9pCLChDZiENV5roGQM7RxHylRBQ/Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEpoxL2jbnnPi2ZZv1w0NMg5LKaWNaOfhSWlKJDlpyefl7IZYZcXA0zuC+PMHfAzO
	 1hHzFWBIUqTJko98HBXJEP+9BR7+JKQf2i55ubErJ/Yxnjr1155coZ21yY9/+L6ZBb
	 kiVGofNr8DmPWNlrImaqvIyvhJTHkvWNmu+9CnoJs0xcy9cThCjznUTbt26PgR/Kvz
	 Ro/VLKWqYiOG/ua5LTVMBZ2xHGnD0urdJ00DvazpUdS+p1kyQW4Lx9kF2VILWr57WK
	 0vDtHf39A+Moa5Sm6/BSLYbDjOjcalyePVhc+assAgkfjV5RZ/7DnC+aUxIlP3V8cr
	 0BftsriqH4AYA==
Date: Tue, 27 Aug 2024 09:14:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: handle a post-direct I/O invalidate race in
 iomap_write_delalloc_release
Message-ID: <20240827161416.GV865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-2-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:48AM +0200, Christoph Hellwig wrote:
> When direct I/O completions invalidates the page cache it holds neither the
> i_rwsem nor the invalidate_lock so it can be racing with
> iomap_write_delalloc_release.  If the search for the end of the region that
> contains data returns the start offset we hit such a race and just need to
> look for the end of the newly created hole instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86acc5..69a931de1979b9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1241,7 +1241,15 @@ static int iomap_write_delalloc_release(struct inode *inode,
>  			error = data_end;
>  			goto out_unlock;
>  		}
> -		WARN_ON_ONCE(data_end <= start_byte);
> +
> +		/*
> +		 * If we race with post-direct I/O invalidation of the page cache,
> +		 * there might be no data left at start_byte.
> +		 */
> +		if (data_end == start_byte)
> +			continue;

Is there any chance that we could get stuck in a loop here?  I
think it's the case that if SEEK_HOLE returns data_end == start_byte,
then the next time through the loop, the SEEK_DATA will return something
that is > start_byte.  Unless someone is very rapidly writing and
punching the page cache?

Hmm but then if *xfs* is punching delalloc then we're we holding the
iolock so who else could be doing that?

If the answers are 'no' and 'nobody' then
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
> +		WARN_ON_ONCE(data_end < start_byte);
>  		WARN_ON_ONCE(data_end > scan_end_byte);
>  
>  		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
> -- 
> 2.43.0
> 
> 

