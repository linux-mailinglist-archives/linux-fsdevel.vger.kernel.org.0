Return-Path: <linux-fsdevel+bounces-44149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84272A6372D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B7188D31F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431381E1E0C;
	Sun, 16 Mar 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czsWyEhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3D1448E0;
	Sun, 16 Mar 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742152801; cv=none; b=MhtWG0CevJKviiMbKqQCAjAxMqc51yJ7kj9+DJJVCvRDeKrlqu8KTuBJeRwLjvY4YX3QkUVspf5Iuz3I8mlTeHjl2pOT4mMcVSb1S/4L1WH5mDxoNMfjEhLPsr2YMcn+HnB4jd3KVxTrP5j4Z2TdtoCWneIpeti+4rva1RyPBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742152801; c=relaxed/simple;
	bh=3zkdgl+5fRrhnPfnmcyMUK5BRIeYR/RPL0KOX8K6Tnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMctrV6Ktv5UVUWKGQXi3/b6J/gaJcdesPu9ZnAIfsm1gxKnN2qA75PXfZY7K8voA7xm255ytQLkXx+3QXa9RE9x9z62HmQqN3HSODPW/LvDPx+5GuGiMJEl3YmnD7wOrbKBCJMws3+6F1ULh349ae4+aRmNWk3WCAavlxngLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czsWyEhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036AAC4CEEA;
	Sun, 16 Mar 2025 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742152801;
	bh=3zkdgl+5fRrhnPfnmcyMUK5BRIeYR/RPL0KOX8K6Tnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=czsWyEhXjjZY0TtC8wPpv5LKIp2OCAf7pOt3CrSe31wlUO5Z7Ao8BMbbscV49KdjA
	 ZsdPAvxOQCPbwaW6qZXXJoYDUCKxC2CfCJ6ahJOEZBccP6DEv4dhaScImFS+JrTU3H
	 nimLyH9/m8pMB1Gj6XMCwiZ5hyJxxW5kycDn8tkC352A5nIoDxZ8xikRmVuJ0Fzdcj
	 jYCvSiE0/W2UQczp8PMzQXkidkAdypCRnkvayBavp20eYA/YbyOs+1vepwtvQelssF
	 KP87YNetnokcEc+JfRRwg8pEpnrS6zJqZYfNfpoFkszM+3pU3AZipA1ZMWntBgg2Dm
	 nZBj0Ynu4tb0Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-549946c5346so3847643e87.2;
        Sun, 16 Mar 2025 12:20:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQCWziY6FucEasu0A4cN1P3FVRiOOuoVgZSBqxvTbhLRvU8TgOPrUG2TtrBAd8P48Ud8ArGUpPxNA=@vger.kernel.org, AJvYcCWdaaY/XqlOj/FK398TfOTKjbtUPa6ZWbkp6h8r5PmdwkYlo0bHlWz0FK/yrtKPG4Km1lzwMpR9SHGaY3G2aA==@vger.kernel.org, AJvYcCWpsYnIefjsOx9MYZCS/huyuMxeYW+vxE2y1feB+LhexfgPFJ6mF17v+2h0zp8vzZcxOh/9/qKMwsMjdSkaBUKZpfpGATc7@vger.kernel.org
X-Gm-Message-State: AOJu0YyueBMTwYwefQ+3z2b+QaVDal/xhn5ylRjf/X5hPs5eBrVf4DBe
	73+UKCGGxX/d6MgaE8nIPBx+/uAGuSKzzVHc03TW14OU77RkZdkv4pEfweRDwIZQeYatfSZrBuf
	uU1IyKyfeHx2o1EhFreR1xlBMOxw=
X-Google-Smtp-Source: AGHT+IGcfsGWidxv9sRAkkFQzKwjpDHZOVE300xVnp+qPdHtQRaXTm3nUv0t/PqqXA0WFmss8SFP1FVNTS2rHPoZVhY=
X-Received: by 2002:a05:6512:4029:b0:549:b0f3:43a2 with SMTP id
 2adb3069b0e04-549c392511amr3793918e87.40.1742152799381; Sun, 16 Mar 2025
 12:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
 <465d1d23-3b36-490e-b0dd-74889d17fa4c@tnxip.de> <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
 <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
 <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>
 <20250311-visite-rastplatz-d1fdb223dc10@brauner> <814a257530ad5e8107ce5f48318ab43a3ef1f783.camel@HansenPartnership.com>
 <7bdcc2c5d8022d2f1a7ec23c0351f7816d4464c8.camel@HansenPartnership.com>
 <20250315-allemal-fahrbahn-9afc7bc0008d@brauner> <bad92b18f389256d26a886b2b0706d04c8c6c336.camel@HansenPartnership.com>
 <20250316-vergibt-hausrat-b23d525a1d24@brauner> <b2086c64d47463a019ac9fc9e5d7ee7f70becc8d.camel@HansenPartnership.com>
In-Reply-To: <b2086c64d47463a019ac9fc9e5d7ee7f70becc8d.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 16 Mar 2025 20:19:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEsO4qmnkX32Ht-V1uD18raf-9PpwpPhvwf7ebX_cHWFg@mail.gmail.com>
X-Gm-Features: AQ5f1JrQSfOpiTTW16QAGjedBBidhMNR_3UN8YFpWBBxFs47qYn47cz-oLlz-6I
Message-ID: <CAMj1kXEsO4qmnkX32Ht-V1uD18raf-9PpwpPhvwf7ebX_cHWFg@mail.gmail.com>
Subject: Re: [RFC 1/1] fix NULL mnt [was Re: apparmor NULL pointer dereference
 on resume [efivarfs]]
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ryan Lee <ryan.lee@canonical.com>, =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>, 
	linux-security-module@vger.kernel.org, apparmor <apparmor@lists.ubuntu.com>, 
	linux-efi@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	"jk@ozlabs.org" <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 16 Mar 2025 at 15:26, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2025-03-16 at 07:46 +0100, Christian Brauner wrote:
> > On Sat, Mar 15, 2025 at 02:41:43PM -0400, James Bottomley wrote:
> [...]
> > > However, there's another problem: the mntput after kernel_file_open
> > > may synchronously call cleanup_mnt() (and thus deactivate_super())
> > > if the open fails because it's marked MNT_INTERNAL, which is caused
> > > by SB_KERNMOUNT.  I fixed this just by not passing the SB_KERNMOUNT
> > > flag, which feels a bit hacky.
> >
> > It actually isn't. We know that vfs_kern_mount() will always
> > resurface the single superblock that's exposed to userspace because
> > we've just taken a reference to it earlier in efivarfs_pm_notify().
> > So that SB_KERNMOUNT flag is ignored because no new superblock is
> > allocated. It would only matter if we'd end up allocating a new
> > superblock which we never do.
>
> I agree with the above: fc->sb_flags never propagates to the existing
> superblock.  However, nothing propagates the superblock flags back to
> fc->sb_flags either.  The check in vfs_create_mount() is on fc-
> >sb_flags.  Since the code is a bit hard to follow I added a printk on
> the path.mnt flags and sure enough it comes back with MNT_INTERNAL when
> SB_KERNMOUNT is set.
>
> > And if we did it would be a bug because the superblock we allocate
> > could be reused at any time if a userspace task mounts efivarfs
> > before efivarfs_pm_notify() has destroyed it (or the respective
> > workqueue). But that superblock would then have SB_KERNMOUNT for
> > something that's not supposed to be one.
>
> True, but the flags don't propagate to the superblock, so no bug.
>
> > And whether or not that helper mount has MNT_INTERNAL is immaterial
> > to what you're doing here afaict.
>
> I think the problem is the call chain mntput() -> mntput_no_expire()
> which directly calls cleanup_mnt() -> deactivate_super() if that flag
> is set.  Though I don't see that kernel_file_open() could ever fail
> except for some catastrophic reason like out of memory, so perhaps it
> isn't worth quibbling about.
>
> > So not passing the SB_KERNMOUNT flag is the right thing (see devtmpfs
> > as well). You could slap a comment in here explaining that we never
> > allocate a new superblock so it's clear to people not familiar with
> > this particular code.
>
> OK, so you agree that the code as written looks correct? Even if we
> don't necessarily quite agree on why.
>

Thanks for making progress on this. It would be nice if we could fix
this before the v6.14 release, given that the code in question was
introduced this cycle.

And there's another suggestion from Al, to use inode_lock_nested() to
work around the lockdep warning. I can take care of that one, unless
you prefer to do it yourself?

