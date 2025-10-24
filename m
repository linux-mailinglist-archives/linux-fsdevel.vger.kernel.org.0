Return-Path: <linux-fsdevel+bounces-65524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC71C06CA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA2FA35C5C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8C304980;
	Fri, 24 Oct 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8seNLt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FF23AE87;
	Fri, 24 Oct 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317452; cv=none; b=UXChoreHiCMRad9LGJ2ZULYFSWM7ztMPP9g0xqWykW9H7PijbeG1kIBYa8gn/N0MH9KIhQL+DGoVY0zxNY4db71bryrrahLqjwbwPc3LiBB2GU6iuJGPW+qVOuzYGn+YImhDXgDP3KBxNHEYd8/Jo45BUGP1cqSiigjhsKCCqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317452; c=relaxed/simple;
	bh=0knJF7uPO6AofNUjLkQQvkI0kJEMlROapYN6LI2qQlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLpmye7PkKFl9ZYhym6NHyiplHhZXrOxSHTK5tDhbDXsN0aGGcFYYEhWC71BjUjGZY18PYMulRDm0IWglWk1s9vGFzunzDcJjaJHOA7Ewkk4OUIr9oxs8WN3HZgPfDrIK3UFmdMaQ5JcgUvdB4iuapcUg5Gmnp4W3WdnE9JK0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8seNLt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB14C4CEF1;
	Fri, 24 Oct 2025 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761317452;
	bh=0knJF7uPO6AofNUjLkQQvkI0kJEMlROapYN6LI2qQlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8seNLt5RF176sZd6t2usJg6+ak1kThL3v1R1UTT43sFOzps+l0LW6+qqN1YXaOx8
	 7G/ugiiZ9KyWkayAGz2cf+0Dkc9NA8WKB6Y9o3lfP2XbiaH3eqsmDVqNugHrZjWZKf
	 ighuDrTNgD1XhVcflIq6Z8ImsGEvPJr4tyXK12HZedFj8fLQrLGSjZhpYyTlfVhXkC
	 Y000Gf13lfSV3wCRZLYNjoCxvQwr1+7WXw06Wwq4Zv/FErQ75Eh6JBMnu3c1HeaJhe
	 IpVGcslSDxM0wR09pKb1kFEDPBjorrfiRibxjWUq5cwo72/cZfUrKT7iebRWaLpeO9
	 TLAuPc+M0yXpQ==
Date: Fri, 24 Oct 2025 16:50:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ferenc Fejes <ferenc@fejes.dev>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC DRAFT 00/50] nstree: listns()
Message-ID: <20251024-rostig-stier-0bcd991850f5@brauner>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
 <f708a1119b2ad8cf2514b1df128a4ef7cf21c636.camel@fejes.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f708a1119b2ad8cf2514b1df128a4ef7cf21c636.camel@fejes.dev>

> > Add a new listns() system call that allows userspace to iterate through
> > namespaces in the system. This provides a programmatic interface to
> > discover and inspect namespaces, enhancing existing namespace apis.
> > 
> > Currently, there is no direct way for userspace to enumerate namespaces
> > in the system. Applications must resort to scanning /proc/<pid>/ns/
> > across all processes, which is:
> > 
> > 1. Inefficient - requires iterating over all processes
> > 2. Incomplete - misses inactive namespaces that aren't attached to any
> >    running process but are kept alive by file descriptors, bind mounts,
> >    or parent namespace references
> > 3. Permission-heavy - requires access to /proc for many processes
> > 4. No ordering or ownership.
> > 5. No filtering per namespace type: Must always iterate and check all
> >    namespaces.
> > 
> > The list goes on. The listns() system call solves these problems by
> > providing direct kernel-level enumeration of namespaces. It is similar
> > to listmount() but obviously tailored to namespaces.
> 
> I've been waiting for such an API for years; thanks for working on it. I mostly
> deal with network namespaces, where points 2 and 3 are especially painful.
> 
> Recently, I've used this eBPF snippet to discover (at most 1024, because of the
> verifier's halt checking) network namespaces, even if no process is attached.
> But I can't do anything with it in userspace since it's not possible to pass the
> inode number or netns cookie value to setns()...

I've mentioned it in the cover letter and in my earlier reply to Josef:

On v6.18+ kernels it is possible to generate and open file handles to
namespaces. This is probably an api that people outside of fs/ proper
aren't all that familiar with.

In essence it allows you to refer to files - or more-general:
kernel-object that may be referenced via files - via opaque handles
instead of paths.

For regular filesystem that are multi-instance (IOW, you can have
multiple btrfs or ext4 filesystems mounted) such file handles cannot be
used without providing a file descriptor to another object in the
filesystem that is used to resolve the file handle...

However, for single-instance filesystems like pidfs and nsfs that's not
required which is why I added:

FD_PIDFS_ROOT
FD_NSFS_ROOT

which means that you can open both pidfds and namespace via
open_by_handle_at() purely based on the file handle. I call such file
handles "exhaustive file handles" because they fully describe the object
to be resolvable without any further information.

They are also not subject to the capable(CAP_DAC_READ_SEARCH) permission
check that regular file handles are and so can be used even by
unprivileged code as long as the caller is sufficiently privileged over
the relevant object (pid resolvable in caller's pid namespace of pidfds,
or caller located in namespace or privileged over the owning user
namespace of the relevant namespace for nsfs).

File handles for namespaces have the following uapi:

struct nsfs_file_handle {
	__u64 ns_id;
	__u32 ns_type;
	__u32 ns_inum;
};

#define NSFS_FILE_HANDLE_SIZE_VER0 16 /* sizeof first published struct */
#define NSFS_FILE_HANDLE_SIZE_LATEST sizeof(struct nsfs_file_handle) /* sizeof latest published struct */

and it is explicitly allowed to generate such file handles manually in
userspace. When the kernel generates a namespace file handle via
name_to_handle_at() till will return: ns_id, ns_type, and ns_inum but
userspace is allowed to provide the kernel with a laxer file handle
where only the ns_id is filled in but ns_type and ns_inum are zero - at
least after this patch series.

So for your case where you even know inode number, ns type, and ns id
you can fill in a struct nsfs_file_handle and either look at my reply to
Josef or in the (ugly) tests.

fd = open_by_handle_at(FD_NSFS_ROOT, file_handle, O_RDONLY);

and can open the namespace (provided it is still active).

> 
> extern const void net_namespace_list __ksym;
> static void list_all_netns()
> {
>     struct list_head *nslist = 
> 	bpf_core_cast(&net_namespace_list, struct list_head);
> 
>     struct list_head *iter = nslist->next;
> 
>     bpf_repeat(1024) {

This isn't needed anymore. I've implemented it in a bpf-friendly way so
it's possible to add kfuncs that would allow you to iterate through the
various namespace trees (locklessly).

If this is merged then I'll likely design that bpf part myself.

> After this merged, do you see any chance for backports? Does it rely on recent
> bits which is hard/impossible to backport? I'm not aware of backported syscalls
> but this would be really nice to see in older kernels.

Uhm, what downstream entities, managing kernels do is not my concern but
for upstream it's certainly not an option. There's a lot of preparatory
work that would have to be backported.

