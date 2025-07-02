Return-Path: <linux-fsdevel+bounces-53699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39614AF60E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4545717730E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816131550E;
	Wed,  2 Jul 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLLsP/rN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339631E633C;
	Wed,  2 Jul 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480096; cv=none; b=CQHkIuB99qeuWajXcbtBJrhpwyzUbS90WbSIS0faohn91LBHZ03GeXTCOnOZ3CS1wa9ZuSZm65C+ORflE4eELgSMiG3EwfCYL2PItH3apYcXzCiu6EbM1Wc4y54UNj71Me8et9OjnhlFG2zwxWkVrjQMGY/fSejxE39Le9W8TSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480096; c=relaxed/simple;
	bh=aEiPO/cxeypXRIURl8t6r0/e9j3L/gK0ZbqvbYvUaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCsohP01pMpuoYG+tRNrGgkIUg7DjA9lkZSsIz9/jzowiRSw6R+VmFMm2D19iuELvIqbaEtLgGIQgVjDTVwm8EPvv/G0NUsVOpnBREF9aFaq8mN5LTAE9SjblAlXdRItCo5dHZ8a9ZRCMNAQzl/VLz3Q97ZhBku3uSgn7W8BJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLLsP/rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F0AC4CEE7;
	Wed,  2 Jul 2025 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480095;
	bh=aEiPO/cxeypXRIURl8t6r0/e9j3L/gK0ZbqvbYvUaTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLLsP/rNSBBbL+ERANnJahudrVuvXtbW9LBrbQ5+lnBb1mIVS3uNNUWWydfTyNg6z
	 tLLepti49d1WDSmSpzM8XrMGavlV60ljRMZrtv8L0j0mZtgQLkFqEvLAX7R0FWEKkx
	 AS7lUuJSJH0ZWzHEJglicMM0HVPTSuC+frHrYUPqs3UryGnIF2fqaRMQM3rOjZRvBu
	 h8nGTh+3bYcajGLqPvax/QnO5dsAgTZLtbOp2wlxnpCQmpKNK17bZmim8kSzWJPLr8
	 NhR2miX6yMTvDtSKCVRDZOO0HW/maEYtQc10NgmZ0dQMaNAP5DLG1fJIttcIpLIcBV
	 wypK4R9ZgsrkQ==
Date: Wed, 2 Jul 2025 11:14:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 15/16] fuse: hook into iomap for invalidating and
 checking partial uptodateness
Message-ID: <20250702181455.GJ10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-16-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-16-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:34PM -0700, Joanne Koong wrote:
> Hook into iomap_invalidate_folio() so that if the entire folio is being
> invalidated during truncation, the dirty state is cleared and the folio
> doesn't get written back. As well the folio's corresponding ifs struct
> will get freed.
> 
> Hook into iomap_is_partially_uptodate() since iomap tracks uptodateness
> granularly when it does buffered writes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Seems reasonable
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 35ecc03c0c48..865d04b8ef31 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3109,6 +3109,8 @@ static const struct address_space_operations fuse_file_aops  = {
>  	.launder_folio	= fuse_launder_folio,
>  	.dirty_folio	= iomap_dirty_folio,
>  	.release_folio	= iomap_release_folio,
> +	.invalidate_folio = iomap_invalidate_folio,
> +	.is_partially_uptodate = iomap_is_partially_uptodate,
>  	.migrate_folio	= filemap_migrate_folio,
>  	.bmap		= fuse_bmap,
>  	.direct_IO	= fuse_direct_IO,
> -- 
> 2.47.1
> 
> 

