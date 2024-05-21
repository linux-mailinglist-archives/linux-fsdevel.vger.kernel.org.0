Return-Path: <linux-fsdevel+bounces-19891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0FC8CB016
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916EF284528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A77F7CE;
	Tue, 21 May 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckWFWUjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1E7F48F;
	Tue, 21 May 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300700; cv=none; b=Ltg8xy8C11cAKED+c/y1vO4ah2aAXqX+6fnjHyJsbttQOjnAOoKjg8RYLEwvYTOwJKpsIIHVFuUM7M+VoqhztHHz9QaMuyYj/kmP8etUiQ8IBqNsPnlFjoV1aB73C7ruGPBf9/lJIV7iEBbPoMh4SbAA03/26dFZ4P3o01kgzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300700; c=relaxed/simple;
	bh=J6B0Lc94l58dW3Qn3r+3rIM76lUefVIUJwnMg9LpUyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDvlwy9+dIhX0c3zOeg7OZ4lNwmlCiq2+7KN1/KnblEf6823gHU+xyEyefUszH9t7VCmKMffOj5UVxHbxJG69FXzVQxoBkbyHpbx5khU5RJRYJrilcFqBa/RCVjcLd9AHqz4BwUUZjXjgklJ9+KAGLRcNkqDYHteh2dy6C/tzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckWFWUjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02B0C32786;
	Tue, 21 May 2024 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300700;
	bh=J6B0Lc94l58dW3Qn3r+3rIM76lUefVIUJwnMg9LpUyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckWFWUjQEtPQn67GXpYz4nso1FlJFjYfJ8FLQFFTuepVPWYCOl+Mm7D+eHB/qBwp7
	 RMf3ucvv2948+g8xPmTcPw1FVS1aobUR+iv2H4AGS5Q9zX1OkdwLjmcU9GOnqbdXOL
	 OIsE8/NDb6nGqCeWmagNCLF5zaKtkOfIZ/s3LrTswj4FTpd6IX3keUTv1MiF0VZiBN
	 WDBvFHvCXShYuR7eJ0O3uUHUkJoQbCRSFgq4r4UCZ1WZL7v4dEAKpSUTprxYQf66HQ
	 tKurOlglct53yDGyR08sk3G+xUsxlV5eYfFJoYisNCHbWiYMr6AiramnQ7ycW+YZcE
	 LOeLEp+ssg6vQ==
Date: Tue, 21 May 2024 16:11:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240521-patentfrei-weswegen-0395678c9f9a@brauner>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240521-verplanen-fahrschein-392a610d9a0b@brauner>

On Tue, May 21, 2024 at 03:46:06PM +0200, Christian Brauner wrote:
> On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > Now that we have stabilised the unique 64-bit mount ID interface in
> > statx, we can now provide a race-free way for name_to_handle_at(2) to
> > provide a file handle and corresponding mount without needing to worry
> > about racing with /proc/mountinfo parsing.
> > 
> > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
> > that doesn't make sense for name_to_handle_at(2).
> > 
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> 
> So I think overall this is probably fine (famous last words). If it's
> just about being able to retrieve the new mount id without having to
> take the hit of another statx system call it's indeed a bit much to
> add a revised system call for this. Althoug I did say earlier that I
> wouldn't rule that out.
> 
> But if we'd that then it'll be a long discussion on the form of the new
> system call and the information it exposes.
> 
> For example, I lack the grey hair needed to understand why
> name_to_handle_at() returns a mount id at all. The pitch in commit
> 990d6c2d7aee ("vfs: Add name to file handle conversion support") is that
> the (old) mount id can be used to "lookup file system specific
> information [...] in /proc/<pid>/mountinfo".
> 
> Granted, that's doable but it'll mean a lot of careful checking to avoid
> races for mount id recycling because they're not even allocated
> cyclically. With lots of containers it becomes even more of an issue. So
> it's doubtful whether exposing the mount id through name_to_handle_at()
> would be something that we'd still do.
> 
> So really, if this is just about a use-case where you want to spare the
> additional system call for statx() and you need the mnt_id then
> overloading is probably ok.
> 
> But it remains an unpleasant thing to look at.

And I'd like an ok from Jeff and Amir if we're going to try this. :)

