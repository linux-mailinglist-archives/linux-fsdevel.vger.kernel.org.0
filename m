Return-Path: <linux-fsdevel+bounces-10957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7382984F66E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986F01C25C5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D63665BB6;
	Fri,  9 Feb 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZK5+Ykg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE72E630;
	Fri,  9 Feb 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487411; cv=none; b=pfTGtwe+tLjdZYOa8DdwJd0RxrBZMtCbw6yy3nMadrmOOLy6cSTAckduO08Ae6USYvv57YX0crweHAOnNRNZ3m8QMueJUMCfDgSw7lYJA5iRQevkBYgcy7Un1jzxaK0l4UwxSa5CKb+Rtv62WXDZ0wVZv8Tch/ZeUZwCCblLnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487411; c=relaxed/simple;
	bh=CaJ3SN9Ab0eZrK9li+Kwg+fpoQ9lcd+6mNQpA5nqPcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ochiwYzLutQp9q8iKPgOybsAq+pMYmtlJ6K1jrKT4Kw6BoDd9tnPC03Wpr374fKvhfGYbtb3QZyaBQeFkWiXAoPqGs62fFUDQnly5u+BbsqpyhL48+KMDOnT+DZS7uPtlRn+F1yP0T9U3hyzo/zhHqdQrEVjRyDZ8nqCtaJUkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZK5+Ykg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01261C433F1;
	Fri,  9 Feb 2024 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707487410;
	bh=CaJ3SN9Ab0eZrK9li+Kwg+fpoQ9lcd+6mNQpA5nqPcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZK5+YkgIJugHBsYz+x3Z3QRFKgCVOksZHccfJO5r43c4z/cNBQ7ji+cEAlUj5ciy
	 GbiMCovO/IX4pj1bgqV8p4fJ0sHt4q+uHr1LPvbXmHPKG44uwVBgowtzuCpW/9aHLM
	 27Ycvest5AvTZrOcPwIHhGcICRkKfNvkEO5dZFW/XqaQ1psvOhwA8iyU80wkzpXXOt
	 f53t0lbrVh6D0WADSkMJyJnlvOswz+afinDLBiw17IWb9bVBd7nS0enA+R7hlsSN9K
	 ureytuEK6B/An3oFmEJQjjW8AevizhbC645sClpLYbo9Q6bk4kDL64H4FO/f2Kyjqo
	 FiAL1LTTUnhTA==
Date: Fri, 9 Feb 2024 15:03:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Eric Biggers <ebiggers@kernel.org>, viro@zeniv.linux.org.uk, 
	jaegeuk@kernel.org, tytso@mit.edu, amir73il@gmail.com, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] fscrypt: Drop d_revalidate for valid dentries
 during lookup
Message-ID: <20240209-netto-ungehalten-35cfdd4b6473@brauner>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-5-krisman@suse.de>
 <20240131004724.GC2020@sol.localdomain>
 <871q9x2vwj.fsf@mailhost.krisman.be>
 <20240201032433.GB1526@sol.localdomain>
 <87le82yl7k.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le82yl7k.fsf@mailhost.krisman.be>

On Fri, Feb 02, 2024 at 11:50:07AM -0300, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Wed, Jan 31, 2024 at 03:35:40PM -0300, Gabriel Krisman Bertazi wrote:
> >> Eric Biggers <ebiggers@kernel.org> writes:
> >> 
> >> > On Mon, Jan 29, 2024 at 05:43:22PM -0300, Gabriel Krisman Bertazi wrote:
> >> >> Unencrypted and encrypted-dentries where the key is available don't need
> >> >> to be revalidated with regards to fscrypt, since they don't go stale
> >> >> from under VFS and the key cannot be removed for the encrypted case
> >> >> without evicting the dentry.  Mark them with d_set_always_valid, to
> >> >
> >> > "d_set_always_valid" doesn't appear in the diff itself.
> >> >
> >> >> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> >> >> index 4aaf847955c0..a22997b9f35c 100644
> >> >> --- a/include/linux/fscrypt.h
> >> >> +++ b/include/linux/fscrypt.h
> >> >> @@ -942,11 +942,22 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
> >> >>  static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
> >> >>  						 bool is_nokey_name)
> >> >>  {
> >> >> -	if (is_nokey_name) {
> >> >> -		spin_lock(&dentry->d_lock);
> >> >> +	spin_lock(&dentry->d_lock);
> >> >> +
> >> >> +	if (is_nokey_name)
> >> >>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
> >> >> -		spin_unlock(&dentry->d_lock);
> >> >> +	else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
> >> >> +		 dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
> >> >> +		/*
> >> >> +		 * Unencrypted dentries and encrypted dentries where the
> >> >> +		 * key is available are always valid from fscrypt
> >> >> +		 * perspective. Avoid the cost of calling
> >> >> +		 * fscrypt_d_revalidate unnecessarily.
> >> >> +		 */
> >> >> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
> >> >>  	}
> >> >> +
> >> >> +	spin_unlock(&dentry->d_lock);
> >> >
> >> > This makes lookups in unencrypted directories start doing the
> >> > spin_lock/spin_unlock pair.  Is that really necessary?
> >> >
> >> > These changes also make the inline function fscrypt_prepare_lookup() very long
> >> > (when including the fscrypt_prepare_lookup_dentry() that's inlined into it).
> >> > The rule that I'm trying to follow is that to the extent that the fscrypt helper
> >> > functions are inlined, the inline part should be a fast path for unencrypted
> >> > directories.  Encrypted directories should be handled out-of-line.
> >> >
> >> > So looking at the original fscrypt_prepare_lookup():
> >> >
> >> > 	static inline int fscrypt_prepare_lookup(struct inode *dir,
> >> > 						 struct dentry *dentry,
> >> > 						 struct fscrypt_name *fname)
> >> > 	{
> >> > 		if (IS_ENCRYPTED(dir))
> >> > 			return __fscrypt_prepare_lookup(dir, dentry, fname);
> >> >
> >> > 		memset(fname, 0, sizeof(*fname));
> >> > 		fname->usr_fname = &dentry->d_name;
> >> > 		fname->disk_name.name = (unsigned char *)dentry->d_name.name;
> >> > 		fname->disk_name.len = dentry->d_name.len;
> >> > 		return 0;
> >> > 	}
> >> >
> >> > If you could just add the DCACHE_OP_REVALIDATE clearing for dentries in
> >> > unencrypted directories just before the "return 0;", hopefully without the
> >> > spinlock, that would be good.  Yes, that does mean that
> >> > __fscrypt_prepare_lookup() will have to handle it too, for the case of dentries
> >> > in encrypted directories, but that seems okay.
> >> 
> >> ok, will do.  IIUC, we might be able to do without the d_lock
> >> provided there is no store tearing.
> >> 
> >> But what was the reason you need the d_lock to set DCACHE_NOKEY_NAME
> >> during lookup?  Is there a race with parallel lookup setting d_flag that
> >> I couldn't find? Or is it another reason?
> >
> > d_flags is documented to be protected by d_lock.  So for setting
> > DCACHE_NOKEY_NAME, fs/crypto/ just does the safe thing of taking d_lock.  I
> > never really looked into whether the lock can be skipped there (i.e., whether
> > anything else can change d_flags while ->lookup is running), since this code
> > only ran for no-key names, for which performance isn't really important.
> 
> Yes, I was looking for the actual race that could happen here, and
> couldn't find one. As far as I understand it, the only thing that could
> see the dentry during a lookup would be a parallel lookup, but those
> will be held waiting for completion in d_alloc_parallel, and won't touch
> d_flags.  Currently, right after this code, we call d_set_d_op() in
> generic_set_encrypted_ci_d_ops(), which will happily write d_flags without
> the d_lock. If this is a problem here, we have a problem there.
> 
> What I really don't want to do is keep the lock for DCACHE_NOKEY_NAME,
> but drop it for unsetting DCACHE_OP_REVALIDATE right in the same field,
> without a good reason.  I get the argument that unencrypted
> dentries are a much hotter path and we care more.  But the locking rules
> of ->d_lookup don't change for both cases.

Even if it were to work in this case I don't think it is generally safe
to do. But also, for DCACHE_OP_REVALIDATE afaict this is an
optimization. Why don't you simply accept the raciness, just like fuse
does in fuse_dentry_settime(), check for DCACHE_OP_REVALIDATE locklessly
and only take the lock if that thing is set?

