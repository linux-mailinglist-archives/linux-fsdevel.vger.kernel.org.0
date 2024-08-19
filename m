Return-Path: <linux-fsdevel+bounces-26250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0D0956929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD9CB225E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B6166318;
	Mon, 19 Aug 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7arKBgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D21163AA7;
	Mon, 19 Aug 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066171; cv=none; b=fKuKZ/FOBHB/O1Lwg1Jay8F0d6BpFLZhqOWRxIUt/b/s5MNv2411ku6DyJEJkCUCxP6hT9sxx73Ksb3sHx76ZgAMi8fqFyGlZK+rhFrqDnV2dcIQbwraReP3kbV226tEqBf8oaNx8RN78U/0649zZe00QBVm5nVXRTfWdjtPoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066171; c=relaxed/simple;
	bh=UUA9wcGcOXhrVP0fsoTAK/cwqpkvy1cfySU4KgiNkKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na5HHJU0DpOo5IU79kjLOaRXRdMhwVIu9IwOiKw4I++wqtvCbfXj3Muig2gvTcxR89k6D/Dx8ggH/UQSR8sVmquGCjJxsSD4ISHd0tYAnSZ0rG/CiZD5Qx3up8EanHVkF9FEyZtE+z62J6WCFhxfTIiXnmegd/+G0joY+isNp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7arKBgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB409C32782;
	Mon, 19 Aug 2024 11:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724066170;
	bh=UUA9wcGcOXhrVP0fsoTAK/cwqpkvy1cfySU4KgiNkKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7arKBgyOgcQfWlBgImkrFR6HL4M70f/i88z8lg2PT3BdC3d9F5Yxp53JF+FFg8rZ
	 mz+T+t2/zqldxOBr9UCbbTCvn/C6dr99DBeb9y3YAhsvrD5ZCbkrr9Hy31bZjLDNGa
	 nF42sJX65ZkCn9F6Cbzm7tbxoplBfoSnUz7/88fWgXfNJqJbEAmPM/5OjcoEIrGBtZ
	 Yu9MFEFw4CmfUUYoAxQ0QkJIUR3frvDrhpeIIQCiL5g67StzDVYTRSZMXd9Od+FJ5f
	 Fblqj19TYu70vtSCIo9bh9N1bDad717a6iRcz615tsSzsf1CjyG9GNKWB1q6rVa1eH
	 aeq+SHoIF09Qg==
Date: Mon, 19 Aug 2024 13:16:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	Liam Wisehart <liamwisehart@meta.com>, Liang Tang <lltang@meta.com>, 
	Shankaran Gnanashanmugam <shankaran@meta.com>, LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <20240819-keilen-urlaub-2875ef909760@brauner>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>

On Mon, Aug 19, 2024 at 07:18:40AM GMT, Song Liu wrote:
> Hi Christian, 
> 
> Thanks again for your suggestions here. I have got more questions on
> this work. 
> 
> > On Jul 29, 2024, at 6:46 AM, Christian Brauner <brauner@kernel.org> wrote:
> 
> [...]
> 
> >> I am not sure I follow the suggestion to implement this with 
> >> security_inode_permission()? Could you please share more details about
> >> this idea?
> > 
> > Given a path like /bin/gcc-6.9/gcc what that code currently does is:
> > 
> > * walk down to /bin/gcc-6.9/gcc
> > * walk up from /bin/gcc-6.9/gcc and then checking xattr labels for:
> >  gcc
> >  gcc-6.9/
> >  bin/
> >  /
> > 
> > That's broken because someone could've done
> > mv /bin/gcc-6.9/gcc /attack/ and when this walks back and it checks xattrs on
> > /attack even though the path lookup was for /bin/gcc-6.9. IOW, the
> > security_file_open() checks have nothing to do with the permission checks that
> > were done during path lookup.
> > 
> > Why isn't that logic:
> > 
> > * walk down to /bin/gcc-6.9/gcc and check for each component:
> > 
> >  security_inode_permission(/)
> >  security_inode_permission(gcc-6.9/)
> >  security_inode_permission(bin/)
> >  security_inode_permission(gcc)
> >  security_file_open(gcc)
> 
> I am trying to implement this approach. The idea, IIUC, is:
> 
> 1. For each open/openat, as we walk the path in do_filp_open=>path_openat, 
>    check xattr for "/", "gcc-6.9/", "bin/" for all given flags.
> 2. Save the value of the flag somewhere (for BPF, we can use inode local
>    storage). This is needed, because openat(dfd, ..) will not start from
>    root again. 
> 3. Propagate these flag to children. All the above are done at 
>    security_inode_permission. 
> 4. Finally, at security_file_open, check the xattr with the file, which 
>    is probably propagated from some parents.
> 
> Did I get this right? 
> 
> IIUC, there are a few issues with this approach. 
> 
> 1. security_inode_permission takes inode as parameter. However, we need 
>    dentry to get the xattr. Shall we change security_inode_permission
>    to take dentry instead? 
>    PS: Maybe we should change most/all inode hooks to take dentry instead?

security_inode_permission() is called in generic_permission() which in
turn is called from inode_permission() which in turn is called from
inode->i_op->permission() for various filesystems. So to make
security_inode_permission() take a dentry argument one would need to
change all inode->i_op->permission() to take a dentry argument for all
filesystems. NAK on that.

That's ignoring that it's just plain wrong to pass a dentry to
**inode**_permission() or security_**inode**_permission(). It's
permissions on the inode, not the dentry.

> 
> 2. There is no easy way to propagate data from parent. Assuming we already
>    changed security_inode_permission to take dentry, we still need some
>    mechanism to look up xattr from the parent, which is probably still 
>    something like bpf_dget_parent(). Or maybe we should add another hook 
>    with both parent and child dentry as input?
> 
> 3. Given we save the flag from parents in children's inode local storage, 
>    we may consume non-trivial extra memory. BPF inode local storage will 
>    be freed as the inode gets freed, so we will not leak any memory or 
>    overflow some hash map. However, this will probably increase the 
>    memory consumption of inode by a few percents. I think a "walk-up" 
>    based approach will not have this problem, as we don't need the extra
>    storage. Of course, this means more xattr lookups in some cases. 
> 
> > 
> > I think that dget_parent() logic also wouldn't make sense for relative path
> > lookups:
> > 
> > dfd = open("/bin/gcc-6.9", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> > 
> > This walks down to /bin/gcc-6.9 and then walks back up (subject to the
> > same problem mentioned earlier) and check xattrs for:
> > 
> >  gcc-6.9
> >  bin/
> >  /
> > 
> > then that dfd is passed to openat() to open "gcc":
> > 
> > fd = openat(dfd, "gcc", O_RDONLY);
> > 
> > which again walks up to /bin/gcc-6.9 and checks xattrs for:
> >  gcc
> >  gcc-6.9
> >  bin/
> >  /
> > 
> > Which means this code ends up charging relative lookups twice. Even if one
> > irons that out in the program this encourages really bad patterns.
> > Path lookup is iterative top down. One can't just randomly walk back up and
> > assume that's equivalent.
> 
> I understand that walk-up is not equivalent to walk down. But it is probably
> accurate enough for some security policies. For example, LSM LandLock uses
> similar logic in the file_open hook (file security/landlock/fs.c, function 
> is_access_to_paths_allowed). 

I'm not well-versed in landlock so I'll let Mickaël comment on this with
more details but there's very important restrictions and differences
here.

Landlock expresses security policies with file hierarchies and
security_inode_permission() doesn't and cannot have access to that.

Landlock is subject to the same problem that the BPF is here. Namely
that the VFS permission checking could have been done on a path walk
completely different from the path walk that is checked when walking
back up from security_file_open().

But because landlock works with a deny-by-default security policy this
is ok and it takes overmounts into account etc.

> 
> To summary my thoughts here. I think we need:
> 
> 1. Change security_inode_permission to take dentry instead of inode. 

Sorry, no.

> 2. Still add bpf_dget_parent. We will use it with security_inode_permission
>    so that we can propagate flags from parents to children. We will need
>    a bpf_dput as well. 
> 3. There are pros and cons with different approaches to implement this
>    policy (tags on directory work for all files in it). We probably need 
>    the policy writer to decide with one to use. From BPF's POV, dget_parent
>    is "safe", because it won't crash the system. It may encourage some bad
>    patterns, but it appears to be required in some use cases. 

You cannot just walk a path upwards and check permissions and assume
that this is safe unless you have a clear idea what makes it safe in
this scenario. Landlock has afaict. But so far you only have a vague
sketch of checking permissions walking upwards and retrieving xattrs
without any notion of the problems involved.

If you provide a bpf_get_parent() api for userspace to consume you'll
end up providing them with an api that is extremly easy to misuse.

