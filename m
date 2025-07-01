Return-Path: <linux-fsdevel+bounces-53460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E841AEF3EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D37A3A9928
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A1426E708;
	Tue,  1 Jul 2025 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYRYrPhJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C21E570D;
	Tue,  1 Jul 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363498; cv=none; b=krkS5nGaAY/CFaZKo9A37F82f6GKdV5fCAPye9aRwia8kIfkGJ/dP6ct0dlK69XpzHwgy1ZhF/n1oG61PhHneJFh2VNIMuOIATXwqjbdfAZyh02AbG7Fswhd6j1urkUDKByZO/tW637PfP6087ikkJWAE0gAncI77nC18NXYGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363498; c=relaxed/simple;
	bh=G0wgPOHRx3LlMlIx4NAFoKBKanEvhm1EAVKcVObjvNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N05BZGdWbOs+Ef3lIvLJQiE7VolntT28UyKdyXLsGsxANRL1wM+r5BV2YjLfZ20WVIJV8d3MzWgg9TSu8O7fVUJu0HjZqKYpyGE50ZR8GVZUsvDC37urR8zPNmdUDb79dpw3z7jFHjy4jkmOg40k/IfmPBG6EPF7ecFw6ZaYG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYRYrPhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFE8C4CEEB;
	Tue,  1 Jul 2025 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751363498;
	bh=G0wgPOHRx3LlMlIx4NAFoKBKanEvhm1EAVKcVObjvNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYRYrPhJWHZ9fUEWlHZO9NimOFkJK6Z2iulYKr43EQEQidzjt3xWuzmi6vbtdyUMy
	 TkW+MGKi8bQ16eBjg5su4O6GjZs7f3dOIMt1zel/j5DuQbmzR1yOY+GhTyJ2UGLzvl
	 np8qLCWSoXPQShq8CX8JcmxNT/Y7nflGtgxlkm8JtL37zx0bpnWpTPsWXWQbpucmxT
	 wC45jyGDX884jM9UHmp2GpdyDmdjq04Pg6rqArVZphLuo4tT7awgfBGNcHvUO26TTS
	 q/1jArAqGTfFNh7vB2l/WKLwLymwhKnOhZmxbOwqMZnrkjcxwURU8NwFV4PqAbJSIi
	 txoIi0hWHxllw==
Date: Tue, 1 Jul 2025 11:51:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org, 
	dada1@cosmosbay.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: Prevent file descriptor table allocations exceeding
 INT_MAX
Message-ID: <20250701-laufkundschaft-beackern-60094bf6570c@brauner>
References: <20250629074021.1038845-1-sashal@kernel.org>
 <i3l4wxfnnnqfg76yg22zfjwzluog2buvc7rtpp67nnxtbslsb3@sggjxvhv7j2h>
 <aGIA18cgkzv-05A2@lappy>
 <CAGudoHHuBBX_FWKp96TZV7vs2xvxkFNkukt4wysx7K3OZDsLDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHuBBX_FWKp96TZV7vs2xvxkFNkukt4wysx7K3OZDsLDw@mail.gmail.com>

On Mon, Jun 30, 2025 at 01:35:08PM +0200, Mateusz Guzik wrote:
> On Mon, Jun 30, 2025 at 5:13 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Sun, Jun 29, 2025 at 09:58:12PM +0200, Mateusz Guzik wrote:
> > >On Sun, Jun 29, 2025 at 03:40:21AM -0400, Sasha Levin wrote:
> > >> When sysctl_nr_open is set to a very high value (for example, 1073741816
> > >> as set by systemd), processes attempting to use file descriptors near

Note that systemd caps all services/processes it starts to 500k fds by
default. So someone would have to hand-massage the per process limit
like in your example.

And fwiw, allocating file descriptors above INT_MAX is inherently unsafe
because we have stuff like:

#define AT_FDWCD -100

If we allow file descriptor allocation above INT_MAX it's easy to
allocate a file descriptor at 4294967196 which is AT_FDCWD. If you pass
that to fchmodat() or something similar you have a problem because
instead of changing whatever the file descriptor points to you're
changing your current working directory.

Since we have a bunch of system calls that return file descriptors such
as pidfd_open() returning above INT_MAX would mean we'd return errnos as
valid fds, e.g., ENETDOWN for an AT_FDCWD range allocation.

But what's annoying is that we are communicating very confusing things
to userspace by being inconsistent in our system call interface.

We have system calls that accept int as the file descriptor type
(fallocate() faccessat() fchmodat() etc) and then we have system calls
that accept unsigned int as the file descriptor type (close()
ftruncate() fchdir() fchmod() etc).

What makes it all worse is that glibc enforces that all fd-based system
calls take int as an argument:

close(2)                              System Calls Manual                              close(2)

NAME
       close - close a file descriptor

LIBRARY
       Standard C library (libc, -lc)

SYNOPSIS
       #include <unistd.h>

       int close(int fd);

So we now also have a userspace-kernel disconnect.

> > >> the limit can trigger massive memory allocation attempts that exceed
> > >> INT_MAX, resulting in a WARNING in mm/slub.c:
> > >>
> > >>   WARNING: CPU: 0 PID: 44 at mm/slub.c:5027 __kvmalloc_node_noprof+0x21a/0x288
> > >>
> > >> This happens because kvmalloc_array() and kvmalloc() check if the
> > >> requested size exceeds INT_MAX and emit a warning when the allocation is
> > >> not flagged with __GFP_NOWARN.
> > >>
> > >> Specifically, when nr_open is set to 1073741816 (0x3ffffff8) and a
> > >> process calls dup2(oldfd, 1073741880), the kernel attempts to allocate:
> > >> - File descriptor array: 1073741880 * 8 bytes = 8,589,935,040 bytes
> > >> - Multiple bitmaps: ~400MB
> > >> - Total allocation size: > 8GB (exceeding INT_MAX = 2,147,483,647)
> > >>
> > >> Reproducer:
> > >> 1. Set /proc/sys/fs/nr_open to 1073741816:
> > >>    # echo 1073741816 > /proc/sys/fs/nr_open
> > >>
> > >> 2. Run a program that uses a high file descriptor:
> > >>    #include <unistd.h>
> > >>    #include <sys/resource.h>
> > >>
> > >>    int main() {
> > >>        struct rlimit rlim = {1073741824, 1073741824};
> > >>        setrlimit(RLIMIT_NOFILE, &rlim);
> > >>        dup2(2, 1073741880);  // Triggers the warning
> > >>        return 0;
> > >>    }
> > >>
> > >> 3. Observe WARNING in dmesg at mm/slub.c:5027
> > >>
> > >> systemd commit a8b627a introduced automatic bumping of fs.nr_open to the
> > >> maximum possible value. The rationale was that systems with memory
> > >> control groups (memcg) no longer need separate file descriptor limits
> > >> since memory is properly accounted. However, this change overlooked
> > >> that:
> > >>
> > >> 1. The kernel's allocation functions still enforce INT_MAX as a maximum
> > >>    size regardless of memcg accounting
> > >> 2. Programs and tests that legitimately test file descriptor limits can
> > >>    inadvertently trigger massive allocations
> > >> 3. The resulting allocations (>8GB) are impractical and will always fail
> > >>
> > >
> > >alloc_fdtable() seems like the wrong place to do it.
> > >
> > >If there is an explicit de facto limit, the machinery which alters
> > >fs.nr_open should validate against it.
> > >
> > >I understand this might result in systemd setting a new value which
> > >significantly lower than what it uses now which technically is a change
> > >in behavior, but I don't think it's a big deal.
> > >
> > >I'm assuming the kernel can't just set the value to something very high
> > >by default.
> > >
> > >But in that case perhaps it could expose the max settable value? Then
> > >systemd would not have to guess.
> >
> > The patch is in alloc_fdtable() because it's addressing a memory
> > allocator limitation, not a fundamental file descriptor limitation.
> >
> > The INT_MAX restriction comes from kvmalloc(), not from any inherent
> > constraint on how many FDs a process can have. If we implemented sparse
> > FD tables or if kvmalloc() later supports larger allocations, the same
> > nr_open value could become usable without any changes to FD handling
> > code.
> >
> > Putting the check at the sysctl layer would codify a temporary
> > implementation detail of the memory allocator as if it were a
> > fundamental FD limit. By keeping it at the allocation point, the check

Yeah, I tend to agree.

> > reflects what it actually is - a current limitation of how large a
> > contiguous allocation we can make.
> >
> > This placement also means the limit naturally adjusts if the underlying
> > implementation changes, rather than requiring coordinated updates
> > between the sysctl validation and the allocator capabilities.
> >
> > I don't have a strong opinion either way...

I think Mateusz' idea of exposing the maximum supported value in procfs
as a read-only file is probably pretty sensible. Userspace like systemd
has to do stuff like if you want to allow large number of fds by
default:

#if BUMP_PROC_SYS_FS_NR_OPEN
        int v = INT_MAX;

        /* Argh! The kernel enforces maximum and minimum values on the fs.nr_open, but we don't really know
         * what they are. The expression by which the maximum is determined is dependent on the architecture,
         * and is something we don't really want to copy to userspace, as it is dependent on implementation
         * details of the kernel. Since the kernel doesn't expose the maximum value to us, we can only try
         * and hope. Hence, let's start with INT_MAX, and then keep halving the value until we find one that
         * works. Ugly? Yes, absolutely, but kernel APIs are kernel APIs, so what do can we do... 🤯 */

        for (;;) {
                int k;

                v &= ~(__SIZEOF_POINTER__ - 1); /* Round down to next multiple of the pointer size */
                if (v < 1024) {
                        log_warning("Can't bump fs.nr_open, value too small.");
                        break;
                }

                k = read_nr_open();
                if (k < 0) {
                        log_error_errno(k, "Failed to read fs.nr_open: %m");
                        break;
                }
                if (k >= v) { /* Already larger */
                        log_debug("Skipping bump, value is already larger.");
                        break;
                }

                r = sysctl_writef("fs/nr_open", "%i", v);
                if (r == -EINVAL) {
                        log_debug("Couldn't write fs.nr_open as %i, halving it.", v);
                        v /= 2;
                        continue;
                }
                if (r < 0) {
                        log_full_errno(IN_SET(r, -EROFS, -EPERM, -EACCES) ? LOG_DEBUG : LOG_WARNING, r, "Failed to bump fs.nr_open, ignoring: %m");
                        break;
                }

                log_debug("Successfully bumped fs.nr_open to %i", v);
                break;
        }
#endif

