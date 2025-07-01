Return-Path: <linux-fsdevel+bounces-53477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44452AEF6AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA657A7405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0222737E6;
	Tue,  1 Jul 2025 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur6x4GW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1227281E;
	Tue,  1 Jul 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369752; cv=none; b=WIb+gaXdWzqaz5p3ctrTNAq0vZMy2/JUtR0Qzq8nap+oLRqudDvacsyFKxmT2KTN7XhRyrq9Rzgl77Uxpb3RwE1ArrqV8tuPIyEBTr3nCVUSEQDTMTvjU3dp80pnQ6EwOSMwS2DYRY43JxJJXdNz5pv4G+VGSKRM9ZHSfUI8cmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369752; c=relaxed/simple;
	bh=uMz31aacen0hV5LEAPRoownx/yVaGh9zlPPUKfGHmy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm3pleaAzjpfzQEVn/fpWLFrRCaD6bYoNhteMVbSuyAD6QzI7UUKXFkCjnF797r5aQ54T4P2zptD+ouG5FB+fXE97P07/wUEyb6ezOz/B/lLLKLMyXwn6/BgZfz9R3pzvfYJUSj3TFhUCeoAT4chV8eYupWxlbqSLPwmKb3p4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur6x4GW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F58FC4CEEB;
	Tue,  1 Jul 2025 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751369752;
	bh=uMz31aacen0hV5LEAPRoownx/yVaGh9zlPPUKfGHmy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur6x4GW4CrWBXFS/v/40PfmRB9CeuolQxuXxRp5EIOt293DICBoiHx6gkidmWbKVD
	 v+CTsFD9lvIOa/rsbmsWYEQkjTnfbRIdvoMTXCekPGgXKxcJ3BNEWJHzCP7CVFPGr5
	 yfFj8/otJNQrD5de/V7xwG+a9NQtIY53mSQlK5PjBNfe1EgQui26RehZ9htqXD30Xs
	 YKsbG+cj9YcvLo16XVm9Ds4oa8hiAVJfqJFP07Jc/LhtFKm6uKz/iUdqrFBSqJi2u1
	 J0bfdjRsjI5k7rlENzY3EQ3qSaqG12go7iiORZz4WMryMXtHMVT6IlbF4FbyMYxgT5
	 lCH0Cy6kkye0w==
Date: Tue, 1 Jul 2025 13:35:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
Message-ID: <20250701-dissident-gruft-00838ea3f311@brauner>
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
 <20250626-schildern-flutlicht-36fa57d43570@brauner>
 <20250626101443.GA6180@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626101443.GA6180@lst.de>

On Thu, Jun 26, 2025 at 12:14:43PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 26, 2025 at 10:38:11AM +0200, Christian Brauner wrote:
> > > +	if (sb->s_op->remove_bdev)
> > > +		sb->s_op->remove_bdev(sb, bdev, surprise);
> > > +	else if (sb->s_op->shutdown)
> > >  		sb->s_op->shutdown(sb);
> > 
> > This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
> > really dislike this pattern. It introduces the possibility that a
> > filesystem accidently implement both variants and assumes both are
> > somehow called. That can be solved by an assert at superblock initation
> > time but it's still nasty.
> > 
> > The other thing is that this just reeks of being the wrong api. We
> > should absolutely aim for the methods to not be mutually exclusive. I
> > hate that with a passion. That's just an ugly api and I want to have as
> > little of that as possible in our code.
> 
> Yes.  As I mentioned before I think we just want to transition everyone
> to the remove_bdev API.  But our life is probably easier if Qu's series
> only adds the new one so that we can do the transitions through the
> file system trees instead of needing a global API change.  Or am I
> overthinking this?

I think it's fine to do it right now. If we can avoid having
transitional stages then let's do that.

