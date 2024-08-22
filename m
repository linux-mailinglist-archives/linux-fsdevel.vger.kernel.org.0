Return-Path: <linux-fsdevel+bounces-26687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C57B95B06F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172DD2863BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6D16EBE6;
	Thu, 22 Aug 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBN3PMjy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C516A955
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315513; cv=none; b=hgXKhRLRBxQ9fJ2Sp7fPQZroA56Yhb+wcPZSIyvVjoUn/A3+bk0ILi71xE6vnOnI5t/R/US5rP9P7FR7eItKdlNyna9jLNyzbGhdhM6R7SblyV2zL00pSewMi+qUmMMpv/NooOyc2W2PyL/CNC9l1U3RyhyJzQWkppZG3PGRtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315513; c=relaxed/simple;
	bh=WtmLzHENyzJ0oqzjTV5PcuOx2yCwd1M8gNFXbqzoayc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL4DuPmsUSqtO8hfy81aNaFVG2z+wfbxpo3UXBBrEmNZQOKqAlkR18UrmFmgSsTgpamBZiZkyw6BeQoCNQTuyKamBgDiDYBI6QKNUTLaaubJF+X5fdB5tUjYLGSRjX3g8K6KaJPZwy0nKJ4g69/vlnYHbJe1jdJGvmwJL4cAPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBN3PMjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6F1C4AF09;
	Thu, 22 Aug 2024 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724315513;
	bh=WtmLzHENyzJ0oqzjTV5PcuOx2yCwd1M8gNFXbqzoayc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBN3PMjyiqZz85GkH906ilgK7doj1qcYKl3zTW9rjmOIMep19wqXQvjKcd+AAWOLU
	 QDfqPDgT9+cFtKlicTPEi+2JevNv9tl1b1po0r8mKQxqQmfdXCAXHy4bmUpkhQiU6u
	 Xm9+QzFoL+BBmcqqe2/p2ByyVoNEl+twZXV3M07x0wU0EbW9iv4YQWedfZFbnXW0Kl
	 La5c0KdU2UxKVryZ3ug8uOgmLmGoTb/ZX/zMcZ0adxSQ9Wod3nY88x+93MrAzoWLOw
	 A1nzbBJQ8ohjxPzEUwosjoD1l87v7j47qIDBLGOv3QHD1HUs5kjmd2s2h4XWoLuu7J
	 cxNPfKYN3H2rw==
Date: Thu, 22 Aug 2024 10:31:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 6/6] inode: make i_state a u32
Message-ID: <20240822-differenz-reihum-0e9f9e265020@brauner>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-6-67244769f102@kernel.org>
 <9BA2DBC4-0DB3-406C-A88D-B816C421EF1D@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9BA2DBC4-0DB3-406C-A88D-B816C421EF1D@dilger.ca>

On Wed, Aug 21, 2024 at 03:03:01PM GMT, Andreas Dilger wrote:
> On Aug 21, 2024, at 9:47 AM, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > Now that we use the wait var event mechanism make i_state a u32 and free
> > up 4 bytes. This means we currently have two 4 byte holes in struct
> > inode which we can pack.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > include/linux/fs.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8525f8bfd7b9..a673173b6896 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -681,7 +681,7 @@ struct inode {
> > #endif
> > 
> > 	/* Misc */
> > -	unsigned long		i_state;
> > +	u32			i_state;
> 
> Is it worthwhile to add a comment that there is a hole here, instead
> of leaving it for future re-discovery?
> 
>         /* 32-bit hole */
> 
> > 	struct rw_semaphore	i_rwsem;
> > 
> > 	unsigned long		dirtied_when; /* jiffies of first dirtying */
> 
> Normally this would be excess noise, but since struct inode is
> micro-optimized (like struct page) it probably makes sense to
> document this case.

Good idea. Added now!

