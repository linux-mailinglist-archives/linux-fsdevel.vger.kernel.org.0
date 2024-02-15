Return-Path: <linux-fsdevel+bounces-11627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B92855851
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 01:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493B01C22CB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 00:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BEAED9;
	Thu, 15 Feb 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv/HFUun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922A383;
	Thu, 15 Feb 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957108; cv=none; b=ZITgFw53i+pwh60isKrFumJjdCKUzlYSG6dqs70LsgOIu74vwnLJ9JHpyzwbGfpXJTfRyTXf01x+a27z3hDtUG1LmtMIoXU4MVwFDvScPdR9QWW7UONtwSIwR9dgxwV3dMBqNjdj3Mry1/rjEC7JLbOqu3Cjzo4QKVcT1KVZ4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957108; c=relaxed/simple;
	bh=ESmguzP9p5Vb3BIlWMztnff8iFe4Ik5fJ9lnfbBSnVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztxnt/G8/2oi2TbDPdXQ6dhOJXCP1YHcc83Imc6sE5ieqYbHZ4MAQ9EkdDhUicphobyW4ER7V0XYBGFmvOX8s1TJ613aw7dZuvx7jDYtGFdlh5BfOW5CTKzxMHPF9Bdj70Np0QCY8+GJTw+BQe6dfy8Wy/BL4jBxRCja8sjm8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv/HFUun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EC8C433C7;
	Thu, 15 Feb 2024 00:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707957107;
	bh=ESmguzP9p5Vb3BIlWMztnff8iFe4Ik5fJ9lnfbBSnVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bv/HFUunSaRB22PFp19/BYYmt9hml0jZfI6CdYPDndHjPVVN2GKlV0ui2tbV/H7K0
	 1kGNM22DNhFN9oFGOMEdzzaBsG61upFSppIE4Cv7v16legfIqzSsrRVw/Y2ttXqZaf
	 gDcKPuVOL21Xio1umjYuf/ZryFcpAsbb3SMhOSg4CE20vFugZvF9V4nJ+mteUuy+oX
	 i4rZWdpzS8DOvssG1jPYFrWNcH5Qt8W+ky0SBdvWaqwXFYA2U57UHaY8ywmuVjvVFT
	 G/u8/Gg3GMpVrOMIv2Eg1TWXEGt4FvlxrwhIhjL7IlRS8AanN1ywg6LcMoAFFk0zKy
	 xXekXDgmjDUkw==
Date: Wed, 14 Feb 2024 16:31:45 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v6 04/10] fscrypt: Drop d_revalidate once the key is added
Message-ID: <20240215003145.GK1638@sol.localdomain>
References: <20240213021321.1804-1-krisman@suse.de>
 <20240213021321.1804-5-krisman@suse.de>
 <20240215001631.GI1638@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215001631.GI1638@sol.localdomain>

On Wed, Feb 14, 2024 at 04:16:31PM -0800, Eric Biggers wrote:
> On Mon, Feb 12, 2024 at 09:13:15PM -0500, Gabriel Krisman Bertazi wrote:
> > From fscrypt perspective, once the key is available, the dentry will
> > remain valid until evicted for other reasons, since keyed dentries don't
> > require revalidation and, if the key is removed, the dentry is
> > forcefully evicted.  Therefore, we don't need to keep revalidating them
> > repeatedly.
> > 
> > Obviously, we can only do this if fscrypt is the only thing requiring
> > revalidation for a dentry.  For this reason, we only disable
> > d_revalidate if the .d_revalidate hook is fscrypt_d_revalidate itself.
> > 
> > It is safe to do it here because when moving the dentry to the
> > plain-text version, we are holding the d_lock.  We might race with a
> > concurrent RCU lookup but this is harmless because, at worst, we will
> > get an extra d_revalidate on the keyed dentry, which is will find the
> > dentry is valid.
> > 
> > Finally, now that we do more than just clear the DCACHE_NOKEY_NAME in
> > fscrypt_handle_d_move, skip it entirely for plaintext dentries, to avoid
> > extra costs.
> > 
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> 
> I think this explanation misses an important point, which is that it's only
> *directories* where a no-key dentry can become the regular dentry.  The VFS does
> the move because it only allows one dentry to exist per directory.
> 
> For nondirectories, the dentries don't get reused and this patch is irrelevant.
> 
> (Of course, there's no point in making fscrypt_handle_d_move() check whether the
> dentry is a directory, since checking DCACHE_NOKEY_NAME is sufficient.)
> 
> The diff itself looks good -- thanks.
> 

Also, do I understand correctly that this patch is a performance optimization,
not preventing a performance regression?  The similar patch that precedes this
one, "fscrypt: Drop d_revalidate for valid dentries during lookup", is about
preventing a performance regression on dentries that aren't no-key.  This patch
looks deceptively similar, but it only affects no-key directory dentries, which
we were already doing the fscrypt_d_revalidate for, even after the move to the
plaintext name.  It's probably still a worthwhile optimization to stop doing the
fscrypt_d_revalidate when a directory dentry gets moved like that.  But I want
to make sure I'm correctly understanding each patch.

- Eric

