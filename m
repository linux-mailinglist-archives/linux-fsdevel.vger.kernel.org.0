Return-Path: <linux-fsdevel+bounces-12925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A114868B4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9B01C22B3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4E133413;
	Tue, 27 Feb 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bwkd6Fsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A4130AF8;
	Tue, 27 Feb 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024020; cv=none; b=X4GnoTZGQYl9EwZWL97NuO8UEh2DJn8pyA6xFTyVu66BLnhqEluMG8VH8kXUifxnxq/C309xpSVvxLQOZ0el5X29mCllHslSiOsjS5eMep6EgxNGTz9X2CoFR4RTALsuIpYaZKdcV7BhGsFDBbJyWvlfTughcDyZw8YrAFLAOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024020; c=relaxed/simple;
	bh=lzCwQyJEpw1qZT/9M5wpgWtO9LJVM/qhBJBKrIpwRL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbc77wNoq4K0a2DsomzqTx8TIHrBrbAOKK6ZnKwVvIhvh2W5r+9+uTypLWolg2OV2YGMA224/w3JtGaznXWp9qLmryA2WE8byp+ZT7+vkYHpgmuxxmGD+8IEnA3x7uyNMCdLsZV0Ius22JkRRBuO1TziNZ8XpoGxmicpa/iq3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bwkd6Fsd; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TkWVR1BWbz9sq8;
	Tue, 27 Feb 2024 09:53:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709024015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xG7fSz4uiTp34cw0D1g4RsXUHnXCjcPMxUY/Xls6pRo=;
	b=bwkd6Fsd51NLXnw7/z4WN4Vs9Rq95oo0ECbijUAdGiZjRV8oRKfHkJ+OlRoEwAYUgii4pS
	MJ6N8K30jVn6Q2b2nLufYhRyspVwGc571+3xnbsWTGqyQylWKNt3/WAB4+3jj22X+uXNGp
	er7tF/crJ2UnX2wo0x2jAtNDMop+kVMFZZoocmy0PIlDCVAHiGHsq6Xj4hsygm0AemiHN5
	81IoGf4NY68rYwbeGrdPcrCypTL6kXf9Aq/uHW/fN7QnjwTfj2ooIhy0VjwxMNpP0fLB15
	6sEDSjk7gxfDiRshE2FVkzv1AJ6fy03HKMgo+Ks7Ky8MNax3pJbMCjpHC+WUYw==
Date: Tue, 27 Feb 2024 09:53:31 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chandan.babu@oracle.com, akpm@linux-foundation.org, 
	mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, djwong@kernel.org, 
	gost.dev@samsung.com, linux-mm@kvack.org, willy@infradead.org, 
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/13] xfs: expose block size in stat
Message-ID: <4ojxfvnqw6d5dytkcw55olpbdcbwy2pgs7d6mchg6nmgt3icbi@rvzrifqb5x3k>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-12-kernel@pankajraghav.com>
 <ZdyHoOHBQ19JJap2@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdyHoOHBQ19JJap2@dread.disaster.area>
X-Rspamd-Queue-Id: 4TkWVR1BWbz9sq8

On Mon, Feb 26, 2024 at 11:44:16PM +1100, Dave Chinner wrote:
> On Mon, Feb 26, 2024 at 10:49:34AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > For block size larger than page size, the unit of efficient IO is
> > the block size, not the page size. Leaving stat() to report
> > PAGE_SIZE as the block size causes test programs like fsx to issue
> > illegal ranges for operations that require block size alignment
> > (e.g. fallocate() insert range). Hence update the preferred IO size
> > to reflect the block size in this case.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > dd2d535e3fb29d ("xfs: cleanup calculating the stat optimal I/O size")]
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Something screwed up there, and you haven't put your own SOB on
> this.
Oops. I will add it.

> 
> > ---
> >  fs/xfs/xfs_iops.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index a0d77f5f512e..1b4edfad464f 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -543,7 +543,7 @@ xfs_stat_blksize(
> >  			return 1U << mp->m_allocsize_log;
> >  	}
> >  
> > -	return PAGE_SIZE;
> > +	return max_t(unsigned long, PAGE_SIZE, mp->m_sb.sb_blocksize);
> >  }
> 
> This function returns a uint32_t, same type as
> mp->m_sb.sb_blocksize. The comparision should use uint32_t casts,
> not unsigned long.
> 
Yeah. Something like this instead of using unsigned long:

return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);

> ALso, this bears no resemblence to the original patch I wrote back in
> 2018. Please remove my SOB from it - you can state that "this change
> is based on a patch originally from Dave Chinner" to credit the
> history of it, but it's certainly not the patch I wrote 6 years ago
> and so my SOB does not belong on it.
Ok.

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

