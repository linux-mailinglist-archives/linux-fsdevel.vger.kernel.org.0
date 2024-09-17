Return-Path: <linux-fsdevel+bounces-29549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7997ABA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 08:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFAD1C2795F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 06:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2724F13698F;
	Tue, 17 Sep 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="UlY6F3xS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782572C18C;
	Tue, 17 Sep 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555737; cv=none; b=SOvNIDNAZWq9IGL7+82dV1HQUxzT74QmUa7liwc7Z+2rGZ9R/rpgS7JoVCDLZEketNljzwv/dQgA/zeiTrl6YdtNzCr4CVsbE491IBUwjS09voY/DVmYXBOUxBDW7cs6PJUEjmGe7mUju7torim0u/Eee7oiDTjH3nueSPAUUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555737; c=relaxed/simple;
	bh=OYVZS+5ii4rthOIBolFOAKAKlPprVk5AYLDFcTQvth0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvLmi4PDeHp/iu1qmoR5tuaZziMLnFlksw8DZxtyoPNYCTDC+6RCNAAAMD0cPXnSK+sUM/+xLFrHOgxOi6kKr83t0nmKcpyKe0w2v7sRPt5JLe83GnTmk0oWS+IvzWRKlfQhWzE8SuQTpfRapcvzxTFYZFvF/RHJXftHCY5DoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=UlY6F3xS; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6049697D1;
	Tue, 17 Sep 2024 02:48:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726555733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Vun4PO28i0mmsLNX3QTNk55JwdaRwjIisdNr9s6W8dM=;
	b=UlY6F3xSPENoOScyRvJyD/lb0LsHJnxP5PAj9oQJksih2Zy6kPXaVqlKOm/6Sc1GlxgcGR
	L/C87vKY8I77AVCk5ZD9ejeV607hMzhOophmgBaKEzP0C+89UcflczYE93rvW6Kr/G30Hs
	TLJGlqNuVHEgfxQoPgIIT8w68akuSPcQgYJXDVxir0fcm6XnwTL2nwymyrbcbV1kojHjfL
	wGSyh+3y5eSrgXaB2SkZaUMuWDCPTeZoZ9sxvFYtwAzajUGlr8tuN+1k0LCH3+8qbHw9PW
	0CDSA1RbYQ73J9Xgm4THjv/dUb91fAq3A2Mqo5G6nZcAVdQEva6kCG74xXmpEQ==
Date: Tue, 17 Sep 2024 14:48:34 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
 <20240916170801.GO2825852@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916170801.GO2825852@ZenIV>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 16, 2024 at 06:08:01PM GMT, Al Viro wrote:
> On Mon, Sep 16, 2024 at 09:56:29PM +0800, Yiyang Wu wrote:
> > +/// Lookup function for dentry-inode lookup replacement.
> > +#[no_mangle]
> > +pub unsafe extern "C" fn erofs_lookup_rust(
> > +    k_inode: NonNull<inode>,
> > +    dentry: NonNull<dentry>,
> > +    _flags: c_uint,
> > +) -> *mut c_void {
> > +    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
> > +    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
> 
> 	Ummm...  A wrapper would be highly useful.  And the reason why
> it's safe is different - your function is called only via ->i_op->lookup,
> the is only one instance of inode_operations that has that ->lookup
> method, and the only place where an inode gets ->i_op set to that
> is erofs_fill_inode().  Which is always passed erofs_inode::vfs_inode.
> 
So my original intention behind this is that all vfs_inodes come from
that erofs_iget function and it's always gets initialized in this case
And this just followes the same convention here. I can document this
more precisely.
> > +    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
> > +    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
> 
> 	Again, that calls for a wrapper - this time not erofs-specific;
> inode->i_sb is *always* non-NULL, is assign-once and always points
> to live struct super_block instance at least until the call of
> destroy_inode().
>

Will be modified correctly, I'm not a native speaker and I just can't
find a better way, I will take my note here.
> > +    // SAFETY: this is backed by qstr which is c representation of a valid slice.
> 
> 	What is that sentence supposed to mean?  Nevermind "why is it correct"...
> 
> > +    let name = unsafe {
> > +        core::str::from_utf8_unchecked(core::slice::from_raw_parts(
> > +            dentry.as_ref().d_name.name,
> > +            dentry.as_ref().d_name.__bindgen_anon_1.__bindgen_anon_1.len as usize,
> 
> 	Is that supposed to be an example of idiomatic Rust?  I'm not
> trying to be snide, but my interest here is mostly about safety of
> access to VFS data structures.	And ->d_name is _very_ unpleasant in
> that respect; the locking rules required for its stability are subtle
> and hard to verify on manual code audit.
> 
Yeah, this code is pretty messed up. I just cannot find a better
way to use this qstr in dentry. So the original C qstr is this.

```c
struct qstr {
	union {
		struct {
			HASH_LEN_DECLARE;
		};
		u64 hash_len;
	};
	const unsigned char *name;
};

```
The original C code can use this pretty easily.

```C
int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
		unsigned int *d_type)
{
	int ndirents;
	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
	struct erofs_dirent *de;
	struct erofs_qstr qn;

	if (!dir->i_size)
		return -ENOENT;

	qn.name = name->name;
	qn.end = name->name + name->len;
	buf.mapping = dir->i_mapping;

```

But after bindgen, since Rust does not support any kinds of anonymous
unions here it just converts to this.

```rust
#[repr(C)]
#[derive(Copy, Clone)]
pub struct qstr {
    pub __bindgen_anon_1: qstr__bindgen_ty_1,
    pub name: *const core::ffi::c_uchar,
}

#[repr(C)]
#[derive(Copy, Clone)]
pub union qstr__bindgen_ty_1 {
    pub __bindgen_anon_1: qstr__bindgen_ty_1__bindgen_ty_1,
    pub hash_len: u64_,
}

```
And it just somehow degrades to this pure mess. :(
I know this is stupid :(

> 	Current erofs_lookup() (and your version as well) *is* indeed
> safe in that respect, but the proof (from filesystem POV) is that "it's
> called only as ->lookup() instance, so dentry is initially unhashed
> negative and will remain such until it's passed to d_splice_alias();
> until that point it is guaranteed to have ->d_name and ->d_parent stable".
> 
> 	Note that once you _have_ called d_splice_alias(), you can't
> count upon the ->d_name stability - or, indeed, upon ->d_name.name you've
> sampled still pointing to allocated memory.
> 
> 	For directory-modifying methods it's "stable, since parent is held
> exclusive".  Some internal function called from different environments?
> Well...  Swear, look through the call graph and see what can be proven
> for each.

Sorry for my ignorance.
I mean i just borrowed the code from the fs/erofs/namei.c and i directly
translated that into Rust code. That might be a problem that also
exists in original working C code.

> 	Expressing that kind of fun in any kind of annotations (Rust type
> system included) is not pleasant.  _Probably_ might be handled by a type
> that would be a dentry pointer with annotation along the lines "->d_name
> and ->d_parent of that one are stable".  Then e.g. ->lookup() would
> take that thing as an argument and d_splice_alias() would consume it.
> ->mkdir() would get the same thing, etc.  I hadn't tried to get that
> all way through (the amount of annotation churn in existing filesystems
> would be high and hard to split into reviewable patch series), so there
> might be dragons - and there definitely are places where the stability is
> proven in different ways (e.g. if dentry->d_lock is held, we have the damn
> thing stable; then there's a "take a safe snapshot of name" API; etc.).

That's kinda interesting, I originally thought that VFS will make sure
its d_name / d_parent is stable in the first place.
Again, I just don't have a full picture or understanding of VFS and my
code is just basic translation of original C code, Maybe we can address
this later.

> 	I want to reduce the PITA of regular code audits.  If, at
> some point, Rust use in parts of the tree reduces that - wonderful.
> But then we'd better make sure that Rust-side uses _are_ safe, accurately
> annotated and easy to grep for.

Yeah, even a small portion of VFS gets abstracted can get things work
smoothly, like inode and dentry data structure. From my understanding
Rust can make some of stability issues you have mentioned
compilation errors if it's correctly annotated.

> Because we'll almost certainly need to
> change method calling conventions at some points through all of that.
> Even if it's just the annotation-level, any such contract change (it
> is doable and quite a few had been done) will require going through
> the instances and checking how much massage will be needed in those.
> Opaque chunks like the above promise to make that very painful...

Certainly needs a lot of energy and efforts.
WE just need a guy who has full grasp of a lot of filesystems and Rust
to solve this stuff altogether to avoid the abstraction degraded
into some toy concepts.

