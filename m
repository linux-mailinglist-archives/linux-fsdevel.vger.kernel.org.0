Return-Path: <linux-fsdevel+bounces-47043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936A2A97F78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CA43B01D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC1267386;
	Wed, 23 Apr 2025 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="if8vr4by"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E291DE4E7;
	Wed, 23 Apr 2025 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390654; cv=none; b=S0TLBuDZnausww49qKHpYGcCBKOiFn7HVKYB77uxv9Ury1osWGoOLYnppaOQ8SwsULIzuwgJpM3kB6Z4FylBgI09jWzkoyWOUzy9Ft4nPvnJ/XeiEEZohBX6VB1i9PNa0YZaK5FZcOkAbGd3i8gGLUV0tClT1zKKUFtXT0skmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390654; c=relaxed/simple;
	bh=hVr+kzlWM1wv3ltRKREclGCTdxcfVyiM/oXyQRdSxNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXImc2J1LYW9bIfcHw+mSk0b2xhMwOjFUX08Z8DhVNHSQ8kN+WgAEjIxHVX66i06W+AHBttg4+IxcAkK4skSiuFl1oXEYd/OmaJqnCq53iIa1QlkU69xOVcFEAJwF6FcoOjA1cbzaxEb+4w7LpalEfSOGmae98D+qO2idZhuwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=if8vr4by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00394C4CEE2;
	Wed, 23 Apr 2025 06:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745390653;
	bh=hVr+kzlWM1wv3ltRKREclGCTdxcfVyiM/oXyQRdSxNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if8vr4by9ZC34ztN3mi8nTIUVpLfBt3tEvfxBGdDHlvjMqIgEZpnGaxtd48kpx7nh
	 +i7+tN48uZzcj4NhVAbxhDp244mTSNC87N1NuR+U27A7TngkhOPj8eB9a5GyIWe6ol
	 iLdHsBI7w6kIQ6QiOTToIjDKe7cna4Nhn4EVv0fw=
Date: Wed, 23 Apr 2025 08:42:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hca@linux.ibm.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <2025042305-timid-unusable-0501@gregkh>
References: <20250423045941.1667425-1-hch@lst.de>
 <20250423-wettkampf-zahnlos-87fa8f273df7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-wettkampf-zahnlos-87fa8f273df7@brauner>

On Wed, Apr 23, 2025 at 07:54:51AM +0200, Christian Brauner wrote:
> On Wed, Apr 23, 2025 at 06:59:41AM +0200, Christoph Hellwig wrote:
> > The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
> > helper caused it being used by devtmpfs, which leads to deadlocks in
> > md teardown due to the block device lookup and put interfering with the
> > unusual lifetime rules in md.
> > 
> > But as handle_remove only works on inodes created and owned by devtmpfs
> > itself there is no need to use vfs_getattr_nosec vs simply reading the
> > mode from the inode directly.  Switch to that to avoid the bdev lookup
> > or any other unintentional side effect.
> > 
> > Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Reported-by: Xiao Ni <xni@redhat.com>
> > Fixes: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Tested-by: Xiao Ni <xni@redhat.com>
> > ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Do you want me to take this through the driver-core tree, or is this a
fs-specific thing as that's where the regression showed up from?  Either
is fine with me.

thanks,

greg k-h

