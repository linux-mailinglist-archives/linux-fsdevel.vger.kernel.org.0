Return-Path: <linux-fsdevel+bounces-47102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA84A98F74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41AC189E10B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773B2820D7;
	Wed, 23 Apr 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OecdS9Du"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A6280CE0;
	Wed, 23 Apr 2025 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420472; cv=none; b=jjOtHp0HDsx+Rt6fT1AyivsWOi56D84elNrcv3pvjcKYqRlrCKnJ3pMK+qp0d08wgP6ymXZr5piBsc6KcAIlqUiBdqOx2MmehLbuE1gfw/QOxlmTOYkh2YAGQkKdrtw3swGb9iKQZBCogrom9EV9QhKviW+Rm/mTxrYlpFsnOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420472; c=relaxed/simple;
	bh=EejihSG4dhJo9Xlvr1jU9YQU1gFxoDhpb+JD6EWedwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPX9vxC3TFfHt4Z3T+qOt3G/1pZPN5Dy87rkcoAGsOMk0AxQ6Zm1QghqXLtsGqZDCAizWLnzSgjduxjcmntpDKx9n9fiyveCOFlDTZxtzzKX7/J4Y2Ds1Dxs0Y2TX86WFSHk1tREyOT93mA9Tq9WH1UwJitBGgkyz7kcsisc/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OecdS9Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FF5C4CEE2;
	Wed, 23 Apr 2025 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420472;
	bh=EejihSG4dhJo9Xlvr1jU9YQU1gFxoDhpb+JD6EWedwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OecdS9Du5yMgDqzO08LwDx/95Z5FyyQeV6qvL/kkV6wLUfAUebaWOjcGjxeG32a3W
	 LJ4UznS7wIceKrF1H1VJMNm1KqqG3wPA5g7wh0jTVAHWkyTEMLQAq2DcSzpYBTOoZz
	 GyRGiiJbwwgeon5fdP2SFuTQQFsD8POlDu9o86Bg3xagxNe8OiZu0WTywuPylKBqsF
	 YbnZ/g7yVxoUn9dLwKd3AKRkxo5pxgsH7OXFzPMefD2/LLnUOFColh8p82FQnvBPGC
	 AfAPpzsP1/MXDLd0WeFyPrkZGfVbQMUhr/CE80l3CvNtc/Xh86jWzn6p11ASbNzUF7
	 Ne/Ynlr4L+1mg==
Date: Wed, 23 Apr 2025 08:01:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 15/15] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
Message-ID: <20250423150110.GB25675@frogsfrogsfrogs>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-16-john.g.garry@oracle.com>
 <20250423083209.GA30432@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423083209.GA30432@lst.de>

On Wed, Apr 23, 2025 at 10:32:09AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 22, 2025 at 12:27:39PM +0000, John Garry wrote:
> > From: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > Introduce a mount option to allow sysadmins to specify the maximum size
> > of an atomic write.  If the filesystem can work with the supplied value,
> > that becomes the new guaranteed maximum.
> > 
> > The value mustn't be too big for the existing filesystem geometry (max
> > write size, max AG/rtgroup size).  We dynamically recompute the
> > tr_atomic_write transaction reservation based on the given block size,
> > check that the current log size isn't less than the new minimum log size
> > constraints, and set a new maximum.
> > 
> > The actual software atomic write max is still computed based off of
> > tr_atomic_ioend the same way it has for the past few commits.
> 
> The cap is a good idea, but a mount option for something that has
> strong effects for persistent application formats is a little suboptimal.
> But adding a sb field and an incompat bit wouldn't be great either.
> 
> Maybe this another use case for a trusted xattr on the root inode like
> the autofsck flag?

That would be even better, since you could set it at mkfs time and it
would persist until the next xfs_property set call.

--D

