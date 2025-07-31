Return-Path: <linux-fsdevel+bounces-56367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0739FB16CF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 09:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550AB5A5FBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F129E110;
	Thu, 31 Jul 2025 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3QVQU1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4B239E88;
	Thu, 31 Jul 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948411; cv=none; b=JSTiHFWlFdMiC3UF6VWE/IhSmBziK2ZijZr9/L7nwabcRzFBWdtkwXYu52U3hfXJLH9FqTBuH9lKCCbEcqoTEUBGpN1JCjdCOuYVj1STKV66FtzuJ+12MmDqA/AwCuRgn0vCiLEqOKcrYtA3hza6tLepN54pDw59cIywdDG5ZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948411; c=relaxed/simple;
	bh=UJl4z9vF2kzQ+3bzci3Xb3mCWDp4ilOWOwkLWewufw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhsfy8BEGXOTjvQzHER+xWX7hMI6b8nMstevQ8hPlVm2g2QOJEok24XlC6HuZoF2DLwJ0EyP4CkcXSUjG8up2mEKdNO84EstBSIWPmmuUj+TElMZu0jrsYVJ8jQ01Y9sFrP2SOek3GUZqctgHff63Mllqg3QE3d9RFqqMGMizG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3QVQU1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73733C4CEF6;
	Thu, 31 Jul 2025 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948410;
	bh=UJl4z9vF2kzQ+3bzci3Xb3mCWDp4ilOWOwkLWewufw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3QVQU1Xmnd4eGA6SINGg+MKH6pjLsCn9p2nrFoM4ov+WjluK83tTTSLCIF6zflVz
	 6pUrh8F0s/azrEGL+K10m866iXoYru8X0MqDdEPKI220HQ4pH+XXmEHUJDM0B7zFuZ
	 vAYCyuEwKz05gXVEsUSeuayfyd/QG1m6KmbO/2Yvqyf/cSM5wo66sjtfUHNlTd+84b
	 fj0WA7kZ2Hdfm/NQgjjDvZv5SV5AgUFMcPLKZ04qHM5sppcpBLIjV7box1HaYDr2xg
	 DNv7zYCwEii36fIv0J0EQSTELb9ST+E6wpoBSmxrZkMk/z52xB7lW41moIvpwYSIP6
	 vhTmLU0HmGotQ==
Date: Thu, 31 Jul 2025 09:53:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Pavel Tikhomirov <snorcht@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrei Vagin <avagin@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev, Linux API <linux-api@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
Message-ID: <20250731-masten-resolut-89aca1e3454f@brauner>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <CAE1zp74Myaab_U5ZswjCE=ND66bT907Y=vmsk14hV89R_ugbtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE1zp74Myaab_U5ZswjCE=ND66bT907Y=vmsk14hV89R_ugbtg@mail.gmail.com>

On Thu, Jul 31, 2025 at 10:40:40AM +0800, Pavel Tikhomirov wrote:
> If detached mounts are our only concern, it looks like the check instead of:
> 
> if (!check_mnt(mnt)) {
>         err = -EINVAL;
>         goto out_unlock;
> }
> 
> could've been a more relaxed one:
> 
> if (mnt_detached(mnt)) {
>         err = -EINVAL;
>         goto out_unlock;
> }
> 
> bool mnt_detached(struct mount *mnt)
> {
>         return !mnt->mnt_ns;
> }
> 
> not to allow propagation change only on detached mounts. (As
> umount_tree sets mnt_ns to NULL.)

Changing propagation settings on detached mounts is fine and shoud work?
Changing propagation settings on unmounted mounts not so much...

> 
> Also in do_mount_setattr we have a more relaxed check too:
> 
> if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
>         goto out;
> 
> Best Regards, Tikhomirov Pavel.
> 
> On Sun, Jul 27, 2025 at 5:01 AM Andrei Vagin <avagin@google.com> wrote:
> >
> > On Sat, Jul 26, 2025 at 10:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Sat, Jul 26, 2025 at 10:12:34AM -0700, Andrei Vagin wrote:
> > > > On Thu, Jul 24, 2025 at 4:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > >
> > > > > On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > > > > > Hi Al and Christian,
> > > > > >
> > > > > > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > > > > > unmounted/not ours mounts") introduced an ABI backward compatibility
> > > > > > break. CRIU depends on the previous behavior, and users are now
> > > > > > reporting criu restore failures following the kernel update. This change
> > > > > > has been propagated to stable kernels. Is this check strictly required?
> > > > >
> > > > > Yes.
> > > > >
> > > > > > Would it be possible to check only if the current process has
> > > > > > CAP_SYS_ADMIN within the mount user namespace?
> > > > >
> > > > > Not enough, both in terms of permissions *and* in terms of "thou
> > > > > shalt not bugger the kernel data structures - nobody's priveleged
> > > > > enough for that".
> > > >
> > > > Al,
> > > >
> > > > I am still thinking in terms of "Thou shalt not break userspace"...
> > > >
> > > > Seriously though, this original behavior has been in the kernel for 20
> > > > years, and it hasn't triggered any corruptions in all that time.
> > >
> > > For a very mild example of fun to be had there:
> > >         mount("none", "/mnt", "tmpfs", 0, "");
> > >         chdir("/mnt");
> > >         umount2(".", MNT_DETACH);
> > >         mount(NULL, ".", NULL, MS_SHARED, NULL);
> > > Repeat in a loop, watch mount group id leak.  That's a trivial example
> > > of violating the assertion ("a mount that had been through umount_tree()
> > > is out of propagation graph and related data structures for good").
> >
> > I wasn't referring to detached mounts. CRIU modifies mounts from
> > non-current namespaces.
> >
> > >
> > > As for the "CAP_SYS_ADMIN within the mount user namespace" - which
> > > userns do you have in mind?
> > >
> >
> > The user namespace of the target mount:
> > ns_capable(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)
> >

