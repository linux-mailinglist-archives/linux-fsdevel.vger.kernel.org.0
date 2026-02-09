Return-Path: <linux-fsdevel+bounces-76700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHHSIrXTiWk3CAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:31:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45F10EA69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53DE03004053
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA6372B32;
	Mon,  9 Feb 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/wBSrDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3654318B8A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638000; cv=none; b=SlCFYD4xDdCQSGqoC53v1kbr2hJFZva/atjdh4QSskbRrYeuyWs/dUXjY7Q1oOpQZnS0rdDQ8yAUmZG0hHe2YRLn3Oxe0rjwEjMeEQhacY0A8J7enJeJJd2ZAO8F3kF+0cg3mQeglsdOWg4y8nBJFP97DtdraUdBunPbwyWAVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638000; c=relaxed/simple;
	bh=/HQ63PbsITeClHs1oO78se3pu9Lmk6cOQEgDeCC6QsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBz8Vreee5dswa+B9j2cYIhEjGCIBLLXAG1Rom/hgiN4qfNz0RwPaQixYgE8/SHaLwRX7kULLTGnTxntTI0QEIPeDk8fnpS/MMFKwwcJfBwthPvu6vOF/2DExLJsdeozr1SUdHY5frqSKLmR7T1Dx0YpYWd5x7Cawn01fuIMNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/wBSrDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC920C116C6;
	Mon,  9 Feb 2026 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770638000;
	bh=/HQ63PbsITeClHs1oO78se3pu9Lmk6cOQEgDeCC6QsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/wBSrDJIdXYApHXn6U8C7kSfdhNp+DGWaCCwVn7norvP8BwMylF3UcyPbiSSxNFY
	 WcaoUdpDv9fOT4mRJTmfxrL2mTvr1AFgxS9zDVCrrxxTwpFbdTw/BqlA6vfSNuFVJp
	 FLqupTav6yNp0B10P6vbPbojdpe6QY1jklRr1dpFN5H+vApAY0VL+ViZI0w2aOmF/4
	 0SYG7g4KIKXfFQqivXOArPY1dMbq91ZacPkBHTeak1JMq5JSVo1k9IxOj+FRPeOE4Z
	 yuG1S6gPBHNBKS/KxDy52XXO9UNreakGrI6eacQBSDGDvDhj90HzJ5dZKSq9LNw+C6
	 vvocbPASA0X1Q==
Date: Mon, 9 Feb 2026 12:53:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jan Kara <jack@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, 
	Werner Almesberger <werner@almesberger.net>
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260209-veredeln-verinnerlichen-cb817f3e9853@brauner>
References: <20260209003437.GF3183987@ZenIV>
 <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
 <20260209063454.GI3183987@ZenIV>
 <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76700-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Queue-Id: 9D45F10EA69
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 10:44:31PM -0800, Linus Torvalds wrote:
> On Sun, 8 Feb 2026 at 22:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Not really - look at those check_mnt() in pivot_root(2).
> > static inline int check_mnt(const struct mount *mnt)
> > {
> >         return mnt->mnt_ns == current->nsproxy->mnt_ns;
> > }
> >
> > SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
> >                 const char __user *, put_old)
> > {
> >         ...
> >         if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
> >                 return -EINVAL;
> >
> > IOW, try to do that to another namespace and you'll get -EINVAL,
> > no matter what permissions you might have in your namespace
> > (or globally, for that matter).
> 
> It's more that you can affect *processes* in another namespace if I
> read things right. Not other processes' namespaces, but basically
> processes that you have no business trying to change...
> 
> Yes, both the old and new root need to be in your own namespace, but
> imagine that you are a process in some random container, and let's say
> that root (the *real* root in the init namespace) is looking at your
> container state.
> 
> IOW, imagine that I'm system root, and I've naively done a "cd
> /proc/<pid>/cwd" to look at the state of some sucker, and now...
> 
> Am I mis-reading things entirely, or can a random process in that
> container (that has mount permissions in that thing) basically do
> pivot_root(), and in the process change the CWD of that root process
> that just happens to be looking at that container state?
> 
> I'm just naively looking at that for_each_process_thread() loop that does that
> 
>                 hits += replace_path(&fs->pwd, old_root, new_root);
> 
> but the keyword here is "naively".
> 
> Is there some other check that I'm missing?

Funny, I was looking at this just a very short while ago and have
written a lengthy mail about this to Jeff here on-list. And yes, I think
your reading is right. Let me add the braindump I did for Jeff (very
container centric):

  The main problem with pivot_root() is not just that it moves the
  old rootfs to any other location on the new rootfs it also takes the
  tasklist read lock and walks all processes on the system trying to find
  any process that uses the old rootfs as its fs root or its pwd and then
  rechroots and repwds all of these processes into the new rootfs.

  But for 90% of the use-cases (containers) that is not needed. When the
  container's mount namespace and rootfs are setup the task creating that
  container is the only task that is using the old rootfs and that task
  could very well just rechroot itself after it unmounted the old rootfs.

  So in essence pivot_root() holds tasklist lock and walks all tasks on
  the systems for no reason. If the user has a beefy and busy machine with
  lots of processes coming and going each pivot_root() penalizes the whole
  system.

I have a patchset sitting in my tree for the 7.1 cycle that I want to
merge that is a better alternative to pivot_root() in most cases -
definitely the container cases.

It just enables MOVE_MOUNT_BENEATH which I added a few years ago to work
with the rootfs. This means one can stuff a new rootfs under the current
rootfs, unmount the old rootfs and chroot and chdir into the new rootfs
and then be done. This works for all container use-cases where you don't
need to care about any global kernel threads picking up the updated
root. You don't need chroot_fs_refs() for that at all.

With MOVE_MOUNT_BENEATH being able to mount beneath the rootfs you get
the following benefits:

* completely avoids the tasklist locking and rechroot/repwd logic

* the pivot_root(".", ".") trick where the old rootfs is mounted on top
  of the new rootfs is for free

* MOVE_MOUNT_BENEATH works with detached mounts which means one can
  assemble a (container) rootfs and then swap the old rootfs with the
  new rootfs

Fwiw, there's also work I sent for this cycle that allows to completely
sidestep pivot_root() already for containers. I'm pretty sure that
sooner or later with that work unshare(CLONE_NEWNS) will be gone from
most container times completely because what we did scales a lot better.

I think even for the case where init pivot's root from the initramfs
the pivot_root() system call isn't really needed anymore because iirc
CLONE_FS guarantees that any change to its root and pwd is visible in
kernel threads. So as long as init isn't stupid and does
unshare(CLONE_FS) and watches what other tasks are created just doing
MOVE_MOUNT_BENEATH might be enough. But idk. I don't think it matters
calling pivot_root() during boot so for that case I don't care. But for
containers I for sure care as the current situation is just a
performance issue for no good reason.

Fwiw, for the 7.1 cycle I also have a patchset for
unshare(UNSHARE_EMPTY_MNTNS) and also for clone3() which creates a
completely empty mount namespaces with a catatonic/immutable mount as
its root getting rid of a bunch of the issues mentioned earlier as well.
It's simply not needed for most modern container setups to copy the
whole mount namespace. It's just wasteful as the rootfs setup can now
happen way before the container is ever created via the new mount api.

