Return-Path: <linux-fsdevel+bounces-16666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA418A12B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 977AFB24AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6A148307;
	Thu, 11 Apr 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKOO/H+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B91474C9;
	Thu, 11 Apr 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833978; cv=none; b=D3xMFYYLEaGgbaIWuPfPVweITJ2h8grP997KI903tyN94pjMFTj/LbEMocoRstdOYdwcvI10EQ/75X20fhXIT94cocAo9biHDECoP2chzaEr1c29KxkZcJTrh9By/5MJ5sOjtPV/0330FJROssdLRBjjMvoPhP4pemC/igdgVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833978; c=relaxed/simple;
	bh=bbEKjy+eSYUjL9yRB7zTbDHe8ycq4RK3pkzGPtkRb0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhJJ4h16vPEHrZCUU50mo8eSECVtFoDswJP44jm1wOdiJoAd9yKC4EIsc5hNzw9dZwge+MvVf6qeyVJ5d0I+5vlKQrjjMF5uAbfyapLN29wY5D4XM43OO99OoU+8Nq8jGji0TMLZBhkN5nnd29xjLqLMAozv9gt3TMC38gWZ2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKOO/H+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EF4C43399;
	Thu, 11 Apr 2024 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833977;
	bh=bbEKjy+eSYUjL9yRB7zTbDHe8ycq4RK3pkzGPtkRb0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKOO/H+rXXxAnPdoIb9WMdIQOAqjOfwzm0oBY0anLEYIa2l46BFS5STObdd2UPOcM
	 WU9fptb5n9M1AslEXQLcGFtNu680YB6/xkCjrYZXp/AlnfCObZTVi+rSF/VXGv2FBm
	 l45buWGmeRbVZ3yoLrQz03ojHlAng+bTC8nWkv9P5PaeK3IhCUj7HXwDhw+kKn609y
	 ZNl6HnUfPnvtt+caFcBuUEqzgxXyF07kox0gfNZooFQOP2+ByeBWmRodvRMhBvoePX
	 Mhz4oS9F1ZuD/0yTJm1Iy4w6ukGX3OkheQ5tvm+OM9g1WTOru4XS8SzXKSDtYzNYzm
	 F91z1+/RsMicg==
Date: Thu, 11 Apr 2024 13:12:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Sakai <msakai@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	jack@suse.cz, hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com, 
	dm-devel@lists.linux.dev
Subject: Re: [PATCH vfs.all 19/26] dm-vdo: convert to use bdev_file
Message-ID: <20240411-abwinken-gesehen-a8f038f147aa@brauner>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-20-yukuai1@huaweicloud.com>
 <a8493592-2a9b-ac14-f914-c747aa4455f3@redhat.com>
 <20240410174022.GF2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410174022.GF2118490@ZenIV>

On Wed, Apr 10, 2024 at 06:40:22PM +0100, Al Viro wrote:
> On Wed, Apr 10, 2024 at 01:26:47PM -0400, Matthew Sakai wrote:
> 
> > > 'dm_dev->bdev_file', it's ok to get inode from the file.
> 
> It can be done much easier, though -
> 
> [PATCH] dm-vdo: use bdev_nr_bytes(bdev) instead of i_size_read(bdev->bd_inode)
> 
> going to be faster, actually - shift is cheaper than dereference...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

I've used that patch instead of the original one.

