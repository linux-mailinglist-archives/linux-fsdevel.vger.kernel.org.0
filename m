Return-Path: <linux-fsdevel+bounces-45815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E153A7CD0C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 09:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB34188A789
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A727191F72;
	Sun,  6 Apr 2025 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7BHyot3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0C1CD1F;
	Sun,  6 Apr 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743923666; cv=none; b=M2Rxchvims8Yx1q6kBpp1CDZ0BUq3jcuKystLILtWzWkF8RAVoNjC3890ocZluhqeJ3Y5X8ckJCksEttB4/2xXQsTaYAiAxcw1Ib1xAG9bvbSu84HNQOIrIUai+BqiHhALpzSqtj15sF0toOpz22m8x/A9Dp1KXLsn8VE67McBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743923666; c=relaxed/simple;
	bh=xyheJqHVSb0yuy/N+Ze7eNy0LUuR9Dn/m3N8SB/4dfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es+Ugv91pV4TeW78UI7DLidD1PlyTaG/vJxJ6cdGTJo9rx9xQgsChYNe+t0oOrXX0VxrTWR3wTiLD0YJvDNL+e+UYWvWw1eTgqZivtpzV9c44TTmAXLESLP25UaU+L06pGz7VEV1r0PWokko++oHFjEV+SIsi4blxPRFzlqXOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7BHyot3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61C0C4CEE3;
	Sun,  6 Apr 2025 07:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743923665;
	bh=xyheJqHVSb0yuy/N+Ze7eNy0LUuR9Dn/m3N8SB/4dfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7BHyot3yR1ippB0dV38oSBDp/3FEyjBWlVHrw8VU7FjRh7uokzNs8dWU/yKt3OXX
	 k3pXmybARjW6MM+VXCIoZAEM5lVxQ4cxPaBB8ImBGzbOjk7Hh7qO+Urdcx3qoQHRug
	 feBEsmRGJEzvVcTSJ4jMi9FB/PDvjS3mLUNQeAMIHDJxdaZ/h3eJOCdD2ykQOraMQs
	 D2ILrs776BqAZQV2dOuXhhBXTfTwkAdLT4i1KZstaGI47yp1LFzgcpKMAF2r/55SJ/
	 esLtjI+KH+jRaI/sEpIOFde79mSfAZ8+TSEgRQPpWJTHEN4A5xtxkYxzwvJGPZU68k
	 nTyIh5M798arQ==
Date: Sun, 6 Apr 2025 09:14:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH] anon_inode: use a proper mode internally
Message-ID: <20250406-reime-kneifen-11714c0a421d@brauner>
References: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
 <CAGudoHErv6sX+Tq=NNLL3b61Q70TeZxi93Nx_MEcMrQSg47JGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHErv6sX+Tq=NNLL3b61Q70TeZxi93Nx_MEcMrQSg47JGA@mail.gmail.com>

On Sat, Apr 05, 2025 at 06:54:28AM +0200, Mateusz Guzik wrote:
> On Fri, Apr 4, 2025 at 12:39 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > This allows the VFS to not trip over anonymous inodes and we can add
> > asserts based on the mode into the vfs. When we report it to userspace
> > we can simply hide the mode to avoid regressions. I've audited all
> > direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> > and i_op inode operations but it already uses a regular file.
> >
> [snip]
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index 6393d7c49ee6..0ad3336f5b49 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -1647,7 +1647,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
> >          * that it already _is_ on the dirty list.
> >          */
> >         inode->i_state = I_DIRTY;
> > -       inode->i_mode = S_IRUSR | S_IWUSR;
> > +       inode->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
> >         inode->i_uid = current_fsuid();
> >         inode->i_gid = current_fsgid();
> >         inode->i_flags |= S_PRIVATE;
> 
> Switching the mode to S_IFREG imo can open a can of worms (perhaps a
> dedicated in-kernel only mode would be better? S_IFANON?), but that's

No, I don't think we should have weird kernel-only things in i_mode.
That's what i_flags is for.

> a long and handwave-y subject, so I'm going to stop at this remark.
> 
> I think the key here is to provide an invariant that anon inodes don't
> pass MAY_EXEC in may_open() regardless of their specific i_mode and
> which the kernel fails to provide at the moment afaics.

The current way of relying on IS_REG() in do_open_execat() is broken
with current kernel semantics ever since commit 633fb6ac3980 ("exec:
move S_ISREG() check earlier"). That commit introduced a WARN_ON_ONCE()
around the S_ISREG() check which indicates that it wasn't clear to the
authors that this is very likely a reachable WARN_ON_ONCE() via e.g.:

int main(int argc, char *argv[])
{
	int ret, sfd;
	sigset_t mask;
	struct signalfd_siginfo fdsi;

	sigemptyset(&mask);
	sigaddset(&mask, SIGINT);
	sigaddset(&mask, SIGQUIT);

	ret = sigprocmask(SIG_BLOCK, &mask, NULL);
	if (ret < 0)
		_exit(1);

	sfd = signalfd(-1, &mask, 0);
	if (sfd < 0)
		_exit(2);

	ret = fchown(sfd, 5555, 5555);
        if (ret < 0)
		_exit(3);

	ret = fchmod(sfd, 0777);
	if (ret < 0)
		_exit(3);

	/* trigger the WARN_ON_ONCE() */
	execveat(sfd, "", NULL, NULL, AT_EMPTY_PATH);
	_exit(4);
}

Because the mode and owner of the single anonymous inode in the
kernel can be changed by anonyone with suitable privileges. That of
course it itself a bug although not a really meaningful one because
anonymous inodes don't really figure into path lookup. They cannot be
reopened via /proc/<pid>/fd/<nr> and can't be used for lookup itself. So
they can only ever serve as direct references. But I'm going to fix
that. Similar to pidfs we should simply fail setattr [1]. Given that noone has
been hitting the execveat() WARN_ON_ONCE() it's safe to say that no one
ever bothered chowning/chmoding anonymous inodes. With that removed it's
not possible to exec anonymous inodes but we should harden this by
setting SB_I_NOEXEC as well (Secretmem is another very fun example
because it uses anonymous inodes but does set S_ISREG already. So
chmod() on such an inode and passing it to execveat() could be fun.)

Anyway, I'm finishing the patch and testing tomorrow and will send out
with all the things I mentioned (unless I find out I'm wrong).

[1]: That's been a constant sore spot for me. We currently simply
     fallback to simple_setattr() if the fs doesn't provide a dedicated
     ->setattr() function. Imho that's broken and we need to remove
     that. All fses that need it need to set ->setattr() and if it isn't
     set EOPNOTSUPP will be returned. So that would need some code audit
     which fses definitely don't need or expect it. Otherwise we risk
     setting attributes on things that don't want them changed. That's
     patch I had on my backlog for quite a while ever since the big
     xattr/acl rework.

