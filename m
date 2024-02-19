Return-Path: <linux-fsdevel+bounces-12047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A143685ABBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A8BB24641
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEC4C617;
	Mon, 19 Feb 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="NnwskEQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F34C3D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369552; cv=none; b=P5mgH8JqE2GQQtmUfWylXttHCOKNLneuo4X6C4fB0BAcAZ9OYXZlT3VDb+D4QHQnT5PFmPx7vNQHQlBmSm+YVrJrOU3gHSJnEz5wQ+peK4aXnA+Ie84i9hurIQ5E3xwiROAIXQBVjaKHusw9w5IavRNlzLGN+XiH1DpQzdvs+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369552; c=relaxed/simple;
	bh=Emo1tUSSIqxJcDfABCAsgRWSne7/TG2nyXcyPizg3SU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lM6OHq+/wzlP+CtXzETN6W7OaFtcrNpfWeYZ3ZvbCldLLT1sgyKL+XhTk3CmDPTw7EA+Hs6JF6Do9bAEhNMabY6dK40LUFVUIcaLTDFcYqRiwNklHgo1trKwEpUnMdG1Xhmu0cO8azxKc+ZGf5r+Xi7ZpBiE+4hylX2rLBCbjDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=NnwskEQB; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1708369539; x=1708628739;
	bh=Emo1tUSSIqxJcDfABCAsgRWSne7/TG2nyXcyPizg3SU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NnwskEQBd5cTvlr7zS9uJjIzN/doM1baNNQxX4E5L0XdLMheLQ64GgqZyCmr5kDx1
	 NB2na2QTkmbOpoXgkoRx58W3WQhav0PgauzVn5CRey/79hcYzWau7AvK9OPoVCktIq
	 HNVV/aZxUdHxWmRclAvSgA0QOwbxobdJM0JZ7E7OJuTXwfUwyCdzudNoyPs2bOdA2I
	 lOEvYNV88/LYkfqfbmSh+4HMResR9zpaG9dVCvEBkDKMAxDXqBMgQts+86DESy2BIr
	 W0JBi/GL6fJf3EooltevPX6wYl7ZRX5PsJlBbCX0oxKWyUvebUDYt0Kll7PW0hkC2M
	 eRilAoqc7HwkQ==
Date: Mon, 19 Feb 2024 19:05:19 +0000
To: Bernd Schubert <bernd.schubert@fastmail.fm>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Message-ID: <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
In-Reply-To: <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link> <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com> <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com> <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, February 19th, 2024 at 5:36 AM, Bernd Schubert <bernd.schubert@f=
astmail.fm> wrote:

>
>
>
>
> On 2/18/24 01:48, Antonio SJ Musumeci wrote:
>
> > On 2/7/24 01:04, Amir Goldstein wrote:
> >
> > > On Wed, Feb 7, 2024 at 5:05=E2=80=AFAM Antonio SJ Musumeci trapexit@s=
pawn.link wrote:
> > >
> > > > On 2/6/24 00:53, Amir Goldstein wrote:
> > > > only for a specific inode object to which you have an open fd for.
> > > > Certainly not at the sb/mount level.
> > >
> > > Thanks,
> > > Amir.
> >
> > Thanks again Amir.
> >
> > I've narrowed down the situation but I'm still struggling to pinpoint
> > the specifics. And I'm unfortunately currently unable to replicate usin=
g
> > any of the passthrough examples. Perhaps some feature I'm enabling (or
> > not). My next steps are looking at exactly what differences there are i=
n
> > the INIT reply.
> >
> > I'm seeing a FUSE_LOOKUP request coming in for ".." of nodeid 1.
> >
> > I have my FUSE fs setup about as simply as I can. Single threaded. attr
> > and entry/neg-entry caching off. direct-io on. EXPORT_SUPPORT is
> > enabled. The mountpoint is exported via NFS. On the same host I mount
> > NFS. I mount it on another host as well.
> >
> > On the local machine I loop reading a large file using dd
> > (if=3D/mnt/nfs/file, of=3D/dev/null). After it finished I echo 3 >
> > drop_caches. That alone will go forever. If on the second machine I
> > start issuing `ls -lh /mnt/nfs` repeatedly after a moment it will
> > trigger the issue.
> >
> > `ls` will successfully statx /mnt/nfs and the following openat and
> > getdents also return successfully. As it iterates over the output of
> > getdents statx's for directories fail with EIO and files succeed as
> > normal. In my FUSE server for each EIO failure I'm seeing a lookup for
> > ".." on nodeid 1. Afterwards all lookups fail on /mnt/nfs. The only
> > request that seems to work is statfs.
> >
> > This was happening some time ago without me being able to reproduce it
> > so I put a check to see if that was happening and return -ENOENT.
> > However, looking over libfuse HLAPI it looks like fuse_lib_lookup
> > doesn't handle this situation. Perhaps a segv waiting to happen?
> >
> > If I remove EXPORT_SUPPORT I'm no longer triggering the issue (which I
> > guess makes sense.)
> >
> > Any ideas on how/why ".." for root node is coming in? Is that valid? It
> > only happens when using NFS? I know there is talk of adding the ability
> > of refusing export but what is the consequence of disabling
> > EXPORT_SUPPORT? Is there a performance or capability difference? If it
> > is a valid request what should I be returning?
>
>
> If you don't set EXPORT_SUPPORT, it just returns -ESTALE in the kernel
> side functions - which is then probably handled by the NFS client. I
> don't think it can handle that in all situations, though. With
> EXPORT_SUPPORT an uncached inode is attempted to be opened with the name
> "." and the node-id set in the lookup call. Similar for parent, but
> ".." is used.
>
> A simple case were this would already fail without NFS, but with the
> same API
>
> name_to_handle_at()
> umount fuse
> mount fuse
> open_by_handle_at
>
>
> I will see if I can come up with a simple patch that just passes these
> through to fuse-server
>
>
> static const struct export_operations fuse_export_operations =3D {
> .fh_to_dentry =3D fuse_fh_to_dentry,
> .fh_to_parent =3D fuse_fh_to_parent,
> .encode_fh =3D fuse_encode_fh,
> .get_parent =3D fuse_get_parent,
> };
>
>
>
>
> Cheers,
> Bernd

Thank you but I'm not sure I'm able to piece together the answers to my que=
stions from that.

Perhaps my ignorance of the kernel side is showing but how can the root nod=
e have a parent? If it can have a parent then does that mean that the HLAPI=
 has a possible bug in lookup?

I handle "." and ".." just fine for non-root nodes. But this is `lookup(nod=
eid=3D1,name=3D"..");`.

Given the relative directory structure:

* /dir1/
* /dir2/
* /dir3/
* /file1
* /file2

This is what I see from the kernel:

lookup(nodeid=3D3, name=3D.);
lookup(nodeid=3D3, name=3D..);
lookup(nodeid=3D1, name=3Ddir2);
lookup(nodeid=3D1, name=3D..);
forget(nodeid=3D3);
forget(nodeid=3D1);

lookup(nodeid=3D4, name=3D.);
lookup(nodeid=3D4, name=3D..);
lookup(nodeid=3D1, name=3Ddir3);
lookup(nodeid=3D1, name=3D..);
forget(nodeid=3D4);

lookup(nodeid=3D5, name=3D.);
lookup(nodeid=3D5, name=3D..);
lookup(nodeid=3D1, name=3Ddir1);
lookup(nodeid=3D1, name=3D..);
forget(nodeid=3D5);
forget(nodeid=3D1);


It isn't clear to me what the proper response is for lookup(nodeid=3D1, nam=
e=3D..). Make something up? From userspace if you stat "/.." you get detail=
s for "/". If I respond to that lookup request with the details of root nod=
e it errors out.

