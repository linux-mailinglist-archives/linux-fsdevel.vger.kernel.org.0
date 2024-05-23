Return-Path: <linux-fsdevel+bounces-20030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D408CCA51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 03:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D531C21648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22014A24;
	Thu, 23 May 2024 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AGc+tg3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7731869
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426890; cv=none; b=EZ8oWt+pJ8D17TedvFtD8dfzNUpzoA7iSE6neyWYZ5WxIMQwYVSvTKiVT/mpNY0WKuPhiIpA6EhWQJoQm0y5JCUpJzl6sB9TeDeV130kBjQQjpZHFBgm9adjWxZ+y9f9ECufbc0UrFyJWhYP7HVRs248je1MIoMFtmSxt+gAZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426890; c=relaxed/simple;
	bh=F6aTYxhT26oFwWZ67Ld502s2Po3+Xcgbu+9VvbthueI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m94yH7+87/E1BW0amzRR4c80fHJGsLEQyV0DmzZcxczGQu2MbcndKh8GqZWquY5HjPEQfrTenbJ6k3RyxmcQ8BAuMRct5pAq0yjHU2gRqd4pA7APOROZUtuHwjZalI9DAwpcTMjNk5Qr+GPp+DLe/ZP/yrvyKe+8tgmmk4T+pTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AGc+tg3U; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-613a6bb2947so1729574a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716426888; x=1717031688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggg+vU4NzAtpKME671SbzqiVssDUIpzqRXRtZ78AP3g=;
        b=AGc+tg3UybDOW3aXsoS6q+WCEN4SAEaK82cy4MdraW193bOI8rCfEdGhcIUHhKVMkj
         UnMfbQMetndoJgNnacpamn53zETSm6/ADa6Z15VSLjLx0IZFh/yQE/92fdNYUN7GbRLN
         qj431krkIukCq7krtanCX6aysNuGJJ7IbktPhaDWn4VFhVFdQkzAX4XgcO4LxgY6s1OS
         m9lVQLcg5R2of4AGoRU0iss9GFD6kGlTxb/ug7plz0nMKyokTwCwoeMdqGpfpOP8G+4f
         KAA0xFIKV/t3dFAP0ThDbXnuYwnYhu/2f3ds3bd+JhezYRLXXK+FYp+gFvSNHug/kLMP
         VcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426888; x=1717031688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggg+vU4NzAtpKME671SbzqiVssDUIpzqRXRtZ78AP3g=;
        b=njSKzo+lcNz0qbLhrIgZT0sO1e3oP95FyHCkQ7094coKQ9fQQgNga1Z8cR20Y7rY5n
         KaSZ7LnLM0HP9aggs/7IcUh6ls3YuoyLoCTSu9r8JdfVVgNBDu4UVUABvY9SBgwk27MF
         TUvctRgwbHpuFiqrwo4rCdnOzYlcpJHl252x/vbaCZI+ij80xfMWMex/jcfMSY7cWabV
         jVozjPPPZTQ7hDeV0L/3fP9iuN66bQXVTvElEIGCwVpHTBWZRr+SyAsNZxHesZH8LEwf
         QZtJEBAsTY5So2Kqj9hRPf4OEKtlLIBw7xFAAXqfYP8KvmdDpwPzBuOf5t+IxXNgCVHW
         oTTA==
X-Forwarded-Encrypted: i=1; AJvYcCUsl33fe14yLSuYFPAippg3k4YJLTcaMg9BHo2JsykS5dTMrH5Y7r8hgEZ3il/47F40xUEKG+ScyQnx7K3H2P0wc3yRNUhmAC35SmVR2w==
X-Gm-Message-State: AOJu0YzokC/3je5m1de1LjZELFVhwsTbeVq7pAi4ti1wjKPEnvEjtcM0
	+Gjd8rSCwUhzGfvilsYQBMCZb4ZZkmbgjAQICpVniW7wvC9ctXPxmwCMraPrKHY=
X-Google-Smtp-Source: AGHT+IGrhJ7h989jjAjSMtYNfzU+Yi3+mZLiquC92tnMfDp+of2ZtyY0LfEoupYObDtgvUJLtg9k7A==
X-Received: by 2002:a17:90a:d706:b0:2ae:b8df:89e7 with SMTP id 98e67ed59e1d1-2bd9f5a2611mr3687386a91.38.1716426888226;
        Wed, 22 May 2024 18:14:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f0adfdsm413976a91.34.2024.05.22.18.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 18:14:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s9x2a-0077HZ-2j;
	Thu, 23 May 2024 11:14:44 +1000
Date: Thu, 23 May 2024 11:14:44 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
Message-ID: <Zk6YhF/DsbOy66EZ@dread.disaster.area>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <ZkwJJuFCV+WQLl40@dread.disaster.area>
 <20240522030020.GU25518@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522030020.GU25518@frogsfrogsfrogs>

On Tue, May 21, 2024 at 08:00:20PM -0700, Darrick J. Wong wrote:
> On Tue, May 21, 2024 at 12:38:30PM +1000, Dave Chinner wrote:
> > [RFC] iomap: zeroing needs to be pagecache aware
> > 
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Unwritten extents can have page cache data over the range being
> > zeroed so we can't just skip them entirely. Fix this by checking for
> > an existing dirty folio over the unwritten range we are zeroing
> > and only performing zeroing if the folio is already dirty.
> > 
> > XXX: how do we detect a iomap containing a cow mapping over a hole
> > in iomap_zero_iter()? The XFS code implies this case also needs to
> > zero the page cache if there is data present, so trigger for page
> > cache lookup only in iomap_zero_iter() needs to handle this case as
> > well.
> 
> Hmm.  If memory serves, we probably need to adapt the
> xfs_buffered/direct_write_iomap_begin functions to return the hole in
> srcmap and the cow mapping in the iomap.  RN I think it just returns the
> hole.

Yes, that is what I was thinking we need to do -
xfs_buffered_write_iomap_begin() doesn't even check for COW mappings
if IOMAP_ZERO is set, so there's a bunch of refactoring work needed
to let iomap know that there is a COW mapping over the hole so it
can do the same page cache lookup stuff that I added for unwritten
extents....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

