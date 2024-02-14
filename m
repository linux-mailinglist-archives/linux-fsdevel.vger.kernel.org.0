Return-Path: <linux-fsdevel+bounces-11516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B003854385
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D531C2245B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD111731;
	Wed, 14 Feb 2024 07:38:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BB11701;
	Wed, 14 Feb 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896302; cv=none; b=ekHmzbN3cVELTEc97X9M3BpIOWJdrKnAjICCONLXeql5Vm+Rxtj1mjliwxaz4d0r2q/TEONMlnL5kNe32Vwi/EIQ+vWOiOz9HHu7ZTf0jdkHslCGUIxW5egiLP2RJgnFIUhBLKoHsi0vya9ZPaG98ilrnUpIQv39Dc7nANOV/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896302; c=relaxed/simple;
	bh=gATsw7AKug4+PziIaykTXVTLzN8FyjlrHqztEG8RHNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auZMLk8uGdH0/1s5BY5II+82vrvwRSQ/og4xt2LjGxY28Tp3WtrN7/FtAXqozuR5rq2MhysI7S6Op/pU88WMKpocFg9Se9z7cG5ClNy6JctGistSak55duyWchiZqfmjztFBVsId8VPR3VNGyN6mMJkC5ZrmgtI+QJAG9u72c8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 881E8227AA8; Wed, 14 Feb 2024 08:38:14 +0100 (CET)
Date: Wed, 14 Feb 2024 08:38:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <20240214073813.GA10006@lst.de>
References: <20240124142645.9334-1-john.g.garry@oracle.com> <20240213072237.GA24218@lst.de> <ZcwAPq8e/ZpAwhYf@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcwAPq8e/ZpAwhYf@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 14, 2024 at 10:50:22AM +1100, Dave Chinner wrote:
> The functionality atomic writes need from the filesystem is for
> extent alignment constraints to be applied to all extent
> manipulations, not just allocation.  This is the same functionality
> that DAX based XFS filesystems need to guarantee PMD aligned
> extents.
> 
> IOWs, the required filesystem extent alignment functionality is not
> specific to atomic writes and it is not specific to a particular
> type of storage hardware.
> 
> If we implement the generic extent alignment constraints properly,
> everything else from there is just a matter of configuring the
> filesystem geometry to match the underlying hardware capability.
> mkfs can do that for us, like it already does for RAID storage...

Agreed.

But the one thing making atomic writes odd right now is that it
absolutely is required for operation right now, while for other
features is is somewhere between nice and important to have and not
a deal breaker.

So eithe we need to figure out a somewhat generic and not totally
XFS implementation specific user space interface to do the force
alignment (which this series tries to do).  Or we make atomic
writes like the other features and ensure they still work without
the proper alignment if they suck.  Doing that was my initial
gut feeling, and looking at other approaches just makes me tend
even stronger towards that.



> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
---end quoted text---

