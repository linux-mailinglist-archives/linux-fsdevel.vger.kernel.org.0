Return-Path: <linux-fsdevel+bounces-66585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2FC250DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B9AE4E6230
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246E4346FD5;
	Fri, 31 Oct 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhnYEr3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861033DEDC;
	Fri, 31 Oct 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914424; cv=none; b=gOEG+U6qpHjDk5IH89K2gcpwvBUQwcv183MWo84kW+keT+dyRqkYFNR+G4Y+6iCPjl/XYN8Uoobn24S/whmGN2dz2S7o3ZQ66+YSXaH1PSoY/6q6ssmA9hG3Enf6yDNbF0doQNVRY6gcfdBxCsmdzLuNXVsv3sIXJu0+fD0NYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914424; c=relaxed/simple;
	bh=TOyX+7MqV/0YgmsMT9EYGXpJ0gAINF6nVC++khICWC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdpcygJH/x/XRPoD6S6sO3Q3D+HbCvEce97ZoDM4W1N/UGzKcdSjEJEYEdGawqRUH+SI4G3nKd1caUMOVmNIwKFBZtoud3ButFoQYofKI375CpT1L5TS94Oj02nGwerYpDC770QftPOyiBLrUz1PDr5En4Xcd6ntZJZSDfxsQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhnYEr3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EAFC4CEF8;
	Fri, 31 Oct 2025 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761914424;
	bh=TOyX+7MqV/0YgmsMT9EYGXpJ0gAINF6nVC++khICWC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhnYEr3U5JIUE/hWiy5w1R76XbDn+yH35KUz15ECPn3pBmZ8QnliZMK/TxQCFITaQ
	 R5R8pY27R9Mo5WkZJyRJlqqQS5JtcS4sER2m7whvS38KdkJvrFINsJfqeBh9Bzap/l
	 MU3I2bi1LkyM29IrZaGmcufQgVL3OgIhNrED36rIu9T7vC9/9/4njflhyoQvZ8N9oK
	 hRZJQiIHwblXbkcB+k6Ptnpu1s2ffwgE/SeI11pYMpQPt82QqraQqEMofg0B73Y0Zc
	 Zv1zkXtva2QyTSF5NzoRA9diimBVTLS9pjImmM1eXc/+8pOosm+gMgfYRzVQsYggD9
	 CLL/dM7mY1VUg==
Date: Fri, 31 Oct 2025 13:40:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Qu Wenruo <wqu@suse.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <20251031-medikament-bunker-993b02d1beed@brauner>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-2-hch@lst.de>
 <20251027161027.GS3356773@frogsfrogsfrogs>
 <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com>
 <20251029074450.GB30412@lst.de>
 <d5d33754-ecd3-43f0-a917-909cd1c2ab3e@suse.com>
 <20251029081516.GA31592@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029081516.GA31592@lst.de>

On Wed, Oct 29, 2025 at 09:15:16AM +0100, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 06:30:47PM +1030, Qu Wenruo wrote:
> > Patch 2 and 3 look good to me. Thank for catching the missing pos/length 
> > checks.
> >
> > If you like you can even fold the fixes into this one.
> 
> That would be best.  I just want to hear from Christian if he's fine
> with rebasing, as he said he already applied your original patch.
> Although it still hasn't shown up in the tree anyway.

Yeah, it's prior to -rc4. I'm usually fine with that and no one's really
came and said that they need this thing stable.

