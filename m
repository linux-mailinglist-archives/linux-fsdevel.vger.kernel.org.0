Return-Path: <linux-fsdevel+bounces-31144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB599923F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 07:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C46B22499
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 05:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF313C807;
	Mon,  7 Oct 2024 05:42:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295D13635E;
	Mon,  7 Oct 2024 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728279756; cv=none; b=hYwGLEQKk8NPFYkfjpaLL1rZMvax++TA03/maBlp6/Vylftk+vETvI6G4HrugO1gg1uhkiSkvtwMGqfnSTHIQn7zwPm7mFokJaC7yrXsH/6mWxViglXo8E9xy8MRfIuYWdJnrIQZUkt8fE9+06OqRSqcE2rF1PycAuetPv+4uRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728279756; c=relaxed/simple;
	bh=jNFJbeaBC/ddBNQtHsaqiEZYQpM+ep++AQHObx5w6UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeE4si6CambJ6bsx4+xVcxQuz+24W39Ec648FzG5tKo9Ovs0aH961Q6Q4RCYoOWjFZOJfaDJWSxEaMQCnHwMSZ7cGIXUee6gDFGPQKJY+DKUDQAZvcBze48NlV7WX1DBaxSPEJbv8msMb5ICfzJ1dm4sVpM9f6bkpSTq+XdwSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85BB1227A8E; Mon,  7 Oct 2024 07:42:29 +0200 (CEST)
Date: Mon, 7 Oct 2024 07:42:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, brauner@kernel.org,
	djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	dchinner@redhat.com, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v7 5/8] xfs: Support FS_XFLAG_ATOMICWRITES
Message-ID: <20241007054229.GA307@lst.de>
References: <20241004092254.3759210-1-john.g.garry@oracle.com> <20241004092254.3759210-6-john.g.garry@oracle.com> <20241004123520.GB19295@lst.de> <f4d2180a-8baa-4636-a0a1-36e474fcd157@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d2180a-8baa-4636-a0a1-36e474fcd157@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 04, 2024 at 02:07:05PM +0100, John Garry wrote:
> Sure, that is true (about being able to atomically write 1x FS block if the 
> bdev support it).
>
> But if we are going to add forcealign or similar later, then it would make 
> sense (to me) to have FS_XFLAG_ATOMICWRITES (and its other flags) from the 
> beginning. I mean, for example, if FS_XFLAG_FORCEALIGN were enabled and we 
> want atomic writes, setting FS_XFLAG_ATOMICWRITES would be rejected if AG 
> count is not aligned with extsize, or extsize is not a power-of-2, or 
> extsize exceeds bdev limits. So FS_XFLAG_ATOMICWRITES could have some value 
> there.
>
> As such, it makes sense to have a consistent user experience and require 
> FS_XFLAG_ATOMICWRITES from the beginning.

Well, even with forcealign we're not going to lose support for atomic
writes <= block size, are we?


