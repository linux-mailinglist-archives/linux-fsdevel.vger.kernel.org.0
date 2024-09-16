Return-Path: <linux-fsdevel+bounces-29518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470E97A672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E42837FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A615A865;
	Mon, 16 Sep 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JIdHZtnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90710A18;
	Mon, 16 Sep 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506486; cv=none; b=d2W/vFq7fAXpaqTPq5VSDG+WEDlI+arDT9rD5MuMCsQxJM7Ox6mhvv7dJXJkSHJBCGgnscyeAikJPyVSWBuAgyhCg1x7No7fzW/CeEiLjx+ORx26pA4U+fC5gp27vHJf7+aUrI5iuUskMqwo5qz6OcR4T11NSrMvf1Xmn/Ao9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506486; c=relaxed/simple;
	bh=1dZjd/ClL+1MJKVM0HnPeVDjPRfg9BFy88++S3/i9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LadSmoOFMF1Gl0ji/3MpR9dMEMNcrAxTxse2MISAHQ0lTTVrvyn8qOTVao7l6gVoBzMhInO4DqNx9Zzy2gJLLzKH+Uos4SOG2XFsvZ0CCdCeUxOoKHQkQ5zzL3hODAkBBSb/9mEXv/D8vZSX6bW5mcDjaWLzLMFv+OFEZWB8QeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JIdHZtnl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e/xlYRrSDit/b/g6M8c4bdxRyyK3CLNhHmufMU5+ieg=; b=JIdHZtnlwMLdbu7oYdbKGigkqw
	4s1ccsqYW4bnNBcYLSY3BZe0ZJ/kopW5iM2sTrVkXUF4UDsORvVSyYpnLSmQ36LavMlQVljMR/wcI
	PTej5tPu6Wgrs4U9MAze6XiUffWeoCpMikl6Gb1WmMj7wnMT2+YRtvBlyxNXJ5PwGkvMnpTA7ANMy
	93i7Je6/dfBFOtYGaaH48RIaVYTAX0exIEWJ6uddRxIBvbFgY23MynS5G8/GiIjqmJLWI+xNnVWsW
	Gs+rASaVBVMMkqN16nKduyt0D447xA575Ab1H4OZQ+kITSZzADlYgmlyKhNtsHnOYGSbhZWXBKqjn
	JzzcFJ2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqFCj-0000000D14P-0QWH;
	Mon, 16 Sep 2024 17:08:01 +0000
Date: Mon, 16 Sep 2024 18:08:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <20240916170801.GO2825852@ZenIV>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135634.98554-20-toolmanp@tlmp.cc>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 16, 2024 at 09:56:29PM +0800, Yiyang Wu wrote:
> +/// Lookup function for dentry-inode lookup replacement.
> +#[no_mangle]
> +pub unsafe extern "C" fn erofs_lookup_rust(
> +    k_inode: NonNull<inode>,
> +    dentry: NonNull<dentry>,
> +    _flags: c_uint,
> +) -> *mut c_void {
> +    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
> +    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };

	Ummm...  A wrapper would be highly useful.  And the reason why
it's safe is different - your function is called only via ->i_op->lookup,
the is only one instance of inode_operations that has that ->lookup
method, and the only place where an inode gets ->i_op set to that
is erofs_fill_inode().  Which is always passed erofs_inode::vfs_inode.

> +    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
> +    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });

	Again, that calls for a wrapper - this time not erofs-specific;
inode->i_sb is *always* non-NULL, is assign-once and always points
to live struct super_block instance at least until the call of
destroy_inode().

> +    // SAFETY: this is backed by qstr which is c representation of a valid slice.

	What is that sentence supposed to mean?  Nevermind "why is it correct"...

> +    let name = unsafe {
> +        core::str::from_utf8_unchecked(core::slice::from_raw_parts(
> +            dentry.as_ref().d_name.name,
> +            dentry.as_ref().d_name.__bindgen_anon_1.__bindgen_anon_1.len as usize,

	Is that supposed to be an example of idiomatic Rust?  I'm not
trying to be snide, but my interest here is mostly about safety of
access to VFS data structures.	And ->d_name is _very_ unpleasant in
that respect; the locking rules required for its stability are subtle
and hard to verify on manual code audit.

	Current erofs_lookup() (and your version as well) *is* indeed
safe in that respect, but the proof (from filesystem POV) is that "it's
called only as ->lookup() instance, so dentry is initially unhashed
negative and will remain such until it's passed to d_splice_alias();
until that point it is guaranteed to have ->d_name and ->d_parent stable".

	Note that once you _have_ called d_splice_alias(), you can't
count upon the ->d_name stability - or, indeed, upon ->d_name.name you've
sampled still pointing to allocated memory.

	For directory-modifying methods it's "stable, since parent is held
exclusive".  Some internal function called from different environments?
Well...  Swear, look through the call graph and see what can be proven
for each.

	Expressing that kind of fun in any kind of annotations (Rust type
system included) is not pleasant.  _Probably_ might be handled by a type
that would be a dentry pointer with annotation along the lines "->d_name
and ->d_parent of that one are stable".  Then e.g. ->lookup() would
take that thing as an argument and d_splice_alias() would consume it.
->mkdir() would get the same thing, etc.  I hadn't tried to get that
all way through (the amount of annotation churn in existing filesystems
would be high and hard to split into reviewable patch series), so there
might be dragons - and there definitely are places where the stability is
proven in different ways (e.g. if dentry->d_lock is held, we have the damn
thing stable; then there's a "take a safe snapshot of name" API; etc.).

	I want to reduce the PITA of regular code audits.  If, at
some point, Rust use in parts of the tree reduces that - wonderful.
But then we'd better make sure that Rust-side uses _are_ safe, accurately
annotated and easy to grep for.  Because we'll almost certainly need to
change method calling conventions at some points through all of that.
Even if it's just the annotation-level, any such contract change (it
is doable and quite a few had been done) will require going through
the instances and checking how much massage will be needed in those.
Opaque chunks like the above promise to make that very painful...

