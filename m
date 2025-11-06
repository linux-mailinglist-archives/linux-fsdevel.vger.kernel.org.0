Return-Path: <linux-fsdevel+bounces-67351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C1C3CB72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56994188F941
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833CD34EEFB;
	Thu,  6 Nov 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lpmjo3Ie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81D34EEEC;
	Thu,  6 Nov 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448779; cv=none; b=Qwhw879Vu2g1H07e8+vl1wEGLvXCqBxkjen+GLz09p0MJv1ZZvfxS97oAeZbehhOL8y62/yX8ay+DuoG3LUBGwKGcdzif+ed2Y6yS+m9Rpu5QBjxkVbWE7oc1Yi7U4Fdk7hzSZwSGgyNAWHRre67LSIdXq9nmthmG0CEz6sbU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448779; c=relaxed/simple;
	bh=HYqSbMVlgRrqd3ughnLCDZUQclzo5+JlWp/SGvPq9II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNJ4nq9NlI8szud5/wCh2plC2ivOCP7qJ1EzwCORjbZpdevutiVX2SDSao0c995bMP1woPsvEGxa6JGi8ONR+wYY8H7HnHeR82Q2RVNB55H+WP56BHZtM377oUt+wQuMn7fZbc8r8t9Qy6hJDCddrQwN3+DUDHoVL6+zLj+/J9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lpmjo3Ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B75C16AAE;
	Thu,  6 Nov 2025 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448779;
	bh=HYqSbMVlgRrqd3ughnLCDZUQclzo5+JlWp/SGvPq9II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lpmjo3IePtJIA9J3kBZEIZl5WgYzWCc/p5gARiwQwsrhvZhVjJ3q9++asd5Bfip31
	 /wZ72cjEbdeOrSIvo/eYnYOCQ2/TPG9nLBjrqqenKtf+wleMtg6KvDi4ht/+Vi2tCh
	 bY+WJFPDpIC2wzQZM8KUVW5/hwAEFq3+ncVoz/qiCxt1rC8zGokZTcx2vFV07cjSw3
	 jqtUm+M+vNE9V+NSU642+TsaGotfX0L+5CphHRR1WEDIYSJdGsgH9zOsnB4R/4iuV2
	 SvPBTPqqnqQQQ+KyAjZZwCu9cvNPiSz0iPPDTe/ulDeybAyQDUD4Kr3EaBY+qeyiAf
	 kG+HWxDOxHh3A==
Date: Thu, 6 Nov 2025 09:06:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, cem@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gabriel@krisman.be, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/6] iomap: report file IO errors to fsnotify
Message-ID: <20251106170618.GR196362@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
 <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
 <ewqcnrecsvpi5wy3mufy3swnf46ejnz4kc5ph2eb4iriftdddi@mamiprlrvi75>
 <CAOQ4uxhfrHNk+b=BW5o7We=jC7ob4JbuL4vQz8QhUKD0VaRP=A@mail.gmail.com>
 <g2xevmkixxjturg47qv4gokvxvbah275z5slweehj2pvesl3zs@ordfml4v7gaa>
 <20251105182808.GC196370@frogsfrogsfrogs>
 <20251105194138.GK196362@frogsfrogsfrogs>
 <flgcbd3bzaa6sdlnspub7htwyengcuuadbcws32edns7z5fpgr@kyjoo4tf7qyf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <flgcbd3bzaa6sdlnspub7htwyengcuuadbcws32edns7z5fpgr@kyjoo4tf7qyf>

On Thu, Nov 06, 2025 at 11:13:45AM +0100, Jan Kara wrote:
> On Wed 05-11-25 11:41:38, Darrick J. Wong wrote:
> > On Wed, Nov 05, 2025 at 10:28:08AM -0800, Darrick J. Wong wrote:
> > > On Wed, Nov 05, 2025 at 03:24:41PM +0100, Jan Kara wrote:
> > > > On Wed 05-11-25 12:14:52, Amir Goldstein wrote:
> > > > > 
> > > > > ...
> > > > > We recently discovered that fsnotify_sb_error() calls are exposed to
> > > > > races with generic_shutdown_super():
> > > > > https://lore.kernel.org/linux-fsdevel/scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa/
> > > 
> > > Hrmm.  I've noticed that ever since I added this new patchset, I've been
> > > getting more instances of outright crashes in the timer code, or
> > > workqueue lockups.  I wonder if that UAF is what's going on here...
> > > 
> > > > > Will punting all FS_ERROR events to workqueue help to improve this
> > > > > situation or will it make it worse?
> > > > 
> > > > Worse. But you raise a really good point which I've missed during my
> > > > review. Currently there's nothing which synchronizes pending works with
> > > > superblock getting destroyed with obvious UAF issues already in
> > > > handle_sb_error().
> > > 
> > > I wonder, could __sb_error call get_active_super() to obtain an active
> > > reference to the sb, and then deactivate_super() it in the workqueue
> > > callback?  If we can't get an active ref then we presume that the fs is
> > > already shutting down and don't send the event.
> > 
> > ...and now that I've actually tried it, I realize that we can't actually
> > call get_active_super because it can sleep waiting for s_umount and
> > SB_BORN.  Maybe we could directly atomic_inc_not_zero(&sb->s_active)
> > adn trust that the caller has an active ref to the sb?  I think that's
> > true for anyone calling __sb_error with a non-null inode.
> 
> Well, the side-effects of holding active sb reference from some workqueue
> item tend to hit back occasionally (like when userspace assumes the device
> isn't used anymore but it in fact still is because of the active
> reference). Every time we tried something like this (last time it was with
> iouring I believe) some user came back and complained his setup broke. In
> this case it should be really rare but still I think it's better to avoid
> it if we can (plus I'm not sure what you'd like to do for __sb_error()
> callers that don't get the inode and thus active reference isn't really
> guaranteed - they still need the protection against umount so that
> handle_sb_error() can do the notifier callchain thing).
> 
> So I think a better solution might be that generic_shutdown_super() waits
> for pending error notifications after clearing SB_ACTIVE before umount
> proceeds further and __sb_error() just starts discarding new notifications
> as soon as we see SB_ACTIVE is clear.

<nod> Summarizing what we just talked about on the ext4 call--

Instead of grabbing an active reference to the sb, I'll instead fix
__sb_error to (a) ignore !BORN || !ACTIVE || DYING supers, and (b)
increment a counter in the sb whenever we queue an event, and decrement
it when the worker finishes with it.  generic_shutdown_super can then
wait (having just cleared ACTIVE) for the counter to hit zero before it
stops fsnotify and drops the dentry cache.

Or at least that's what I'll try today.

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

