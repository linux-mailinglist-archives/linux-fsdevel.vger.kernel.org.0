Return-Path: <linux-fsdevel+bounces-35717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE609D77E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC314B24C0E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894E139D0A;
	Sun, 24 Nov 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UP+IVKTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1D2500AF;
	Sun, 24 Nov 2024 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732473468; cv=none; b=HUmb2PqAsedweRSbfW5Ertd7T3qAtuOFlWTdNkVsAfvUz3Yi7iURE4s4VZAoxinB1HKNWQUmho9UjJmJkHIogARtYlrZNfYY9x1eZScZ3ekNUaaajb0iZVO39gpLhnsttEkvX9Rr1jEd3gHTRwv+HAyVfRTwTK0/bqLEQa8h5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732473468; c=relaxed/simple;
	bh=n0WOv8S+fsUK51CYXilb+SqNDRIpcD0NoUp+KWowj+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gdmh1Gf2m74NeNCWoewJEc5QVPWd8GepEASORfegby9j/nudsnVkqaAvLjz8hi9abt0JIRb0UqBdzJSG/Fg4LJYvs2zOGpECFwT3VyQkGg+kwarobbY1U415Z6uuDSt4UOcQvc3LkTZputd7fb3f2OigbjfEc6Er3nshq1zat/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UP+IVKTv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A1+pVZ914l8PLvs8MX78kndBXnycxx2yVqnECs3WAPs=; b=UP+IVKTvNYLMJjhShlBTAzuZTk
	H6qcjf63NJqMDmk3TE2xGwbKklvIwAOFgnrTahTJ2c/lOpmklLb5W7cg8vDxrUOD7zN4fUehwO1o7
	gLXJLcRNnc68s07CPABVP++KksScWyhBg4x6bYoS5oaDWeHhhyrLYR7nbxudxQEo5rnCKzQDdO3NC
	6pQhzkc3xvaRWorPooT2PE0vEVbI81hChFEmri3dmXG00vD2nP9eit9GJdY6wwxas11IFG60aXFQP
	cx9/iQWwUGkgXcD0r7GREu4g2ZeLYzZx/lEEyBoUSXvRLVGUHN0xE+AR5hJJMKxz1yTzHZqoXxod4
	BBef43+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFHUO-00000001Hos-02zo;
	Sun, 24 Nov 2024 18:37:44 +0000
Date: Sun, 24 Nov 2024 18:37:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/26] smb: avoid pointless cred reference count bump
Message-ID: <20241124183743.GX3387508@ZenIV>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-21-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-work-cred-v1-21-f352241c3970@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 24, 2024 at 02:44:07PM +0100, Christian Brauner wrote:
> No need for the extra reference count bump.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/smb/server/smb_common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> index f1d770a214c8b2c7d7dd4083ef57c7130bbce52c..a3f96804f84f03c22376769dffdf60cd66f5e3d2 100644
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -780,7 +780,7 @@ int __ksmbd_override_fsids(struct ksmbd_work *work,
>  		cred->cap_effective = cap_drop_fs_set(cred->cap_effective);
>  
>  	WARN_ON(work->saved_cred);
> -	work->saved_cred = override_creds(get_new_cred(cred));
> +	work->saved_cred = override_creds(cred);
>  	if (!work->saved_cred) {
>  		abort_creds(cred);
>  		return -EINVAL;

Won't that leave a dangling pointer?

