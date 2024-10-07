Return-Path: <linux-fsdevel+bounces-31256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA7993865
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 22:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C94B2281B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616B21DE3D4;
	Mon,  7 Oct 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJhbyi6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534B1DE8A0
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333461; cv=none; b=mXZxpWGuqWck7LWY5YHA8ZOI/3MoHAgAkt8YV/xFekNNOzbCRTlI1zMG5fHra1um3RolQgT7+SNEKYqufgYKCBzBCZEXHJFj5zIQUivNZ5Vfp/k8Ae0o3K0Su+/zYzNFvb+DIpZTHqYcuatNG8MATwRHnWaXv2OTzjDRdvY0x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333461; c=relaxed/simple;
	bh=Y3xYC+wz5DB+ioeLv98h6nPB0DXqGCfot1aJrQPSDA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnSKULhDCd6OCM8+oA0HEB3BVravMrlYzRWPZBhzB4gJ0ZSn5xtDpnv4zRDB3ECtSQCd4rsFzWDDwxCx4o6tnzQEgriZKvlUAAmK9NrBwocKNOxpfmHwZ4tZIZ8OsY8sppw937T6CLf1nB6jZ24GBYFcS5FgPe9s4B8lWO6jhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJhbyi6p; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86e9db75b9so754084966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728333458; x=1728938258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxfIEmnywXXr2F4fJYOrFGHGu5IS2gv2EOSHZH1isPU=;
        b=IJhbyi6pljJGQ+739uN364uV4CxPZltzwmrzTDEd5sSvO54tjbjr10to3dnNqFQL9Z
         wWWdXEpn4OHfctFQsidXmZpNSnyZ5rb/KtLPcwdl+K11mzcBptWPhk3LmiwOChnNcsES
         Fhw/58CgIHxRHFD03OHca6aEp+wrDBxlVsdvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333458; x=1728938258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxfIEmnywXXr2F4fJYOrFGHGu5IS2gv2EOSHZH1isPU=;
        b=cpBqF8rB4scPnh2Ucm3aHEPVfMkOfUWEjljru4YF5TZbSu2xEifHKMF/9OKtx6diOe
         RYY2Vn59Ubnp6UTeXbiriS8ZmMfQKOygEe7W7tWqDbwk3ocmMLPG1OLiZ9t2Lfy/OWcI
         +JOfmjh6SIoDvLOXccgCdNIjHH1ekLV6AvQksyMXtulrUFkHiVXMQL1nHrZENv1wittA
         9j1U099XAGWdTT1/9oqwAbVJ9y3B2yUWDMgQqHD3M+5LEZVAcIylbKEiKpqwHBnWhvrf
         VSgcbOqV44Z6mTm15khegQGtIpYc9po+yx5h3D9b35GiLc96VeAwq5PK3MReYAmtTW4P
         HdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+XGvUqKab4lxHB2YJHTxU5lBlJsQeZaRj74JwiAHUM37dmhvC9gfHh4WniiE4BSE0mfbsNaqJlnlaRPsg@vger.kernel.org
X-Gm-Message-State: AOJu0YyULQd1qsoooOrh8Je7oLev2Jp1qOkaQpwZMPDtyhIJBrngdLVW
	cJ5UYjvPq5uOXaf/xT6YXX1xCcANSCwx0JAEN81jnht2/82/5SlK21x0Xrm5G+6mbrz4Cm/+6Rn
	9EyCF1A==
X-Google-Smtp-Source: AGHT+IEGtnE87wEPt8vFmDZWKwuqeBiamfqQxH4YZrUack3DVOYvbapo5PQAN1Ec0PVFZ4Ll5zhKwg==
X-Received: by 2002:a17:907:5cd:b0:a99:409a:370 with SMTP id a640c23a62f3a-a99409a04f1mr901277066b.49.1728333457691;
        Mon, 07 Oct 2024 13:37:37 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7856bfsm421554666b.138.2024.10.07.13.37.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 13:37:36 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86e9db75b9so754081866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 13:37:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOxQAQHV24TuYqAXyNsiByRuevInEHtcDPZGdQWp/zEsZF1Pdw54uv/W+crSz8wudfkNulWhbJ1Ls0c6cj@vger.kernel.org
X-Received: by 2002:a17:906:eec2:b0:a99:4789:6ad3 with SMTP id
 a640c23a62f3a-a9947896b17mr599234166b.59.1728333455897; Mon, 07 Oct 2024
 13:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org> <20241003115721.kg2caqgj2xxinnth@quack3>
In-Reply-To: <20241003115721.kg2caqgj2xxinnth@quack3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 13:37:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
Message-ID: <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
>
> Fair enough. If we go with the iterator variant I've suggested to Dave in
> [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> Landlocks hook_sb_delete() into a single iteration relatively easily. But
> I'd wait with that convertion until this series lands.

Honza, I looked at this a bit more, particularly with an eye of "what
happens if we just end up making the inode lifetimes subject to the
dentry lifetimes" as suggested by Dave elsewhere.

And honestly, the whole inode list use by the fsnotify layer seems to
kind of suck. But I may be entirely missing something, so maybe I'm
very wrong for some reason.

The reason I say it "seems to kind of suck" is that the whole final

                /* for each watch, send FS_UNMOUNT and then remove it */
                fsnotify_inode(inode, FS_UNMOUNT);

                fsnotify_inode_delete(inode);

sequence seems to be entirely timing-dependent, and largely pointless and wrong.

Why?

Because inodes with no users will get removed at completely arbitrary
times under memory pressure in evict() -> destroy_inode(), and
obviously with I_DONTCACHE that ends up happening even earlier when
the dentry is removed.

So the whole "send FS_UNMOUNT and then remove it " thing seems to be
entirely bogus, and depending on memory pressure, lots of inodes will
only see the fsnotify_inode_delete() at eviction time and never get
the FS_UNMOUNT notification anyway.

So I get the feeling that we'd be better off entirely removing the
sb->s_inodes use from fsnotify, and replace this "get rid of them at
umount" with something like this instead:

  diff --git a/fs/dcache.c b/fs/dcache.c
  index 0f6b16ba30d0..aa2558de8d1f 100644
  --- a/fs/dcache.c
  +++ b/fs/dcache.c
  @@ -406,6 +406,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
        spin_unlock(&inode->i_lock);
        if (!inode->i_nlink)
                fsnotify_inoderemove(inode);
  +     fsnotify_inode_delete(inode);
        if (dentry->d_op && dentry->d_op->d_iput)
                dentry->d_op->d_iput(dentry, inode);
        else
  diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
  index 278620e063ab..ea91cc216028 100644
  --- a/include/linux/fsnotify.h
  +++ b/include/linux/fsnotify.h
  @@ -261,7 +261,6 @@ static inline void
fsnotify_vfsmount_delete(struct vfsmount *mnt)
   static inline void fsnotify_inoderemove(struct inode *inode)
   {
        fsnotify_inode(inode, FS_DELETE_SELF);
  -     __fsnotify_inode_delete(inode);
   }

   /*

which makes the fsnotify_inode_delete() happen when the inode is
removed from the dentry.

Then at umount time, the dentry shrinking will deal with all live
dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
just the root dentry inodes?

Wouldn't that make things much cleaner, and remove at least *one* odd
use of the nasty s_inodes list?

I have this feeling that maybe we can just remove the other users too
using similar models. I think the LSM layer use (in landlock) is bogus
for exactly the same reason - there's really no reason to keep things
around for a random cached inode without a dentry.

And I wonder if the quota code (which uses the s_inodes list to enable
quotas on already mounted filesystems) could for all the same reasons
just walk the dentry tree instead (and remove_dquot_ref similarly
could just remove it at dentry_unlink_inode() time)?

It really feels like most (all?) of the s_inode list users are
basically historical, and shouldn't use that list at all. And there
aren't _that_ many of them. I think Dave was right in just saying that
this list should go away entirely (or was it somebody else who made
that comment?)

                   Linus

