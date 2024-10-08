Return-Path: <linux-fsdevel+bounces-31322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435C9948BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F928720F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB301DE898;
	Tue,  8 Oct 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Inln1iza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12A1DDA36;
	Tue,  8 Oct 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389770; cv=none; b=TSGnwWcEz/aVigB8eMaW7xSZK98lyhW6K1AooScwfEYU39zaWJbcyrEVOcgEk1hvfZDvjVmk8x+HcY5+ta/23kEUPXvPh3J5bcXg1Hw4VFDcJISBeD0V6X9yXuxgIqb6v8jp2funNW9FWKHmxLKIkDbZ+6PN3DTk/lBzhxtEG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389770; c=relaxed/simple;
	bh=JR6+VGh4CArZqCoRYObFOhv7Sd/FBRfMfr2vlpfToZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEXPTtB6Ut6ycIxbMZie5sQKX0jVWvLgVhq22bQTDCxqnGknOxZ8ZAaDQ4EYMXOobY5FWpdpX8cgrPB383gbvzoN+slRUCjfcr7pInmUPeUBfHKrjZ9/pIFkePi2gAU1pElCDfJz/8ww9/z2CKwOacKXB+1SY/gUmE0xdjWIegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Inln1iza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AC6C4CEC7;
	Tue,  8 Oct 2024 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728389769;
	bh=JR6+VGh4CArZqCoRYObFOhv7Sd/FBRfMfr2vlpfToZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Inln1izaHcBVmlOAdchRyn4Ruq/9ep3amvz0JpuhRz5yiQkvkzSWa4IGWb2s/AKAb
	 tViBIB2dxeFAonrdPf/uzRajGXf+nBWTJe6dm/64KSVrnb+o5gwKYh81GT7xSJfu9J
	 IBpJKUOvIGp73lQ9orbhqaSGiS5iBCTOyE1pbmnt4GqxFVMqYhNUDN0AuN6NRZtWpW
	 aCFnqOOGAweMxlyJbtvvgfnaROGyh/+q+MK+X2K6Kay0IrU/vz9AsNIi/nFT9TONww
	 N+fQF3PyHJ+dE8IN6oESKy9uiHRIOWJ+S4UJEYFY5i36EufcecMlNdAJM9pCM05vLy
	 AMvfkdGQwLgkg==
Date: Tue, 8 Oct 2024 14:16:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>, Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241008-kanuten-tangente-8a7f35f58031@brauner>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
 <20241008112344.mzi2qjpaszrkrsxg@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008112344.mzi2qjpaszrkrsxg@quack3>

On Tue, Oct 08, 2024 at 01:23:44PM GMT, Jan Kara wrote:
> On Tue 08-10-24 10:57:22, Amir Goldstein wrote:
> > On Tue, Oct 8, 2024 at 1:33 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Oct 07, 2024 at 01:37:19PM -0700, Linus Torvalds wrote:
> > > > On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > > > > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > > > > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > > > > I'd wait with that convertion until this series lands.
> > > >
> > > > Honza, I looked at this a bit more, particularly with an eye of "what
> > > > happens if we just end up making the inode lifetimes subject to the
> > > > dentry lifetimes" as suggested by Dave elsewhere.
> > >
> > > ....
> > >
> > > > which makes the fsnotify_inode_delete() happen when the inode is
> > > > removed from the dentry.
> > >
> > > There may be other inode references being held that make
> > > the inode live longer than the dentry cache. When should the
> > > fsnotify marks be removed from the inode in that case? Do they need
> > > to remain until, e.g, writeback completes?
> > >
> > 
> > fsnotify inode marks remain until explicitly removed or until sb
> > is unmounted (*), so other inode references are irrelevant to
> > inode mark removal.
> > 
> > (*) fanotify has "evictable" inode marks, which do not hold inode
> > reference and go away on inode evict, but those mark evictions
> > do not generate any event (i.e. there is no FAN_UNMOUNT).
> 
> Yes. Amir beat me with the response so let me just add that FS_UMOUNT event
> is for inotify which guarantees that either you get an event about somebody
> unlinking the inode (e.g. IN_DELETE_SELF) or event about filesystem being
> unmounted (IN_UMOUNT) if you place mark on some inode. I also don't see how
> we would maintain this behavior with what Linus proposes.
> 
> > > > Then at umount time, the dentry shrinking will deal with all live
> > > > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > > > just the root dentry inodes?
> > >
> > > I don't think even that is necessary, because
> > > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > > trimming the dentry tree. Hence the dcache drop would cleanup all
> > > inode references, roots included.
> > >
> > > > Wouldn't that make things much cleaner, and remove at least *one* odd
> > > > use of the nasty s_inodes list?
> > >
> > > Yes, it would, but someone who knows exactly when the fsnotify
> > > marks can be removed needs to chime in here...
> 
> So fsnotify needs a list of inodes for the superblock which have marks
> attached and for which we hold inode reference. We can keep it inside
> fsnotify code although it would practically mean another list_head for the
> inode for this list (probably in our fsnotify_connector structure which
> connects list of notification marks to the inode). If we actually get rid
> of i_sb_list in struct inode, this will be a win for the overall system,
> otherwise it is a net loss IMHO. So if we can figure out how to change
> other s_inodes owners we can certainly do this fsnotify change.
> 
> > > > And I wonder if the quota code (which uses the s_inodes list to enable
> > > > quotas on already mounted filesystems) could for all the same reasons
> > > > just walk the dentry tree instead (and remove_dquot_ref similarly
> > > > could just remove it at dentry_unlink_inode() time)?
> > >
> > > I don't think that will work because we have to be able to modify
> > > quota in evict() processing. This is especially true for unlinked
> > > inodes being evicted from cache, but also the dquots need to stay
> > > attached until writeback completes.
> > >
> > > Hence I don't think we can remove the quota refs from the inode
> > > before we call iput_final(), and so I think quotaoff (at least)
> > > still needs to iterate inodes...
> 
> Yeah, I'm not sure how to get rid of the s_inodes use in quota code. One of
> the things we need s_inodes list for is during quotaoff on a mounted
> filesystem when we need to iterate all inodes which are referencing quota
> structures and free them.  In theory we could keep a list of inodes
> referencing quota structures but that would require adding list_head to
> inode structure for filesystems that support quotas. Now for the sake of
> full context I'll also say that enabling / disabling quotas on a mounted
> filesystem is a legacy feature because it is quite easy that quota
> accounting goes wrong with it. So ext4 and f2fs support for quite a few
> years a mode where quota tracking is enabled on mount and disabled on
> unmount (if appropriate fs feature is enabled) and you can only enable /
> disable enforcement of quota limits during runtime.  So I could see us
> deprecating this functionality altogether although jfs never adapted to
> this new way we do quotas so we'd have to deal with that somehow.  But one
> way or another it would take a significant amount of time before we can
> completely remove this so it is out of question for this series.

I still maintain that we don't need to solve the fsnotify and lsm rework
as part of this particular series.

