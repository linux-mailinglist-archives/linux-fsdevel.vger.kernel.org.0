Return-Path: <linux-fsdevel+bounces-49541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E8ABE323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 20:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CD37A603E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362127C875;
	Tue, 20 May 2025 18:49:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312402580F7;
	Tue, 20 May 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766966; cv=none; b=Kpv1x5/VO2uC0j9OXkUkCDPf+AkKdGbG1PjGlF5mkGpRWEkkQ07+Fog3vuN6RMPNylpK/8cIUOYfTSTpP0dQTEXUY/TvKymfq6rm8AZ6seavzUZG4UhtcOZIVVQ1mHqGmhaGFIAtL81x1ZFv5aWAlr3yEacijykALw4AX4pLQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766966; c=relaxed/simple;
	bh=vNUKqmYqQw8nL0EvcTeWQO4Ef7PMDGwmPmhwd8foeds=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=LSpgWM4kqFr4ffbJ2jEScs2BB4dyLmMf0mSe4/ztM2Ue4BVzFB66orxSxB/maRJiYjtYNop0mq8KqFXs9jk3EbfCqA/4mg+1lFcowFn/zlid9HzlU2z1zV2iZ9I1/1kScoBsuz5GXVXXKWyTZ4/mTQu7uT8QdhDmlJJzD1fSID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (syn-097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 291DB1E38E;
	Tue, 20 May 2025 14:49:17 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 92F16A0FDF; Tue, 20 May 2025 14:49:16 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <26668.52908.574606.416955@quad.stoffel.home>
Date: Tue, 20 May 2025 14:49:16 -0400
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>,
    linux-fsdevel@vger.kernel.org,
    linux-bcachefs@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-unionfs@vger.kernel.org,
    Miklos Szeredi <miklos@szeredi.hu>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jan Kara <jack@suse.cz>
X-Clacks-Overhead: GNU Terry Pratchett
Subject: Re: [PATCH 0/6] overlayfs + casefolding
In-Reply-To: <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
	<CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
	<osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
	<CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
	<gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
	<CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
	<rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
X-Mailer: VM 8.3.x under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" =3D=3D Kent Overstreet <kent.overstreet@linux.dev> writes:

> On Tue, May 20, 2025 at 04:03:27PM +0200, Amir Goldstein wrote:
>> On Tue, May 20, 2025 at 2:43=E2=80=AFPM Kent Overstreet
>> <kent.overstreet@linux.dev> wrote:
>> >
>> > On Tue, May 20, 2025 at 02:40:07PM +0200, Amir Goldstein wrote:
>> > > On Tue, May 20, 2025 at 2:25=E2=80=AFPM Kent Overstreet
>> > > <kent.overstreet@linux.dev> wrote:
>> > > >
>> > > > On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
>> > > > > On Tue, May 20, 2025 at 7:16=E2=80=AFAM Kent Overstreet
>> > > > > <kent.overstreet@linux.dev> wrote:
>> > > > > >
>> > > > > > This series allows overlayfs and casefolding to safely be used on the
>> > > > > > same filesystem by providing exclusion to ensure that overlayfs never
>> > > > > > has to deal with casefolded directories.
>> > > > > >
>> > > > > > Currently, overlayfs can't be used _at all_ if a filesystem even
>> > > > > > supports casefolding, which is really nasty for users.
>> > > > > >
>> > > > > > Components:
>> > > > > >
>> > > > > > - filesystem has to track, for each directory, "does any _descendent_
>> > > > > >   have casefolding enabled"
>> > > > > >
>> > > > > > - new inode flag to pass this to VFS layer
>> > > > > >
>> > > > > > - new dcache methods for providing refs for overlayfs, and filesystem
>> > > > > >   methods for safely clearing this flag
>> > > > > >
>> > > > > > - new superblock flag for indicating to overlayfs & dcache "filesystem
>> > > > > >   supports casefolding, it's safe to use provided new dcache methods are
>> > > > > >   used"
>> > > > > >
>> > > > >
>> > > > > I don't think that this is really needed.
>> > > > >
>> > > > > Too bad you did not ask before going through the trouble of this implementation.
>> > > > >
>> > > > > I think it is enough for overlayfs to know the THIS directory has no
>> > > > > casefolding.
>> > > >
>> > > > overlayfs works on trees, not directories...
>> > >
>> > > I know how overlayfs works...
>> > >
>> > > I've explained why I don't think that sanitizing the entire tree is needed
>> > > for creating overlayfs over a filesystem that may enable casefolding
>> > > on some of its directories.
>> >
>> > So, you want to move error checking from mount time, where we _just_
>> > did a massive API rework so that we can return errors in a way that
>> > users will actually see them - to open/lookup, where all we have are a
>> > small fixed set of error codes?
>>=20
>> That's one way of putting it.
>>=20
>> Please explain the use case.
>>=20
>> When is overlayfs created over a subtree that is only partially case folded?
>> Is that really so common that a mount time error justifies all the vfs
>> infrastructure involved?

> Amir, you've got two widely used filesystem features that conflict and
> can't be used on the same filesystem.

Wait, what?  How many people use casefolding, on a per-directory
basis?  It's stupid.  Unix/Linux has used case-sensitive filesystems
for years.  Yes, linux supports other OSes which did do casefolding,
but yikes... per-directory support is just insane.  It should be
per-filesystem only at BEST.=20=20

> That's _broken_.

So?  what about my cross mounting of VMS filesystems with "foo.txt;3"
version control so I can go back to previous versions?  Why can't I do
that from my Linux systems that's mounting that VMS image?=20=20=20

Just because it's done doesn't mean it's not dumb.=20=20

> Users hate partitioning just for separate /boot and /home, having to
> partition for different applications is horrible. And since overlay
> fs is used under the hood by docker, and casefolding is used under
> the hood for running Windows applications, this isn't something
> people can predict in advance.

Sure I can, I don't run windows applications to screw casefolding.
:-)

And I personally LIKE having a seperate /boot and /home, because it
gives isolation.  The world is not just single user laptops with
everything all on one disk or spread across a couple of disks using
LVM or RAID or all of the above.=20=20

I also don't see any updates for the XFS tests, or any other
filesystem tests, that actually checks and confirms this decidedly
obtuse and dumb to implement idea.=20=20


John

