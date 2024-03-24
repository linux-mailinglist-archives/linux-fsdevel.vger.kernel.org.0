Return-Path: <linux-fsdevel+bounces-15167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBF887B74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 03:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2439B1C2104A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 02:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804E16FD0;
	Sun, 24 Mar 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WTdg4nnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAC63A1;
	Sun, 24 Mar 2024 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711247282; cv=none; b=IlclhZdV7ThvbFLXtcenm8mMbKVqJHh7cZHpUTG/Lk79OO1s8c/J7XvnsA369mez0ND7RXxjfVPK1OegmRKLVEPJ60lftI6wKT4+n/Tmt9l6YOCQ4kYEsT57q81jFGoB8ODrtA/N22ILEy+BNxt6rhQuJ7zQZ+l9eCoiQ/YivXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711247282; c=relaxed/simple;
	bh=j7cwiU9WpH1v7ptn9G45h6NOLb1MsA0yEP7XVW6yQMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXxW54UPlhpmNNQtAjugd654Z21V3v5fkLOv8Sl4RtYQiAUiNJDVjJULZuWhyCrAbp/X4D/XveB+kkOXv3/yEuvj90ld/xI92t+53oUHD+DZf0GULQswcSnYg8Af1P7ntR4VhVp8JqpJi+1lC18Mv90tPWESdCyRcw7Q0L93TWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WTdg4nnJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5anrztUeF8JG/Q33v10wfAqJ9O4OuzO3WxPcGzCz/TY=; b=WTdg4nnJUuQpkBIFuZFHSNxfo/
	p20+XA4M1RXQ7tTZAMDLOw7HTZW4HJBbv/utts4jrNzOkQHc2MBpBnrE5KgNf+ODD747qMSw0o5Pi
	oSDzWCvaLWU+8wykiMlVhhYQlACyKobyeEMzxyVFBL+KZU8Vkdz0FvXwptw1NTlGviMxwYwznjhp1
	EnkViMnS2CCk9icn5ZnT7bSz58vEETs/gVjsZKMzV6wbfeOH3PBVzIQj7oRGdlIHHslmKR1NIOSOR
	1lJfUll3dyJE5j42V5946Tz7SZfaYUJfWQLCQ5o8mzainCz7fDkPWJr/mH/ncNAdbsev9EAMaY+Dp
	qF6Lurnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1roDa7-00FXRD-2L;
	Sun, 24 Mar 2024 02:27:31 +0000
Date: Sun, 24 Mar 2024 02:27:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in
 path_openat()
Message-ID: <20240324022731.GR538574@ZenIV>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
 <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 01, 2024 at 09:51:18AM -0800, Linus Torvalds wrote:

> Right. I think the natural and logical way to deal with this is to
> just say "we account when we add the file to the fdtable".
> 
> IOW, just have fd_install() do it. That's the really natural point,
> and also makes it very logical why alloc_empty_file_noaccount()
> wouldn't need to do the GFP_KERNEL_ACCOUNT.

We can have the same file occuring in many slots of many descriptor tables,
obviously.  So it would have to be a flag (in ->f_mode?) set by it, for
"someone's already charged for it", or you'll end up with really insane
crap on each fork(), dup(), etc.

But there's also MAP_ANON with its setup_shmem_file(), with the resulting
file not going into descriptor tables at all, and that's not a rare thing.

> > - I don't know how to properly unwind the accounting failure case. It
> >   seems like a new case because when we succeed the open, there's no
> >   further error path at least in path_openat().
> 
> Yeah, let me think about this part. Becasue fd_install() is the right
> point, but that too does not really allow for error handling.
> 
> Yes, we could close things and fail it, but it really is much too late
> at this point.

That as well.  For things like O_CREAT even do_dentry_open() would be too
late for unrolls.

> What I *think* I'd want for this case is
> 
>  (a) allow the accounting to go over by a bit
> 
>  (b) make sure there's a cheap way to ask (before) about "did we go
> over the limit"
> 
> IOW, the accounting never needed to be byte-accurate to begin with,
> and making it fail (cheaply and early) on the next file allocation is
> fine.
> 
> Just make it really cheap. Can we do that?

That might be reasonable, but TBH I would rather combine that with
do_dentry_open()/alloc_file() (i.e. the places where we set FMODE_OPENED)
as places to do that, rather than messing with fd_install().

How does the following sound?
	* those who allocate empty files mark them if they are intended
to be kernel-internal (see below for how to get the information there)
	* memcg charge happens when we set FMODE_OPENED, provided that
struct file instance is not marked kernel-internal.
	* exceeding the limit => pretend we'd succeeded and fail the
next allocation.

As for how to get the information down there...  We have 6 functions
where "allocate" and "mark it opened" callchains converge -
alloc_file() (pipe(2) et.al., mostly), path_openat() (normal opens,
but also filp_open() et.al.), dentry_open(), kernel_file_open(),
kernel_tmpfile_open(), dentry_create().  The last 3 are all
kernel-internal; dentry_open() might or might not be.

For path_openat() we can add a bit somewhere in struct open_flags;
the places where we set struct open_flags up would be the ones that
might need to be annotated.  That's
	file_open_name()
	file_open_root()
	do_sys_openat2() (definitely userland)
	io_openat2() (ditto)
	sys_uselib() (ditto)
	do_open_execat() (IMO can be considered userland in all cases)

For alloc_file() it's almost always userland.  IMO things like
dma_buf_export() and setup_shmem_file() should be charged.

So it's a matter of propagating the information to dentry_open(),
file_open_name() and file_open_root().  That's about 70 callers
to annotate, including filp_open() and file_open_root_mnt() into
the mix.  <greps>  61, actually, and from the quick look it
seems that most of them are really obvious...

Comments?

