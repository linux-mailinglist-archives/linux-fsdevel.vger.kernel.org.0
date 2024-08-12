Return-Path: <linux-fsdevel+bounces-25703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C385C94F55E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E4B25DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C3187FF5;
	Mon, 12 Aug 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbIbL9K9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B39188CA5;
	Mon, 12 Aug 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481706; cv=none; b=lEUXVQko2uxOui/214bi8I+cJu8iuKTwrh+L6uoxT+IFM02z3v5psbTEFZxFuwBk0lE2ITU3G+CP0KQqNbqNsrrWa1ELBPYM5cbBWVMUDpCehv6KM8oi4/Jusyh7IvSebMonG4vy5dZrX+F0iTZC+YdmL/8Nds1kPt1oULoGiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481706; c=relaxed/simple;
	bh=a+cKAitlYShHL0UZfUf1gfLJJeLtDwiavEOakSvW/ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M465lMxQieodYLKf76xn21nx9Ggst3MukOCuT6ceop7Ad1O8JhgsnTtwLFB8AWaOd884HNgexGzawVBsh8luusbEERuLcqSAq4u+FTXOBWhB3JgA2oEe826RiFOg3WrMJ6RAyE19Cc9AmVz4nXH/OR3iRNtnGQ/OYaUdrSwilck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbIbL9K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46920C4AF0D;
	Mon, 12 Aug 2024 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481706;
	bh=a+cKAitlYShHL0UZfUf1gfLJJeLtDwiavEOakSvW/ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbIbL9K9nyGz1Z0mAmypuCUUc2QlbDjfMJ+c4Da8KPNw7inqzSyfnqO7gol2YfB9A
	 GZnA62YSMZcnHxtOgqGJLIcEgWkOf5L1jhkRIMNuWoAZvanrL4SQcj0WcbbY0sfbJK
	 AK60TPtVC3OgNFNbyt6UddaHs8lsm9ZbAL67HkP5WEW8XDDR/fT5k8l4Aq+DKUZep9
	 q81/lrQFQKuUF/+D5gf5s0JCP85UAUsSUghH7Q6UzfaiL3UIi8+2IhvZ+2mEZIgknN
	 WtPhK6TB+C2c9ARSjymc8cjSeVrtMQwbNEtjwPgr0QLjISSk1EEZontqVDjEPA6Pdl
	 fqR4FfimLik6Q==
Date: Mon, 12 Aug 2024 09:55:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 2/6] iomap: support invalidating partial folios
Message-ID: <20240812165505.GH6043@frogsfrogsfrogs>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-3-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:55PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current iomap_invalidate_folio() could only invalidate an entire folio,
> if we truncate a partial folio on a filesystem with blocksize < folio
> size, it will left over the dirty bits of truncated/punched blocks, and
> the write back process will try to map the invalid hole range, but
> fortunately it hasn't trigger any real problems now since ->map_blocks()
> will fix the length. Fix this by supporting invalidating partial folios.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Seems ok to me
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4da453394aaf..763deabe8331 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -644,6 +644,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>  		WARN_ON_ONCE(folio_test_writeback(folio));
>  		folio_cancel_dirty(folio);
>  		ifs_free(folio);
> +	} else {
> +		iomap_clear_range_dirty(folio, offset, len);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
> -- 
> 2.39.2
> 
> 

