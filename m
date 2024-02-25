Return-Path: <linux-fsdevel+bounces-12729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A23862CF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 21:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 095A9B21064
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6351B80A;
	Sun, 25 Feb 2024 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="qLI6uNl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749E1B59F
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894709; cv=none; b=YHXYfwe+OaE5nhO3BzpXResPLhk0WVnU3S7aztl2geqZm3aU2C9/MHn/ld3Zj3ohGX//OcoTl1v28sNWVVKiXKMw/2BJiAzarjhHtTdq7121tzQmT/Xm0Z5WN+VnUe9PfD/lINnER58zgjFqeZEAej85bWXudgZve2WpOI4gTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894709; c=relaxed/simple;
	bh=0c81bcHVCvSbB0GpAPKInZaRb6rB0DvzNq2nUhuryJw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Blee6PkEyCg/7obaEIidYvXAp0xfHtGX8oB2Zzq6tAe1Koszpg20vY1nLfftO/PJn5aOGTLQ6xYEwdT8XMytC3E/kSk5HMipp3UgRWxS2alRDALYCAAHsz9xVL8fWlb5fjjgBWVRNH1vJ7mQccOyV4gaE/qwlF8WXT5vOSeWWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=qLI6uNl+; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1708894698; x=1709153898;
	bh=oZRuTWqYc0s+m9Mb+IWzKfrBKj/WNKaGGkufQBi20pA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qLI6uNl+8rkA/KzFDGTQlBTdgO8q1TGm1rpDm524SIiYflpu1kCLBF6BsTFWJclBi
	 AAog5b/AfsItXgwoK0CDizE8h0MU4GtEnZ2QZAGahmejMORnFkkHQRqz937OzrimBM
	 rtaCo4xzBdVQwZu2llNb0pyfQiWb6nVfi2QCPAmaJYPVE8hWweai2p0KJEqb2y9TDh
	 efor8TbrXxisl+27hFmglbCYiJPNC3aM58e74sdbp5VLl6DpT4gP+Dn7T9YSYfv/Yn
	 fCT7qrDT0O78DLtj12E1eZ/JEJWnC2yG7us1B8U6R27XtNiCIrkEk/1CIDhZalN9lO
	 Pu+qYoWkc3pHA==
Date: Sun, 25 Feb 2024 20:58:13 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Message-ID: <9b9aab6f-ee29-441b-960d-a95d99ba90d8@spawn.link>
In-Reply-To: <f70732f8-4d67-474a-a4b8-320f78c3394d@spawn.link>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm> <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link> <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com> <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com> <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com> <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link> <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com> <f70732f8-4d67-474a-a4b8-320f78c3394d@spawn.link>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/24/24 18:18, Antonio SJ Musumeci wrote:
> On 2/22/24 05:09, Miklos Szeredi wrote:
>> On Thu, 22 Feb 2024 at 02:26, Antonio SJ Musumeci <trapexit@spawn.link> =
wrote:
>>
>>> I'll try it when I get some cycles in the next week or so but... I'm no=
t
>>> sure I see how this would address it.  Is this not still marking the
>>> inode bad. So while it won't forget it perhaps it will still error out.
>>> How does this keep ".." of root being looked up?
>>>
>>> I don't know the code well but I'd have thought the reason for the
>>> forget was because the lookup of the parent fails.
>>
>> It shouldn't be looking up the parent of root.   Root should always be
>> there, and the only way I see root disappearing is by marking it bad.
>>
>> If the patch makes a difference, then you need to find out why the
>> root is marked bad, since the filesystem will still fail in that case.
>> But at least the kernel won't do stupid things.
>>
>> I think the patch is correct and is needed regardless of the outcome
>> of your test.  But there might be other kernel bugs involved, so
>> definitely need to see what happens.
>>
>> Thanks,
>> Miklos
>=20
> With the patch it doesn't issue forget(nodeid=3D1) anymore. Nor requestin=
g
> parent of nodeid=3D1.
>=20
> However, I'm seeing different issues.
>=20
> I instrumented FUSE to print when it tags an inode bad.
>=20
> After it gets into the bad state I'm seeing nfsd hammering the mount
> even when I've umounted the nfs share and killed the FUSE server. nfsd
> is pegging a CPU core and the kernel log is filled with
> fuse_stale_inode(nodeid=3D1) fuse_make_bad(nodeid=3D1) calls. Have to reb=
oot.
>=20
> What's triggering the flagging the inode as bad seems to be in
> fuse_iget() at fuse_stale_inode() check. inode->i_generation is 0 while
> the generation value is as I set it originally.
>=20
>   From the FUSE server I see:
>=20
> lookup(nodeid=3D3,name=3D".")
> lookup(nodeid=3D3,name=3D"..") which returns ino=3D1 gen=3Dexpected_val
> getattr(nodeid=3D2) inodeid=3D2 is the file I'm reading in a loop
> forget(nodeid=3D2)
>=20
> after which point it's no longer functional.
>=20
>=20

I've resolved the issue and I believe I know why I couldn't reproduce=20
with current libfuse examples. The fact root node has a generation of 0=20
is implicit in the examples and as a result when the request came in the=20
lookup on ".." of a child node to root it would return 0. However, in my=20
server I start the generation value of everything at different non-zero=20
value per instance of the server as at one point I read that ensuring=20
different nodeid + gen pairs for different filesystems was better/needed=20
for NFS support. I'm guessing the increase in reports I've had was=20
happenstance of people upgrading to kernels past 5.14.

In retrospect it makes sense that the nodeid and gen are assumed to be 1=20
and 0 respectively, and don't change, but due to the symptoms I had it=20
wasn't clicking till I saw the stale check.

Not sure if there is any changes to the kernel code that would make=20
sense. A log entry indicating root was tagged as bad and why would have=20
helped but not sure it needs more than a note in some docs. Which I'll=20
likely add to libfuse.

Thanks for everyone's help. Sorry for the goose chase.




