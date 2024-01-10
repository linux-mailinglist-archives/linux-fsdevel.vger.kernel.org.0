Return-Path: <linux-fsdevel+bounces-7735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2135829FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152AA1C213C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF304D590;
	Wed, 10 Jan 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAygTEqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB44D125;
	Wed, 10 Jan 2024 17:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE8BC433F1;
	Wed, 10 Jan 2024 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704909315;
	bh=fu4Rj/eN06CEkV5JbSMpnHawgZaPLeLIgtEFRQv1w5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAygTEqZWVfylCFiDRG7P1l/VNgkre3NkIa+TSKWtjTWzTjqWxGd+6jLl9JLq9Ff0
	 HkUiC0YShB3RTedTUqQpvGmjzfg4QuMwsAoJ/Jdw+Tb8AoAVZ2vkZw9wgCj3kSgF+j
	 yzwcPO01+qwLDH/Y73uLhuwWnuWnal0emVdoFNiftr94w2BLYKTYdnr0oMLshOaGDd
	 NBbRCi0am1LWayVzGsz33cPYmCO/+nX7iUneIlV6CMd6eTt5zF+47RDDPWe+BOqgei
	 Z9rVGGi0mIBlfrbcxwOpuT5Te9ccn5QkF6yosVtLxF4wzyuFarxC28PHW4SJAiMXg/
	 agoDkyYabdckg==
Date: Wed, 10 Jan 2024 09:55:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: disable large folio support in xfile_create
Message-ID: <20240110175515.GA722950@frogsfrogsfrogs>
References: <20240110092109.1950011-1-hch@lst.de>
 <20240110092109.1950011-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110092109.1950011-3-hch@lst.de>

On Wed, Jan 10, 2024 at 10:21:09AM +0100, Christoph Hellwig wrote:
> The xfarray code will crash if large folios are force enabled using:
> 
>    echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> 
> Fixing this will require a bit of an API change, and prefeably sorting out
> the hwpoison story for pages vs folio and where it is placed in the shmem
> API.  For now use this one liner to disable large folios.
> 
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Can someone who knows more about shmem.c than I do please review
https://lore.kernel.org/linux-xfs/20240103084126.513354-4-hch@lst.de/
so that I can feel slightly more confident as hch and I sort through the
xfile.c issues?

For this patch,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/xfile.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> index 090c3ead43fdf1..1a8d1bedd0b0dc 100644
> --- a/fs/xfs/scrub/xfile.c
> +++ b/fs/xfs/scrub/xfile.c
> @@ -94,6 +94,11 @@ xfile_create(
>  
>  	lockdep_set_class(&inode->i_rwsem, &xfile_i_mutex_key);
>  
> +	/*
> +	 * We're not quite ready for large folios yet.
> +	 */
> +	mapping_clear_large_folios(inode->i_mapping);
> +
>  	trace_xfile_create(xf);
>  
>  	*xfilep = xf;
> -- 
> 2.39.2
> 
> 

