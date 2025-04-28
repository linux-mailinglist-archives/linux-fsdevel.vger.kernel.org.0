Return-Path: <linux-fsdevel+bounces-47503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F6A9EBAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 11:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5A1189D73E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1421233145;
	Mon, 28 Apr 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYn1dQyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98618C937
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745831971; cv=none; b=enYa79M4dyNKPD11/7j4Lb21MeIzUP9Bgffc51t4/i+ZvXDoie/YD1fTENOGe9vsNZrVb+51GZqE0cua9YX+r7eNNVderU54EpvVgkvzCl2X50UBtxR4ZAhtR58W5fB1X2R7cZqGJ0w9EMVsnOdy4D6hSwi5LBaIWAs2sFipZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745831971; c=relaxed/simple;
	bh=FV6pRbUNKc/G/CkVMy80TrYGct7pP+2S5Czg6FVii8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk/nzuww6ibgA7QXjUOXFkFcTJOFpfOHiB+DfAkFEKcfJcQikN43cFBILYt7Td9bdM4NsOwenDLldxmEy+GPsQYL4SWxt7lQL407aV3FOBuvviRJECf6sBjC3wzAwEQhiQXaqvQsDNnyPB6R8hQv2KJyEVvV7zf5DrnPNs78rbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYn1dQyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE27C4CEE4;
	Mon, 28 Apr 2025 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745831970;
	bh=FV6pRbUNKc/G/CkVMy80TrYGct7pP+2S5Czg6FVii8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYn1dQyEKdJTZVxdWl7kwfj+BZF9TUGc8/NzNWjAA3xaEtOIn4kYyWKOYuRlMKHl+
	 p+WGgHg6TIVIDg7Fg+CupZWgZnk28DqSvnh55HrbkL0R1OlVgQAQdQ3gV97/rEm58x
	 37NS0K9dfZ0y5UHm0xlzElNEOPCnAJJ5eEajSjeWdFvWcxx1W1Yrw6LJR4jMghUSa0
	 gpTehHBE200or1MUZ8qgedJIzHxJ2yMuAk/UXFYecrFsgnVOhq1JfFZaayxIu68E2x
	 RQ/UBP7UD+J6TTV25tTfwOr05A59nlcHXbzFbWQlXLiSuXRDLxQKWrxMxh9BzR5OfA
	 8eUzi/lruz+fA==
Date: Mon, 28 Apr 2025 11:19:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and
 getxattrat(2)
Message-ID: <20250428-gesendet-bemerken-f2535df7b4cd@brauner>
References: <20250424132246.16822-2-jack@suse.cz>
 <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>
 <20250425-fahrschein-obacht-c622fbb4399b@brauner>
 <a3w7xdgldyoodxeav6zwn3dkw6y4cir6fdhftopo3snrpgbjoz@zvz4vny63ehf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3w7xdgldyoodxeav6zwn3dkw6y4cir6fdhftopo3snrpgbjoz@zvz4vny63ehf>

On Fri, Apr 25, 2025 at 03:33:05PM +0200, Jan Kara wrote:
> On Fri 25-04-25 10:45:22, Christian Brauner wrote:
> > On Thu, Apr 24, 2025 at 05:45:17PM +0200, Mateusz Guzik wrote:
> > > On Thu, Apr 24, 2025 at 03:22:47PM +0200, Jan Kara wrote:
> > > > Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
> > > > calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
> > > > fail with -EBADF error instead of operating on CWD. Fix it.
> > > > 
> > > > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  fs/xattr.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > index 02bee149ad96..fabb2a04501e 100644
> > > > --- a/fs/xattr.c
> > > > +++ b/fs/xattr.c
> > > > @@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
> > > >  		return error;
> > > >  
> > > >  	filename = getname_maybe_null(pathname, at_flags);
> > > > -	if (!filename) {
> > > > +	if (!filename && dfd >= 0) {
> > > >  		CLASS(fd, f)(dfd);
> > > >  		if (fd_empty(f))
> > > >  			error = -EBADF;
> > > > @@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
> > > >  		return error;
> > > >  
> > > >  	filename = getname_maybe_null(pathname, at_flags);
> > > > -	if (!filename) {
> > > > +	if (!filename && dfd >= 0) {
> > > >  		CLASS(fd, f)(dfd);
> > > >  		if (fd_empty(f))
> > > >  			return -EBADF;
> > > 
> > > Is there any code which legitimately does not follow this pattern?
> > > 
> > > With some refactoring getname_maybe_null() could handle the fd thing,
> > > notably return the NULL pointer if the name is empty. This could bring
> > > back the invariant that the path argument is not NULL.
> > > 
> > > Something like this:
> > > static inline struct filename *getname_maybe_null(int fd, const char __user *name, int flags)
> > > {
> > >         if (!(flags & AT_EMPTY_PATH))
> > >                 return getname(name);
> > > 
> > >         if (!name && fd >= 0)
> > >                 return NULL;
> > >         return __getname_maybe_null(fd, name);
> > > }
> > > 
> > > struct filename *__getname_maybe_null(int fd, const char __user *pathname)
> > > {
> > >         char c;
> > > 
> > >         if (fd >= 0) {
> > >                 /* try to save on allocations; loss on um, though */
> > >                 if (get_user(c, pathname))
> > >                         return ERR_PTR(-EFAULT);
> > >                 if (!c)
> > >                         return NULL;
> > >         }
> > > 
> > > 	/* we alloc suffer the allocation of the buffer. worst case, if
> > > 	 * the name turned empty in the meantime, we return it and
> > > 	 * handle it the old-fashioned way.
> > > 	 /
> > >         return getname_flags(pathname, LOOKUP_EMPTY);
> > > }
> > > 
> > > Then callers would look like this:
> > > filename = getname_maybe_null(dfd, pathname, at_flags);
> > > if (!filename) {
> > > 	/* fd handling goes here */
> > > 	CLASS(fd, f)(dfd);
> > > 	....
> > > 
> > > } else {
> > > 	/* regular path handling goes here */
> > > }
> > > 
> > > 
> > > set_nameidata() would lose this branch:
> > > p->pathname = likely(name) ? name->name : "";
> > > 
> > > and putname would convert IS_ERR_OR_NULL (which is 2 branches) into one,
> > > maybe like so:
> > > -       if (IS_ERR_OR_NULL(name))
> > > +       VFS_BUG_ON(!name);
> > > +
> > > +       if (IS_ERR(name))
> > >                 return;
> > > 
> > > i think this would be an ok cleanup
> > 
> > Not opposed, but please for -next and Jan's thing as a backportable fix,
> > please. Thanks!
> 
> Exactly, I agree the code is pretty subtle and ugly. It shouldn't take
> several engineers to properly call a function to lookup a file :) So
> some cleanup and refactoring is definitely long overdue but for now I
> wanted some minimal fix which is easy to backport to stable.
> 
> When we speak about refactoring: Is there a reason why user_path_at()
> actually doesn't handle NULL 'name' as empty like we do it in *xattrat()
> syscalls? I understand this will make all _at() syscalls accept NULL name
> with AT_EMPTY_PATH but is that a problem?

It probably isn't but it needs an audit of all callers.

