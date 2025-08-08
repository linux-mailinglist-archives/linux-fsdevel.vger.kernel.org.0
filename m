Return-Path: <linux-fsdevel+bounces-57091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D21B1EA15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591B77B5C17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FFC27F006;
	Fri,  8 Aug 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/K4Hlfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AD27E05E;
	Fri,  8 Aug 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662346; cv=none; b=iild48Ud9ypavU0/rJtgng1kXhN3gGFz8LqrJadNp8r9VL6efGGjgc0L/27SmqeHHAjNMVPzTGnlpg1GFAx4NyVhA/WhEj4sjLCFNbBmNaiyjNnLryAmKN5eCzk5Br88Y5SSaxPxljxvaAYJ1gb91MlEkVoU2tk2uchKHICCb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662346; c=relaxed/simple;
	bh=Yq4JBb/hsbhU89dMDt4TrHpKLmZvJDervBYp9pOoGGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puvdM1lNyq1oIb4zkodoqpFqyjEZ3Q745CjgcZRowO+wtJvBIbaPfPpO7dZYuGJPZAJynfRalzdtOhEtqRikixevKDFUxP2ZdRMOgSRJobV8nBSyibkWxU1FZ71zARQ7Hilt7FaE5GVYwCjJ+mycIlLEF3er6gpuow5qv2AEwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/K4Hlfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABFDC4CEED;
	Fri,  8 Aug 2025 14:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754662345;
	bh=Yq4JBb/hsbhU89dMDt4TrHpKLmZvJDervBYp9pOoGGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/K4HlfuUx6LKpoZIrIKCA2MAiFpC4iF0lEvFYy09fFdkV6dPqamM2jha/o6PkLgL
	 mZH0CME3E66XouhzLMj9MeKSTjdbXU7/boNBpophSGxLfNflGo5y/PyiBH/canKd3N
	 4zLPs542wfJxub1Q8KOrnmjN0XcreUrsYSncXlqTNtf5uoIxT4ZBkmsVSzWJqpCXGq
	 4nvXO041HWaz9+KogFg9qUx0JFaN6wftY/S+oz1sp1BlqHmCujK4mQ4X9faPUU73hW
	 EB9tM9nx+oI2KFdpiZFRgJDU9CVrZvveb3M1WBYBWuBCXzAHAP2PH3Rz/Gb1WCWvWG
	 GRtvYBczaC7/A==
Date: Fri, 8 Aug 2025 16:12:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Message-ID: <20250808-huschen-jazzband-c7d1ba351773@brauner>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250805-procfs-pidns-api-v4-3-705f984940e7@cyphar.com>
 <9027aa89-b3b2-46c8-8338-6c37f1c5b97a@infradead.org>
 <2025-08-06.1754503216-vulgar-pinch-more-tasks-meager-grader-93KeQn@cyphar.com>
 <1ea6f1d9-550d-4b81-bade-1a0ca14c27c6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ea6f1d9-550d-4b81-bade-1a0ca14c27c6@infradead.org>

On Wed, Aug 06, 2025 at 11:57:42AM -0700, Randy Dunlap wrote:
> 
> 
> On 8/6/25 11:02 AM, Aleksa Sarai wrote:
> > On 2025-08-05, Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >>
> >> On 8/4/25 10:45 PM, Aleksa Sarai wrote:
> >>> /proc has historically had very opaque semantics about PID namespaces,
> >>> which is a little unfortunate for container runtimes and other programs
> >>> that deal with switching namespaces very often. One common issue is that
> >>> of converting between PIDs in the process's namespace and PIDs in the
> >>> namespace of /proc.
> >>>
> >>> In principle, it is possible to do this today by opening a pidfd with
> >>> pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
> >>> contain a PID value translated to the pid namespace associated with that
> >>> procfs superblock). However, allocating a new file for each PID to be
> >>> converted is less than ideal for programs that may need to scan procfs,
> >>> and it is generally useful for userspace to be able to finally get this
> >>> information from procfs.
> >>>
> >>> So, add a new API to get the pid namespace of a procfs instance, in the
> >>> form of an ioctl(2) you can call on the root directory of said procfs.
> >>> The returned file descriptor will have O_CLOEXEC set. This acts as a
> >>> sister feature to the new "pidns" mount option, finally allowing
> >>> userspace full control of the pid namespaces associated with procfs
> >>> instances.
> >>>
> >>> The permission model for this is a bit looser than that of the "pidns"
> >>> mount option (and also setns(2)) because /proc/1/ns/pid provides the
> >>> same information, so as long as you have access to that magic-link (or
> >>> something equivalently reasonable such as being in an ancestor pid
> >>> namespace) it makes sense to allow userspace to grab a handle. Ideally
> >>> we would check for ptrace-read access against all processes in the pidns
> >>> (which is very likely to be true for at least one process, as
> >>> SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set by most
> >>> programs), but this would obviously not scale.
> >>>
> >>> setns(2) will still have their own permission checks, so being able to
> >>> open a pidns handle doesn't really provide too many other capabilities.
> >>>
> >>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> >>> ---
> >>>  Documentation/filesystems/proc.rst |  4 +++
> >>>  fs/proc/root.c                     | 68 ++++++++++++++++++++++++++++++++++++--
> >>>  include/uapi/linux/fs.h            |  4 +++
> >>>  3 files changed, 74 insertions(+), 2 deletions(-)
> >>>
> >>
> >>
> >>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> >>> index 0bd678a4a10e..68e65e6d7d6b 100644
> >>> --- a/include/uapi/linux/fs.h
> >>> +++ b/include/uapi/linux/fs.h
> >>> @@ -435,8 +435,12 @@ typedef int __bitwise __kernel_rwf_t;
> >>>  			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
> >>>  			 RWF_DONTCACHE)
> >>>  
> >>> +/* This matches XSDFEC_MAGIC, so we need to allocate subvalues carefully. */
> >>>  #define PROCFS_IOCTL_MAGIC 'f'
> >>>  
> >>> +/* procfs root ioctls */
> >>> +#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 32)
> >>
> >> Since the _IO() nr here is 32, Documentation/userspace-api/ioctl/ioctl-number.rst
> >> should be updated like:
> >>
> >> -'f'   00-0F  linux/fs.h                                                conflict!
> >> +'f'   00-1F  linux/fs.h                                                conflict!
> > 
> > Should this be 00-20 (or 00-2F) instead?
> 
> Oops, yes, it should be one of those. Thanks.
> 
> > Also, is there a better value to use for this new ioctl? I'm not quite
> > sure what is the best practice to handle these kinds of conflicts...
> 
> I wouldn't worry about it. We have *many* conflicts.
> (unless Al or Christian are concerned)

We try to minimize conflicts but we unfortunately give no strong
guarantees in any way. I always defer to Arnd in such matters as he's
got a pretty good mental model of what is best to do for ioctls.

> 
> >> (17 is already used for PROCFS_IOCTL_MAGIC somewhere else, so that probably should
> >> have update the Doc/rst file.)

