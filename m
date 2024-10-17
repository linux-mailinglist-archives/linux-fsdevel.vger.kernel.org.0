Return-Path: <linux-fsdevel+bounces-32224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7C09A2768
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E01FB2BD3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501381DEFD2;
	Thu, 17 Oct 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQLLNmbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DF1D47AC;
	Thu, 17 Oct 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180028; cv=none; b=cpe9w1Xtbz9DWj3J7wivepMQ6Iq/8BvFq6fMfw/d+VrwIzlonfXoOMG0RbI/CVjT/guMTA7NjUwxRWHthj6dz3ROd0YQz0bacGixTalLSt2ms85Q350jbufSq/Wp8Vh59Q2NvfIj0EJdXg3pQr8/lGz3ilK6vNwJ5bEOiSE8vWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180028; c=relaxed/simple;
	bh=Uvx5j39oQwVjqMRql4ui9TrzD7d3TLD7Bw2r34x+59A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k95Lt4Qb6IAeF3bwmXmLNeRrD61WkXxkLvGxA2B5yEdKdQfBFO4XUQ7OPQ8K27BRKTNWX0YPBo47fpkw09go3K40yvsw2sPNS884PMXr5C8jHBVIiP1eQM4WwujUOIkodJncdzs8V8efa7MCa6YLIhe/scCjiaC2YFXUnbUDxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQLLNmbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A02C4CEC3;
	Thu, 17 Oct 2024 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729180028;
	bh=Uvx5j39oQwVjqMRql4ui9TrzD7d3TLD7Bw2r34x+59A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQLLNmbRBlRc4oyZ+uiiRgwg8u9G3p7xZ/R8kJ2htAWL/8gCd7EeNLXr9DUD6+35f
	 AUNQ2vXxOoyaEmJLfyZ8wQA1kFy4RWHT+vtidmgbPofSdvpPoCT10i3QNfVUkfF8Lr
	 EEAsRgiGcd9HrhakR183XerTwEnUYLN0djK7iQSugnqLj69pdQTx1HiLf4w4Av7sY6
	 gCPy1vkBaE32D1qa6Xoj6/2rXNYVh+YazQCkwzT07xdWixXAYMlN7pBwav3y2jLgk4
	 SO6s1lkjpRUz3jhlHs+k6exXJRILxndnjyVx5PqERHTIc/70V5e5g2xUA2WvXSEdLe
	 400Sv9+GKLdgA==
Date: Thu, 17 Oct 2024 08:47:03 -0700
From: Kees Cook <kees@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <202410170840.8E974776@keescook>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <Zv1aA4I6r4py-8yW@kawka3.in.waw.pl>
 <ZwaWG/ult2P7HR5A@tycho.pizza>
 <202410141403.D8B6671@keescook>
 <ZxEgg+CEnvIHJJ4q@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEgg+CEnvIHJJ4q@tycho.pizza>

On Thu, Oct 17, 2024 at 08:34:43AM -0600, Tycho Andersen wrote:
> On Mon, Oct 14, 2024 at 02:13:32PM -0700, Kees Cook wrote:
> > On Wed, Oct 09, 2024 at 08:41:31AM -0600, Tycho Andersen wrote:
> > > +static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
> > > +{
> > > +	const char __user *p = get_user_arg_ptr(argv, 0);
> > > +
> > > +	/*
> > > +	 * In keeping with the logic in do_execveat_common(), we say p == NULL
> > > +	 * => "" for comm.
> > > +	 */
> > > +	if (!p) {
> > > +		bprm->argv0 = kstrdup("", GFP_KERNEL);
> > > +		return 0;
> > > +	}
> > > +
> > > +	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
> > > +	if (bprm->argv0)
> > > +		return 0;
> > > +
> > > +	return -EFAULT;
> > > +}
> > 
> > I'd rather this logic got done in copy_strings() and to avoid duplicating
> > a copy for all exec users. I think it should be possible to just do
> > this, to find the __user char *:
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 77364806b48d..e12fd706f577 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -642,6 +642,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
> >  				goto out;
> >  			}
> >  		}
> > +		if (argc == 0)
> > +			bprm->argv0 = str;
> >  	}
> >  	ret = 0;
> >  out:
> 
> Isn't str here a __user? We want a kernel string for setting comm, so
> I guess kaddr+offset? But that's not mapped any more...

Yes, but it'll be valid __user addr in the new process. (IIUC)

> > Once we get to begin_new_exec(), only if we need to do the work (fdpath
> > set), then we can do the strndup_user() instead of making every exec
> > hold a copy regardless of whether it will be needed.
> 
> What happens if that allocation fails? begin_new_exec() says it is the
> point of no return, so we would just swallow the exec? Or have
> mysteriously inconsistent behavior?

If we can't alloc a string in begin_new_exec() we're going to have much
later problems, so yeah, I'm fine with it failing there.

> I think we could check ->fdpath in the bprm_add_fixup_comm() above,
> and only do the allocation when really necessary. I should have done
> that in the above version, which would have made the comment about
> checking fdpath even somewhat true :)

But to keep this more readable, I do like your version below, with some
notes.

> 
> Something like the below?
> 
> Tycho
> 
> 
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index dad402d55681..7ec0bbfbc3c3 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1416,7 +1416,16 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		set_dumpable(current->mm, SUID_DUMP_USER);
>  
>  	perf_event_exec();
> -	__set_task_comm(me, kbasename(bprm->filename), true);
> +
> +	/*
> +	 * If argv0 was set, execveat() made up a path that will
> +	 * probably not be useful to admins running ps or similar.
> +	 * Let's fix it up to be something reasonable.
> +	 */
> +	if (bprm->argv0)
> +		__set_task_comm(me, kbasename(bprm->argv0), true);
> +	else
> +		__set_task_comm(me, kbasename(bprm->filename), true);
>  
>  	/* An exec changes our domain. We are no longer part of the thread
>  	   group */
> @@ -1566,9 +1575,36 @@ static void free_bprm(struct linux_binprm *bprm)
>  	if (bprm->interp != bprm->filename)
>  		kfree(bprm->interp);
>  	kfree(bprm->fdpath);
> +	kfree(bprm->argv0);
>  	kfree(bprm);
>  }
>  
> +static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
> +{
> +	const char __user *p = get_user_arg_ptr(argv, 0);

To keep this const but not call get_user_arg_ptr() before the fdpath
check, how about externalizing it. See further below...

> +
> +	/*
> +	 * If this isn't an execveat(), we don't need to fix up the command.
> +	 */
> +	if (!bprm->fdpath)
> +		return 0;
> +
> +	/*
> +	 * In keeping with the logic in do_execveat_common(), we say p == NULL
> +	 * => "" for comm.
> +	 */
> +	if (!p) {
> +		bprm->argv0 = kstrdup("", GFP_KERNEL);

Do we want an empty argv0, though? Shouldn't an empty fall back to
fdpath?

> +		return 0;
> +	}
> +
> +	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
> +	if (bprm->argv0)
> +		return 0;
> +
> +	return -EFAULT;
> +}
> +
>  static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
>  {
>  	struct linux_binprm *bprm;
> @@ -1975,6 +2011,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>  		goto out_ret;
>  	}
>  
> +	retval = bprm_add_fixup_comm(bprm, argv);
> +	if (retval != 0)
> +		goto out_free;

How about:

	if (unlikely(bprm->fdpath)) {
		retval = bprm_add_fixup_comm(bprm, argv);
		if (retval != 0)
			goto out_free;
	}

with the fdpath removed from bprm_add_fixup_comm()?

> +
>  	retval = count(argv, MAX_ARG_STRINGS);
>  	if (retval == 0)
>  		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",

-- 
Kees Cook

