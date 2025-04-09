Return-Path: <linux-fsdevel+bounces-46053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22CA82033
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382693B16DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F40D25D1E7;
	Wed,  9 Apr 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LToqfAyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D924EF6E;
	Wed,  9 Apr 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187794; cv=none; b=AZtj15h3+mAouOYsTDEIv5m46460r0YplYfxiApYwMCJSZ1jUncMO3z+68WJqAglwohHoKxULBW+l41+6mWYZ2uzfPmymNmaI6fKsf9nM7jRIbHEu/gmW9cTbyjc8aS79I4zTpjd/8R7aDKMl5g9Ue7ACzJYTVvgFEIKwOTJW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187794; c=relaxed/simple;
	bh=vX+yZVgdB9/F5MVYvn74uJvoipKBMh2DUd7klkO7k9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEl946XomQ2tBoBVGKZHK/qxVPLdSQ47VZeQZJz5OZXs/EyK1P7VZEMNpQRublB/jOONhYUouSJY+xWLuTahmAArjZJy8U1hj8LxK2JibwCAjwPisO0FlYzv5RNPH7Ht1oCtih+4/cNp8phigAOzsClFSYsoRD5EkfVejc9s8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LToqfAyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F804C4CEE3;
	Wed,  9 Apr 2025 08:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744187794;
	bh=vX+yZVgdB9/F5MVYvn74uJvoipKBMh2DUd7klkO7k9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LToqfAyZBCAwbrvMCMoeHIj0Lxug8wM554pi3hWLDi3YOomdjvMQXBliD4xgl8EGj
	 NpK5L6cfCseJR/8kFixUbWCaUvKUTek8yVYvtgzcBJAXlIeMcGtniKZrD70Wm65yIV
	 ubUWNgqGxqw88dpvGkBezGf3uXGpI1oabMCUj8ujP+iB5s9RvIy5aZKznDwjisK+AL
	 cFVBwnnTLexCbcss/E6LORaCIdmfxwBkHDb0ZfLvKtFd5yWzjMKJnYJqFEsprn1i1O
	 JX7Rnyj5DkpdRw6FL16CCxJyqSlCp0yivyoHecmuJzsUuXmefr9RjUzoAsbKXSkAdw
	 ULp4ymWjwMBQg==
Date: Wed, 9 Apr 2025 10:36:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux regressions mailing list <regressions@lists.linux.dev>, 
	lennart@poettering.net
Subject: Re: 6.15-rc1/regression/bisected - commit 474f7825d533 is broke
 systemd-nspawn on my system
Message-ID: <20250409-sektflaschen-gecko-27c021fbd222@brauner>
References: <CABXGCsPXitW-5USFdP4fTGt5vh5J8MRZV+8J873tn7NYXU61wQ@mail.gmail.com>
 <20250407-unmodern-abkam-ce0395573fc2@brauner>
 <CABXGCsNk2ycAKBtOG6fum016sa_-O9kD04betBVyiUTWwuBqsQ@mail.gmail.com>
 <20250408-regal-kommt-724350b8a186@brauner>
 <CABXGCsPzb3KzJQph_PCg6N7526FEMqtidejNRZ0heF6Mv2xwdA@mail.gmail.com>
 <20250408-vorher-karnickel-330646f410bd@brauner>
 <CABXGCsO56m1e6EO82JNxT6-DGt6isp-9Wf1fk4Pk10ju=-zmVA@mail.gmail.com>
 <20250408-deprimierend-bewandern-6c2878453555@brauner>
 <CABXGCsPx7X7aTtS_9XopXb29r9n=Tjxm7ik007XDOhzS7-WCSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsPx7X7aTtS_9XopXb29r9n=Tjxm7ik007XDOhzS7-WCSw@mail.gmail.com>

On Tue, Apr 08, 2025 at 06:05:23PM +0500, Mikhail Gavrilov wrote:
> On Tue, Apr 8, 2025 at 3:22 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> >
> > Resolved it for you:
> >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.bisect
> 
> I can confirm that systemd-nspawn is working on the kernel built from
> branch work.bisect.
> It confirms the correctness of my bisect.
> 
> > sudo /usr/bin/systemd-nspawn -q --ephemeral -D /var/lib/mock/fedora-rawhide-x86_64/root
> [sudo] password for mikhail:
> [root@root-7a084a9cbe689c8a ~]# uname -r
> 6.15.0-rc1-work.bisect+
> 
> And I attached the full kernel log below.

Ok, I see the bug. It's caused by pecularity in systemd that a specific
implementation detail of mount_setattr() papered over.

Basically, I added a shortcut to mount_settatr():

        /* Don't bother walking through the mounts if this is a nop. */
        if (attr.attr_set == 0 &&
            attr.attr_clr == 0 &&
            attr.propagation == 0)
                return 0;

So that we:

* don't pointlessly do path lookup
* don't pointlessly walk the mount tree and hold the namespace semaphore etc.

When I added copy_mount_setattr() this cycle this optimization got
broken because I moved it into this helper and we now do path lookup and
walk the mount tree even if there's no mount properties to change at
all.

That's just a performance thing, not a correctness thing though.

systemd has the following code:

	int make_fsmount(
	                int error_log_level,
	                const char *what,
	                const char *type,
	                unsigned long flags,
	                const char *options,
	                int userns_fd) {
	
<snip>
	
	        mnt_fd = fsmount(fs_fd, FSMOUNT_CLOEXEC, 0);
	        if (mnt_fd < 0)
	                return log_full_errno(error_log_level, errno, "Failed to create mount fd for \"%s\" (\"%s\"): %m", what, type);
	
	        if (mount_setattr(mnt_fd, "", AT_EMPTY_PATH|AT_RECURSIVE,
	                          &(struct mount_attr) {
	                                  .attr_set = ms_flags_to_mount_attr(f) | (userns_fd >= 0 ? MOUNT_ATTR_IDMAP : 0),
	                                  .userns_fd = userns_fd,
	                          }, MOUNT_ATTR_SIZE_VER0) < 0)
	
<snip>

So if userns_fd is greater or equal than zero MOUNT_ATTR_IDMAP will be
raised otherwise not.

Later in the code we find this function used in nspawn during:

	static int get_fuse_version(uint32_t *ret_major, uint32_t *ret_minor) {

<snip>
	        /* Get a FUSE handle. */
	        fuse_fd = open("/dev/fuse", O_CLOEXEC|O_RDWR);
<snip>
	        mnt_fd = make_fsmount(LOG_DEBUG, "nspawn-fuse", "fuse.nspawn", 0, opts, -EBADF);

This will cause the aforementioned mount_setattr() call to be called
with:

	        if (mount_setattr(mnt_fd, "", AT_EMPTY_PATH|AT_RECURSIVE,
	                          &(struct mount_attr) {
	                                  .attr_set = 0,
	                                  .userns_fd = -EBADF,
	                          }, MOUNT_ATTR_SIZE_VER0) < 0)

This means:

attr_set == 0 && attr_clear == 0 and propagation == 0 and we'd thus
never trigger a path lookup on older kernels. But now we do thus causing
the hang.

I've restored the old behavior. Can you please test?:

https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.mount.fixes

