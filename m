Return-Path: <linux-fsdevel+bounces-26265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9432956BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 15:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADBD1C23134
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F68172784;
	Mon, 19 Aug 2024 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="o1I4OYUD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4B170A3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073621; cv=none; b=SfmvJlTTiBQvo5gO4WznD/IF+U73tkICJHSGwr5dsI4AL4/LXhSWtYMYwAKeDNDf05txMeR8b6FKB1MNOZEd9Vxw0wKzA3T/GIYgcEwzzZIaKiRK0RV6bpS7NeEh+hxLqtXAcQSbTREuRXhsmhOQ1iye+cIQUp81T2pro9Qkwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073621; c=relaxed/simple;
	bh=8kwfI1TnELzZrOepQChYowYs/1X0jWSVXx7IzEPk/94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAuVP0UcOEFlJz7pmYU9IbCQvB9nV/9hifqFJvBIJZYtoEaZuA6fmICihblCB2h1RCYv6P1VyPBaihYl0YURGoX6heX7dBFv+Da0nfAEk8XwXSTqzQAaGvawOHdJTOqnqhOsBaCXI7o7i3VMkRr7QVDQ0ECHk5UXRL7TOBnatzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=o1I4OYUD; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WnY1R4qpDz2Wn;
	Mon, 19 Aug 2024 15:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724073179;
	bh=EGDgMGiI1rLi1QaH8sGZgwVoYVSJNKc5O3G8+N0zXSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1I4OYUDu88R70pN4oV6zbPXrbNsfQsK1jdit2Ux663X12lHv/JZ3cnirv4eXF4xO
	 V19M39L8hSCV4Tj+d5NrQeNSic5DtP5Mca5RwwMqGItGLu+Ab8G8ApWOobC2E27RYA
	 Wuq6mD1cGE9bqMPx5G4tAn5s8uz6SqixsTodAIw4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WnY1Q3Fv5z94q;
	Mon, 19 Aug 2024 15:12:58 +0200 (CEST)
Date: Mon, 19 Aug 2024 15:12:55 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, Liam Wisehart <liamwisehart@meta.com>, 
	Liang Tang <lltang@meta.com>, Shankaran Gnanashanmugam <shankaran@meta.com>, 
	LSM List <linux-security-module@vger.kernel.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <20240819.Uohee1oongu4@digikod.net>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819-keilen-urlaub-2875ef909760@brauner>
X-Infomaniak-Routing: alpha

On Mon, Aug 19, 2024 at 01:16:04PM +0200, Christian Brauner wrote:
> On Mon, Aug 19, 2024 at 07:18:40AM GMT, Song Liu wrote:
> > Hi Christian, 
> > 
> > Thanks again for your suggestions here. I have got more questions on
> > this work. 
> > 
> > > On Jul 29, 2024, at 6:46 AM, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > [...]
> > 
> > >> I am not sure I follow the suggestion to implement this with 
> > >> security_inode_permission()? Could you please share more details about
> > >> this idea?
> > > 
> > > Given a path like /bin/gcc-6.9/gcc what that code currently does is:
> > > 
> > > * walk down to /bin/gcc-6.9/gcc
> > > * walk up from /bin/gcc-6.9/gcc and then checking xattr labels for:
> > >  gcc
> > >  gcc-6.9/
> > >  bin/
> > >  /
> > > 
> > > That's broken because someone could've done
> > > mv /bin/gcc-6.9/gcc /attack/ and when this walks back and it checks xattrs on
> > > /attack even though the path lookup was for /bin/gcc-6.9. IOW, the
> > > security_file_open() checks have nothing to do with the permission checks that
> > > were done during path lookup.
> > > 
> > > Why isn't that logic:
> > > 
> > > * walk down to /bin/gcc-6.9/gcc and check for each component:
> > > 
> > >  security_inode_permission(/)
> > >  security_inode_permission(gcc-6.9/)
> > >  security_inode_permission(bin/)
> > >  security_inode_permission(gcc)
> > >  security_file_open(gcc)
> > 
> > I am trying to implement this approach. The idea, IIUC, is:
> > 
> > 1. For each open/openat, as we walk the path in do_filp_open=>path_openat, 
> >    check xattr for "/", "gcc-6.9/", "bin/" for all given flags.
> > 2. Save the value of the flag somewhere (for BPF, we can use inode local
> >    storage). This is needed, because openat(dfd, ..) will not start from
> >    root again. 
> > 3. Propagate these flag to children. All the above are done at 
> >    security_inode_permission. 
> > 4. Finally, at security_file_open, check the xattr with the file, which 
> >    is probably propagated from some parents.
> > 
> > Did I get this right? 
> > 
> > IIUC, there are a few issues with this approach. 
> > 
> > 1. security_inode_permission takes inode as parameter. However, we need 
> >    dentry to get the xattr. Shall we change security_inode_permission
> >    to take dentry instead? 
> >    PS: Maybe we should change most/all inode hooks to take dentry instead?
> 
> security_inode_permission() is called in generic_permission() which in
> turn is called from inode_permission() which in turn is called from
> inode->i_op->permission() for various filesystems. So to make
> security_inode_permission() take a dentry argument one would need to
> change all inode->i_op->permission() to take a dentry argument for all
> filesystems. NAK on that.
> 
> That's ignoring that it's just plain wrong to pass a dentry to
> **inode**_permission() or security_**inode**_permission(). It's
> permissions on the inode, not the dentry.
> 
> > 
> > 2. There is no easy way to propagate data from parent. Assuming we already
> >    changed security_inode_permission to take dentry, we still need some
> >    mechanism to look up xattr from the parent, which is probably still 
> >    something like bpf_dget_parent(). Or maybe we should add another hook 
> >    with both parent and child dentry as input?
> > 
> > 3. Given we save the flag from parents in children's inode local storage, 
> >    we may consume non-trivial extra memory. BPF inode local storage will 
> >    be freed as the inode gets freed, so we will not leak any memory or 
> >    overflow some hash map. However, this will probably increase the 
> >    memory consumption of inode by a few percents. I think a "walk-up" 
> >    based approach will not have this problem, as we don't need the extra
> >    storage. Of course, this means more xattr lookups in some cases. 
> > 
> > > 
> > > I think that dget_parent() logic also wouldn't make sense for relative path
> > > lookups:
> > > 
> > > dfd = open("/bin/gcc-6.9", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> > > 
> > > This walks down to /bin/gcc-6.9 and then walks back up (subject to the
> > > same problem mentioned earlier) and check xattrs for:
> > > 
> > >  gcc-6.9
> > >  bin/
> > >  /
> > > 
> > > then that dfd is passed to openat() to open "gcc":
> > > 
> > > fd = openat(dfd, "gcc", O_RDONLY);
> > > 
> > > which again walks up to /bin/gcc-6.9 and checks xattrs for:
> > >  gcc
> > >  gcc-6.9
> > >  bin/
> > >  /
> > > 
> > > Which means this code ends up charging relative lookups twice. Even if one
> > > irons that out in the program this encourages really bad patterns.
> > > Path lookup is iterative top down. One can't just randomly walk back up and
> > > assume that's equivalent.
> > 
> > I understand that walk-up is not equivalent to walk down. But it is probably
> > accurate enough for some security policies. For example, LSM LandLock uses
> > similar logic in the file_open hook (file security/landlock/fs.c, function 
> > is_access_to_paths_allowed). 
> 
> I'm not well-versed in landlock so I'll let Mickaël comment on this with
> more details but there's very important restrictions and differences
> here.
> 
> Landlock expresses security policies with file hierarchies and
> security_inode_permission() doesn't and cannot have access to that.
> 
> Landlock is subject to the same problem that the BPF is here. Namely
> that the VFS permission checking could have been done on a path walk
> completely different from the path walk that is checked when walking
> back up from security_file_open().
> 
> But because landlock works with a deny-by-default security policy this
> is ok and it takes overmounts into account etc.

Correct. Another point is that Landlock uses the file's path (i.e.
dentry + mnt) to walk down to the parent.  Only using the dentry would
be incorrect for most use cases (i.e. any system with more than one
mount point).

> 
> > 
> > To summary my thoughts here. I think we need:
> > 
> > 1. Change security_inode_permission to take dentry instead of inode. 
> 
> Sorry, no.
> 
> > 2. Still add bpf_dget_parent. We will use it with security_inode_permission
> >    so that we can propagate flags from parents to children. We will need
> >    a bpf_dput as well. 
> > 3. There are pros and cons with different approaches to implement this
> >    policy (tags on directory work for all files in it). We probably need 
> >    the policy writer to decide with one to use. From BPF's POV, dget_parent
> >    is "safe", because it won't crash the system. It may encourage some bad
> >    patterns, but it appears to be required in some use cases. 
> 
> You cannot just walk a path upwards and check permissions and assume
> that this is safe unless you have a clear idea what makes it safe in
> this scenario. Landlock has afaict. But so far you only have a vague
> sketch of checking permissions walking upwards and retrieving xattrs
> without any notion of the problems involved.

Something to keep in mind is that relying on xattr to label files
requires to deny sanboxed processes to change this xattr, otherwise it
would be trivial to bypass such a sandbox.  Sandboxing must be though as
a whole and Landlock's design for file system access control takes into
account all kind of file system operations that could bypass a sandbox
policy (e.g. mount operations), and also protects from impersonations.

What is the use case for this patch series?  Couldn't Landlock be used
for that?

> 
> If you provide a bpf_get_parent() api for userspace to consume you'll
> end up providing them with an api that is extremly easy to misuse.

