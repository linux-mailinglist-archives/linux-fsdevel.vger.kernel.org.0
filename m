Return-Path: <linux-fsdevel+bounces-42745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1FA47760
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 09:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67DA16D94D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B0C222577;
	Thu, 27 Feb 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHXDHEMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B201129A78;
	Thu, 27 Feb 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644001; cv=none; b=SHsePEO3nfs+e3XVJuPGo11VwsxpO13yDk9LD12KtnyJgDvl/y15gLexefrTJkVr6uLOAyhs/m54XU/3GSV9dSOApwxEpJEh020puE+88XRwBu96PSxI3LgNfa7cdDtc9nk962ztkgOXITfVMbc819coR0GwmLIM6bqf4OjfPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644001; c=relaxed/simple;
	bh=Ds+RA7hpXsNgtC82cHiCvKVNPVhYDU+5sN6Wwx16rMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDMy8moY4AIxX+9KJ2aeaGC59K3nW9DRXg9IJuSJIkYKsG7uvTxcuH/YMms84E4igLutmvc9yS0n7sJNvn+Q9k8rxZvDp3sCob8pAUkdnBv/YNLwhVHrxR2QW122jkESaGTHoulKFjwz0drMdxKJlzBzBo6dT137Fgyt9Bo9Dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHXDHEMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAB5C4CEDD;
	Thu, 27 Feb 2025 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644001;
	bh=Ds+RA7hpXsNgtC82cHiCvKVNPVhYDU+5sN6Wwx16rMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHXDHEMpldPkVwMkfYNA2CgH8EB4Uod/nH6vKZ7FruafdrtdbJ9NX+suvWd94xeMf
	 xL9MK18hVEnuIm1rgMuMudeO0/NR3w+Cu5vrtOvgi3vcwL4CmRS5/7NlE2pZd4EQag
	 0aLpv29bK2QTnVEuuSuk4CH4tWHyBuXa9XCxPLZmsxOYEofQ8ip5Qos1lQHReUJOet
	 /cTQLODZeljKxDK6iWMQbYFFNomlEg91QevyOy/sj3QcnoC15Pphm/i/sGrM79Fopv
	 FKkfxsftv4X2Hn8YibLTcBRSKNLoFVCdZv/tWC7Uvo4xoxcrkvVw0mAz/XIBWuVpU+
	 EhTm1ZL4DPnog==
Date: Thu, 27 Feb 2025 09:13:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: Re: [PATCH RFC namespace] Fix uninitialized uflags in
 SYSCALL_DEFINE5(move_mount)
Message-ID: <20250227-abbruch-geknickt-c6522ef250a7@brauner>
References: <e85f9977-0719-4de8-952e-8ecdd741a9d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e85f9977-0719-4de8-952e-8ecdd741a9d4@paulmck-laptop>

On Wed, Feb 26, 2025 at 11:18:49AM -0800, Paul E. McKenney wrote:
> The next-20250226 release gets an uninitialized-variable warning from the
> move_mount syscall in builds with clang 19.1.5.  This variable is in fact
> assigned only if the MOVE_MOUNT_F_EMPTY_PATH flag is set, but is then
> unconditionally passed to getname_maybe_null(), which unconditionally
> references it.
> 
> This patch simply sets uflags to zero in the same manner as is done
> for lflags, which makes rcutorture happy, but might or might not be a
> proper patch.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---

Hey Paul! Thank you for the patch. The fix is correct but I've already
taken a patch from Arnd yesterday. So hopefully you'll forgive me for
not taking yours. :)

>  namespace.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 663bacefddfa6..80505d533cd23 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4617,6 +4617,7 @@ SYSCALL_DEFINE5(move_mount,
>  	if (flags & MOVE_MOUNT_BENEATH)		mflags |= MNT_TREE_BENEATH;
>  
>  	lflags = 0;
> +	uflags = 0;
>  	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
>  	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
>  	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
> @@ -4625,6 +4626,7 @@ SYSCALL_DEFINE5(move_mount,
>  		return PTR_ERR(from_name);
>  
>  	lflags = 0;
> +	uflags = 0;
>  	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
>  	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
>  	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	uflags = AT_EMPTY_PATH;

