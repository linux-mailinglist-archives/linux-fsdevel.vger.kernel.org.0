Return-Path: <linux-fsdevel+bounces-20122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F88CE85A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E4328191C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A812E1E9;
	Fri, 24 May 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="UCbuK3h7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E240126F04;
	Fri, 24 May 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566356; cv=none; b=Tied/aAfgTVzkhfJU6br5yCMKXyIDhNnWx7+lYLFZgNftg4QyjCApMavnERhMDhE25SJStnSBm2vWGYr1owgPsvt05jByYZIurrQT6Gvxc8oupj8y+wi3EZLsYs2ZMyVAXmjLGp8O4+cobQVavvJzFkyG5nYeAcMGc3pBp5o73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566356; c=relaxed/simple;
	bh=9DkMa3xjypHWNGLkI7x7YKTlF3sCNONyXQIuF+js6Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV2qx3zNRv7g+9KH3j4l2sEZzfw00g7NEm9usWPI60cQ7GmLDXtSJbbkW4PcTuWVpIQ1IwNmwIwRtT5AKKK6Ssr+3I1KfDsMlWF5mBum7f7dE3qfNTTlHWJq8D6RnX+HqJTXI3sO6v5+hg7wxhMnjuWvFdrYEGDYQC5GNgGJlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=UCbuK3h7; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vm8qC2L04z9srG;
	Fri, 24 May 2024 17:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716566343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CB5bRg0Ig+nbCG1HCGM8uXKXoWP9XmiqwyR59+Aaey8=;
	b=UCbuK3h7jT3JhXxq9YGbX0UqakWkClSfpy8CNTKubRJyedEMcP3AaRri/1HV6bv7Zci84m
	2dLCwK4mgRyy0WIHM6mIetJ0C2ExGZE+njTAGvDCMzjPmSRKEY0FOoo210Zi86vlWuXatN
	j94wJ2JYNlCwCfYNU0bSLZIt9Db60I+6bUX24JgYxDIU6crn2doCHg8DeYRHUMZQPoqH9O
	ffFsUJVLH4T0xTtIhx6166L0ro4efL1Q3w4bcUmovVw11oYjQhn1n9+JVaiQzlTnUq+scV
	8cpAiTnqpbCEQzQq8MXBhAKWtaYWMfA6xLWBTZH7Z/jsjceJjfgABJtQXrwcbA==
Date: Fri, 24 May 2024 08:58:55 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240524.154429-smoked.node.sleepy.dragster-w2EokFBsl7RC@cyphar.com>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
 <20240523.154320-nasty.dough.dark.swig-wIoXO62qiRSP@cyphar.com>
 <20240524-ahnden-danken-02a2e9b87190@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64k4h5bta2vrchdk"
Content-Disposition: inline
In-Reply-To: <20240524-ahnden-danken-02a2e9b87190@brauner>
X-Rspamd-Queue-Id: 4Vm8qC2L04z9srG


--64k4h5bta2vrchdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-24, Christian Brauner <brauner@kernel.org> wrote:
> On Thu, May 23, 2024 at 09:52:20AM -0600, Aleksa Sarai wrote:
> > On 2024-05-21, Christian Brauner <brauner@kernel.org> wrote:
> > > On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > > > Now that we have stabilised the unique 64-bit mount ID interface in
> > > > statx, we can now provide a race-free way for name_to_handle_at(2) =
to
> > > > provide a file handle and corresponding mount without needing to wo=
rry
> > > > about racing with /proc/mountinfo parsing.
> > > >=20
> > > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* =
bit
> > > > that doesn't make sense for name_to_handle_at(2).
> > > >=20
> > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > ---
> > >=20
> > > So I think overall this is probably fine (famous last words). If it's
> > > just about being able to retrieve the new mount id without having to
> > > take the hit of another statx system call it's indeed a bit much to
> > > add a revised system call for this. Althoug I did say earlier that I
> > > wouldn't rule that out.
> > >=20
> > > But if we'd that then it'll be a long discussion on the form of the n=
ew
> > > system call and the information it exposes.
> > >=20
> > > For example, I lack the grey hair needed to understand why
> > > name_to_handle_at() returns a mount id at all. The pitch in commit
> > > 990d6c2d7aee ("vfs: Add name to file handle conversion support") is t=
hat
> > > the (old) mount id can be used to "lookup file system specific
> > > information [...] in /proc/<pid>/mountinfo".
> >=20
> > The logic was presumably to allow you to know what mount the resolved
> > file handle came from. If you use AT_EMPTY_PATH this is not needed
> > because you could just fstatfs (and now statx(AT_EMPTY_PATH)), but if
> > you just give name_to_handle_at() almost any path, there is no race-free
> > way to make sure that you know which filesystem the file handle came
> > from.
> >=20
> > I don't know if that could lead to security issues (I guess an attacker
> > could find a way to try to manipulate the file handle you get back, and
> > then try to trick you into operating on the wrong filesystem with
> > open_by_handle_at()) but it is definitely something you'd want to avoid.
>=20
> So the following paragraphs are prefaced with: I'm not an expert on file
> handle encoding and so might be totally wrong.
>=20
> Afaiu, the uniqueness guarantee of the file handle mostly depends on:
>=20
> (1) the filesystem
> (2) the actual file handling encoding
>=20
> Looking at file handle encoding to me it looks like it's fairly easy to
> fake them in userspace (I guess that's ok if you think about them like a
> path but with a weird permission model built around them.) for quite a
> few filesystems.

The old Docker breakout attack did brute-force the fhandle for the root
directory of the host filesystem, so it is entirely possible.

However, the attack I was thinking of was whether a directory tree that
an attacker had mount permissions over could be manipulated such that a
privileged process doing name_to_handle_at() on a path within the tree
would get a file handle that open_by_handle_at() on a different
filesystem would result in a potentially dangerous path being opened.

For instance (M is management process, C is the malicious container
process):

 C: Bind-mounts the root of the container filesystem at /foo.
 M: name_to_handle_at($CONTAINER/foo)
     -> gets an fhandle of / of the container filesystem
     -> stores a copy of the (recycled) mount id
 C: Swaps /foo with a bind-mount of the host root filesystem such that
    the mount id is recycled, before M can scan /proc/self/mountinfo.
 C: Triggers M to try to use the filehandle for some administrative
    process.
 M: open_by_handle_at(...) on the wrong mount id, getting an fd of the
    host / directory. Possibly does something bad to this directory
    (deleting files, passing the fd back to the container, etc).

It seems possible that this could happen, so having a unique mount id is
kind of important if you plan to use open_by_handle_at() with malicious
actors in control of the target filesystem tree.

Though, regardless of the attack you are worried about, I guess we are
in agreement that a unique mount id from name_to_handle_at() would be a
good idea if we are planning for userspace to use file handles for
everything.

> For example, for anything that uses fs/libfs.c:generic_encode_ino32_fh()
> it's easy to construct a file handle by retrieving the inode number via
> stat and the generation number via FS_IOC_GETVERSION.
>=20
> Encoding using the inode number and the inode generation number is
> probably not very strong so it's not impossible to generate a file
> handle that is not unique without knowing in which filesystem to
> interpret it in.
>=20
> The problem is with what name_to_handle_at() returns imho. A mnt_id
> doesn't pin the filesystem and the old mnt_id isn't unique. That means
> the filesystem can be unmounted and go away and the mnt_id can be
> recycled almost immediately for another mount but the file handle is
> still there.
>=20
> So to guarantee that a (weakly encoded) file handle is interpreted in
> the right filesystem the file handle must either be accompanied by a
> file descriptor that pins the relevant mount or have any other guarantee
> that the filesystem doesn't go away (Or of course, the file handle
> encodes the uuid of the filesystem or something or uses some sort of
> hashing scheme.).
>=20
> One of the features of file handles is that they're globally usable so
> they're interesting to use as handles that can be shared. IOW, one can
> send around a file handle to another process without having to pin
> anything or have a file descriptor open that needs to be sent via
> AF_UNIX.
>=20
> But as stated above that's potentially risky so one might still have to
> send around an fd together with the file handle if sender and receiver
> don't share the filesystem for the handle.
>=20
> However, with the unique mount id things improve quite a bit. Because
> now it's possible to send around the unique mount id and the file
> handle. Then one can use statmount() to figure out which filesystem this
> file handle needs to be interpreted in.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--64k4h5bta2vrchdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZlC5OwAKCRAol/rSt+lE
b1v+AQDmuUTvZAruF22prlCyJw0a0qvY5B8B/IHl/ZTRHN+prAEA7QWCtrGO3Hwh
lC9Q1xwungvgtxehxX5VlCMpxWo28wA=
=O40w
-----END PGP SIGNATURE-----

--64k4h5bta2vrchdk--

