Return-Path: <linux-fsdevel+bounces-34640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CDB9C708C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5372854FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6E91EE010;
	Wed, 13 Nov 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKXgmslH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A61DF737;
	Wed, 13 Nov 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504391; cv=none; b=kTh+nTYJ9MYNUBdExkREcaQ0EXI9WegdLZ6ZcPEvMgGE4tqq8AlXcLIgw0hl6AstkCM7HlnG5XIHbSBmhiJ9N2u1awRJ0BAUmHKBYSgzFu2faqAGyc4DwIgXE1rCrDHv7eaJwvM803Yb4P5MqVepAHa5cwIsU7mhqtEoe7Ltk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504391; c=relaxed/simple;
	bh=OYPuaE2+AnUxXcJi5nXMxJhfuKUqJgkZ5AbDTz/mMms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEOSiuUrWQ6BIBOchLx2M8Mp4H7gM9yUS9Q8ZrD5I0TtwAuAzt7CdGX+CbQ0NNnXEL/Www0laMLsKUSS05MIz3pL6XRhcIpdSfhPyS0wBfDj5/wgvskHNmRMSp7acWF8h4jZRZbnoORyeMgQn6/F6pK3vqNm0TrIkjFtJV0uC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKXgmslH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E717C4CECD;
	Wed, 13 Nov 2024 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731504390;
	bh=OYPuaE2+AnUxXcJi5nXMxJhfuKUqJgkZ5AbDTz/mMms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKXgmslHh7yaccvhogJAePw2LjZfji15iqQ2t5WPDLuuldRRNzcb3xTb5iirqMWw7
	 7MPrCryJxt2sz85HC/EK7LJeMfj/xr1WRWpitbl8i4Qw5RkAO56eNUqV+1fKf4MRnx
	 VnXO7+6aqbal13ZFyfl98OHJPDBvcHECJl7nspmyL13xw2FuF9Rd2xsn0o2Vs0gvNy
	 2oXRkuRsfAdyiQvJ7hepTwe03cZ+O2N9Ckn1QEKJsqetvpPOXnx93wMQbHOaQzfhpW
	 Q2vvvyVPBWbz6XfEmAcjkbp+m1N4WoT+IgYshqr9O45WKJuiybVmJ3KKZPkyxs6Imv
	 7u+I53MphrjjA==
Date: Wed, 13 Nov 2024 14:26:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
Message-ID: <20241113-entnimmt-weintrauben-3b0b4a1a18b7@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241101135452.19359-5-erin.shepherd@e43.eu>
 <20241113-erlogen-aussehen-b75a9f8cb441@brauner>
 <65e22368-d4f8-45f5-adcb-4d8c297ae293@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65e22368-d4f8-45f5-adcb-4d8c297ae293@e43.eu>

On Wed, Nov 13, 2024 at 02:06:56PM +0100, Erin Shepherd wrote:
> On 13/11/2024 13:09, Christian Brauner wrote:
> 
> > Hm, a pidfd comes in two flavours:
> >
> > (1) thread-group leader pidfd: pidfd_open(<pid>, 0)
> > (2) thread pidfd:              pidfd_open(<pid>, PIDFD_THREAD)
> >
> > In your current scheme fid->pid = pid_nr(pid) means that you always
> > encode a pidfs file handle for a thread pidfd no matter if the provided
> > pidfd was a thread-group leader pidfd or a thread pidfd. This is very
> > likely wrong as it means users that use a thread-group pidfd get a
> > thread-specific pid back.
> >
> > I think we need to encode (1) and (2) in the pidfs file handle so users
> > always get back the correct type of pidfd.
> >
> > That very likely means name_to_handle_at() needs to encode this into the
> > pidfs file handle.
> 
> I guess a question here is whether a pidfd handle encodes a handle to a pid
> in a specific mode, or just to a pid in general? The thought had occurred
> to me while I was working on this initially, but I felt like perhaps treating
> it as a property of the file descriptor in general was better.
> 
> Currently open_by_handle_at always returns a thread-group pidfd (since
> PIDFD_THREAD) isn't set, regardless of what type of pidfd you passed to
> name_to_handle_at. I had thought that PIDFD_THREAD/O_EXCL would have been

I don't think you're returning a thread-groupd pidfd from
open_by_handle_at() in your scheme. After all you're encoding the tid in
pid_nr() so you'll always find the struct pid for the thread afaict. If
I'm wrong could you please explain how you think this works? I might
just be missing something obvious.

> passed through to f->f_flags on the restored pidfd, but upon checking I see that
> it gets filtered out in do_dentry_open.

It does, but note that __pidfd_prepare() raises it explicitly on the
file afterwards. So it works fine.

> 
> I feel like leaving it up to the caller of open_by_handle_at might be better
> (because they are probably better informed about whether they want poll() to
> inform them of thread or process exit) but I could lean either way.

So in order to decode a pidfs file handle you want the caller to have to
specify O_EXCL in the flags argument of open_by_handle_at()? Is that
your idea?

> 
> >> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> >> +					 struct fid *gen_fid,
> >> +					 int fh_len, int fh_type)
> >> +{
> >> +	int ret;
> >> +	struct path path;
> >> +	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
> >> +	struct pid *pid;
> >> +
> >> +	if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
> >> +		return NULL;
> >> +
> >> +	pid = find_get_pid_ns(fid->pid, &init_pid_ns);
> >> +	if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0) {
> >> +		put_pid(pid);
> >> +		return NULL;
> >> +	}
> > I think we can avoid the premature reference bump and do:
> >
> > scoped_guard(rcu) {
> >         struct pid *pid;
> >
> > 	pid = find_pid_ns(fid->pid, &init_pid_ns);
> > 	if (!pid)
> > 		return NULL;
> >
> > 	/* Did the pid get recycled? */
> > 	if (pid->ino != fid->ino)
> > 		return NULL;
> >
> > 	/* Must be resolvable in the caller's pid namespace. */
> > 	if (pid_vnr(pid) == 0)
> > 		return NULL;
> >
> > 	/* Ok, this is the pid we want. */
> > 	get_pid(pid);
> > }
> 
> I can go with that if preferred. I was worried a bit about making the RCU
> critical section too large, but of course I'm sure there are much larger
> sections inside the kernel.

This is perfectly fine. Don't worry about it.

> 
> >> +
> >> +	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
> >> +	if (ret < 0)
> >> +		return ERR_PTR(ret);
> >> +
> >> +	mntput(path.mnt);
> >> +	return path.dentry;
> >>  }
> 
> Similarly here i should probably refactor this into dentry_from_stashed in
> order to avoid a needless bump-then-drop of path.mnt's reference count

No, what you have now is fine. I wouldn't add a specific helper for
this. In contrast to the pid the pidfs mount never goes away.

