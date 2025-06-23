Return-Path: <linux-fsdevel+bounces-52563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F364EAE4180
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179D83AA254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86796248882;
	Mon, 23 Jun 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGv81Cd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B11EF38E;
	Mon, 23 Jun 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683648; cv=none; b=UgqVObia669YIC205jBG6UDu+9Yg+bgUa49N+SVK8NZGoX03Bhpld1yzRWeY9ASdh6ZOjrFfWXQLkFc93up4a1mSW9dP3SIHxoSH4u79FZZ/m7N3K1yl2XkiwQzfXEhvuPhJcDzyueNk2vye2+yV7boPU+JTY3yO4eEFqIDfUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683648; c=relaxed/simple;
	bh=HHeSa0K3f0CqWQR6qvhRszU4bklGUN5r7edjrf1akig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na5PuHlBpVb0qDYFvyNEmfj9WPIzMGUsaLOgkkeD8iLsRO/Kj9uWxfjZc+xHuZl05TNuAIVK0xDZimuhP0fr1kCsfcYTKaaQGHEsws6dlRaOVYZbg7kvm9WBEhwzcGyyETwd1NjJ4q5lAk5J/Te3tGPhJvdyTJ4UEbzMp8IwS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGv81Cd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837D4C4CEEA;
	Mon, 23 Jun 2025 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750683647;
	bh=HHeSa0K3f0CqWQR6qvhRszU4bklGUN5r7edjrf1akig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGv81Cd+WesSSCBOQFcKtSK7Wx7AemYdUzn7CkRGReYGJKXHShrYuGJDecPso9yAm
	 p2ytr84IIyewJ8QTe+ajZWupsvTk/hEh2tn2/K+odLzEGLU8Ekeif/U6yY50Mh8Ff/
	 gShIoL7eECGb1liadOAMsUeSxFlvNWDL3KOJZ0R0LXQGp4ws9/JEhy6QEXDa4y8Vgg
	 M6smpb4dbzevrC5Pyb4v8eWMirO+D7OBLDvFnzHSIHvKhBO/aQ2muNqVdJq26xGzHQ
	 g+och14EaKh5YNOXcZFSioahr2L/Dm5cITA0zp159oSsuZl/i4h7/1psaQ9j0R7+7c
	 W7dkz7mu8nIng==
Date: Mon, 23 Jun 2025 15:00:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
Message-ID: <20250623-notstand-aufkreuzen-7e558b3b8f7e@brauner>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
 <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu>
 <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner>
 <CAOQ4uxjZy8tc_tOChJ_r_FPkUxE0qrz0CxmKeJj2MZ7wyhLpBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjZy8tc_tOChJ_r_FPkUxE0qrz0CxmKeJj2MZ7wyhLpBw@mail.gmail.com>

On Mon, Jun 23, 2025 at 02:54:00PM +0200, Amir Goldstein wrote:
> On Mon, Jun 23, 2025 at 2:25 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jun 23, 2025 at 02:06:43PM +0200, Jan Kara wrote:
> > > On Mon 23-06-25 11:01:30, Christian Brauner wrote:
> > > > Various filesystems such as pidfs (and likely drm in the future) have a
> > > > use-case to support opening files purely based on the handle without
> > > > having to require a file descriptor to another object. That's especially
> > > > the case for filesystems that don't do any lookup whatsoever and there's
> > > > zero relationship between the objects. Such filesystems are also
> > > > singletons that stay around for the lifetime of the system meaning that
> > > > they can be uniquely identified and accessed purely based on the file
> > > > handle type. Enable that so that userspace doesn't have to allocate an
> > > > object needlessly especially if they can't do that for whatever reason.
> > > >
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > >
> > > Hmm, maybe we should predefine some invalid fd value userspace should pass
> > > when it wants to "autopick" fs root? Otherwise defining more special fd
> > > values like AT_FDCWD would become difficult in the future. Or we could just
> >
> > Fwiw, I already did that with:
> >
> > #define PIDFD_SELF_THREAD               -10000 /* Current thread. */
> > #define PIDFD_SELF_THREAD_GROUP         -20000 /* Current thread group leader. */
> >
> > I think the correct thing to do would have been to say anything below
> >
> > #define AT_FDCWD                -100    /* Special value for dirfd used to
> >
> > is reserved for the kernel. But we can probably easily do this and say
> > anything from -10000 to -40000 is reserved for the kernel.
> >
> > I would then change:
> >
> > #define PIDFD_SELF_THREAD               -10000 /* Current thread. */
> > #define PIDFD_SELF_THREAD_GROUP         -10001 /* Current thread group leader. */
> >
> > since that's very very new and then move
> > PIDFD_SELF_THREAD/PIDFD_SELF_THREAD_GROUP to include/uapi/linux/fcntl.h
> >
> > and add that comment about the reserved range in there.
> >
> > The thing is that we'd need to enforce this on the system call level.
> >
> > Thoughts?
> >
> > > define that FILEID_PIDFS file handles *always* ignore the fd value and
> > > auto-pick the root.
> >
> > I see the issue I don't think it's a big deal but I'm open to adding:
> >
> > #define AT_EBADF -10009 /* -10000 - EBADF */
> >
> > and document that as a stand-in for a handle that can't be resolved.
> >
> > Thoughts?
> 
> I think the AT prefix of AT_FDCWD may have been a mistake
> because it is quite easy to confuse this value with the completely
> unrelated namespace of AT_ flags.
> 
> This is a null dirfd value. Is it not?

Not necessarily dirfd. We do allow direct operations of file descriptor
of any type. For example, in the mount api where you can mount files
onto other files.

> 
> FD_NULL, FD_NONE?

FD_INVALID, I think.

> 
> You could envision that an *at() syscalls could in theory accept
> (FD_NONE , "/an/absolute/path/only", ...
> 
> or MOUNTFD_NONE if we want to define a constant specifically for
> this open_by_handle_at() extension.

I think this is useful beyond open_by_handle_at().

