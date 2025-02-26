Return-Path: <linux-fsdevel+bounces-42715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25404A4692F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 19:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882B87A9D5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E4237708;
	Wed, 26 Feb 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktiNMmR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79E2376F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593436; cv=none; b=lwm3RSSSmlfuN4PuPinp5NEjotXkA/ne0VklwD7G3TCx/OkzlmAC1AvoCfjcre1ozCddC6xeS7ouUD9i9dvB86FzktFMcIdeEiGcRQ5PoiGwptUyKxRXC0wt137zwTzxpJV6GgqNShpnTCoNYflxq+xI0oho6XZWMvOuZIH0kPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593436; c=relaxed/simple;
	bh=37fYJIQTP5e3CcAaxYU/HzEKIg1LugAnS4BEQL9aV1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5Ohz3XVH5L62ulSUvva9vEveHXlCg6sWt5OEC3WavMOaFEc8FFaslxzDwURo5kvZG/2pvBo6HP3OkpBl0NIRW5udUvfJ1UsJoM1fiGFaDpGNV1ATnxTwyHS50WX/ZRzJazHOVD6JQiYY2Y2rD/qsWycKA8hq5CfxwLb1NTeB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktiNMmR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7749BC4CEEC;
	Wed, 26 Feb 2025 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740593433;
	bh=37fYJIQTP5e3CcAaxYU/HzEKIg1LugAnS4BEQL9aV1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktiNMmR6TwgWRr6ruGuLd2CutJCNpD7fRMYwWIwftmCQoY94nDtiqntKvnGAXqbya
	 1qMhQj/Bb1SpCE5DYZofu6TOhn6d9SVJfpgGZPlNx0yRtLuUD6I0H5LgPciPXp6LLU
	 aZ+Ttda19vU2O2eAqd9IFY6J7givy/+taZ2JuLtOhtJZFZFkmSHlmV2rNQy3NWeeLH
	 n+I6z0UnbTcF5FsySgImpaLe7MLKhW0i1fVyE+zP+3biE8H/BIQSqOC/Tj+FW/BdOO
	 MdkCSlte3za5+XWMEHUsg62DrruRdUk0sLNEFusMacGlNzJEGARQbXuJkBQOrp3frJ
	 koFMyEVL43D2A==
Date: Wed, 26 Feb 2025 10:10:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] make sure IOMAP_F_BOUNDARY does not merge with next IO
Message-ID: <20250226181032.GB6225@frogsfrogsfrogs>
References: <hgvgztw7ip3purcsaxxozt3qmxskgzadifahxxaj3nzilqqzcz@3h7bcaeoy6gl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hgvgztw7ip3purcsaxxozt3qmxskgzadifahxxaj3nzilqqzcz@3h7bcaeoy6gl>

On Wed, Feb 26, 2025 at 11:51:19AM -0500, Goldwyn Rodrigues wrote:
> If the current ioend is built for iomap with flags set to
> IOMAP_F_BOUNDARY and the next iomap does not have IOMAP_F_BOUNDARY set,
> IOMAP_F_BOUNDARY will not be respected because the iomap structure has
> been overwritten during the map_blocks call for the next iomap. Fix this
> by checking both iomap.flags and ioend->io_flags for IOMAP_F_BOUNDARY.

Why is it necessary to avoid merging with an IOMAP_F_BOUNDARY ioend if
this new mapping isn't IOMAP_F_BOUNDARY?  If the filesystem needs that,
it can set BOUNDARY on both mappings, right?

--D

> Fixes: 64c58d7c9934 ("iomap: add a merge boundary flag")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d303e6c8900c..0e2d24581bd3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1739,7 +1739,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  
>  static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
>  {
> -	if (wpc->iomap.offset == pos && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> +	if (wpc->iomap.offset == pos &&
> +	    ((wpc->iomap.flags | wpc->ioend->io_flags) & IOMAP_F_BOUNDARY))
>  		return false;
>  	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
>  	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
> 
> -- 
> Goldwyn
> 

