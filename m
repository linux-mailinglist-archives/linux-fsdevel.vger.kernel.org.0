Return-Path: <linux-fsdevel+bounces-53570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C0AF0320
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F9E16C3DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555F245029;
	Tue,  1 Jul 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USwTPFVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45E3596B;
	Tue,  1 Jul 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395659; cv=none; b=Td3OsFt79ViF/VpcA1QcODXMDwaL1HkD6bMibmRgUimeVULpwFuw4ReEBUVv0cGzvp+QBpUMcOdcNS1rgErJGJDCi5oD2KTVhx/1Tb76yRcds50ikuqYyQroyGAl2nkuuN9PXrleh8qWTkbMc0bxUyoLSb6BGB2/A0hjCpD69Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395659; c=relaxed/simple;
	bh=JkTTkr7necSommWO+02eTXNXA+2BqYihS2B9P96yej4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNwxvb+uxLb4ry3bXUC0X6w0qscwGcreSW4U/cpcd3Ocw1Jd4cmumf7jaKdeZOVd+3dk4ju5qjLyug4/gAfjiz8jA+7DSa21kco1ynu2lUa2GZJksMUlDtMztLcGin1FmcaUWHNGkgD5EnS03mH0s68hyKiyJvF8Xl77aDj1L90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USwTPFVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E73AC4CEEB;
	Tue,  1 Jul 2025 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751395658;
	bh=JkTTkr7necSommWO+02eTXNXA+2BqYihS2B9P96yej4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USwTPFVA83klNEMTYfQHugsomxqIFBazWYYW6VXoMlsr4Kp1xroTJgkR6KHRm7CST
	 3mp462/Fq/qPxMVuvILSLvkyOdCZVMqOrEQo7QUAXpPunYIUUwvPqIuCDH0Spywcar
	 WrnnafQ7qUz35il5zvYSypT8S6xekZcckMwXDTNjISTUVqHjSxsjZ175r06XUvbTdi
	 sf4IaSMNwJ/1nW2KHQCVZ3LTHLzafn9rUVLNs9r694DA6QUW5otmSHy8fGlVUlSMo2
	 JV8ab8U21R2/tFFU4bfWdyWj1wIS5ndcJL7CU7wxvncHKBHkB4JN0Qcatnm4hMJNi9
	 OP1herZ0ZwSOg==
Date: Tue, 1 Jul 2025 11:47:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with
 locks
Message-ID: <20250701184737.GA9991@frogsfrogsfrogs>
References: <20250701144847.12752-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701144847.12752-1-alexjlzheng@tencent.com>

On Tue, Jul 01, 2025 at 10:48:47PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> In the buffer write path, iomap_set_range_uptodate() is called every
> time iomap_end_write() is called. But if folio_test_uptodate() holds, we
> know that all blocks in this folio are already in the uptodate state, so
> there is no need to go deep into the critical section of state_lock to
> execute bitmap_set().
> 
> Although state_lock may not have significant lock contention due to
> folio lock, this patch at least reduces the number of instructions.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..fb4519158f3a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -71,6 +71,9 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  	unsigned long flags;
>  	bool uptodate = true;
>  
> +	if (folio_test_uptodate(folio))
> +		return;

Looks fine, but how exhaustively have you tested this with heavy IO
workloads?  I /think/ it's the case that folios always creep towards
ifs_is_fully_uptodate() == true state and once they've gotten there
never go back.  But folio state bugs are tricky to detect once they've
crept in.

--D

> +
>  	if (ifs) {
>  		spin_lock_irqsave(&ifs->state_lock, flags);
>  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> -- 
> 2.49.0
> 
> 

