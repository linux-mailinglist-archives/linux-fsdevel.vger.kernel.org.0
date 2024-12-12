Return-Path: <linux-fsdevel+bounces-37117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A349EDD1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 02:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45121167E19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FBF139D1B;
	Thu, 12 Dec 2024 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff0xsieG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C90126C03;
	Thu, 12 Dec 2024 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967274; cv=none; b=VR2M/De0aOakchjW/9b9SHpg6TFRkd/dAB01KA273iQMJoWu2KhV0JvSzGTkbPhZK47Ja2AiPy8Ji4BuZFkTwU9ObjRR4EgFYfgg61Mp5QF2f6wHUz1ZmeigbyGE31ibumD9NYFmYTbZWICBS9yQlmJpAYmLOkfjuDesGCqJwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967274; c=relaxed/simple;
	bh=rFH7Vy0d4qqQnrvT18y1Gzee/2MVlERDiCCKxcMB4MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJq8ZbJ7yCODeq+As7zrIZeQyLF2PO+8fmJbtPUpKJnRkcjm3EL3HegzIdbQcUplcyCL4WRwsdk54+G73xgSJ0y9Z/aE6smMv93F11hyKwq2DC8Z4d/ty7z5tuIUSnkr5lgP34mWi0K9KNEuBHt3ELCFLB5bVyXudDibkECmINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff0xsieG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA672C4CED2;
	Thu, 12 Dec 2024 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733967273;
	bh=rFH7Vy0d4qqQnrvT18y1Gzee/2MVlERDiCCKxcMB4MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ff0xsieGdd30CDFIGipHS9fXaBBfwfPOOmAjl/1jf0hhwfAiy5y56+ezcDUpQBJwP
	 5c0UFmjVvk0ThugADzndeZZl8hiOe0A9GIY0ZHf5o2Za0jAGR9R8EZvs1dr1RD5VdS
	 rjuJOeB1CspoEf52aXdIpU8CVRj2DBobvrd3KnMdPJog9dd/uxFIf2iVILApv9PFew
	 eqGhCcLGlDX4N4sgu24LwbwsKvMRoWD5qfmgvq4WLgrYqqZj9Kx2q6uo9wTmg6gjNo
	 Vx6coRarW8mcuryvvx+55EBtxyk9YqjzTPDMtcjmz3PCPUtrTnfbFDelML48YNINPL
	 okr6cdyZc/KKA==
Date: Wed, 11 Dec 2024 17:34:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20241212013433.GC6678@frogsfrogsfrogs>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1IX2dFida3coOxe@dread.disaster.area>

On Fri, Dec 06, 2024 at 08:15:05AM +1100, Dave Chinner wrote:
> On Thu, Dec 05, 2024 at 10:52:50AM +0000, John Garry wrote:
> > On 04/12/2024 20:35, Dave Chinner wrote:
> > > On Wed, Dec 04, 2024 at 03:43:41PM +0000, John Garry wrote:
> > > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > > 
> > > > Filesystems like ext4 can submit writes in multiples of blocksizes.
> > > > But we still can't allow the writes to be split into multiple BIOs. Hence
> > > > let's check if the iomap_length() is same as iter->len or not.
> > > > 
> > > > It is the responsibility of userspace to ensure that a write does not span
> > > > mixed unwritten and mapped extents (which would lead to multiple BIOs).
> > > 
> > > How is "userspace" supposed to do this?
> > 
> > If an atomic write spans mixed unwritten and mapped extents, then it should
> > manually zero the unwritten extents beforehand.
> > 
> > > 
> > > No existing utility in userspace is aware of atomic write limits or
> > > rtextsize configs, so how does "userspace" ensure everything is
> > > laid out in a manner compatible with atomic writes?
> > > 
> > > e.g. restoring a backup (or other disaster recovery procedures) is
> > > going to have to lay the files out correctly for atomic writes.
> > > backup tools often sparsify the data set and so what gets restored
> > > will not have the same layout as the original data set...
> > 
> > I am happy to support whatever is needed to make atomic writes work over
> > mixed extents if that is really an expected use case and it is a pain for an
> > application writer/admin to deal with this (by manually zeroing extents).
> > 
> > JFYI, I did originally support the extent pre-zeroing for this. That was to
> > support a real-life scenario which we saw where we were attempting atomic
> > writes over mixed extents. The mixed extents were coming from userspace
> > punching holes and then attempting an atomic write over that space. However
> > that was using an early experimental and buggy forcealign; it was buggy as
> > it did not handle punching holes properly - it punched out single blocks and
> > not only full alloc units.
> > 
> > > 
> > > Where's the documentation that outlines all the restrictions on
> > > userspace behaviour to prevent this sort of problem being triggered?
> > 
> > I would provide a man page update.
> 
> I think, at this point, we need an better way of documenting all the
> atomic write stuff in one place. Not just the user interface and
> what is expected of userspace, but also all the things the
> filesystems need to do to ensure atomic writes work correctly. I was
> thinking that a document somewhere in the Documentation/ directory,
> rather than random pieces of information splattered across random man pages
> would be a much better way of explaining all this.
> 
> Don't get me wrong - man pages explaining the programmatic API are
> necessary, but there's a whole lot more to understanding and making
> effective use of atomic writes than what has been added to the man
> pages so far.
> 
> > > Common operations such as truncate, hole punch,
> > 
> > So how would punch hole be a problem? The atomic write unit max is limited
> > by the alloc unit, and we can only punch out full alloc units.
> 
> I was under the impression that this was a feature of the
> force-align code, not a feature of atomic writes. i.e. force-align
> is what ensures the BMBT aligns correctly with the underlying
> extents.
> 
> Or did I miss the fact that some of the force-align semantics bleed
> back into the original atomic write patch set?
> 
> > > buffered writes,
> > > reflinks, etc will trip over this, so application developers, users
> > > and admins really need to know what they should be doing to avoid
> > > stepping on this landmine...
> > 
> > If this is not a real-life scenario which we expect to see, then I don't see
> > why we would add the complexity to the kernel for this.
> 
> I gave you one above - restoring a data set as a result of disaster
> recovery. 
> 
> > My motivation for atomic writes support is to support atomically writing
> > large database internal page size. If the database only writes at a fixed
> > internal page size, then we should not see mixed mappings.
> 
> Yup, that's the problem here. Once atomic writes are supported by
> the kernel and userspace, all sorts of applications are going to
> start using them for in all sorts of ways you didn't think of.
> 
> > But you see potential problems elsewhere ..
> 
> That's my job as a senior engineer with 20+ years of experience in
> filesystems and storage related applications. I see far because I
> stand on the shoulders of giants - I don't try to be a giant myself.
> 
> Other people become giants by implementing ground-breaking features
> (e.g. like atomic writes), but without the people who can see far
> enough ahead just adding features ends up with an incoherent mess of
> special interest niche features rather than a neatly integrated set
> of widely usable generic features.
> 
> e.g. look at MySQL's use of fallocate(hole punch) for transparent
> data compression - nobody had forseen that hole punching would be
> used like this, but it's a massive win for the applications which
> store bulk compressible data in the database even though it does bad
> things to the filesystem.
> 
> Spend some time looking outside the proprietary database application
> box and think a little harder about the implications of atomic write
> functionality.  i.e. what happens when we have ubiquitous support
> for guaranteeing only the old or the new data will be seen after
> a crash *without the need for using fsync*.

IOWs, the program either wants an old version or a new version of the
files that it wrote, and the commit boundary is syncfs() after updating
all the files?

> Think about the implications of that for a minute - for any full
> file overwrite up to the hardware atomic limits, we won't need fsync
> to guarantee the integrity of overwritten data anymore. We only need
> a mechanism to flush the journal and device caches once all the data
> has been written (e.g. syncfs)...

"up to the hardware atomic limits" -- that's a big limitation.  What if
I need to write 256K but the device only supports up to 64k?  RWF_ATOMIC
won't work.  Or what if the file range I want to dirty isn't aligned
with the atomic write alignment?  What if the awu geometry changes
online due to a device change, how do programs detect that?

Programs that aren't 100% block-based should use exchange-range.  There
are no alignment restrictions, no limits on the size you can exchange,
no file mapping state requiments to trip over, and you can update
arbitrary sparse ranges.  As long as you don't tell exchange-range to
flush the log itself, programs can use syncfs to amortize the log and
cache flush across a bunch of file content exchanges.

Even better, if you still wanted to use untorn block writes to persist
the temporary file's dirty data to disk, you don't even need forcealign
because the exchange-range will take care of restarting the operation
during log recovery.  I don't know that there's much point in doing that
but the idea is there.

> Want to overwrite a bunch of small files safely?  Atomic write the
> new data, then syncfs(). There's no need to run fdatasync after each
> write to ensure individual files are not corrupted if we crash in
> the middle of the operation. Indeed, atomic writes actually provide
> better overwrite integrity semantics that fdatasync as it will be
> all or nothing. fdatasync does not provide that guarantee if we
> crash during the fdatasync operation.
> 
> Further, with COW data filesystems like XFS, btrfs and bcachefs, we
> can emulate atomic writes for any size larger than what the hardware
> supports.
> 
> At this point we actually provide app developers with what they've
> been repeatedly asking kernel filesystem engineers to provide them
> for the past 20 years: a way of overwriting arbitrary file data
> safely without needing an expensive fdatasync operation on every
> file that gets modified.
> 
> Put simply: atomic writes have a huge potential to fundamentally
> change the way applications interact with Linux filesystems and to
> make it *much* simpler for applications to safely overwrite user
> data.  Hence there is an imperitive here to make the foundational
> support for this technology solid and robust because atomic writes
> are going to be with us for the next few decades...

I agree that we need to make the interface solid and robust, but I don't
agree that the current RWF_ATOMIC, with its block-oriented storage
device quirks is the way to go here.  Maybe a byte-oriented RWF_ATOMIC
would work, but the only way I can think of to do that is (say) someone
implements Christoph's suggestion to change the COW code to allow
multiple writes to a staging extent, and only commit the remapping
operations at sync time... and you'd still have problems if you have to
do multiple remappings if there's not also a way to restart the ioend
chains.

Exchange-range already solved all of that, and it's already merged.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

