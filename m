Return-Path: <linux-fsdevel+bounces-27825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B456964598
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B21C24BD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D921AB512;
	Thu, 29 Aug 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p8P9u5g3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58D1AB505
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936164; cv=none; b=HEoNzMcYvYTVXg3EH/eR6YqbJLrtsjt70MSguoFldgWgDxFwqlCmd9/L9dxibNeSVUd1C7a+MlWH5CKao631e99mMiuG2wMowMFRf8APnHMfLMPbWs/j7M+SDBPyrOgnMtUT7IHnsgxc30vegbqHfHCQewsIGyXrwEZ7sfypvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936164; c=relaxed/simple;
	bh=zNkDvfaNhgjAc7yL7GBBZMbe/RFNPbnApKQFg9/TgLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQUcqXVWJFc7r7OFQugwa6ky+guvJ0+kQ5qbCW6nmDGJmdedOmUJKXOn5uZaDchPpKOqHY9K+60udXV4GA13YLzCrCtQ5o1O5Pf4aiCvYWNbWMelNiT4F4DWboHFhK6yPoJSnZorK+8VotPBaJZnPxNhRUIUGGvQkOC1hu1gN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p8P9u5g3; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 08:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724936160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnMGv88WDoKcQvjIJzYL0rYHExqMCe4hXsbVaVeGr5Y=;
	b=p8P9u5g3LDHWjWblqz0GqWJCIJSXDmaQrHa2pgL1rH/QQ6sAojd/2n07vgwWs+YIV5JWYP
	Gbq50Ic52qNBIIqvOSawcDlj6vmZktBtuqyBKURHzELB2nE5nzmBblz4b6G/FQV1vmYRB7
	MPXnfuypCK3TeRUkhBcHsMMp5vweTq4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 14/16] bcachefs: add pre-content fsnotify hook to fault
Message-ID: <3cuyv5dz376boeahogdpgzdkzgkjiwmksgfrattzblrh2agkqn@igtywyxsifnv>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
 <20240829111055.hyc4eke7a5e26z7r@quack3>
 <zzlv7xb76hkojmilxsvrsrhsh7yzglvrwofxcavjo4nluhjbdu@cl2c4iscmfg2>
 <20240829124607.GC2995802@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829124607.GC2995802@perftesting>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 08:46:07AM GMT, Josef Bacik wrote:
> On Thu, Aug 29, 2024 at 07:26:42AM -0400, Kent Overstreet wrote:
> > On Thu, Aug 29, 2024 at 01:10:55PM GMT, Jan Kara wrote:
> > > On Wed 14-08-24 17:25:32, Josef Bacik wrote:
> > > > bcachefs has its own locking around filemap_fault, so we have to make
> > > > sure we do the fsnotify hook before the locking.  Add the check to emit
> > > > the event before the locking and return VM_FAULT_RETRY to retrigger the
> > > > fault once the event has been emitted.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > 
> > > Looks good to me. Would be nice to get ack from bcachefs guys. Kent?
> > 
> > I said I wanted the bcachefs side tested, and offered Josef CI access
> > for that - still waiting to hear from him.
> 
> My bad I thought I had responded.  I tested bcachefs, xfs, ext4, and btrfs with
> my tests.  I'll get those turned into fstests today/tomorrow.  Thanks,

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

