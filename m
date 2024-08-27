Return-Path: <linux-fsdevel+bounces-27305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC115960135
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A3282FAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F213A416;
	Tue, 27 Aug 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMbZytn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EB2260C;
	Tue, 27 Aug 2024 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738140; cv=none; b=Ymm3BbhZoIiF11T6a443r5scuDG4gFlMuw992YUTg5T2dW0MZdXiFhRiVe6TpMtIIkCSuOkFVmakj3eu6+UzwxAZNegIL83gl+b/V5EV/KDMfxmujXKqFjlbw10HFCz63Igf5Pbhzsli9i2NOnf9JvdMR+cMdUjLcShnNWPsTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738140; c=relaxed/simple;
	bh=UNUUCvQTms/9iZEo4GfsCDlp2KN6INNumi/aUtPAUsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sscPRcJhw6TrwcQuU0Hd0PuDc3E8dGfYB9wD7TiN8MoKrOEjO0KcedGVKu/u3fqo5DBPCADnrehtu/820gzVnwaLwkmkoj0OeOielI3V+ct+YdiYbIOTgRCkAKWtxzbeJzsstCUXWJCHDIP6Kp6xl9N54w9bCIMPoMKMBKkd4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMbZytn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C286AC8B7A4;
	Tue, 27 Aug 2024 05:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724738139;
	bh=UNUUCvQTms/9iZEo4GfsCDlp2KN6INNumi/aUtPAUsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMbZytn/IziybM+kw+0P3sab/WKf0I5NwzlFI7IVFzXzCbFZHXD1QcqQiRFvOl9L2
	 kuTPNW/NkTSPpccRYnnVrYqFpHTN86B+PypYoQ2I/0VLpR8gm/zT+UoUZ0AioG4/2e
	 vpSEZshcHFujaCfyIL7aLPA1hylOrjz/Rh2ruVI3APVvv2dy5pisd8Skr3CT3Dr6UI
	 1T+WAkrlnzexX+YxPOrLdgrs/DQRSArPt+q45/KR3xfOIDFazUJ1zaAfYWVHkxYYCh
	 TAbkj4JA+GJPDKOa7R58vwTA2rT1FHCfRBpS/9Vni3rdxBv4vegLJJI6CuV5gUOiSv
	 2UfD2/XHf7E6Q==
Date: Mon, 26 Aug 2024 22:55:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, sfr@canb.auug.org.au, p.raghav@samsung.com,
	dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH] iomap: remove set_memor_ro() on zero page
Message-ID: <20240827055539.GL865349@frogsfrogsfrogs>
References: <20240826212632.2098685-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826212632.2098685-1-mcgrof@kernel.org>

On Mon, Aug 26, 2024 at 02:26:32PM -0700, Luis Chamberlain wrote:
> Stephen reported a boot failure on ppc power8 system where
> set_memor_ro() on the new zero page failed [0]. Christophe Leroy
> further clarifies we can't use this on on linear memory on ppc, and
> so instead of special casing this just for PowerPC [2] remove the
> call as suggested by Darrick.
> 
> [0] https://lore.kernel.org/all/20240826175931.1989f99e@canb.auug.org.au/T/#u
> [1] https://lore.kernel.org/all/b0fe75b4-c1bb-47f7-a7c3-2534b31c1780@csgroup.eu/
> [2] https://lore.kernel.org/all/ZszrJkFOpiy5rCma@bombadil.infradead.org/
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> This applies to the vfs.blocksize branch on the vfs tree.
> 
>  fs/iomap/direct-io.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c02b266bba52..f637aa0706a3 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -11,7 +11,6 @@
>  #include <linux/iomap.h>
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
> -#include <linux/set_memory.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include "trace.h"
>  
> @@ -781,8 +780,6 @@ static int __init iomap_dio_init(void)
>  	if (!zero_page)
>  		return -ENOMEM;
>  
> -	set_memory_ro((unsigned long)page_address(zero_page),
> -		      1U << IOMAP_ZERO_PAGE_ORDER);
>  	return 0;
>  }
>  fs_initcall(iomap_dio_init);
> -- 
> 2.43.0
> 
> 

