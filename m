Return-Path: <linux-fsdevel+bounces-60212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD456B42B64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4F54865DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6522C2E92B8;
	Wed,  3 Sep 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgbhUb9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75532E764A;
	Wed,  3 Sep 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932794; cv=none; b=HEMwvs54UBg8ZUKrugammQvLfs3/jzDYgZVtQlfSPfYLI1aM/P2cFbQ/s/7VoAkATTyTEmJNa913k7fXt7+asA8L5HXB33SV8ycqx171usiKo11QyepFrhiJIIB+4VaGhlwb2dwHjldnImr6gWsmqS7SDkiYc28a+HS1RrVyLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932794; c=relaxed/simple;
	bh=mob4Qm6dHEytT4f3C/TZ7R4A4EzZCYh9oGWZqxhaMUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEVFexJaz+NAjJlHs0GEbAGTnPQKJUmLwmYi4n6dOnUvlGblhOw5gbzGVci6fQmj1q17NMx/NRLzhixxBL6x4993VnnV9CwaAhuiz5cfmhycvXpoHQ7QlyyHqWmYCJ4s50wl/MsNXU230/EiynBIdIkejD0u8R+3+jub0M+BWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgbhUb9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4EDC4CEE7;
	Wed,  3 Sep 2025 20:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932794;
	bh=mob4Qm6dHEytT4f3C/TZ7R4A4EzZCYh9oGWZqxhaMUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgbhUb9zaJBbwTBdhO+nnomZ6oyKmSjGAobDxQw8kt8gB8yLOZ7HU7wUQXrHYLtn4
	 2EP0L42BGqFyybFxIfN44TkieUGMGUUiDio3Q8PGUVP+MU7rpwLs4wXIDOGcivPnUk
	 DIpz9Hc7ptHv/RxyDdw5jAPM6rrmFkE4DCHs7eRgRAI+OTR/YRV2BXKBuzhwoId5as
	 IVPk6trKajJwqlzecmayRuVjPtbHX/257P2CxUIY4jHX1F9M1RbgpmUwFDbGMhF6X/
	 RaM6I3cZ5wjYDnkB9dxvnMyGAaD86RPSpdtjkLyE84DIbwDLvhqNC53apWaPEzcMcJ
	 9I7sN9Vq46mEQ==
Date: Wed, 3 Sep 2025 13:53:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 11/16] iomap: make start folio read and finish folio
 read public APIs
Message-ID: <20250903205313.GS1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-12-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:22PM -0700, Joanne Koong wrote:
> Make iomap_start_folio_read() and iomap_finish_folio_read() publicly
> accessible. These need to be accessible in order to support
> user-provided read folio callbacks for read/readahead.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks decent,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 10 ++++++----
>  include/linux/iomap.h  |  3 +++
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6a9f9a9e591f..5d153c6b16b6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -323,8 +323,7 @@ struct iomap_readfolio_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -#ifdef CONFIG_BLOCK
> -static void iomap_start_folio_read(struct folio *folio, size_t len)
> +void iomap_start_folio_read(struct folio *folio, size_t len)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  
> @@ -334,9 +333,10 @@ static void iomap_start_folio_read(struct folio *folio, size_t len)
>  		spin_unlock_irq(&ifs->state_lock);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(iomap_start_folio_read);
>  
> -static void iomap_finish_folio_read(struct folio *folio, size_t off,
> -		size_t len, int error)
> +void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
> +		int error)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	bool uptodate = !error;
> @@ -356,7 +356,9 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
>  	if (finished)
>  		folio_end_read(folio, uptodate);
>  }
> +EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
>  
> +#ifdef CONFIG_BLOCK
>  static void iomap_read_end_io(struct bio *bio)
>  {
>  	int error = blk_status_to_errno(bio->bi_status);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 73dceabc21c8..0938c4a57f4c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -467,6 +467,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len);
>  int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
>  
> +void iomap_start_folio_read(struct folio *folio, size_t len);
> +void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
> +		int error);
>  void iomap_start_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len);
>  void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
> -- 
> 2.47.3
> 
> 

