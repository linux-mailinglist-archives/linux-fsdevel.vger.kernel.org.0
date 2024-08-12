Return-Path: <linux-fsdevel+bounces-25699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B694F526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A251C20FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C595E18754D;
	Mon, 12 Aug 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8+ASycA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B44317C;
	Mon, 12 Aug 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481137; cv=none; b=P3TNBal3gvfvuiIAAH1QQWyKmZWxgvdmV9FWlzFYlaiCMJv3iy7rlIU4Wmy1VxEyr3KotnlD+SEtYo+VCr1Ms0+dmqmHm7BRN2G7Ut640oxfVDbvAfcSXgnhLv4XB/sl6d9GCA1F8AokphAJz2W7dPSH0jlMKx1BdXnO1m/lPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481137; c=relaxed/simple;
	bh=fKYlJwy9loPmywPAiGijdAnHNQS3azjgKPmKvKK6vnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVeWpUFdl0vjvMAmNtgil+dHtQZGwNYraMApLKQksyqC+qZ81JepnhYaSUJ4uRtMc9o3nDe2U/Ipv5CDkq2P5ImWWaNvFDag2n5Lp3S+1khTCOp8LeIoE10JhFWiw5aCtkMhiHu0tut1OJ5OC1IhYF74uDnng0fubv0S2IgE0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8+ASycA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAFCC32782;
	Mon, 12 Aug 2024 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481136;
	bh=fKYlJwy9loPmywPAiGijdAnHNQS3azjgKPmKvKK6vnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8+ASycALNsiF2BhYXKB6kjgfZ3w0ym6uo6Unsy4YGHsIajhych9ZRoTk1MZxYCGs
	 KaYpm3tzTLyPQVsdDMmUcVKeRBHZoGLqJg+jvMB7kibTsxk3gVxEGnbgxnMGUxesJh
	 eZd5izfSA/m2+rMXJRv7e4dTdHJNSotDSznNNEKHuBGf3+78712MqwWNgsQSUrR1o5
	 7yiiRl774k/FQORrZBQRbivYa/cGuBXLzhYXmPisIKXJOL5yms7YEtl1DzrX/k9CvK
	 4uH0tPBrWU8YxfjzOryWq6euyTe4uG38sKiSXse1x+C5UOdE5AZxLv/hNjOYstzHKf
	 iMUq/1ng0tZrQ==
Date: Mon, 12 Aug 2024 09:45:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
Message-ID: <20240812164536.GE6043@frogsfrogsfrogs>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-5-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:57PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When doing page mkwrite, iomap_folio_mkwrite_iter() dirty the entire
> folio by folio_mark_dirty() even the map length is shorter than one
> folio. However, on the filesystem with more than one blocks per folio,
> we'd better to only set counterpart block's dirty bit according to
> iomap_length(), so open code folio_mark_dirty() and pass the correct
> length.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 79031b7517e5..ac762de9a27f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1492,7 +1492,10 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
>  		block_commit_write(&folio->page, 0, length);
>  	} else {
>  		WARN_ON_ONCE(!folio_test_uptodate(folio));
> -		folio_mark_dirty(folio);
> +
> +		ifs_alloc(iter->inode, folio, 0);
> +		iomap_set_range_dirty(folio, 0, length);
> +		filemap_dirty_folio(iter->inode->i_mapping, folio);

Is it correct to be doing a lot more work by changing folio_mark_dirty
to filemap_dirty_folio?  Now pagefaults call __mark_inode_dirty which
they did not before.  Also, the folio itself must be marked dirty if any
of the ifs bitmap is marked dirty, so I don't understand the change
here.

--D

>  	}
>  
>  	return length;
> -- 
> 2.39.2
> 
> 

