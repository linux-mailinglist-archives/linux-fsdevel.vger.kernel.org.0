Return-Path: <linux-fsdevel+bounces-55239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644CB08B83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2785E7BF450
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126F229A30E;
	Thu, 17 Jul 2025 11:04:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238C219EB;
	Thu, 17 Jul 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750261; cv=none; b=R6QUyHuUoWTosItMArOCj3FOdAOIsQWCoVpBAhPbhoWBtdGOMDpOVy1oGF9I73PhTROQeO5JW5IiiH0xL7BxlJJH3X6TXzRMZpOp+OM2Be/kN4YlVF/42m8cCBH0nD3j0rg9YuldU1M1Tpd1zedGa3lpvVQNggReELdHapcc0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750261; c=relaxed/simple;
	bh=nUdIsbpB6mBlCiqopSxvUVM4CFHErnmJYCADY8mV6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHaSUbhmmMXerIxUrCGZPEazrgJnrV86JMZ9eiAKkl62+sPwjdoi7KlAQG40XcG9XY/1K9fco1gjNJx/mKjZv1FSRJ85Hvhl00e3CkGTIyAq/658NLV7ZMSNvBDCT7F6XNvmURqrzR7KpiVFew2zRKsxWvfHWdDJZ433jIhYPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 340E0227A87; Thu, 17 Jul 2025 13:04:10 +0200 (CEST)
Date: Thu, 17 Jul 2025 13:04:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Zizhi Wo <wozizhi@huawei.com>, hch@lst.de, jack@suse.com,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [bug report] A filesystem abnormal mount issue
Message-ID: <20250717110410.GA15870@lst.de>
References: <20250717091150.2156842-1-wozizhi@huawei.com> <20250717-friseur-aufrollen-60e89dbd9c89@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-friseur-aufrollen-60e89dbd9c89@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 17, 2025 at 11:39:01AM +0200, Christian Brauner wrote:
> As long as you use the new mount api you should pass
> FSCONFIG_CMD_CREATE_EXCL which will refuse to mount if a superblock for
> the device already exists. IOW, it ensure that you cannot silently reuse
> a superblock.
> 
> Other than that I think a blkdev_get_no_open(dev, false) after
> lookup_bdev() should sort the issue out. Christoph?

Or just check for GD_DEAD before the mount proceeds?

