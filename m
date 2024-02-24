Return-Path: <linux-fsdevel+bounces-12654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC98622D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 07:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02FDB225B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D71755E;
	Sat, 24 Feb 2024 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGGzqJEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0513AFB
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754727; cv=none; b=eutZAqOi47AGqnoGv6P5qpvAn+28fu5O9gDj/3kX2dPKPvZlDPdcLR2csUehBgeZ+8j+lfV99JICatuM345Mn7Tc4VzWvE4x88Sn/8vfp3nseEEOdzFPULaW497dkp8jEBGU5UhNjXo+d9jLhuzlx3w3CewSa5mlqDGxE6sZfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754727; c=relaxed/simple;
	bh=EZEaiwhAwPNUxrP9ndG2wSI9fd5zqiMJrdtOMh3JOEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk3nXmJogtbREcUuEzQYzPkSeCBvsCyh84xXayy+hwX/Ss/FMxnkc8JvOILWq6o8muMBSKDy2EZTNdHOoJUwjYXp/HC0/OdXEPlxTpKk3F5BZXGwIhhzad7/l5Yk/pZ1cyIPST6dCkYqm5tcT987A6H42DhgF4d9S3C7a3emjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGGzqJEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4716BC433F1;
	Sat, 24 Feb 2024 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708754726;
	bh=EZEaiwhAwPNUxrP9ndG2wSI9fd5zqiMJrdtOMh3JOEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGGzqJEc3VTaw1yr14ozoxeTbWIsH9KnUaY/Alb2kgZz2Rh+jiLJ93jMsU/gPtzgH
	 UAl6F77JAa+sJidA6SyWlitWTKMJSyA9J8COikfbOeXcNAvgeSO0l0VQsE+Enpqzrd
	 NpgUmxg0q+FhD8IYJdrGU0yfq+KTKVKWLPgcQ5X+XPvcrB+KpstDnsRspL/R27qMZn
	 VX7GwzVe4tI2X4VHW/y3L15ax7U1GE1q38I2yQMnHLFJlKSt9KKVIbgNVWlcViKxYC
	 RExv9HhaXZd9NVtsQY+1/PBPymcZDeZjU1AOSRZStgeGfZ80axg2JMbqSP4MU0fw8w
	 OWgk8oMENTlCA==
Date: Sat, 24 Feb 2024 07:05:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240224-erstmal-brotkrumen-2a398b2d9fa2@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
 <20240224-westseite-haftzeit-721640a8700b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240224-westseite-haftzeit-721640a8700b@brauner>

On Sat, Feb 24, 2024 at 06:52:41AM +0100, Christian Brauner wrote:
> On Fri, Feb 23, 2024 at 01:58:36PM -0800, Linus Torvalds wrote:
> > On Fri, 23 Feb 2024 at 13:26, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > So, the immediate fix separate from the selinux policy update is to fix
> > > dbus-broker which we've done now:
> > >
> > > https://github.com/bus1/dbus-broker/pull/343
> > 
> > Why is that code then continuing the idiocy of doing different things
> > for different error conditions?
> 
> Not under my control unfortunately.
> 
> > Also, honestly, if this breaks existing setups, then we should fix the
> > kernel anyway. Changing things from the old anonymous inodes to the
> > new pidfs inodes should *not* have caused any LSM denial issues.
> > 
> > You used the same pointer to dbus-broker for the LSM changes, but I
> > really don't think this should have required LSM changes in the first
> > place. Your reaction to "my kernel change caused LSM to barf" should
> > have made you go "let's fix the kernel so that LSM _doesn't_ barf".
> > 
> > Maybe by making pidfs look exactly like anonfs to LSM. Since I don't
> > see the LSM change, I'm not actually sure exactly what LSM even
> > reacted to in that switch-over.
> 
> This is selinux. So I think this is a misunderstanding. This isn't
> something we can fix in the kernel. If Selinux is in enforcing mode in
> userspace and it encounters anything that it doesn't know about it will
> deny it by default. And the policy is entirely in userspace including
> declaring new types for stuff like nsfs or pidfs to allow it. There's
> just nothing to do in the kernel.
> 
> The Selinux policy update in userspace would always have to happen just
> like it had to for nsfs. Usually that happens after a change has landed
> and people realize breakage or realize that new functionality isn't
> available. This time it's just interacting with bad error handling in
> dbus-broker.

I found the old thread for nsfs for example. Same thing:

https://www.spinics.net/lists/selinux/msg18425.html

"Since Linux 3.19 targets of /proc/PID/ns/* symlinks have lived in a fs
separated from /proc, named nsfs [1].  [...] 
When using a recent kernel with a policy without nsfs support, the
inodes are not labeled, as reported for example in Fedora bug #1234757
[3].  As I encounter this issue on my systems, I asked yesterday on the
refpolicy ML how nsfs inodes should be labeled [4]."

With the asker being pointed to a userspace policy update in

https://spinics.net/lists/selinux/msg18426.html

Honestly, my default reaction is always to test things like that with
various security modules and if I encounter anything that I can fix in
the kernel I do it. But the policies aren't in the kernel. The last link
above explicitly mentions this.

