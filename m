Return-Path: <linux-fsdevel+bounces-73877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3FD22880
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EEAE303F0C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B089225762;
	Thu, 15 Jan 2026 06:17:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3B2745C;
	Thu, 15 Jan 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457853; cv=none; b=kaMm/Ws+ncfHUfKM0J3e2ZEXLMnLtpQXxd/zyc3vFF5MEgvDp7wtzMkSHp84461UC3QNroqtr9lMuF9sCqwtvSRu5uox9c+Kdi4DZgwgeBYxGIRJnaR0ouY5UutuWRKfLu1Zlqd1SWIRpEPBZiGCmb28FhssXgnHBG8LJRANHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457853; c=relaxed/simple;
	bh=Em7xLgPNoWmG3Wi+gdO8z8MA/N82kA56rBbI23SOo1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA3rk9nEjrjkfxkadNBFJHnHNFn+NlPY2EazPDZceTrH+qmYnBr5f0BIh772XrjRc1aaFSOVwWrXY5wHhVEx2wgahldznlQJPcASdaOMxTkzisHIeTxif6HftTS9Kt59TMgtU/AKubdAmCjA/VdJtG6EDyEY2QIo71zvd6f13Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8B31227AA8; Thu, 15 Jan 2026 07:17:27 +0100 (CET)
Date: Thu, 15 Jan 2026 07:17:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/14] iomap: fix submission side handling of
 completion side errors
Message-ID: <20260115061727.GD9205@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <20260114074145.3396036-7-hch@lst.de> <20260114223558.GK15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114223558.GK15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 02:35:58PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 08:41:04AM +0100, Christoph Hellwig wrote:
> > The "if (dio->error)" in iomap_dio_bio_iter exists to stop submitting
> > more bios when a completion already return an error.  Commit cfe057f7db1f
> > ("iomap_dio_actor(): fix iov_iter bugs") made it revert the iov by
> > "copied", which is very wrong given that we've already consumed that
> > range and submitted a bio for it.
> 
> Is it possible for the error to be ENOTBLK and the caller wants to fall
> back to buffered IO?  I /think/ the answer is "no" because only the
> ->iomap_begin methods (and therefore iomap_iter()) should be doing that,
> and we mask the ENOTBLK and pretend it's a short write.  Right?

Yeah, returning that on completion is too late to fall back, because
the iov_iter is already consumed.


