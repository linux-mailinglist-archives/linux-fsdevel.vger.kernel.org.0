Return-Path: <linux-fsdevel+bounces-9797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F70F844FA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6ED296123
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789CD3A8E4;
	Thu,  1 Feb 2024 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9HIfgrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3D3A8C1;
	Thu,  1 Feb 2024 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757875; cv=none; b=mCGDnFME1R837WZzlQSONds1EUvAizfByp0vX58WWdnEScpxAFI4uen1XM74InAPX9Kvikk4q6JXrzMImTWHWvpRg8uw8OFq7MpjuJIye7pcOzQfqJOPVzVPmYrM0i0b3Z7hKPqJT5Z2HEhJnX6epvaE7GOJz6hqVxPPXBwbpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757875; c=relaxed/simple;
	bh=gc4v17wSZ6Qjqbp/jjpPvy6HAXY8q3i8CoEzcQx+p5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqK0l73o2pxSEIJfuqymDMle1oc46XOf1yHMFi1ZFUUU9PGKwEkl2aUa3cMKv7VyBvBydtGwNMNdbWVnc6+T0A6jfJoDz83gCEj7HPwYAdKSgqkUgGyqPXLoxDxuH4BN+x3bV0MnDHLJ76C/jRQbpF/xK3mKkLfmnHm6IijaNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9HIfgrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B2DC433C7;
	Thu,  1 Feb 2024 03:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706757875;
	bh=gc4v17wSZ6Qjqbp/jjpPvy6HAXY8q3i8CoEzcQx+p5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9HIfgrjQN4UNK2O52IcyksmHgjKicwwypq6hTILIRCeBTVo7SGVmoVgOQMPmzZkL
	 Vqi/r9+whLWGODUxnvUCkEnpq3Q6a5RG5LRgFd+xpXosOJk1TC+3r3u+sBAq7gmN0G
	 8zOOYrgD2uypAEsiGN4DBstHrpzMXul2JLcMIY2swDh4zdE2SQUW4kIHcv2MR21U8d
	 HvgerTiSlDB1DNZorlBKtkOFUwfuKZ1utk5FzYoMeWDl8TdAnmAZILJYVNOxn3fwJv
	 GfXv1vIfQc0feHnLFvYA2nDWxczw6BO30AknTWTP3XK1cJPHf2v4mW2E1Jv4zbN45a
	 QuXYf6lmq0Fiw==
Date: Wed, 31 Jan 2024 19:24:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] fscrypt: Drop d_revalidate for valid dentries
 during lookup
Message-ID: <20240201032433.GB1526@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-5-krisman@suse.de>
 <20240131004724.GC2020@sol.localdomain>
 <871q9x2vwj.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9x2vwj.fsf@mailhost.krisman.be>

On Wed, Jan 31, 2024 at 03:35:40PM -0300, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Mon, Jan 29, 2024 at 05:43:22PM -0300, Gabriel Krisman Bertazi wrote:
> >> Unencrypted and encrypted-dentries where the key is available don't need
> >> to be revalidated with regards to fscrypt, since they don't go stale
> >> from under VFS and the key cannot be removed for the encrypted case
> >> without evicting the dentry.  Mark them with d_set_always_valid, to
> >
> > "d_set_always_valid" doesn't appear in the diff itself.
> >
> >> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> >> index 4aaf847955c0..a22997b9f35c 100644
> >> --- a/include/linux/fscrypt.h
> >> +++ b/include/linux/fscrypt.h
> >> @@ -942,11 +942,22 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
> >>  static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
> >>  						 bool is_nokey_name)
> >>  {
> >> -	if (is_nokey_name) {
> >> -		spin_lock(&dentry->d_lock);
> >> +	spin_lock(&dentry->d_lock);
> >> +
> >> +	if (is_nokey_name)
> >>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
> >> -		spin_unlock(&dentry->d_lock);
> >> +	else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
> >> +		 dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
> >> +		/*
> >> +		 * Unencrypted dentries and encrypted dentries where the
> >> +		 * key is available are always valid from fscrypt
> >> +		 * perspective. Avoid the cost of calling
> >> +		 * fscrypt_d_revalidate unnecessarily.
> >> +		 */
> >> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
> >>  	}
> >> +
> >> +	spin_unlock(&dentry->d_lock);
> >
> > This makes lookups in unencrypted directories start doing the
> > spin_lock/spin_unlock pair.  Is that really necessary?
> >
> > These changes also make the inline function fscrypt_prepare_lookup() very long
> > (when including the fscrypt_prepare_lookup_dentry() that's inlined into it).
> > The rule that I'm trying to follow is that to the extent that the fscrypt helper
> > functions are inlined, the inline part should be a fast path for unencrypted
> > directories.  Encrypted directories should be handled out-of-line.
> >
> > So looking at the original fscrypt_prepare_lookup():
> >
> > 	static inline int fscrypt_prepare_lookup(struct inode *dir,
> > 						 struct dentry *dentry,
> > 						 struct fscrypt_name *fname)
> > 	{
> > 		if (IS_ENCRYPTED(dir))
> > 			return __fscrypt_prepare_lookup(dir, dentry, fname);
> >
> > 		memset(fname, 0, sizeof(*fname));
> > 		fname->usr_fname = &dentry->d_name;
> > 		fname->disk_name.name = (unsigned char *)dentry->d_name.name;
> > 		fname->disk_name.len = dentry->d_name.len;
> > 		return 0;
> > 	}
> >
> > If you could just add the DCACHE_OP_REVALIDATE clearing for dentries in
> > unencrypted directories just before the "return 0;", hopefully without the
> > spinlock, that would be good.  Yes, that does mean that
> > __fscrypt_prepare_lookup() will have to handle it too, for the case of dentries
> > in encrypted directories, but that seems okay.
> 
> ok, will do.  IIUC, we might be able to do without the d_lock
> provided there is no store tearing.
> 
> But what was the reason you need the d_lock to set DCACHE_NOKEY_NAME
> during lookup?  Is there a race with parallel lookup setting d_flag that
> I couldn't find? Or is it another reason?

d_flags is documented to be protected by d_lock.  So for setting
DCACHE_NOKEY_NAME, fs/crypto/ just does the safe thing of taking d_lock.  I
never really looked into whether the lock can be skipped there (i.e., whether
anything else can change d_flags while ->lookup is running), since this code
only ran for no-key names, for which performance isn't really important.

This patch would extend that locking to a new context in which it would be
executed several orders of magnitude more often.  So, making sure it's properly
optimized becomes more important.  It looks like it *might* be the case that
->lookup has exclusive access to d_flags, by virtue of having allocated the
dentry, so I'm just wondering if we can take advantage of that (or whether in
classic VFS fashion there's some edge case where that assumption is wrong).

- Eric

