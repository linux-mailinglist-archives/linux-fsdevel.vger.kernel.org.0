Return-Path: <linux-fsdevel+bounces-47035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120F7A97E66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4758C17E3D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB279266B4F;
	Wed, 23 Apr 2025 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuD1SsCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32396EAFA;
	Wed, 23 Apr 2025 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387696; cv=none; b=ortLxoKaWoNC3kuupjDj8U7G8ijkR9eNuBoz442g4D1MoiTgNlOGhtZydnFTLVbRkctHi2vcftiJRRWPtOxtpMwU0iaXMOHNQmQwck6JhGK2M76+QvTs+oZIDQ14c7kSB9LV2QNvqFpyM50M9lLXGgpBBZxvD3v3bfwWiE9x5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387696; c=relaxed/simple;
	bh=xPhC417MWB9QO8lMkuF+TY55PbF7VGvsp/C3ykM0GDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaJHqIwQG3nliA9WXgHRlRm9HBOi/jCJwhYQBTlMHK6tZ5jy6Y+nJbkOtFy7PrPeOgYwj6ftEGzzN3PlBlx/GKRTbr7XhZc44/U3GxKYveTVH8Oh7h6fx5gnYUzAyMIn4FCTmw2sYpwYby6rBUf9cXftbp354Ah3jNilH933CoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuD1SsCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE23BC4CEE2;
	Wed, 23 Apr 2025 05:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745387696;
	bh=xPhC417MWB9QO8lMkuF+TY55PbF7VGvsp/C3ykM0GDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuD1SsClSnhLWfOgZvtcumePEfQZAG28ea+3VP5d5g4ngXyOnPP+VJSzZvWCT2tDP
	 fkwEgV7H4/zGCQVcTjxwnQsuzrbaBMbgO33jnvG3Xtc2yIAZ73rDFwyLddkME21kN6
	 ajQWslvZZpyax374mrq8npuGHAhgy39MoK417Iz8mxY2Z/zg7Wv0yXrKH9YMojJnuP
	 E6tiVQWeKameX9M5LbjEMJOEAzdtBZTGqRF3t9NrgV1pTYp2nuqV+9kbbijzMAMTaV
	 pFQ+bpOtWGYWWPS52iyKUjMliztroB3NPKD0y2ybLcDBRMFwEWNynEMrusXiV8rQi4
	 ki+hiV2tOdzew==
Date: Wed, 23 Apr 2025 07:54:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hca@linux.ibm.com, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250423-wettkampf-zahnlos-87fa8f273df7@brauner>
References: <20250423045941.1667425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423045941.1667425-1-hch@lst.de>

On Wed, Apr 23, 2025 at 06:59:41AM +0200, Christoph Hellwig wrote:
> The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
> helper caused it being used by devtmpfs, which leads to deadlocks in
> md teardown due to the block device lookup and put interfering with the
> unusual lifetime rules in md.
> 
> But as handle_remove only works on inodes created and owned by devtmpfs
> itself there is no need to use vfs_getattr_nosec vs simply reading the
> mode from the inode directly.  Switch to that to avoid the bdev lookup
> or any other unintentional side effect.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Reported-by: Xiao Ni <xni@redhat.com>
> Fixes: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Xiao Ni <xni@redhat.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

