Return-Path: <linux-fsdevel+bounces-42395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B9A41B4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401BD1892321
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C49A253B6D;
	Mon, 24 Feb 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF/13JyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978C2505CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393352; cv=none; b=rPZc0VglzIWj2kXnWYbtswfEoANpKHRFZYzj5PTrzjXFJi7zBkwM0Iy5G2a88QpAOW4LhwdVjlbsoAyawVJNqaDYP/23ttHkiIZjBmF3M3QR/4w4ZQE67zFRslDaFWL6P51E73pnkEpP+hWEHpk+DWEsNM6nyRVdmSdykcK2pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393352; c=relaxed/simple;
	bh=ifNOc3u5PITW4T8IfWVSO41TY53mSTx2VUjwhhIO0A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL8GGE3R1IfQQTgbeJk0Ydfr36zkpo/1e3Ql8XkEGXY9rnGai1XqFCdd5Ad6EEOgLpFJJcHRnfAQn8sa7W6+SNOTO69rWnOND+dNivbpHTMeQJvPldM741CF4MJ3Lilk9HQ5mdQ75lKAdCcp6vipcp5IEXYccw+oWExGeSp4Ck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF/13JyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69EFC4CED6;
	Mon, 24 Feb 2025 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740393351;
	bh=ifNOc3u5PITW4T8IfWVSO41TY53mSTx2VUjwhhIO0A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KF/13JyNLPtWW6SOe6k2DNsvVAio6MxxS8/CZi+GgCQ7E/s79Pir5Tc3Vn1sDgaOu
	 BqSFiBPyL6kJc4iDtqohH9/b48QgBC7CIz7wJz3+MCxO9MmAh9dFSUSmyPJsDvWs2U
	 TsG4Z23T3NNK1fwP2DjyDA8BPhkKGaq/N+umLLCC+AKr4JVo3+L26Gp1L99+yRZchW
	 miRzNBm9w6lsr2rCq9E7UsaNMXRlLFTOx7Q5Y4F9TpBiq/xNKmCDVzdnbyXrSG4Peb
	 v1DLIG2YXgdt7TNT9HRuYfMZD0hpATC+7CoOuzWPOaljYu5OTWHzohweXlw0uniDYa
	 5SEL5fEPgYPtQ==
Date: Mon, 24 Feb 2025 11:35:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC] dentry->d_flags locking
Message-ID: <20250224-attribut-singen-e29c9a49ee56@brauner>
References: <20250224010624.GT1977892@ZenIV>
 <20250224013844.GU1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224013844.GU1977892@ZenIV>

On Mon, Feb 24, 2025 at 01:38:44AM +0000, Al Viro wrote:
> On Mon, Feb 24, 2025 at 01:06:24AM +0000, Al Viro wrote:
> 
> > PS: turns out that set_default_d_op() is slightly more interesting
> > than I expected - fuse has separate dentry_operations for its
> > root dentry.  I don't see the point, TBH - the only difference is
> > that root one lacks
> > 	* ->d_delete() (never even called for root dentry; it's
> > only called if d_unhashed() is false)
> > 	* ->d_revalidate() (never called for root)
> > 	* ->d_automount() (not even looked at unless you have
> > S_AUTOMOUNT set on the inode).
> > What's wrong with using fuse_dentry_operations for root dentry?
> > Am I missing something subtle here?  Miklos?
> 
> Speaking of fun questions - does pidfs_dentry_operations need
> ->d_delete()?  I mean, it's not even called for unhashed
> dentries and AFAICS there's no way for those to be hashed...
> The same goes for all filesystems created by init_pseudo().
> 
> Is there any reason to have that in pidfs_dentry_operations and
> ns_dentry_operations?
> 
> I think nsfs is my sloppiness back then - original commit message
> explicitly says that neither dentries nor inodes in that thing
> are ever hashed, so ->d_delete() had been clearly pointless
> from the very beginning.
> 
> Christian, pidfs looks like it just had copied that from nsfs.
> Is there something subtle about pidfs that makes ->d_delete()
> needed there?

No, I don't think so. I put patches on top of vfs.fixes that remove it
for both pidfs and nsfs. Thanks!

The fact that hashing a dentry happens during lookup and that I didn't
even have to think about lookup for pidfs and nsfs because they don't
matter probably just led to carrying this over for pidfs.

I think it would be worthwhile to mark dentries of such filesystems as
always unhashed and then add an assert into fs/dcache.c whenever such a
dentry should suddenly become hashed.

That would not just make it very easy to see for the reviewer that the
dentries of this filesystem are always unhashed it would also make it
possible to spot bugs.

