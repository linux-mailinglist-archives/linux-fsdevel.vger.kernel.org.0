Return-Path: <linux-fsdevel+bounces-10572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7084C598
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4111C23571
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1A200A6;
	Wed,  7 Feb 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/fszHe3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D8C200A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290680; cv=none; b=Kroa0oJdhR6dqCg12Kcg/a37KDJSLwbqi07J7DpWZ7FZRBOsU5b8RFTDkEBuxuAaX0jFC6yLap9xvovRbp+/FOmPVp8+MlNiikp3+4/wRde5bVu+iKhKQC3w2Uj3BCNIL4Zm0xiCNnghzXYP5k8my2rGfRInxOX3n2q9QYbAa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290680; c=relaxed/simple;
	bh=Le6wuuUnVScURwwBAuy27cQYLwAVCsyxmamI3dT73bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiFaKqc4eWUOlar1bYaYtpD5WRny4hMUDB6tsWsjonvm+icKd9avV8yiVjN+P4x8NZB/ru04fjxrTfmSHthx0UyKuJAzNMzf08DlZJNqw6/oNAMAWQq5CA7pa79Rp8ZfSko0AbuJM6x4lhg7FMiEYqGe0roMkVeCo8yoXDhV3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/fszHe3; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so142619241.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 23:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707290677; x=1707895477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsw+7/5FM01Ub+RAFBck1P8hJGdjf6aquqFlzwE2888=;
        b=O/fszHe3DjeSQ+U65PAkoUuUnvgygLgAJ/pUpAXpaqVPTaKgz/4u0Dh2bUanvzzSaY
         gTpLjPkm9zrPZPq1uNs+zjdDG0kZkXZsiuaepdPAbJ+EDkN9yigtlfEF5ahxmdV11Hvm
         cB9Wsrmgh/Ta4FsPE3t1pP7lABw2o9iyd7rTguAj/sjsATVsT7Lj1txFzDsDa6EPqykq
         Njch+1EK/P+lGJnrMrlA8NLcMDP/ToFcTiah699uQwiC9+6Cm8G7LFTTAg3tPI/EZsrj
         VPfxQEgaUfNhJvFgmr4kJoEqB6b9XqESvrekcqadxyWCv84wjwU0fWRtoQSizKX9+jk7
         K8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707290677; x=1707895477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsw+7/5FM01Ub+RAFBck1P8hJGdjf6aquqFlzwE2888=;
        b=Qhct2oTqZl5JYVc1cvNI/aeWgygdTM1BCcl4T5+MCPgrlHrkuedQPBLN4TTrr2INRc
         L+eyMdn5lKkvRrya3+Gtoq0vLmzXlmciPyr6znbZcUDR3A4dhYhThDNgVfoA1NdM8FDX
         yOACkhk8JI5LqWKkaWYx3Jik71dk5mi2f4JhM+TPs7RQxMriK2PXBUBxdgAPoWdIWn/6
         vfOoeGwR0h5BLp1YHdKBbp1gHuNRvE+k75iKCK0XntEyfGV2VrPvah3Uv0ArTFMZJrfn
         01ZeeD733r7riAGf/IFUI2LOCTf6lrwFw+25O8ZaWgLrRyxPnCFEMP/uB93KHSbXlLOi
         7B4g==
X-Gm-Message-State: AOJu0YwCQe1rpTWo6pjSXzYur+zZR7u2N07OTUo92UiwUigVb+K/PCRI
	oWxcmeqrAT4AJnyFiJr6drHYew2OWa/HIU/SrP/eUOVG/USRb2KUXpUCRaYCGUaMgzBTw60Kdux
	guxqPTqg/hoLQR+sQ+oYBLrZQfgk=
X-Google-Smtp-Source: AGHT+IEs3HsfJq4svFYdCVksihm9LI1Psn5UyEAzeOOApH9dBqWk71rDmU+bwFCmFuPBXUFEoEmhF1cLcrGY3omdXVU=
X-Received: by 2002:a05:6122:4b13:b0:4c0:34e8:d55d with SMTP id
 fc19-20020a0561224b1300b004c034e8d55dmr1779384vkb.11.1707290677081; Tue, 06
 Feb 2024 23:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com> <764a49b0-9a82-4042-8e03-10219b152e77@spawn.link>
In-Reply-To: <764a49b0-9a82-4042-8e03-10219b152e77@spawn.link>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 Feb 2024 09:24:25 +0200
Message-ID: <CAOQ4uxi-46N0uRj7vnSmzv3jCnQmGG==jEcgN5echcrrb1xbDw@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: fuse-devel <fuse-devel@lists.sourceforge.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:08=E2=80=AFAM Antonio SJ Musumeci <trapexit@spawn.=
link> wrote:
>
> On 2/6/24 00:53, Amir Goldstein wrote:
> > On Tue, Feb 6, 2024 at 4:52=E2=80=AFAM Antonio SJ Musumeci <trapexit@sp=
awn.link> wrote:
> >> Hi,
> >>
> >> Anyone have users exporting a FUSE filesystem over NFS? Particularly
> >> from Proxmox (recent release, kernel 6.5.11)? I've gotten a number of
> >> reports recently from individuals who have such a setup and after some
> >> time (not easily reproducible, seems usually after software like Plex =
or
> >> Jellyfin do a scan of media or a backup process) starts returning EIO
> >> errors. Not just from NFS but also when trying to access the FUSE moun=
t
> >> as well. One person noted that they had moved from Ubuntu 18.04 (kerne=
l
> >> 4.15.0) to Proxmox and on Ubuntu had no problems with otherwise the sa=
me
> >> settings.
> >>
> >> I've not yet been able to reproduced this issue myself but wanted to s=
ee
> >> if anyone else has run into this. As far as I can tell from what users
> >> have reported the FUSE server is still running but isn't receiving mos=
t
> >> requests. I do see evidence of statfs calls coming through but nothing
> >> else. Though the straces I've received typically are after the issues =
start.
> >>
> >> In an effort to rule out the FUSE server... is there anything the serv=
er
> >> could do to cause the kernel to return EIO and not forward anything bu=
t
> >> statfs? Doesn't seem to matter if direct_io is enabled or attr/entry
> >> caching is used.
> >>
> > This could be the outcome of commit 15db16837a35 ("fuse: fix illegal
> > access to inode with reused nodeid") in kernel v5.14.
> >
> > It is not an unintended regression - this behavior replaces what would
> > have been a potentially severe security violation with an EIO error.
> >
> > As the commit says:
> > "...With current code, this situation will not be detected and an old f=
use
> >      dentry that used to point to an older generation real inode, can b=
e used to
> >      access a completely new inode, which should be accessed only via t=
he new
> >      dentry."
> >
> > I have made this fix after seeing users get the content of another
> > file from the one that they opened in NFS!
> >
> > libfuse commit 10ecd4f ("test/test_syscalls.c: check unlinked testfiles
> > at the end of the test") reproduces this problem in a test.
> > This test does not involve NFS export, but NFS export has higher
> > likelihood of exposing this issue.
> >
> > I wonder if the FUSE filesystems that report the errors have
> > FUSE_EXPORT_SUPPORT capability?
> > Not that this capability guarantees anything wrt to this issue.
> >
> > IMO, the root of all evil wrt NFS+FUSE is that LOOKUP is by ino
> > without generation with FUSE_EXPORT_SUPPORT, but worse
> > is that FUSE does not even require FUSE_EXPORT_SUPPORT
> > capability to export to NFS, but this is legacy FUSE behavior and
> > I am sure that many people export FUSE filesystems, as your
> > report proves.
> >
> > There is now a proposal for opt-out of NFS export:
> > https://lore.kernel.org/linux-fsdevel/20240126072120.71867-1-jefflexu@l=
inux.alibaba.com/
> > so there will be a way for a FUSE filesystem to prevent misuse.
> >
> > Some practical suggestions for users running existing FUSE filesystems:
> >
> > - Never export a FUSE filesystem with a fixed fsid
> > - Everytime one wants to export a FUSE filesystem generate
> >    a oneshot fsid/uuid to use in exportfs
> > - Then restarting/re-exporting the FUSE filesystem will result in
> >    ESTALE errors on NFS client, but not security violations and not EIO
> >    errors
> > - This does not give full guarantee, unlinked inodes could still result
> >    in EIO errors, as the libfuse test demonstrates
> > - The situation with NFSv4 is slightly better than with NFSv3, because
> >     with NFSv3, an open file in the client does not keep the FUSE file
> >     open and increases the chance of evicted FUSE inode for an open
> >     NFS file
> >
> > Thanks,
> > Amir.
>
> Thank you Amir for such a detailed response. I'll look into this further
> but a few questions. To answer your question: yes, the server is setting
> EXPORT_SUPPORT.
>
> 1. The expected behavior, if the above situation occurred, is that the
> whole of the mount would return EIO? All requests going forward? What
> about FUSE_STATFS? From what I saw that was coming through.
>

It's only for a specific bad/stale inode which you have an open fd for
and trying to access, but another FUSE inode object already reused
its inode number.

> 2. Regarding the tests. I downloaded the latest libfuse, compiled, and
> ran test_syscalls against the FUSE server. I get no failures when
> running `./test_syscalls /mnt/fusemount :/mnt/ext4mount -u` or
> `./test_syscalls /mnt/fusemount -u` where ext4mount is the underlying
> filesystem and fusemount is the FUSE server's. No error is reported. A
> strace shows the fstat returning ESTALE at the end but the tests all
> pass. The mount continues to work after running the test. This is on
> kernel 6.5.0. Is that expected? It sounds from your description that I
> should be seeing EIOs somewhere.
>

It is expected.
The test says:

                        // With O_PATH fd, the server does not have to keep
                        // the inode alive so FUSE inode may be stale or ba=
d
                        if (errno =3D=3D ESTALE || errno =3D=3D EIO ||
                            errno =3D=3D ENOENT || errno =3D=3D EBADF)
                                return 0;

So it is a matter of chance which error you get.
But those EIO errors are relatively rare, so if your users see them
across the fs, it's probably due to something else.

> 3. Thank you for the "practical suggestions". I will compare them to
> what my users are doing... but are there specific guidelines somewhere
> for building a FUSE server to ensure NFS export can be supported? This

I have implemented a library/fs-template for writing FUSE passthrough fs
that supports persistent NFS file handles (i.e. they survive server restart=
):

https://github.com/amir73il/libfuse/blob/fuse_passthrough/passthrough/fuse_=
passthrough.cpp

This is an implementation that assumes passthrough to ext4/xfs.
A generic implementation would require FUSE protocol change.

See: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEho=
MfG=3D3CSKucvoJbj6JSg@mail.gmail.com/

> topic has had limited details available over the years and I/users have
> had odd behaviors at times that were unclear of the cause. Like this
> situation or when NFS somehow triggered a request for '..' of the root
> nodeid (1). Some questions that come to mind: is the generation strictly
> necessary (practically) for things to work so long as nodeid is unique
> during a session (64bit nodeid space can last a long time)? Is there

The nodeid space is restarted on server restart and new nodeids are
assigned to same objects.

Using server inode numbers is more sane but as the test demonstrates
it is not always enough.

> possibility of conflict if multiple fuse servers used the same
> nodeid//gen pairs at the same time?

You cannot export two different fs with the same fsid/uuid at the same
time. NFS won't let you do that.

>  To what degree does the inode value
> matter? Should old node/gen pairs be kept around forever as noforget
> libfuse option suggests for NFS?

Does not matter.
As long as FUSE protocol does lookup by ino without generation
there is little that the server can do. It can only return the most
recent generation for that ino.

> Perhaps some of this is obvious but
> given changes to FUSE over time and the differences between kernel and
> userspace fs experiences it would be nice to have some of these more
> niche/complicated situations better flushed out in the official docs.
>

Would be nice if someone picked up that glove, but nothing about this
is trivial...

My plan was to contribute fuse_passthrough lib to the libfuse project,
but my focus has shifted and it requires some work yet to package this lib.

If someone is interested to take up this work and help maintain this
library, I am willing to help them.

Thanks,
Amir.

