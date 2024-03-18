Return-Path: <linux-fsdevel+bounces-14717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049F87E501
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91419B215E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADBC28DC8;
	Mon, 18 Mar 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB0QabqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D728DA5;
	Mon, 18 Mar 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750821; cv=none; b=QZIRFND+6HV7q4pPCowZ/MDP2Z1yyh1DHgbd380s7nbvKWO0QckDoHlrSHjxj+Hp/dO2cjIoDYc2lYdi6wOzQBW4DmkDFNI4PB4wt5klth9oDY+7GRM/u35N5oVLnnaLbcy10ZJU6vzi1A56Xonog3mCryZ5nWgMWtHeUCVnIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750821; c=relaxed/simple;
	bh=SbMAD9hclS7MZ4xz6LIJyGsFZIeKU1ChXipgW5RrNPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIsMkf58R3sZwGPb/5wsAU0GzebM7gXvpTXCAT5XKse2HOraKmfi6iCEDJWM93JUjvohTIWfmvi/tvSpqhwA70xz87Xf0q5gJ3epUVctY1bgdKXLMfzP8ALQY/ZyZpVjGLRcXxOlyf1hET04hiFw14EzDVAfi8Z38tkMeVzSnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB0QabqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C233AC433C7;
	Mon, 18 Mar 2024 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710750820;
	bh=SbMAD9hclS7MZ4xz6LIJyGsFZIeKU1ChXipgW5RrNPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gB0QabqU2SmgnpTReDDuanCy7H+rVHXPDj/tQMNWrBvav9yhNXNHzewu/jxoZ34hL
	 U3dSNHoTCSBUazjBaT+KTKYFEpgoT3tgk1+P8zNMvgXbsvc2GJbFp/pskitO9Bu007
	 Uf3bOD6E9WRbiy6Ma/XJ2AmiBsFuUM2iiR2EXCf8QaabWgqHfV1FA8fBKctuzdgRKb
	 ulhXnl/EUVgoL3uFGkQ3hf1SHk+JEEgyV6mMNm9OgEO8n+NewVHy38E01kYVICRo0r
	 /tTxdZEuiDZwHWy70oLiSxqcscMEiuXkZchThRMgAapp4pVShlXYpeGDSKOqH4nm8/
	 ejv41k7sMcO2A==
Date: Mon, 18 Mar 2024 09:33:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs,block: get holder during claim
Message-ID: <20240318-begierde-ehedrama-a3b57393e496@brauner>
References: <20240314165814.tne3leyfmb4sqk2t@quack3>
 <20240315-freibad-annehmbar-ca68c375af91@brauner>
 <ZfdYX3-_53txEYTa@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfdYX3-_53txEYTa@infradead.org>

On Sun, Mar 17, 2024 at 01:53:51PM -0700, Christoph Hellwig wrote:
> On Fri, Mar 15, 2024 at 02:23:07PM +0100, Christian Brauner wrote:
> > Now that we open block devices as files we need to deal with the
> > realities that closing is a deferred operation. An operation on the
> > block device such as e.g., freeze, thaw, or removal that runs
> > concurrently with umount, tries to acquire a stable reference on the
> > holder. The holder might already be gone though. Make that reliable by
> > grabbing a passive reference to the holder during bdev_open() and
> > releasing it during bdev_release().
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> does bcachefs also need a fix for it's holder ops?  Or does it get to
> keep the pieces as it has it's own NULL holder_ops and obviously doens't
> care about getting any of this right?

It has empty holder ops and so is behaving equivalent too having NULL
holder ops. IOW, the block layer cannot access the holder.

