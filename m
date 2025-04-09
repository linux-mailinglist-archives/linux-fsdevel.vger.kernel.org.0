Return-Path: <linux-fsdevel+bounces-46046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D6A81E16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD61BA3A3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F2625A2A0;
	Wed,  9 Apr 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN5QvfRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509122ACEE;
	Wed,  9 Apr 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183043; cv=none; b=MaO3vWx42inKickd5v+UaxhqwZIhCkPsL+HPW+eB/Ppz5j0MSB6Pu5h9aIgf+54zPueNO9XNdDiS52TolU/ZyqLQxYn419E+UYTZn/1vSOnSgQgqaQ7kKcksVmpQy29NZjIxtmtKoMa1y8qdoleo04Db8QrhXXuQssNqjbdwdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183043; c=relaxed/simple;
	bh=sKzJcHcNCXqbcQsV/WeBuuiSaW8w91RTcxMXW6GMLyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdH1Xa8uSsQFFX1veBcazW140yLnTqvdjn14aYFdP4Tj2Vlf5njMnqDht49m2OgrfdYVeuIqsfhUFqbwGJjDuC7zlHaHc1HjznHjutYf4NSuo9ZUbQDVVnCzkrxztoP4Scx+3bElh1jcH8mfzlbd8rqSASegsFbl6L7XDX4BFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN5QvfRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85253C4CEE3;
	Wed,  9 Apr 2025 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744183042;
	bh=sKzJcHcNCXqbcQsV/WeBuuiSaW8w91RTcxMXW6GMLyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN5QvfRyQCoxD/jJz0qicNUGbMEbXBIKlhj2kQduX3At2ZPJPWkiT42P37JqZUOWa
	 AuehoM3GrCPS+zIESeJn+gpzpgAFz4X4f0bNPFi/wvsTSjWacVb2MJDw8cZGYbhcVU
	 4YLE7G+kBMKemEl5FI0V5N+iRtvrB3VxT3vC8lotCR7TFirwDocFg7pxYiuYva11wL
	 D43tHKW1slVFBaHq8DCP2frpS/FhNsXRRDQIjPlxAKAlDNM0BtGWMGkUObC5INAD1R
	 N4SrH4748HQPl7FWmIyAkcZt9IF0GdnZx9ffSBsCd5szIrnQsQufbqkEj63IRDLlSV
	 11FyVNI0/r0NQ==
Date: Wed, 9 Apr 2025 09:17:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, rafael@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <20250409-epochal-famos-cf03c9f13b81@brauner>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <ddee7c1ce2d1ff1a8ced6e9b6ac707250f70e68b.camel@HansenPartnership.com>
 <20250402-radstand-neufahrzeuge-198b40c2d073@brauner>
 <2d698820ebd2e82abe8551425d82e9c387aefd66.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d698820ebd2e82abe8551425d82e9c387aefd66.camel@HansenPartnership.com>

On Tue, Apr 08, 2025 at 11:43:46AM -0400, James Bottomley wrote:
> On Wed, 2025-04-02 at 09:46 +0200, Christian Brauner wrote:
> > On Tue, Apr 01, 2025 at 01:02:07PM -0400, James Bottomley wrote:
> > > On Tue, 2025-04-01 at 02:32 +0200, Christian Brauner wrote:
> > > > The whole shebang can also be found at:
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> > > > 
> > > > I know nothing about power or hibernation. I've tested it as best
> > > > as I could. Works for me (TM).
> > > 
> > > I'm testing the latest you have in work.freeze and it doesn't
> > > currently work for me.  Patch 7b315c39b67d ("power: freeze
> > > filesystems during suspend/resume") doesn't set
> > > filesystems_freeze_ptr so it ends up being NULL and tripping over
> > > this check 
> > 
> > I haven't pushed the new version there. Sorry about that. I only have
> > it locally.
> > 
> > > 
> > > +static inline bool may_unfreeze(struct super_block *sb, enum
> > > freeze_holder who,
> > > +                               const void *freeze_owner)
> > > +{
> > > +       WARN_ON_ONCE((who & ~FREEZE_FLAGS));
> > > +       WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
> > > +
> > > +       if (who & FREEZE_EXCL) {
> > > +               if (WARN_ON_ONCE(sb->s_writers.freeze_owner ==
> > > NULL))
> > > +                       return false;
> > > 
> > > 
> > > in f15a9ae05a71 ("fs: add owner of freeze/thaw") and failing to
> > > resume from hibernate.  Setting it to __builtin_return_address(0)
> > > in filesystems_freeze() makes everything work as expected, so
> > > that's what I'm testing now.
> > 
> > +1
> > 
> > I'll send the final version out in a bit.
> 
> I've now done some extensive testing on loop nested filesystems with
> fio load on the upper. I've tried xfs on ext4 and ext4 on ext4.
> Hibernate/Resume has currently worked on these without a hitch (and the
> fio load burps a bit but then starts running at full speed within a few
> seconds). What I'm doing is a single round of hibernate/resume followed
> by a reboot. I'm relying on the fschecks to detect any filesystem
> corruption. I've also tried doing a couple of fresh starts of the
> hibernated image to check that we did correctly freeze the filesystems.
> 
> The problems I've noticed are:
> 
>    1. I'm using 9p to push host directories throught and that
>       completely hangs after a resume. This is expected because the
>       virtio server is out of sync, but it does indicate a need to
>       address Jeff's question of what we should be doing for network
>       filesystems (and is also the reason I have to reboot after
>       resuming).

No network filesystem supports freeze/thaw so they're not frozen/thawed
during hibernation.

virtiofs doesn't support filesystem freezing either and it warns about
virtio_driver based freezing not being implemented.

