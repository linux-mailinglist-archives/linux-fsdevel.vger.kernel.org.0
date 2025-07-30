Return-Path: <linux-fsdevel+bounces-56363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF334B168F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 00:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD72566B83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5F226888;
	Wed, 30 Jul 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FX6EG+Iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6C1DE8A8;
	Wed, 30 Jul 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914099; cv=none; b=QxIMV08j7pPY0yhE5jDiKpA9KO8qZeN0DYkfrvynwX/HqQ3W6g71BLf0u3DxUOkdaZsS1LC+wY+xybvKVUJh/JAv19gmM7ysc8O9oAnsVR6cvWkc9umx54om9Swq2vIQHBG+vxqOr0z7RcsKa9RftAP1w32Mm0XCn8XfdAyHE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914099; c=relaxed/simple;
	bh=gPV/fgmzSN1XFnlZAHxb9pvfXXEMpz0osDLD/6DJ3W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH35BBjglY1nVmGj25mYJ9jOktbo+7CvVS7bnEAxCCKzkz70TgWcZjDwYwOdfTeHy1I7ecqaIkbZxHvRWr6uE2wBCdD7alUQJcNxZYOl0gn2kilvXq9xIrQW81eZmcgK2JPqKB0hXKi60KEDt9H+9EsbTIE7lFbz4jm/Sj+B5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FX6EG+Iy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9D97C14C2D3;
	Thu, 31 Jul 2025 00:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1753914096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6JhiF7KoKNgSPD3zCt9p8g2uKhJH9FPFoUMsjdvKB4=;
	b=FX6EG+IyhJiM2RBZ/KS+3Jz+TsegqLOZXiLNApe+3/CuS68KAz+BdeCjNcQIOioo3eDx0h
	46POYyy2gWBw30aDw88dEg4Y25ArxKMDI+rO6olMTmAKLcgzvAgFrRPAbaFfpX8MQRriA1
	zrURvN5QcfKNJtCavzEOqtcdYf8Uv69A2yB/AF2UeODOEBBU0NdAsK1QctGqb/4owV/fQh
	OROGCfSJGmTli7Jrt6uk7TDV3EQDtuUPcHcG+0Dvb0WfxCnZYQ6il9e27p6oZH9Bk7Dsrh
	8WHB6QD/IS7ifZnIrbamYVs7y0/t7hZEh4YLuw5x+eSjWdy9FcPl7z0tyRuBfw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ad4612f5;
	Wed, 30 Jul 2025 22:21:32 +0000 (UTC)
Date: Thu, 31 Jul 2025 07:21:17 +0900
From: asmadeus@codewreck.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, dhowells@redhat.com
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Message-ID: <aIqa3cdv3whfNhfP@codewreck.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730192511.2161333-1-sandeen@redhat.com>

Hi Eric,

Eric Sandeen wrote on Wed, Jul 30, 2025 at 02:18:51PM -0500:
> This is an updated attempt to convert 9p to the new mount API. 9p is
> one of the last conversions needed, possibly because it is one of the
> trickier ones!

Thanks for this work!

I think the main contention point here is that we're moving some opaque
logic that was in each transport into the common code, so e.g. an out of
tree transport can no longer have its own options (not that I'm aware of
such a transport existing anyway, so we probably don't have to worry
about this)

OTOH this is also a blessing because 9p used to silently ignore unknown
options, and will now properly refuse them (although it'd still silently
ignore e.g. rdma options being set for a virtio mount -- I guess there's
little harm in that as long as typos are caught?)

So I think I'm fine with the approach.

> I was able to test this to some degree, but I am not sure how to test
> all transports; there may well be bugs here. It would be great to get
> some feedback on whether this approach seems reasonable, and of course
> any further review or testing would be most welcome.

I still want to de-dust my test setup with rdma over siw for lack of
supported hardware, so I'll try to give it a try, but don't necessarily
wait for me as I don't know when that'll be..

-- 
Dominique Martinet | Asmadeus

