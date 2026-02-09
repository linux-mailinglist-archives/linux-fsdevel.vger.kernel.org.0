Return-Path: <linux-fsdevel+bounces-76697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNqOMwjBiWk/BgUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 12:12:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9010E8A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 12:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC1D301828B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6236C5BC;
	Mon,  9 Feb 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US3j3mXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA536C0DE;
	Mon,  9 Feb 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635488; cv=none; b=ABu9oPsfL4TblNnMPYWIHiLdizNwWGO8+ZfHyX+H7kp9lpzTiAVhh5PIZNNUurKGsTf312c1dabBGGJAwb1lhPiU8N6v2YGYyctkw3R5Ss5qyvv026A7WBYMkTMuazyTVdnTo9ONcGTCl1fK0ABk18VJDkpt37TVMvIMqunCy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635488; c=relaxed/simple;
	bh=t9KSThTVOz35Ej5vEwbl+zga07u71//fQQzyyB/C/1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP9UHY+7cUFkUBsu40Qg0xLXMpAXoAL/nZ9qOUMYmWUFSaeafXhVLpTbB14xOB7K9Uu4L9dDuun1W7VrOzjAeCAemzZopCRQNlAXn3bVYGEaGFklvrwA73WP0hho8L4kjIpukh/n38P5+5kS3R0hLWJb/WKr8BpFKdYUizKG2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US3j3mXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DBDC116C6;
	Mon,  9 Feb 2026 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770635487;
	bh=t9KSThTVOz35Ej5vEwbl+zga07u71//fQQzyyB/C/1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=US3j3mXewcTiSU8I3Xlw/cde2ucDVcT7xZfdQwl8uJ+rDRL1avQRXq/A9rmRM4DJG
	 9SwKd9wUkYOeG1boavbpk62LUM81u9QoeAKdiC7p2BX4wnNqJeC5hc7RoKh2uRwh+t
	 vXmXRqAWp4gEdqTetrH/uhy8uYpPW6xB8EzRgqTWcOeanqUS82UqDijHgr62WOyH5A
	 E2mTGW2TP6GnlBgB1SwvN9Rbb4mJQN2/2rTcP41Fm0TUNwONGY8XPHqbdPDeWCI1P+
	 ta2NA7X0xvBytjX3PsXkAVxAg/isRpoSn0Qm4whT6WZ0xuKsnGRQ/1QxuuCj5TpbZb
	 zMTQ7+FuXtyUg==
Date: Mon, 9 Feb 2026 12:11:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
Message-ID: <20260209-infolge-dachorganisation-acd79c9ad934@brauner>
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <20260206-gelenk-gierig-82ad15ec8080@brauner>
 <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76697-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,futurfusion.io:email,linux.dev:email,fomichev.me:email]
X-Rspamd-Queue-Id: 3AF9010E8A9
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:42:17PM +0100, Alexander Mikhalitsyn wrote:
> Am Fr., 6. Feb. 2026 um 13:33 Uhr schrieb Christian Brauner
> <brauner@kernel.org>:
> >
> > On Thu, Feb 05, 2026 at 11:45:41AM +0100, Alexander Mikhalitsyn wrote:
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Instead of FS_USERNS_MOUNT we should use recently introduced
> > > FS_USERNS_DELEGATABLE cause it better expresses what we
> > > really want to get there. Filesystem should not be allowed
> > > to be mounted by an unprivileged user, but at the same time
> > > we want to have sb->s_user_ns to point to the container's
> > > user namespace, at the same time superblock can only
> > > be created if capable(CAP_SYS_ADMIN) check is successful.
> > >
> > > Tested and no regressions noticed.
> > >
> > > No functional change intended.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
> > > Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yonghong.song@linux.dev>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Jeff Layton <jlayton@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > - RWB-tag from Jeff [1]
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  kernel/bpf/inode.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 9f866a010dad..d8dfdc846bd0 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       struct inode *inode;
> > >       int ret;
> > >
> > > -     /* Mounting an instance of BPF FS requires privileges */
> > > -     if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > > -             return -EPERM;
> >
> > Jeff's patch does:
> >
> >         if (user_ns != &init_user_ns &&
> >             !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
> >                 errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
> >                 return ERR_PTR(-EPERM);
> >         }
> 
> Hi Christian,
> 
> >
> > IOW, it only restricts the ability to end up in bpf_fill_super() if
> > FS_USERNS_DELEGATABLE is set. You still need to perform the permission
> > check in bpf_fill_super() though otherwise anyone can mount bpffs in an
> > unprivileged container now.
> 
> Yeah, this is what  mount_capable(struct fs_context *fc) does. I'm removing
> FS_USERNS_MOUNT so know it checks capable(CAP_SYS_ADMIN), instead of
> ns_capable(fc->user_ns, CAP_SYS_ADMIN).
> 
> No functional changes here.

Ah right, I remember. We require global CAP_SYS_ADMIN if FS_USERNS_MOUNT
isn't set. That's great. Thanks!

I can route Jeff's patch as fix since the original change technically
regressed nfs a while ago.

