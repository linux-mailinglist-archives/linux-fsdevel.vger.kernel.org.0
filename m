Return-Path: <linux-fsdevel+bounces-37841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9984F9F820D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7725A7A1D35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C8D1A3A94;
	Thu, 19 Dec 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrEcKwg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761981A08D1;
	Thu, 19 Dec 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629813; cv=none; b=CfKNRsv5y36KCaAsKRWZ6bFT8+803fRvK7HSp1Yec0CC3AEgrRZ8Tf6FL0kn/RiuquAtmpJ5PpgFeZBM0xnKYLw/Z4UMTV7MVTBvUTFX/9Okdy4xGJaV2T9c9Z6crudIJt+rLx9zPbtYNjzk3gXgd4HV1e8P8VGf05l/hIieUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629813; c=relaxed/simple;
	bh=TOyDvsev+ONo4BTDbrsIlNrNh+Fv5neVenJMClcDoEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHZqCKsL+EhA0aN84qCmR7sirS2F/SvQTC+0HlB5Ah6dfiGBbJ0BdfXuHu8RQ3/yg4+yJiEluhSp27hcjy5Ho7aZHq5CTPmdHGhKniWAkyvEZJGDS+wcT6dNGiJ3i15pdpOO7u/79zVltHao501TgSaiW9eI8S8nTMSXTVEUUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrEcKwg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD47C4CECE;
	Thu, 19 Dec 2024 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734629813;
	bh=TOyDvsev+ONo4BTDbrsIlNrNh+Fv5neVenJMClcDoEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrEcKwg/OlfdcjF8GB0OJhOqICZAZ5EQKucoaJhQCh6in66j0egF5VjMBXG364AsA
	 CRjqrU3zVvlZzBax0k3gfcRSO3DW5xlF2SLvVbzVO+6jfn4jtQUvDU5ZQtVQ79lOf3
	 9kAT5+8Koz4jM/HfPMIRWcKfVvGUCC3qF4DOThRNd0pgtDHXFk2hZokDXBkiUkB7a3
	 pihG1mYcBFlIZgjnic8sIhOtu1+mKrX+N6DMdj2uj9vKG/i7xFt+RTousoboOjr8hY
	 AGgfqYdJw078KNCUHapkW58xG0LstbTvcC0FlciRzoP0zlMifCgCyB79gvYGgdXw7s
	 lAJLM4n78i1Uw==
Date: Thu, 19 Dec 2024 09:36:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/8] iomap: add a IOMAP_F_ZONE_APPEND flag
Message-ID: <20241219173652.GM6174@frogsfrogsfrogs>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-4-hch@lst.de>
 <20241212180547.GG6678@frogsfrogsfrogs>
 <20241216045554.GA16580@lst.de>
 <20241219173030.GJ6174@frogsfrogsfrogs>
 <20241219173512.GA30295@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173512.GA30295@lst.de>

On Thu, Dec 19, 2024 at 06:35:12PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 19, 2024 at 09:30:30AM -0800, Darrick J. Wong wrote:
> > The iomap documentation has been helpful for the people working on
> > porting existing filesystems to iomap, because it provides a story for
> > "if you want to implement file operation X, this is how you'd do that in
> > iomap".  Seeing as we're coming up on -rc4 now, do you want to just send
> > your iomap patches and I'll go deal with the docs?
> 
> I've actually writtem (or rahter copy and pasted) the documentation
> already, that's what made me notice how duplicative it is.  But let
> me shoot out what I currently have.

Oh, ok.  I was planning to repost the rtrmap/reflink series shortly FYI.

--D

