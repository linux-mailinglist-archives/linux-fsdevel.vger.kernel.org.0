Return-Path: <linux-fsdevel+bounces-51290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388EEAD534A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05998188A5C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A728936C;
	Wed, 11 Jun 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+HmJCGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577A27816B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639371; cv=none; b=J5LKkgbmTtAbYZL7oVks8KSM/5js3qThSedMYDdonB6YmzSgCJ8xvqZXvcSQWjox31b/m1yQ6KKRQ+W/x0oUCgIAnGzEbrJ1KalqonWgaoVxoYqnxtsy/4Z/bRtjwGfDhCnI9MHzHwT7c28F7H5KDHl/zkw0f+Hn59nWbujWh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639371; c=relaxed/simple;
	bh=CG11Tz7CfTqJ/5TByRwSA4fl+j/4fII8M9y0ETDJwL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djmB49L2GFO9aWJRs/2Oluueezi7j6OQJjNOFHfjKRhY6LP761alkftzv5oWKjUphI/Cv5/mBBbKYGkRym37OrueYl7WDdsFc+/HXH8ZXOMwQqZAAXwhS7zpd3TyUgkxVjd/fv751g7scgUxbR9GseyQK2MZezstOWlDdurWj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+HmJCGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814F9C4CEEE;
	Wed, 11 Jun 2025 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639370;
	bh=CG11Tz7CfTqJ/5TByRwSA4fl+j/4fII8M9y0ETDJwL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+HmJCGS9X2vvEBBN1DyxpgmsFYE/zmdqVXPr0/86UxZM0FEtCOCgS1TTku0cGWOq
	 xWFGfebErd2bEm/mHEDyGoYMV27KqEo7tVoq5DVE/bY93FH8SJDFOnMl2ZRNowVe28
	 yYZTvrNb8dMPoUoZ4GxJpafE3+QBicyBtxdCqeS5iJXWsDKnBNr/X9NNcUzvmfFvjH
	 /JM4Igg7mA9OgNsy8+A8TlhWkd3SE6pxXi2Y8uPa3shls0PUQqxRhAnfI8APUUQ8zb
	 TRPAm/TZn2nHiqhFXkCV5CmsZqnhaRX8YMWeFAaec8n6I6SOqCMUKDz2pQS0M+jEjI
	 jYro/K4/UjLbA==
Date: Wed, 11 Jun 2025 12:56:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 11/26] sanitize handling of long-term internal mounts
Message-ID: <20250611-minus-zugfahrt-d6e68d933f0f@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-11-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:33AM +0100, Al Viro wrote:
> Original rationale for those had been the reduced cost of mntput()
> for the stuff that is mounted somewhere.  Mount refcount increments and
> decrements are frequent; what's worse, they tend to concentrate on the
> same instances and cacheline pingpong is quite noticable.
> 
> As the result, mount refcounts are per-cpu; that allows a very cheap
> increment.  Plain decrement would be just as easy, but decrement-and-test
> is anything but (we need to add the components up, with exclusion against
> possible increment-from-zero, etc.).
> 
> Fortunately, there is a very common case where we can tell that decrement
> won't be the final one - if the thing we are dropping is currently
> mounted somewhere.  We have an RCU delay between the removal from mount
> tree and dropping the reference that used to pin it there, so we can
> just take rcu_read_lock() and check if the victim is mounted somewhere.
> If it is, we can go ahead and decrement without and further checks -
> the reference we are dropping is not the last one.  If it isn't, we
> get all the fun with locking, carefully adding up components, etc.,
> but the majority of refcount decrements end up taking the fast path.
> 
> There is a major exception, though - pipes and sockets.  Those live
> on the internal filesystems that are not going to be mounted anywhere.
> They are not going to be _un_mounted, of course, so having to take the
> slow path every time a pipe or socket gets closed is really obnoxious.
> Solution had been to mark them as long-lived ones - essentially faking
> "they are mounted somewhere" indicator.
> 
> With minor modification that works even for ones that do eventually get
> dropped - all it takes is making sure we have an RCU delay between
> clearing the "mounted somewhere" indicator and dropping the reference.
> 
> There are some additional twists (if you want to drop a dozen of such
> internal mounts, you'd be better off with clearing the indicator on
> all of them, doing an RCU delay once, then dropping the references),
> but in the basic form it had been
> 	* use kern_mount() if you want your internal mount to be
> a long-term one.
> 	* use kern_unmount() to undo that.
> 
> Unfortunately, the things did rot a bit during the mount API reshuffling.
> In several cases we have lost the "fake the indicator" part; kern_unmount()
> on the unmount side remained (it doesn't warn if you use it on a mount
> without the indicator), but all benefits regaring mntput() cost had been
> lost.
> 
> To get rid of that bitrot, let's add a new helper that would work
> with fs_context-based API: fc_mount_longterm().  It's a counterpart
> of fc_mount() that does, on success, mark its result as long-term.
> It must be paired with kern_unmount() or equivalents.
> 
> Converted:
> 	1) mqueue (it used to use kern_mount_data() and the umount side
> is still as it used to be)
> 	2) hugetlbfs (used to use kern_mount_data(), internal mount is
> never unmounted in this one)
> 	3) i915 gemfs (used to be kern_mount() + manual remount to set
> options, still uses kern_unmount() on umount side)
> 	4) v3d gemfs (copied from i915)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

