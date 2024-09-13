Return-Path: <linux-fsdevel+bounces-29285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4BF977AAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4D51F24891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0F1BD514;
	Fri, 13 Sep 2024 08:07:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529C19F41A;
	Fri, 13 Sep 2024 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214834; cv=none; b=j92zjUpkl2F35E1rH4tGo18chDYfPVZwCbaDmtwIO+3JFhiMTnAYdYySwXwrZsXpdsZ0f6yUqfEotMA5k90/L7meck7KnwKHU1zn9Pp5WbdW4pwgFlvjofaUY7fW/eAvNqPfNS7lLEcseQAqW8Ontr6hkL2do1hHaDxJMxlyXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214834; c=relaxed/simple;
	bh=OoeooWScYrdT/7Ye2MT+bee9p/3N1jp3nqcoiu34Ji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtlVxidlP4mp5ZEThGSMLb8GtnL8tR5vk+bJH4Wcm7w9IioPPbMcWoFDrmf+7frGtPDmuz0VGCIful2jA60fssXu0KhsZCyfaymDbVHu05Wyg87aN0YZ/OrpstsMGRG7M/LR9ilqC/fG48GEwZMRiOHlsIoji4ycBB0MXMjN+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DAE2227ABD; Fri, 13 Sep 2024 10:07:00 +0200 (CEST)
Date: Fri, 13 Sep 2024 10:06:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240913080659.GA30525@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 12, 2024 at 10:01:00PM +0530, Kanchan Joshi wrote:
> Please see the response in patch #1. My worries were:
> (a) adding a new field and propagating it across the stack will cause 
> code duplication.
> (b) to add a new field we need to carve space within inode, bio and 
> request.
> We had a hole in request, but it is set to vanish after ongoing 
> integrity refactoring patch of Keith [1]. For inode also, there is no 
> liberty at this point [2].
> 
> I think current multiplexing approach is similar to ioprio where 
> multiple io priority classes/values are expressed within an int type. 
> And few kernel components choose to interpret certain ioprio values at will.
> 
> And all this is still in-kernel details. Which can be changed if/when 
> other factors start helping.

Maybe part of the problem is that the API is very confusing.  A smal
part of that is of course that the existing temperature hints already
have some issues, but this seems to be taking them make it significantly
worse.

Note: this tries to include highlevel comments from the discussion of
the previous patches instead of splitting them over multiple threads.

F_{S,G}ET_RW_HINT works on arbitrary file descriptors with absolutely no
check for support by the device or file system and not check for the
file type.  That's not exactly good API design, but not really a major
because they are clearly designed as hints with a fixed number of
values, allowing the implementation to map them if not enough are
supported.

But if we increase this to a variable number of hints that don't have
any meaning (and even if that is just the rough order of the temperature
hints assigned to them), that doesn't really work.  We'll need an API
to check if these stream hints are supported and how many of them,
otherwise the applications can't make any sensible use of them.

If these aren't just stream hints of the file system but you actually
want them as an abstract API for FDP you'll also need to actually
expose even more information like the reclaim unit size, but let's
ignore that for this part of the discssion.

Back the the API: the existing lifetime hints have basically three
layers:

 1) syscall ABI
 2) the hint stored in the inode
 3) the hint passed in the bio

1) is very much fixed for the temperature API, we just need to think if
   we want to support it at the same time as a more general hints API.
   Or if we can map one into another.  Or if we can't support them at
   the same time how that is communicated.

For 2) and 3) we can use an actual union if we decide to not support
both at the same time, keyed off a flag outside the field, but if not
we simply need space for both.

