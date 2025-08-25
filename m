Return-Path: <linux-fsdevel+bounces-58987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829FB33B29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4220C18884C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934126C3BF;
	Mon, 25 Aug 2025 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lfz1vs26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC06221299
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114317; cv=none; b=DpZJxbZtLBhmml1/3fompbX50dk5Mj8uJ5C7q4K0DVxm4c3Kzn/p0A+Uu9fexsd2PoNyJZTaYiH/Y5/7FfEaa4aDqe+P3af3dLdyZ7d56JJuxIgdrVSbi3aiJMuT8Fi0AFJFM55gpZxBFcNx/gaQDoapgDjfkh0tm+PPOKhye2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114317; c=relaxed/simple;
	bh=uxUyieml/K+cEmLmB94nhLa9rZ+8OnJOzJpO5gZRxjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+REYZzixKdII8EVv0OYbHv/E9egB+KWuM/fmvdUvhbIlhu9n1b9Z3DwyuRS8s3geUnU+40KCEzWaRyXAMhgGZNB8awyypuqzGkmAhTmawmpAaF8Zt0B+tuopcnN4zX9Zs8lWBJAdzoRxHTNpMxEv6bXzAlWXFUp7r3d8NzPYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lfz1vs26; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c9QXx4LsSz11Zf;
	Mon, 25 Aug 2025 11:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756114305;
	bh=6c3YchL3/fNwRCulq0i15lYi7C15uJVbj/gOpRwjky8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfz1vs26y2WCKJQVnGmddHJD7X7EX16GQk3wc72nxeHl34P299PKqPNvyK390Ip4i
	 5a7VLdMRTJStXNDtE0ro/Z7M7gLcsu/311EA+rHLzJccd17tSxHO+o/Q3K3C8ZhiIy
	 o8iDyrPylRY6iM03oLhJhVVIM4Ux+hgJ4WNFNu20=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4c9QXv2dP9zRVl;
	Mon, 25 Aug 2025 11:31:43 +0200 (CEST)
Date: Mon, 25 Aug 2025 11:31:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
Message-ID: <20250825.mahNeel0dohz@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net>
 <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> On Sun, Aug 24, 2025 at 4:03 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > On Fri, Aug 22, 2025 at 7:08 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > Add a new O_DENY_WRITE flag usable at open time and on opened file (e.g.
> > > > passed file descriptors).  This changes the state of the opened file by
> > > > making it read-only until it is closed.  The main use case is for script
> > > > interpreters to get the guarantee that script' content cannot be altered
> > > > while being read and interpreted.  This is useful for generic distros
> > > > that may not have a write-xor-execute policy.  See commit a5874fde3c08
> > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > >
> > > > Both execve(2) and the IOCTL to enable fsverity can already set this
> > > > property on files with deny_write_access().  This new O_DENY_WRITE make
> > >
> > > The kernel actually tried to get rid of this behavior on execve() in
> > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
> > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> > > because it broke userspace assumptions.
> >
> > Oh, good to know.
> >
> > >
> > > > it widely available.  This is similar to what other OSs may provide
> > > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> > >
> > > We used to have the analogous mmap() flag MAP_DENYWRITE, and that was
> > > removed for security reasons; as
> > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > >
> > > |        MAP_DENYWRITE
> > > |               This flag is ignored.  (Long ago—Linux 2.0 and earlier—it
> > > |               signaled that attempts to write to the underlying file
> > > |               should fail with ETXTBSY.  But this was a source of denial-
> > > |               of-service attacks.)"
> > >
> > > It seems to me that the same issue applies to your patch - it would
> > > allow unprivileged processes to essentially lock files such that other
> > > processes can't write to them anymore. This might allow unprivileged
> > > users to prevent root from updating config files or stuff like that if
> > > they're updated in-place.
> >
> > Yes, I agree, but since it is the case for executed files I though it
> > was worth starting a discussion on this topic.  This new flag could be
> > restricted to executable files, but we should avoid system-wide locks
> > like this.  I'm not sure how Windows handle these issues though.
> >
> > Anyway, we should rely on the access control policy to control write and
> > execute access in a consistent way (e.g. write-xor-execute).  Thanks for
> > the references and the background!
> 
> I'm confused.  I understand that there are many contexts in which one
> would want to prevent execution of unapproved content, which might
> include preventing a given process from modifying some code and then
> executing it.
> 
> I don't understand what these deny-write features have to do with it.
> These features merely prevent someone from modifying code *that is
> currently in use*, which is not at all the same thing as preventing
> modifying code that might get executed -- one can often modify
> contents *before* executing those contents.

The order of checks would be:
1. open script with O_DENY_WRITE
2. check executability with AT_EXECVE_CHECK
3. read the content and interpret it

The deny-write feature was to guarantee that there is no race condition
between step 2 and 3.  All these checks are supposed to be done by a
trusted interpreter (which is allowed to be executed).  The
AT_EXECVE_CHECK call enables the caller to know if the kernel (and
associated security policies) allowed the *current* content of the file
to be executed.  Whatever happen before or after that (wrt.
O_DENY_WRITE) should be covered by the security policy.

> 
> In any case, IMO it's rather sad that the elimination of ETXTBSY had
> to be reverted -- it's really quite a nasty feature.  But it occurs to
> me that Linux can more or less do what is IMO the actually desired
> thing: snapshot the contents of a file and execute the snapshot.  The
> hack at the end of the email works!  (Well, it works if the chosen
> filesystem supports it.)
> 
> $ ./silly_tmp /tmp/test /tmp vim /proc/self/fd/3
> 
> emacs is apparently far, far too clever and can't save if you do:
> 
> $ ./silly_tmp /tmp/test /tmp emacs /proc/self/fd/3
> 
> 
> I'm not seriously suggesting that anyone should execute binaries or
> scripts on Linux exactly like this, for a whole bunch of reasons:
> 
> - It needs filesystem support (but maybe this isn't so bad)
> 
> - It needs write access to a directory on the correct filesystem (a
> showstopper for serious use)
> 
> - It is wildly incompatible with write-xor-execute, so this would be a
> case of one step forward, ten steps back.
> 
> - It would defeat a lot of tools that inspect /proc, which would be
> quite annoying to say the least.
> 
> 
> But maybe a less kludgy version could be used for real.  What if there
> was a syscall that would take an fd and make a snapshot of the file?

Yes, that would be a clean solution.  I don't think this is achievable
in an efficient way without involving filesystem implementations though.

> It would, at least by default, produce a *read-only* snapshot (fully
> sealed a la F_SEAL_*), inherit any integrity data that came with the
> source (e.g. LSMs could understand it), would not require a writable
> directory on the filesystem, and would maybe even come with an extra
> seal-like thing that prevents it from being linkat-ed.  (I'm not sure
> that linkat would actually be a problem, but I'm also not immediately
> sure that LSMs would be as comfortable with it if linkat were
> allowed.)  And there could probably be an extremely efficient
> implementation that might even reuse the existing deny-write mechanism
> to optimize the common case where the file is never written.
> 
> For that matter, the actual common case would be to execute stuff in
> /usr or similar, and those files really ought never to be modified.
> So there could be a file attribute or something that means "this file
> CANNOT be modified, but it can still be unlinked or replaced as
> usual", and snapshotting such a file would be a no-op.  Distributions
> and container tools could set that attribute.  Overlayfs could also
> provide an efficient implementation if the file currently comes from
> an immutable source.
> 
> Hmm, maybe it's not strictly necessary that it be immutable -- maybe
> it's sometimes okay if reads start to fail if the contents change.
> Let's call this a "weak snapshot" -- reads of a weak snapshot either
> return the original contents or fail.  fsverity would give weak
> snapshots for at no additional cost.
> 
> 
> It's worth noting that the common case doesn't actually need an fd.
> We have mmap(..., MAP_PRIVATE, ...).  What we would actually want for
> mmap use cases is mmap(..., MAP_SNAPSHOT, ...), with the semantics
> that the kernel promises that future writes to the source would either
> not be reflected in the mapping or would cause SIGBUS.  One might
> reasonably debate what forced-writes would do (I think forced-writes
> should be allowed just like they currently are, since anyone who can
> force-write to process memory is already assumed to be permitted to
> bypass write-xor-execute).
> 
> 
> ---
> 
> /* Written by Claude Sonnet 4 with a surprisingly small amount of help
> from Andy */
> 
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/fs.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <string.h>
> 
> int main(int argc, char *argv[]) {
>     if (argc < 4) {
>         fprintf(stderr, "Usage: %s <source_file> <temp_dir>
> [exec_args...]\n", argv[0]);
>         exit(1);
>     }
> 
>     const char *source_file = argv[1];
>     const char *temp_dir = argv[2];
> 
>     // Open source file
>     int source_fd = open(source_file, O_RDONLY);
>     if (source_fd == -1) {
>         perror("Failed to open source file");
>         exit(1);
>     }
> 
>     // Create temporary file
>     int temp_fd = open(temp_dir, O_TMPFILE | O_RDWR, 0600);
>     if (temp_fd == -1) {
>         perror("Failed to create temporary file");
>         close(source_fd);
>         exit(1);
>     }
> 
>     // Clone the file contents using FICLONE
>     if (ioctl(temp_fd, FICLONE, source_fd) == -1) {
>         perror("Failed to clone file");
>         close(source_fd);
>         close(temp_fd);
>         exit(1);
>     }
> 
>     // Close source file
>     close(source_fd);
> 
>     // Make sure temp file is on fd 3
>     if (temp_fd != 3) {
>         if (dup2(temp_fd, 3) == -1) {
>             perror("Failed to move temp file to fd 3");
>             close(temp_fd);
>             exit(1);
>         }
>         close(temp_fd);
>     }
> 
>     // Execute the remaining arguments
>     if (argc >= 3) {
>         execvp(argv[3], &argv[3]);
>         perror("Failed to execute command");
>         exit(1);
>     }
> 
>     return 0;
> }

As you said, this doesn't work if temp_dir is not allowed for execution,
and it doesn't allow the kernel to check/track the content of the
script, which is the purpose of AT_EXECVE_CHECK.

