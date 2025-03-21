Return-Path: <linux-fsdevel+bounces-44671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90154A6B3E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE763AA3F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343CC1E51FF;
	Fri, 21 Mar 2025 05:01:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5779EA;
	Fri, 21 Mar 2025 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533313; cv=none; b=p8mfCY0Q1UACxCbqg+kcehQjP2urEeBuiR/lN3CEkyhWFmZDbL6Bg6xaFFf2G9W+hMUgUaKnb2l2y2bZIExcpRvvZy3Z11ygcece3NzeIPuHQv9FBHU/Vq5hRS5moLGv62Mg7jr1TbZ23fwJDV1eDtIJZiv1iFloNGBtE06Oik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533313; c=relaxed/simple;
	bh=CkJQeBziRtnUexNuR+FLa3CnZuNSiTZIDvvQnmaBnk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngQI4FIONCymKojzPGPPFTxr/8FBw+XhVGgaDSSPLAVupW6xNjlM1JZ2J5dxxz355+ukQXYVqQnKtXoCQazQtTnPxXueRE5g8L9FbEqqMN/HCXFpnublCXYo7tbTecuY+XhfHSkC7J2mI0s3Xn2EqMPCpGgmclJ38Id68Oks6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 257A468AA6; Fri, 21 Mar 2025 06:01:47 +0100 (CET)
Date: Fri, 21 Mar 2025 06:01:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: julian.stecklina@cyberus-technology.de
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] initrd: resize /dev/ram as needed
Message-ID: <20250321050146.GD1831@lst.de>
References: <20250320-initrd-autoresize-v1-1-a9a5930205f8@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-initrd-autoresize-v1-1-a9a5930205f8@cyberus-technology.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 20, 2025 at 08:46:14PM +0100, Julian Stecklina via B4 Relay wrote:
> From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> 
> When the initrd doesn't fit into the RAM disk, we currently just die.
> This is unfortunate, because users have to manually configure the RAM
> disk size for no good reason. It also means that the kernel command
> line needs to be changed for different initrds, which is sometimes
> cumbersome.
> 
> Attempt resizing /dev/ram to fit the RAM disk size instead. This makes
> initrd images work a bit more like initramfs images in that they just
> work.
> 
> Of course, this only works, because we know that /dev/ram is a RAM
> disk and we can resize it freely. I'm not sure whether I've used the
> blockdev APIs here in a sane way. If not, please advise!

Just use an initramfs and avoid all these problems.


