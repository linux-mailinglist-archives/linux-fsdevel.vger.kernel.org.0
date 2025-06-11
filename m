Return-Path: <linux-fsdevel+bounces-51291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008AAD5316
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28901E2C44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66727816B;
	Wed, 11 Jun 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHe8XDwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5FF2749F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639413; cv=none; b=CrfEAGC7X+dJBSZcDO2RqEv0OCCBuV9dgF/1PNtKlSTqiE/d4SvwbxToQKTtwcmVE6idQPsqapcBQy+hfasYgfQoRMxWj4ec8UaWTxiIbqWbsl9RiZetz13kcYQ7wErG6jYLcYBkrab3MdyjB+cHUNkoS5jFexZFvDoh+w670Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639413; c=relaxed/simple;
	bh=lFBA1zvRgpgYJwhwkjr+9qJCJssRSmTd1VR0g+r+9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtPmjYPNVdpOmQHAr2NslTrcR9neeGjEE0UFjuZdtrdj7RSC7RlBoAmwbt7STtqmWpLXjwmaMTcpjxhdrj6175nK7x7sEVzHrfKsIsVn6oN9IazPxVM6pcZO5wfzvQQaJVOOgv2SfYpUbTViStBVHm8jW9KByfgpHnBBjemtU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHe8XDwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B48C4CEEE;
	Wed, 11 Jun 2025 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639412;
	bh=lFBA1zvRgpgYJwhwkjr+9qJCJssRSmTd1VR0g+r+9JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHe8XDwNMbShYASuL87TSesE7aWKwl8bsNY7OV+E0CUvk9vkT5j6U/3ZEb7UQeSwg
	 xIOK7ChS4aECLun9k5Sr50DjS6EV+KCQaQOqAA1kKueB+vLvhoDl/LFDJGN+dfzuVJ
	 zkxdUerjgCXLW3jAQJlFSNWmP66/Zvhl5Y5F4BMjiDtUhfylEmE0UWFoOrrZZKiBjh
	 u6BXGRwIs/HgeqKYk/7kJOb9XiOUveMojE/KfCGzGnH2opTORDepMq0Y8ugCcw6bY9
	 WR7cYXRpP7mUu4/MUeVSC6yiga3kG9h/wJl3qYl6gHcdkYcSTowvOep5A1vXQ+qlfl
	 R22oY9HqtCKlw==
Date: Wed, 11 Jun 2025 12:56:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 12/26] Rewrite of propagate_umount()
Message-ID: <20250611-boomen-turnhalle-bcae860f3399@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-12-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-12-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:34AM +0100, Al Viro wrote:
> The variant currently in the tree has problems; trying to prove
> correctness has caught at least one class of bugs (reparenting
> that ends up moving the visible location of reparented mount, due
> to not excluding some of the counterparts on propagation that
> should've been included).
> 
> I tried to prove that it's the only bug there; I'm still not sure
> whether it is.  If anyone can reconstruct and write down an analysis
> of the mainline implementation, I'll gladly review it; as it is,
> I ended up doing a different implementation.  Candidate collection
> phase is similar, but trimming the set down until it satisfies the
> constraints turned out pretty different.
> 
> I hoped to do transformation as a massage series, but that turns out
> to be too convoluted.  So it's a single patch replacing propagate_umount()
> and friends in one go, with notes and analysis in D/f/propagate_umount.txt
> (in addition to inline comments).
> 
> As far I can tell, it is provably correct and provably linear by the number
> of mounts we need to look at in order to decide what should be unmounted.
> It even builds and seems to survive testing...
> 
> Another nice thing that fell out of that is that ->mnt_umounting is no longer
> needed.
> 
> Compared to the first version:
> 	* explicit MNT_UMOUNT_CANDIDATE flag for is_candidate()
> 	* trim_ancestors() only clears that flag, leaving the suckers on list
> 	* trim_one() and handle_locked() take the stuff with flag cleared off
> the list.  That allows to iterate with list_for_each_entry_safe() when calling
> trim_one() - it removes at most one element from the list now.
> 	* no globals - I didn't bother with any kind of context, not worth it.
> 
> 	* Notes updated accordingly; I have not touch the terms yet.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

