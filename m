Return-Path: <linux-fsdevel+bounces-51508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F9AD774B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6CE57A8DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5A29A307;
	Thu, 12 Jun 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdiMO4Kl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22495299A8C;
	Thu, 12 Jun 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744037; cv=none; b=DU7dVxbZFfifM16mYSn4/9SX/jHi68ar7mih8pndvQawfs5TII1Pqwr+C710PqdLv1huWXcXxW7DOLwrLm7Ain6dTDJwuCgwc2k08sHH9a0ydy/MmZMjUE5AHjcRdw/VMbMVPmEkq4HDVQT/VGnYnRzFUGTCTe7rHpCOMIGtn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744037; c=relaxed/simple;
	bh=UMU27gYvQHH7PdtL/YFF/bFpvSv8erPUowtR9GgFuOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3zjmccneN9llX1RZyZtGftxZxQqyd+PJ4GAinEislTOSSq+CPZ87RP2BrdCeaC7dKbnSy45ABZumMrl5107+b8JHuT8vMrVfXEbkINXzLtHneYHC5eteYQGSmYDlZ7RMaVaYHQvNEw4X4c5EjuwxqI3gf68jQ3hFhRomd/O3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdiMO4Kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F5FC4CEEA;
	Thu, 12 Jun 2025 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749744036;
	bh=UMU27gYvQHH7PdtL/YFF/bFpvSv8erPUowtR9GgFuOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdiMO4Kloz2c4Oqq/t3PA/2eEXwBg317rFZ3frSPfdAzNiJJJxRqbk24P69Zi21Ry
	 B/bDjBD4AbhEmm8zKFW/pBu4vnNLoieOT1purQb9DEw9L0DJBZVb23+ZxVW9A340lX
	 ZdlDvsokXI79/BXau9v9KW1S8vbDECmLGccCOiHdGZCMChocVoj8BXLiTBW/tZfOGG
	 jgzfPo6B8kQxeZzPvHwM5Dh9s0z+BriMMqa7tCsF8JT+0eAQGNsdm8Q7hHQdpCRXpz
	 h2LUz4pfwBKCl6HN+X9buwAV4gpgmsi4BPZ5n7bT2V5/MTe8tWNH4lX47TbO13/6DS
	 ILKagfZmDVYFw==
Date: Thu, 12 Jun 2025 12:00:35 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aEr5ozy-UnHT90R9@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>

On Thu, Jun 12, 2025 at 09:21:35AM -0400, Chuck Lever wrote:
> On 6/11/25 3:18 PM, Mike Snitzer wrote:
> > On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
> >> On 6/10/25 4:57 PM, Mike Snitzer wrote:
> >>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> >>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
> >>> or will be removed from the page cache upon completion (DONTCACHE).
> >>
> >> I thought we were going to do two switches: One for reads and one for
> >> writes? I could be misremembering.
> > 
> > We did discuss the possibility of doing that.  Still can-do if that's
> > what you'd prefer.
> 
> For our experimental interface, I think having read and write enablement
> as separate settings is wise, so please do that.
> 
> One quibble, though: The name "enable_dontcache" might be directly
> meaningful to you, but I think others might find "enable_dont" to be
> oxymoronic. And, it ties the setting to a specific kernel technology:
> RWF_DONTCACHE.
> 
> So: Can we call these settings "io_cache_read" and "io_cache_write" ?
> 
> They could each carry multiple settings:
> 
> 0: Use page cache
> 1: Use RWF_DONTCACHE
> 2: Use O_DIRECT
> 
> You can choose to implement any or all of the above three mechanisms.

I like it, will do for v2. But will have O_DIRECT=1 and RWF_DONTCACHE=2.

Thanks,
Mike

