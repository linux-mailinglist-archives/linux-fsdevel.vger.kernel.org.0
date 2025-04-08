Return-Path: <linux-fsdevel+bounces-46005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4513A81343
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6992A1BA5722
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1292356D0;
	Tue,  8 Apr 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOQ1kAhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A7191F79;
	Tue,  8 Apr 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132199; cv=none; b=g+8HLNFPFS4Qfe24pqPRu4AgmqRAtGJVOdtQyO6veeAmZdPuTzwLgdqTTgBrFz1mpwwyncHhUgL8KCWCoLPQgPM6EQD2G2Hix7xUKGmZSaloF8qdCe3aK9suGHmXaLFslQvJhpArx2zZoSyVOwtwG76xNDpp2wVmIZDA7RX8NT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132199; c=relaxed/simple;
	bh=EgmeW83G8jhcI4IjVa+l3i7sUzA33Jc14b4TmgoCBZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEMmTaLQqeyJh0s0sTkbxL4Yz1S7lS3sbwWaiRW3h0H1wJ7QdFHShIxnmZgBN1E/iOi7PwJTGJXrUhAl3vkfJkQPi3Yaw3K22UVINFVEw3rBgae8rTjmf1mu7BLdQwKDrkdDSwMX9ym/72zzlnb+gZEsFbwBEFxirFOPM64KVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOQ1kAhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF252C4CEE5;
	Tue,  8 Apr 2025 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744132198;
	bh=EgmeW83G8jhcI4IjVa+l3i7sUzA33Jc14b4TmgoCBZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOQ1kAhN0C5XGe3KPvC5Jz8AcGjCoYiY1qudcrTwiItZIvCUC4PYJz0QiuxrJ+TWT
	 RGLFIV3C068/dBUbqsqMWtdAh/OjbAEUn62/QneV+2K0dPRjs8mtA770yGnsx5GhP5
	 2sy/XecRKrE/sJEed8v/MSFp7kGuLH9XMI99fx/6tRvTL30zdR4kvp5ChXDcJC6cSx
	 GZDUUxiDxNUbUAb09AD4itsPJ2mdaNftB+UEWicIHhLB40lfFXGHXk1cTLjbAL+qHT
	 ac6naQNjuGeb77Po+2RSrFTL0zyBoQ8DeTaVNSYvCt5UJ1wYgWuItnldmSPuW8huNl
	 GnQUO2jxse6Ew==
Date: Tue, 8 Apr 2025 10:09:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, rafael@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, david@fromorbit.com, djwong@kernel.org,
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <Z_VYZAgHNGEqF7ZB@bombadil.infradead.org>
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
Content-Type: text/plain; charset=iso-8859-1
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
>    2. Top doesn't show any CPU activity after resume even though fio is
>       definitely running.  This seems to be a suspend issue and
>       unrelated to filesystems, but I'll continue investigating.

To be clear, on the fio run -- are you running fio *while*
suspend/resume cycle on XFS? That used to stall / break suspend
resume. We may want to test dd against a drive too, that will use
the block device cache, and I forget if we have a freeze/thaw for it.

  Luis

