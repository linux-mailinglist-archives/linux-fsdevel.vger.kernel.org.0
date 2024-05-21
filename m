Return-Path: <linux-fsdevel+bounces-19888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDAF8CAF9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DA4283E62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1A7CF39;
	Tue, 21 May 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doSvk6gj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054455783;
	Tue, 21 May 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299160; cv=none; b=ArVeStcguuuMxGfvVQepUPCB8wFB7abZSX80rwTbB7XFFLB9/y53LbPsLaIej88rd4d6ECVy4ELLrdvibanHg3dVjwm9tZVYkh6RZbzFJNZg+m7IDKKA/CK5VGo99y3ZNvA7/OrWim7+we+bGptZpseX3q2dleFKHFBaKHLeB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299160; c=relaxed/simple;
	bh=FLQbbXjucJdpPz4isaAj7e59xfrG4oqG7uu7VlLroSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAoREYrUCUYRgBt+apnefKCquTQ6kj/dnpHK2YMjUUDzMLfAeM/ZqSvlSHW3ZyuSjyH2P18ljjDgOnehQbjoSZok2LXPtAl6PtZapZgK+KKm00+kj/9j9WI4W0zLvruryXxeyteG0d6Zv2F74mPFv3SUPamgtgiDK31R9OG3dPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doSvk6gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEBBC2BD11;
	Tue, 21 May 2024 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716299160;
	bh=FLQbbXjucJdpPz4isaAj7e59xfrG4oqG7uu7VlLroSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doSvk6gjtGjiGe+wKSK27hcw9Yl6R5tpaY1HdJYxxTGuXN7EMEt064MbBRUw9Kf8q
	 E+7V/3YB1xIyuTAqYPuCCXjKyM/9QsjdSSyqsGXjkwRKHlNrn4BqEDCCVWJgcnUWH8
	 wFQvlANd0en80wsfSwEetQ+HyHW8YaWn6ygJuUZDBRSrZUMIORs/qtHdXce25/83SA
	 3O9Pidt3H1pRv/3jSbcR32SNPqeVF3VqDWztDZ7PMUqhVygJQo6aQVviI1XXMeIMsA
	 +gzV9rO74sH5kkGNT4QDbCFDPiA53dFgJediivdlNxDCRQDmhk6Qu8tDO/L5YbgGSU
	 1mMaWsRf1Gijw==
Date: Tue, 21 May 2024 15:45:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>

On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> Now that we have stabilised the unique 64-bit mount ID interface in
> statx, we can now provide a race-free way for name_to_handle_at(2) to
> provide a file handle and corresponding mount without needing to worry
> about racing with /proc/mountinfo parsing.
> 
> As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
> that doesn't make sense for name_to_handle_at(2).
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---

So I think overall this is probably fine (famous last words). If it's
just about being able to retrieve the new mount id without having to
take the hit of another statx system call it's indeed a bit much to
add a revised system call for this. Althoug I did say earlier that I
wouldn't rule that out.

But if we'd that then it'll be a long discussion on the form of the new
system call and the information it exposes.

For example, I lack the grey hair needed to understand why
name_to_handle_at() returns a mount id at all. The pitch in commit
990d6c2d7aee ("vfs: Add name to file handle conversion support") is that
the (old) mount id can be used to "lookup file system specific
information [...] in /proc/<pid>/mountinfo".

Granted, that's doable but it'll mean a lot of careful checking to avoid
races for mount id recycling because they're not even allocated
cyclically. With lots of containers it becomes even more of an issue. So
it's doubtful whether exposing the mount id through name_to_handle_at()
would be something that we'd still do.

So really, if this is just about a use-case where you want to spare the
additional system call for statx() and you need the mnt_id then
overloading is probably ok.

But it remains an unpleasant thing to look at.

