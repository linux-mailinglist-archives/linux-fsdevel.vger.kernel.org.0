Return-Path: <linux-fsdevel+bounces-53748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C591CAF66C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0514A864F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610361FCE;
	Thu,  3 Jul 2025 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hIEWK/+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195022F43
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751502214; cv=none; b=cw0ZofnMNQGjDPc8gMaBEpfAIa+tgBGlYiheDInOfMmSG9WcJK1LUPAwNxujddt8tyioj3/wFD/C5wmh4TUTfSvKLMDnoJeHcRBlfc+z8CqP59izRHRl0qIrSPxcETqsqbt8WLhKOd6Dv3DJVR1Obtr6PJOg2ajFmzJ4a6obkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751502214; c=relaxed/simple;
	bh=6LMbYIIgeZUq1orWC5fVrBqD/Ek2PAvnqd0knbfh7XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmF8VJoCJ3m5S5qRyy0dJvujsVaiZXPHHMvbMU7Ht/JNO19HqAN2z5OgePHCj3UoRo2b7OzK2y7zHLB+r3pjCJfcFidOnAi4rvmkREYcgPic6KR9g3nFH0seDZRoRwi0o3TZE2Z3uo1rcbG4XFznyRtrpgqUumPVJpBqSw95koo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hIEWK/+q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UE4IuECEi/dNUyNkAelmVq4GoVMmkCTkbXavgIxugZY=; b=hIEWK/+qaY/gaEqVxuBP6PWJse
	clAunf2na3M2xH/IOanJzhSVXpfE6iRUa4UHDXJyDISe2t7wG7AWVHJ2lDYVjMVGElVv+Ej0X9Z1b
	FDwM25TeumuNVQvS24SK2QM/gfAXGwYzxED+ciXcavRko+kNTS+32XWtOA6NuP4tmwDa5JHeMl42a
	SO1nOkC0JP78bTrnUqojUdd0f5UqTnH71o6OQUQv/0q8P4Gl0aXcFbvmfSpwXM4eObZToNdadG2Cy
	l4V90bExKJU0AfseA/P9npO7a6nlb8EElDYidHRJxNO9EvzpyivqgPKZVkcoDm913iE88WPwFzVqQ
	svTSeYNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX7jd-0000000Fbrb-0iSG;
	Thu, 03 Jul 2025 00:23:29 +0000
Date: Thu, 3 Jul 2025 01:23:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH 01/11] zynqmp: don't bother with
 debugfs_file_{get,put}() in proxied fops
Message-ID: <20250703002329.GF1880847@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <175149835231.467027.7368105747282893229.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175149835231.467027.7368105747282893229.b4-ty@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 02, 2025 at 05:19:12PM -0600, Jens Axboe wrote:
> 
> On Wed, 02 Jul 2025 22:14:08 +0100, Al Viro wrote:
> > When debugfs file has been created by debugfs_create_file_unsafe(),
> > we do need the file_operations methods to use debugfs_file_{get,put}()
> > to prevent concurrent removal; for files created by debugfs_create_file()
> > that is done in the wrappers that call underlying methods, so there's
> > no point whatsoever duplicating that in the underlying methods themselves.
> > 
> > 
> > [...]
> 
> Applied, thanks!
> 
> [10/11] blk-mq-debugfs: use debugfs_get_aux()
>         commit: c25885fc939f29200cccb58ffdb920a91ec62647

Umm...  That sucker depends upon the previous commit - you'll
need to cast debugfs_get_aux() result to void * without that...

