Return-Path: <linux-fsdevel+bounces-44181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE862A64662
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8821B3AB7F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440E221F14;
	Mon, 17 Mar 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njcCKsv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146471B412B;
	Mon, 17 Mar 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201822; cv=none; b=TyslbrCAm49VgrUk3tpqBBy/HmiNDUMcnThhxxzoXKg0RkhQoDffbwKaCjIkf1MQRlauwNGHeEpra55FYzLCqzm8X5HwlHPWxfACwTorw6CBZks2Q8bChuF+714PK4J7cScSkXVZTBKiblbglFkOAzLAFj4cPh8+xiL51stmkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201822; c=relaxed/simple;
	bh=ywlphlxpwCbbPyYcOlpQM+tQkwstJ8CoKCBbl1Omctg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDRVANsfAM+DmaTsm9jlPtGXm6csWt54a1Rqqt1PIBYBM6VCAVoMCOyZncBJbgxxdhL1hNaa43yKuqSStZz/qNiXi7c3hKTtQRR6yk7kV8NoD7oNlBgPZ4oBLIdImIBBsT49INCnj+MVdeg8pdd40t2ToWVVVc74U9oAPJnMx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njcCKsv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C619C4CEE3;
	Mon, 17 Mar 2025 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742201821;
	bh=ywlphlxpwCbbPyYcOlpQM+tQkwstJ8CoKCBbl1Omctg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njcCKsv9iXfeuAqtf22Aoj3cXDpO82NMV6YXnb4cMRONWBaOjoS/BLaMzhGLK3984
	 o43sWUkgw8B/ofiiaaUm85Y2LF0+YyJu+U27im+JEzUTgxY6xqeea40663LJ4Z6vIT
	 oncktrJDsZBd6JB7bB1YQMxzgXxELEf4Xt3SbiyX1CprO33Y+14dw2KbkIxArKwnA6
	 RzzUy5rF9z19lBw3EKvDedt2AsZtLG6eyk4UlSQSJgvEmKVzBvl42OsUVd4h+wSzyM
	 hMmt/xy4aHOj5aINlORD20C3Ki8x3f8jhz+QCZSFX3RV7W2I+ljVTwH+LXdbzsyc/D
	 7hQs4reau5ihQ==
Date: Mon, 17 Mar 2025 09:56:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ryan Lee <ryan.lee@canonical.com>, Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, 
	linux-security-module@vger.kernel.org, apparmor <apparmor@lists.ubuntu.com>, linux-efi@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, "jk@ozlabs.org" <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] fix NULL mnt [was Re: apparmor NULL pointer
 dereference on resume [efivarfs]]
Message-ID: <20250317-luftdicht-mehrweg-aab410542864@brauner>
References: <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
 <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
 <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>
 <20250311-visite-rastplatz-d1fdb223dc10@brauner>
 <814a257530ad5e8107ce5f48318ab43a3ef1f783.camel@HansenPartnership.com>
 <7bdcc2c5d8022d2f1a7ec23c0351f7816d4464c8.camel@HansenPartnership.com>
 <20250315-allemal-fahrbahn-9afc7bc0008d@brauner>
 <bad92b18f389256d26a886b2b0706d04c8c6c336.camel@HansenPartnership.com>
 <20250316-vergibt-hausrat-b23d525a1d24@brauner>
 <b2086c64d47463a019ac9fc9e5d7ee7f70becc8d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2086c64d47463a019ac9fc9e5d7ee7f70becc8d.camel@HansenPartnership.com>

On Sun, Mar 16, 2025 at 10:26:12AM -0400, James Bottomley wrote:
> On Sun, 2025-03-16 at 07:46 +0100, Christian Brauner wrote:
> > On Sat, Mar 15, 2025 at 02:41:43PM -0400, James Bottomley wrote:
> [...]
> > > However, there's another problem: the mntput after kernel_file_open
> > > may synchronously call cleanup_mnt() (and thus deactivate_super())
> > > if the open fails because it's marked MNT_INTERNAL, which is caused
> > > by SB_KERNMOUNT.  I fixed this just by not passing the SB_KERNMOUNT
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

SB_KERNMOUNT does propagate to the superblock if it is newly allocated
via sget_fc(): alloc_super(fc->fs_type, fc->sb_flags, user_ns);

But you misunderstood. "If we did it" means "If efivarfs_pm_notify()
somehow were to allocate a new superblock (which it doesn't) then having
SB_KERNMOUNT raised on the newly allocated superblock would be bug
because the superblock could be reused by userspace mounting efivars.

So removing it is the correct thing in either case. It's just confusing
to anyone maintaining that code thinking that it'd be possible for a
superblock to resurface with SB_KERNMOUNT.

> 
> > And whether or not that helper mount has MNT_INTERNAL is immaterial
> > to what you're doing here afaict.
> 
> I think the problem is the call chain mntput() -> mntput_no_expire()
> which directly calls cleanup_mnt() -> deactivate_super() if that flag
> is set.  Though I don't see that kernel_file_open() could ever fail
> except for some catastrophic reason like out of memory, so perhaps it
> isn't worth quibbling about.

Not what I'm saying. Not having MNT_INTERNAL is paramount to not
deadlocking but by not having it you're not losing anything.

> 
> > So not passing the SB_KERNMOUNT flag is the right thing (see devtmpfs
> > as well). You could slap a comment in here explaining that we never
> > allocate a new superblock so it's clear to people not familiar with
> > this particular code.
> 
> OK, so you agree that the code as written looks correct? Even if we
> don't necessarily quite agree on why.

We agree but you just misunderstood. :)

