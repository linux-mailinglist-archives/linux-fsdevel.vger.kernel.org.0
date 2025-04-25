Return-Path: <linux-fsdevel+bounces-47330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A34A9C204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8A43B3698
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA721D5A6;
	Fri, 25 Apr 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFyCKcjp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981621D5B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570727; cv=none; b=Q8XvWAK28RoGL1CMv2bD9QuTX52m+tETrBc7YGj+UeNbFNMG3hsFdcfI3V8bSTtmsRQkO3z+3zWk3vMM+ONd3DfIV6nhU78VoSPrl99CQ7B2uOxCROzQlAcRZRgYFVwFVQk4FZGROaGNFiLfkWMv3kLtUNNaAfMcCgcFQH4D3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570727; c=relaxed/simple;
	bh=lxdCfc2MBTx+A75Fy+x/i57yrRI7yKrIfte1Fz28HnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeDgCvw5eLSZ1E6YL/eoRCTzs5gyVOtF7tJ0MUSjqqRc4u6HQeWx/1zUMHYaLPfDQ03TDPXlYFxOipii3FJigdRvgFo7DrsOQaO64UOfp7WD4C1yKx7eTlTElS0D6bCx1gZNvpLD2MSXW1/HUaWhRIKi65Rybj1pVO1urzSerkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFyCKcjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3D3C4CEEA;
	Fri, 25 Apr 2025 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745570726;
	bh=lxdCfc2MBTx+A75Fy+x/i57yrRI7yKrIfte1Fz28HnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFyCKcjpYKlNnlsuv4HqHin3upvqk371/WnkpP2duWeQphuIRsRR1tQBAPHRElIQp
	 S5Rn4bl5dDbxPAdOXhafMlgjQYGHLNoIRmoHd62gsK7qLwUQpIMSyTUPe4Ycmkx7OR
	 nrimtknG8BCmXbvUjtUvEf+4zVSN9ctmWjhkqQAEB+pqU3p6Iru+Ey7+NQpVyorGaY
	 mwlZCrCBPvF2ycRfzD3+K0icl3vPQKVrykOmy1Bizt2oMrtfa2DEa5TmyO8D1ob6I6
	 UcFNd6A5Ws74x462ths6Mo0od9VmOucDfbOp8RFkuu7esTwh2pr01R7xxFQm6feTO2
	 j/e/g/YkaBS5w==
Date: Fri, 25 Apr 2025 10:45:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and
 getxattrat(2)
Message-ID: <20250425-fahrschein-obacht-c622fbb4399b@brauner>
References: <20250424132246.16822-2-jack@suse.cz>
 <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>

On Thu, Apr 24, 2025 at 05:45:17PM +0200, Mateusz Guzik wrote:
> On Thu, Apr 24, 2025 at 03:22:47PM +0200, Jan Kara wrote:
> > Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
> > calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
> > fail with -EBADF error instead of operating on CWD. Fix it.
> > 
> > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/xattr.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 02bee149ad96..fabb2a04501e 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
> >  		return error;
> >  
> >  	filename = getname_maybe_null(pathname, at_flags);
> > -	if (!filename) {
> > +	if (!filename && dfd >= 0) {
> >  		CLASS(fd, f)(dfd);
> >  		if (fd_empty(f))
> >  			error = -EBADF;
> > @@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
> >  		return error;
> >  
> >  	filename = getname_maybe_null(pathname, at_flags);
> > -	if (!filename) {
> > +	if (!filename && dfd >= 0) {
> >  		CLASS(fd, f)(dfd);
> >  		if (fd_empty(f))
> >  			return -EBADF;
> 
> Is there any code which legitimately does not follow this pattern?
> 
> With some refactoring getname_maybe_null() could handle the fd thing,
> notably return the NULL pointer if the name is empty. This could bring
> back the invariant that the path argument is not NULL.
> 
> Something like this:
> static inline struct filename *getname_maybe_null(int fd, const char __user *name, int flags)
> {
>         if (!(flags & AT_EMPTY_PATH))
>                 return getname(name);
> 
>         if (!name && fd >= 0)
>                 return NULL;
>         return __getname_maybe_null(fd, name);
> }
> 
> struct filename *__getname_maybe_null(int fd, const char __user *pathname)
> {
>         char c;
> 
>         if (fd >= 0) {
>                 /* try to save on allocations; loss on um, though */
>                 if (get_user(c, pathname))
>                         return ERR_PTR(-EFAULT);
>                 if (!c)
>                         return NULL;
>         }
> 
> 	/* we alloc suffer the allocation of the buffer. worst case, if
> 	 * the name turned empty in the meantime, we return it and
> 	 * handle it the old-fashioned way.
> 	 /
>         return getname_flags(pathname, LOOKUP_EMPTY);
> }
> 
> Then callers would look like this:
> filename = getname_maybe_null(dfd, pathname, at_flags);
> if (!filename) {
> 	/* fd handling goes here */
> 	CLASS(fd, f)(dfd);
> 	....
> 
> } else {
> 	/* regular path handling goes here */
> }
> 
> 
> set_nameidata() would lose this branch:
> p->pathname = likely(name) ? name->name : "";
> 
> and putname would convert IS_ERR_OR_NULL (which is 2 branches) into one,
> maybe like so:
> -       if (IS_ERR_OR_NULL(name))
> +       VFS_BUG_ON(!name);
> +
> +       if (IS_ERR(name))
>                 return;
> 
> i think this would be an ok cleanup

Not opposed, but please for -next and Jan's thing as a backportable fix,
please. Thanks!

