Return-Path: <linux-fsdevel+bounces-41307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC53EA2DA17
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 02:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9B1887AAC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD651243362;
	Sun,  9 Feb 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nBoveMWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49323A9;
	Sun,  9 Feb 2025 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739063355; cv=none; b=b2ii0UZH0yG3ScCuEiyHGP58PTQdQ/CbdrmWzLnY5MshKirgyNXAu9LEihL2y38wmeEPenxt+PQL+gE4h8PQTVdeGGm9A5W1vTW5buhc3oIZmqLY0ZxFHm0BFVLF5RuNp7S3R2hdUi9sSwwTZWt0KLh/hDiNYTO6e1M3dD2suHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739063355; c=relaxed/simple;
	bh=90Z0RvxUzC2VcP1yS2pux6wHBPXOVqCueAAyflyDvjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+jep+Fo9cMTr7STDO1+GKMg2HrWoIJT8MQ5gpj0WyqbCxeYSJNJLtyVGmKBVd5bdvg1M6XW3wkxM9B/S1nd/rKtZ3qVEbCseT+HEGpNSx0Ne8J5WRhqof2zE9dOG1eAYh4SB6ZyqsX9VttRsE0UfVKZLbjVXzmkqe7iA1kOh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nBoveMWe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nm8zbqno1Fs+37Xjq0tMKcI4TG9Wu6jE0AXJRMNzSSo=; b=nBoveMWe0l5MjvLb9b94TGx1Qq
	87FAg62xswVtj/QqHb+8dwdkPa10f5O4rOe0hq69KIyxVR/EX9dhhfDmCEbsGyKlyo/eRBBqEP3kI
	xqM99HPhJy38+zzIWK4AAlhYSAMFfNqOpBv8LVbeUM2xImZOo02haWs0PIKfQltrKeiXRX4ga1zx5
	LDKwGAIb+fLZdGiERJxP2lkwGb/wTB705PlABmYgk7Bozima//WbPebPdqPXMPtqfx73vM9HOXSR3
	0bl7GPy2EhAJGc7xqieYlUfiHZCLFj2tao20OG6ldAGg8Pmkq/4nvfnIaHQheM93S4DhI6Q6BjhHp
	+F3ZzRJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgvos-00000007zJc-0kjW;
	Sun, 09 Feb 2025 01:09:10 +0000
Date: Sun, 9 Feb 2025 01:09:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/19] VFS: add _async versions of the various directory
 modifying inode_operations
Message-ID: <20250209010910.GT1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-10-neilb@suse.de>
 <20250207224134.GM1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207224134.GM1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 07, 2025 at 10:41:34PM +0000, Al Viro wrote:

> I'm sorry, but I don't buy the "complete with no lock on directory"
> part - not without a verifiable proof of correctness of the locking
> scheme.  Especially if you are putting rename into the mix.
> 
> And your method prototypes pretty much bake that in.
> 
> *IF* we intend to try going that way (and I'm not at all convinced
> that it's feasible - locking aside, there's also a shitload of fun
> with fsnotify, audit, etc.), let's make those new methods take
> a single argument - something like struct mkdir_args, etc., with
> inlines for extracting individual arguments out of that.  Yes, it's
> ugly, but it allows later changes without a massive headache on
> each calling convention modification.
> 
> Said that, an explicit description of locking scheme and a proof of
> correctness (at least on the "it can't deadlock" level) is, IMO,
> a hard requirement for the entire thing, async or no async.
> 
> We *do* have such for the current locking scheme.

While we are at it, the locking order is... interesting.  You
have
	* parent's ->i_rwsem before child's d_update_lock()
	* for a child, d_update_lock() before ->i_rwsem
and that - on top of ordering between ->i_rwsem of various
inodes.

Do you actually have a proof that it's deadlock-free?

