Return-Path: <linux-fsdevel+bounces-8670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8E83A05B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A476E1F2B62F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 04:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF9BE56;
	Wed, 24 Jan 2024 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/7J4RQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6D6FBB;
	Wed, 24 Jan 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706069285; cv=none; b=noBZ1eRmZYOPhJYsa4/U6dT7DG0GcXukCXWxY9XAevicRqMpsjo0coRb/zeMUocZ0NH2iEYm1cYgEV2ob4fVkTXQtW8WEqfV2NRS2asKy9L7ILqCrR31M5tsK5sgJn6l4jr3QxwPvt9AH2EK8SrCh+B8gHWop+fOt7Bx387jnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706069285; c=relaxed/simple;
	bh=3tox/uEhsKouIoVIME/v+sodPqUeCUanlm9NhtTwtbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paUDK3gp52p7V3kgByNSRSzGqG89P33bsYMs2L4a/x4nGEkgCD33ITp1PnjpB3ibGB2iQccXBMRlTdIHm89aCJ56I59Lu3gcxYSTfR7w8q49JvE2Eh3w7OYzIu3IKRnTeMEQ0OPHwYTeuTUEyQYnjaJjKsHa/MPx0WrU/ypwDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/7J4RQ6; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0ed26cc5eso1848552a34.3;
        Tue, 23 Jan 2024 20:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706069283; x=1706674083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14aE2Tmym6RO54bNuO9D8gn1sfqeYbO+xQ1GDkk8bAo=;
        b=A/7J4RQ6vYTI3VR1pj0dRnHfimo6QZms4u7jLElVIP6D53ew9HNHVc1MPeL5rBI69w
         i3gnUyLN2BJpnUXmmOhS7D3S1+OgmI5sOpVEofYe77rr1XfLhs6ToEE8Ja9b/LvnKEHm
         uWJE5bFsWmdE8T36RRTAAjuWxK92wyOIYAljY8J3fyNDWOXaYq4FIEeqNqC+5mJmrcYB
         9dsVoAdVJOyjDYXYkLsgU8hDl/TrLDzEsxr0BXNA12r7koNzOHD9zLbxpn8hE3eDZrZo
         p2aMzj/yYTaSQNzplWDmZcz7EfX5CVXFeq1JG0hXVi/ukJHJUgMDpfd0qOl4VJo3oUMp
         IQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706069283; x=1706674083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14aE2Tmym6RO54bNuO9D8gn1sfqeYbO+xQ1GDkk8bAo=;
        b=JYacTuYIQz+MQ1MnYUpWplUSCcAqLtlMRq8tlUw5PCN/o8tq6omv424TIacVp6Jscg
         AqNxoEtwox3wv788Kxswm0ZXRt2XLclvzMDyl9J7my0cLlqvyzxW2QAGy2gVjiqGQOWZ
         CkBEESilPvGLemUlMC9Gty/5zWpFEbg/JT3UftVItvrKG85xohMDMeKdKlYxZzV4yyq6
         4IBYPuWsOPf+r8TJweKxFV/Bl7tzSdu2gxUkqn0HRcbmYG2M4pZl9Bqnd4aABVhNQ7D0
         SqtKDjOC2UWu2luItqTEiM/hdcjvhTRZLjGLqTwb5lbNcX6VVn8z5pkYd3l9TNeUUsDj
         uQSA==
X-Gm-Message-State: AOJu0Yzo+cHJM2pOPBom9wNzC3BN64kbuYW9YvUiecnerUKQzrD10E2r
	GjKv5EB42+0lkQk0qZcLUOZn0rtlCroRn7RDK2n0DX3EFm7y2jfi
X-Google-Smtp-Source: AGHT+IFxCYVTtETsoeoDMgiufoL8+xyL0MK1A2rE2RoCwPva+b6nDth80HSuE6Ys6HC5mjjKBRLwnw==
X-Received: by 2002:a9d:3e14:0:b0:6e0:efaa:4e6e with SMTP id a20-20020a9d3e14000000b006e0efaa4e6emr1010274otd.50.1706069282622;
        Tue, 23 Jan 2024 20:08:02 -0800 (PST)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id y3-20020a62ce03000000b006dd844e7c2bsm1336871pfg.171.2024.01.23.20.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 20:08:02 -0800 (PST)
Date: Wed, 24 Jan 2024 01:07:54 -0300
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <ZbCNGkyuYBwkWIEq@wedsonaf-dev>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
 <87o7e25v2z.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7e25v2z.fsf@metaspace.dk>

On Wed, Jan 03, 2024 at 02:29:33PM +0100, Andreas Hindborg (Samsung) wrote:
> 
> Wedson Almeida Filho <wedsonaf@gmail.com> writes:
> 
> [...]
> 
> >  
> > +/// An inode that is locked and hasn't been initialised yet.
> > +#[repr(transparent)]
> > +pub struct NewINode<T: FileSystem + ?Sized>(ARef<INode<T>>);
> > +
> > +impl<T: FileSystem + ?Sized> NewINode<T> {
> > +    /// Initialises the new inode with the given parameters.
> > +    pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
> > +        // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
> > +        let inode = unsafe { &mut *self.0 .0.get() };
> 
> Perhaps it would make sense with a `UniqueARef` that guarantees
> uniqueness, in line with `alloc::UniqueRc`?

We do have something like that in the kernel crate for Rust-allocated
ref-counted memory, namely, UniqueArc.

But in this case, this is slightly different: the ref-count may be >1, it's just
that the other holders of pointers will refrain from accessing the object (for
some unspecified reason). We do have another case like this for folios. Perhaps
it does make sense to generalise the concept with a type; I'll look into this.

> 
> [...]
> 
> >  
> > +impl<T: FileSystem + ?Sized> SuperBlock<T> {
> > +    /// Tries to get an existing inode or create a new one if it doesn't exist yet.
> > +    pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, NewINode<T>>> {
> > +        // SAFETY: The only initialisation missing from the superblock is the root, and this
> > +        // function is needed to create the root, so it's safe to call it.
> > +        let inode =
> > +            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.get(), ino) }).ok_or(ENOMEM)?;
> 
> I can't parse this safety comment properly.

Fixed in v2.

> > +
> > +        // SAFETY: `inode` is valid for read, but there could be concurrent writers (e.g., if it's
> > +        // an already-initialised inode), so we use `read_volatile` to read its current state.
> > +        let state = unsafe { ptr::read_volatile(ptr::addr_of!((*inode.as_ptr()).i_state)) };
> > +        if state & u64::from(bindings::I_NEW) == 0 {
> > +            // The inode is cached. Just return it.
> > +            //
> > +            // SAFETY: `inode` had its refcount incremented by `iget_locked`; this increment is now
> > +            // owned by `ARef`.
> > +            Ok(Either::Left(unsafe { ARef::from_raw(inode.cast()) }))
> > +        } else {
> > +            // SAFETY: The new inode is valid but not fully initialised yet, so it's ok to create a
> > +            // `NewINode`.
> > +            Ok(Either::Right(NewINode(unsafe {
> > +                ARef::from_raw(inode.cast())
> 
> I would suggest making the destination type explicit for the cast.

Done in v2.

> 
> > +            })))
> > +        }
> > +    }
> > +}
> > +
> >  /// Required superblock parameters.
> >  ///
> >  /// This is returned by implementations of [`FileSystem::super_params`].
> > @@ -215,41 +345,28 @@ impl<T: FileSystem + ?Sized> Tables<T> {
> >              sb.0.s_blocksize = 1 << sb.0.s_blocksize_bits;
> >              sb.0.s_flags |= bindings::SB_RDONLY;
> >  
> > -            // The following is scaffolding code that will be removed in a subsequent patch. It is
> > -            // needed to build a root dentry, otherwise core code will BUG().
> > -            // SAFETY: `sb` is the superblock being initialised, it is valid for read and write.
> > -            let inode = unsafe { bindings::new_inode(&mut sb.0) };
> > -            if inode.is_null() {
> > -                return Err(ENOMEM);
> > -            }
> > -
> > -            // SAFETY: `inode` is valid for write.
> > -            unsafe { bindings::set_nlink(inode, 2) };
> > -
> > -            {
> > -                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
> > -                // safe to mutably dereference it.
> > -                let inode = unsafe { &mut *inode };
> > -                inode.i_ino = 1;
> > -                inode.i_mode = (bindings::S_IFDIR | 0o755) as _;
> > -
> > -                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
> > -                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
> > +            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
> > +            // newly-created (and initialised above) superblock.
> > +            let sb = unsafe { &mut *sb_ptr.cast() };
> 
> Again, I would suggest an explicit destination type for the cast.

Done in v2.

> 
> > +            let root = T::init_root(sb)?;
> >  
> > -                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
> > -                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
> > +            // Reject root inode if it belongs to a different superblock.
> 
> I am curious how this would happen?

If a user mounts two instances of a file system and the implementation allocates
root inodes and swap them before returning. The types will match because they
are the same file system, but they'll have the wrong super-block.

Thanks,
-Wedson

