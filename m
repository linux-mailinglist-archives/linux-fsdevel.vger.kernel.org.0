Return-Path: <linux-fsdevel+bounces-19209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A968C144A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 19:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9425CB22CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536D770E6;
	Thu,  9 May 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuAMFIQ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C32FBFD;
	Thu,  9 May 2024 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276814; cv=none; b=OD9Aa/AJzizQJ4Pn/562S++PxUGgzVx1Tv6ez4Z5ES9afrOXwB/qY86FutWDVUXH2Mj/9nUypxWRwHR7R9XbdXK6YOtQd5sR/X8JVzPgUQfdtPRGV24QDqxM/6C0tfR4zH+jN3aZk/SLzYCkj8qN3QPc1wnhsKJb2FAHPNv7esE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276814; c=relaxed/simple;
	bh=60olD59E1KrxpBeHp8XDeSOe0xnUAY99qj5zWDoqPSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=balty9e2EtFBYG5wqBuQCwzDfklmQvxDxSRAb7J0JJk9rKv2GB34yJeKA+ZSmp1pmazSwwxZeVGjB8QRPbyaAIc1scuwXvj+uk/DRh9lnNMoWwNiCbrvjKsICrRRKaYPLOeitvp0y+M6cJaDVgzXDvXyWwt43P4HpozO2dAKTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuAMFIQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED1EC116B1;
	Thu,  9 May 2024 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715276814;
	bh=60olD59E1KrxpBeHp8XDeSOe0xnUAY99qj5zWDoqPSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuAMFIQ+YzaqnvgBKjDqo8aJOLX+xtpufy8lF+7sY7Q7zcKOtoi3a624AKH4r3MaT
	 Glh/7eELP/HsWAg1gb0yggGhFyuiOapSprBPdX+24sauefGeXe+ziZSXoyTQhfw5nT
	 4MsHII0ler0LgPxyrSkRgNqq7n+/iZYIb5/51u2ECeDcYL8yi7ZEfoYIG0XRcCcv7r
	 WofoER4XNU4lzGUpHYI+w6qpicZ8Efd1sYHZpYD0JJSn2ttkzm5p0F37EZmjARo8C2
	 ItjRAtGTXoEbSXvaxHOJZsoiD/suE3mRac4BngZz7eTjux8ils2A217wTahkGrUgWP
	 MUlfTJPBYF6+w==
Date: Thu, 9 May 2024 10:46:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240509174652.GA2127@sol.localdomain>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508202603.GC360919@frogsfrogsfrogs>

On Wed, May 08, 2024 at 01:26:03PM -0700, Darrick J. Wong wrote:
> > If we did that would be yet another indicator that they aren't attrs
> > but something else.  But maybe I should stop banging that drum and
> > agree that everything is a nail if all you got is a hammer.. :)
> 
> Hammer?  All I've got is a big block of cheese. :P
> 
> FWIW the fsverity code seems to cut us off at U32_MAX bytes of merkle
> data so that's going to be the limit until they rev the ondisk format.
> 

Where does that happen?

- Eric

