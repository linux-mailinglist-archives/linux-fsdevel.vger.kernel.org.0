Return-Path: <linux-fsdevel+bounces-36928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FBF9EB11B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC792814CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637B1A725A;
	Tue, 10 Dec 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0OxeNi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121D19CC1C;
	Tue, 10 Dec 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834686; cv=none; b=Lr46FN8wQhIMIEo09obMJlSwwzIrSFt+79ZmTKWeeaXWDYm3Duh4xOjR5duNKi6WozJAg94/Lb2o+IuG13Gn8+yb/EP8s6PICXQo84AMBKvBMTKdR8fWMqbWhQzQGI63Q7DB1Z737NZvTM2fJf3LeB86QvvGjGjz0UZ5LGNAMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834686; c=relaxed/simple;
	bh=L2UmMkEAjWl/RspMbGsEqygaTjbGn+Q9iIdhXVK1si4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SMGCx9LPIgftySAbp4OAWT+Cy44PXhsSamIIdVOmaLSZd1RycqMRbyUcJJHJqIdoeldlZNITWMTPPOmll01ikAzxItiYDbPEaig+Xfa/jasj6a3e3eaDp813XMHChsvz3JpKKjy87VRb/WTB3MB6doSqk6iyEkBmi1itTHrBxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0OxeNi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0FFC4CED6;
	Tue, 10 Dec 2024 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733834685;
	bh=L2UmMkEAjWl/RspMbGsEqygaTjbGn+Q9iIdhXVK1si4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I0OxeNi0VTqhT9wkN++q0rdqsjkaeOatEYMcmV81X6uRx3wYCHCUr4QojyzIREBfm
	 YM8VtbrLWI8wrtqXmJhk3fVXfwLVLNJlFvisdIc086vWsCoNz8xWvXszoLPf14eKz9
	 YdURoDRliPjqxs7yL+CGgMtadnf3SfEPNNk3l5UJNyabeb+WvECWi1jPIJX2Xq1vb9
	 Gk2J7vm40YU/h+GgJj9NcZqpXtkQVbYNQkSx8WCNlHc36QpzcA5ZFCblliIqHo6ElP
	 jAH2kowNu4R7HzeDJ0eT0BrMSfA2cV08h3zwYAsJuEi6MVqtq1HSK8gxfxKlyGZCfp
	 KNV7KF43ZcuLA==
Message-ID: <eb9edf1c7abb3ef2f5fe6c80eee08ff2d21d6dd2.camel@kernel.org>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig
 <hch@infradead.org>,  "Darrick J. Wong" <djwong@kernel.org>, Erin Shepherd
 <erin.shepherd@e43.eu>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-nfs@vger.kernel.org, stable
 <stable@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Date: Tue, 10 Dec 2024 07:44:43 -0500
In-Reply-To: <20241210-gekonnt-pigmente-6d44d768469f@brauner>
References: 
	<CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
	 <20241206160358.GC7820@frogsfrogsfrogs>
	 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
	 <Z1ahFxFtksuThilS@infradead.org>
	 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
	 <Z1b00KG2O6YMuh_r@infradead.org>
	 <CAOQ4uxjcVuq+PCoMos5Vi=t_S1OgJEM5wQ6Za2Ue9_FOq31m9Q@mail.gmail.com>
	 <15628525-629f-49a4-a821-92092e2fa8cb@oracle.com>
	 <d74572123acf8e09174a29897c3074f5d46e4ede.camel@kernel.org>
	 <337ca572-2bfb-4bb5-b71c-daf7ac5e9d56@oracle.com>
	 <20241210-gekonnt-pigmente-6d44d768469f@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 11:13 +0100, Christian Brauner wrote:
> On Mon, Dec 09, 2024 at 12:20:10PM -0500, Chuck Lever wrote:
> > On 12/9/24 12:15 PM, Jeff Layton wrote:
> > > On Mon, 2024-12-09 at 11:35 -0500, Chuck Lever wrote:
> > > > On 12/9/24 11:30 AM, Amir Goldstein wrote:
> > > > > On Mon, Dec 9, 2024 at 2:46=E2=80=AFPM Christoph Hellwig <hch@inf=
radead.org> wrote:
> > > > > >=20
> > > > > > On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
> > > > > > > To be clear, exporting pidfs or internal shmem via an anonymo=
us fd is
> > > > > > > probably not possible with existing userspace tools, but with=
 all the new
> > > > > > > mount_fd and magic link apis, I can never be sure what can be=
 made possible
> > > > > > > to achieve when the user holds an anonymous fd.
> > > > > > >=20
> > > > > > > The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE fl=
ag
> > > > > > > was that when kernfs/cgroups was added exportfs support with =
commit
> > > > > > > aa8188253474 ("kernfs: add exportfs operations"), there was n=
o intention
> > > > > > > to export cgroupfs over nfs, only local to uses, but that was=
 never enforced,
> > > > > > > so we thought it would be good to add this restriction and ba=
ckport it to
> > > > > > > stable kernels.
> > > > > >=20
> > > > > > Can you please explain what the problem with exporting these fi=
le
> > > > > > systems over NFS is?  Yes, it's not going to be very useful.  B=
ut what
> > > > > > is actually problematic about it?  Any why is it not problemati=
c with
> > > > > > a userland nfs server?  We really need to settle that argumet b=
efore
> > > > > > deciding a flag name or polarity.
> > > > > >=20
> > > > >=20
> > > > > I agree that it is not the end of the world and users do have to =
explicitly
> > > > > use fsid=3D argument to be able to export cgroupfs via nfsd.
> > > > >=20
> > > > > The idea for this patch started from the claim that Jeff wrote th=
at cgroups
> > > > > is not allowed for nfsd export, but I couldn't find where it is n=
ot allowed.
> > > > >=20
> > >=20
> > > I think that must have been a wrong assumption on my part. I don't se=
e
> > > anything that specifically prevents that either. If cgroupfs is mount=
ed
> > > and you tell mountd to export it, I don't see what would prevent that=
.
> > >=20
> > > To be clear, I don't see how you would trick bog-standard mountd into
> > > exporting a filesystem that isn't mounted into its namespace, however=
.
> > > Writing a replacement for mountd is always a possibilty.
> > >=20
> > > > > I have no issue personally with leaving cgroupfs exportable via n=
fsd
> > > > > and changing restricting only SB_NOUSER and SB_KERNMOUNT fs.
> > > > >=20
> > > > > Jeff, Chuck, what is your opinion w.r.t exportability of cgroupfs=
 via nfsd?
> > > >=20
> > > > We all seem to be hard-pressed to find a usage scenario where expor=
ting
> > > > pseudo-filesystems via NFS is valuable. But maybe someone has done =
it
> > > > and has a good reason for it.
> > > >=20
> > > > The issue is whether such export should be consistently and activel=
y
> > > > prevented.
> > > >=20
> > > > I'm not aware of any specific security issues with it.
> > > >=20
> > > >=20
> > >=20
> > > I'm not either, but we are in new territory here. nfsd is a network
> > > service, so it does present more of an attack surface vs. local acces=
s.
> > >=20
> > > In general, you do have to take active steps to export a filesystem,
> > > but if someone exports / with "crossmnt", everything mounted is
> > > potentially accessible. That's obviously a dumb thing to do, but peop=
le
> > > make mistakes, and it's possible that doing this could be part of a
> > > wider exploit.
> > >=20
> > > I tend to think it safest to make exporting via nfsd an opt-in thing =
on
> > > a per-fs basis (along the lines of this patchset). If someone wants t=
o
> > > allow access to more "exotic" filesystems, let them argue their use-
> > > case on the list first.
> >=20
> > If we were starting from scratch, 100% agree.
> >=20
> > The current situation is that these file systems appear to be exportabl=
e
> > (and not only via NFS). The proposal is that this facility is to be
> > taken away. This can easily turn into a behavior regression for someone
> > if we're not careful.
>=20
> So I'm happy to drop the exportfs preliminary we have now preventing
> kernfs from being exported but then Christoph and you should figure out
> what the security implications of allowing kernfs instances to be
> exported areare because I'm not an NFS export expert.
>=20
> Filesystems that fall under kernfs that are exportable by NFS as I
> currently understand it are at least:
>=20
> (1) sysfs
> (2) cgroupfs
>=20
> Has anyone ever actually tried to export the two and tested what
> happens? Because I wouldn't be surprised if this ended in tears but
> maybe I'm overly pessimistic.
>=20
> Both (1) and (2) are rather special and don't have standard filesystem
> semantics in a few places.
>=20
> - cgroupfs isn't actually namespace aware. Whereas most filesystems like
>   tmpfs and ramfs that are mountable inside unprivileged containers are
>   multi-instance filesystems, aka allocate a new superblock per
>   container cgroupfs is single-instance with a nasty implementation to
>   virtualize the per-container view via cgroup namespaces. I wouldn't be
>   surprised if that ends up being problematic.
>=20
> - Cgroupfs has write-time permission checks as the process that is moved
>   into a cgroup isn't known at open time. That has been exploitable
>   before this was fixed.
>=20
> - Even though it's legacy cgroup has a v1 and v2 mode where v1 is even
>   more messed up than v2 including the release-agent logic which ends up
>   issuing a usermode helper to call a binary when a cgroup is released.
>=20
> - sysfs potentially exposes all kinds of extremly low-level information
>   to a remote machine.
>=20
> None of this gives me the warm and fuzzy. But that's just me.
>=20
> Otherwise, I don't understand what it means that a userspace NFS server
> can export kernfs instances. I don't know what that means and what the
> contrast to in-kernel NFS server export is and whether that has the same
> security implications. If so it's even scary that some random userspace
> NFS server can just expose guts like kernfs.
>=20

A userspace NFS server can export anything to which it has access. If
cgroupfs or sysfs is mounted and the server is running with appropriate
permissions then there is nothing that prevents it from making that
available. It's helpful if the filesystem can implement
name_to_handle_at() and open_by_handle_at(), but even that isn't
specifically required.

> But if both of you feel that this is safe to do and there aren't any
> security issues lurking that have gone unnoticed simply because no one
> has really ever exported sysfs or cgroupfs then by all means continue
> allowing that. I'm rather skeptical.

I'm not sure I agree that it's "safe", but in order to export kernfs or
pidfs you have to explicitly set it up to be exported. Christoph has a
good point that we don't have a specific scenario that we're trying to
prevent here.

My main thinking here is that:

1/ exporting these fstypes is not something we consider useful

2/ by forbidding this now, we prevent someone from complaining that
there is a regression later if we do find that it's problematic and
have to forbid it

Also, if we forbid this now, that might force someone who does want to
do this to articulate their use-case publicly.
--=20
Jeff Layton <jlayton@kernel.org>

