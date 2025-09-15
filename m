Return-Path: <linux-fsdevel+bounces-61467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D436FB58854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A5D3A79FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732B2D1F64;
	Mon, 15 Sep 2025 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="1ElrqUR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450028E5F3;
	Mon, 15 Sep 2025 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979134; cv=none; b=jIZ7/yeoBqwfgUw4LEv+QjJ/YSHoZoEEEN31QjxSNH0B/2IU26Y+yYeoJL/X1PurzuQiPNuSwWe8+70i0VO7jJiwwHPLI7B+Yo474OZ25IobIWMDV7B6cs/gdQgQy7hYlxJzp5+97O90KArfopJ7bSqKOBtzPJlEchncjP7SM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979134; c=relaxed/simple;
	bh=WHU2CxZRa2g5EFKpbNfzwYfa90eDm6qyaP8bTKks+VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HJQBqnjTjJdOUi3Zus3fXK/GdDIGW3PgzL85Xg2mZHkwrTf7Y71N+lMgCLJ1tzniBvxUTd197AHsUod+eiurGpFcXEkWTRMSjr6/ySRSsSy50iet3K5sMddVOuMfcoLrcxdno462l+79KxtHNXtpgr/ltC5BbKJXau58jVP24RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=1ElrqUR1; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1305A14C2D3;
	Tue, 16 Sep 2025 01:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1757979129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=zoWYUdNi4Raj9EAnFQq01pnwxMPu7jm7FnNods9uys4=;
	b=1ElrqUR1IuWPrWWofFu+WWUSwR/WsroYsLK3RMV2eMVtI7m+uqED1Pm9IPGlTPeeGg1Vj6
	6wBFUHGTJylveAk80uFTFl4PAAqpuKn/tNKLv9pUMsXClpvTkQkUPwSW6oZz22DeTRWiSQ
	U/zIFxYyj0XSYYvgE8dU/ucRU4AYXahXAyv67Vs74alHy98/Cuubhhd+ADwthAZ7IylTCE
	tHgMrMpOIls7wARa88eukiJw0b1Ckf+707Viz3jM/UFMJSSaYQjPAKssMu6yu0DvMEsDJX
	328cex7smJ0JPpAPylZ/KqurtGwiYo/BDzcgaMMrdFPDx0E3JE9kBV4kI+Yjrg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9511c87d;
	Mon, 15 Sep 2025 23:32:04 +0000 (UTC)
Date: Tue, 16 Sep 2025 08:31:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <aMih5XYYrpP559de@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41d761e6-d826-4c29-b673-1fb2b0af77b9@maowtm.org>

(Thanks Christian, replying just once but your reply was helpful)

Tingmao Wang wrote on Mon, Sep 15, 2025 at 02:44:44PM +0100:
> > I'm fuzzy on the details but I don't see how inode pointers would be
> > stable for other filesystems as well, what prevents
> > e.g. vm.drop_caches=3 to drop these inodes on ext4?
> 
> Landlock holds a reference to the inode in the ruleset, so they shouldn't
> be dropped.  On security_sb_delete Landlock will iput those inodes so they
> won't cause issue with unmounting.  There is some special mechanism
> ("landlock objects") to decouple the ruleset themselves from the actual
> inodes, so that previously Landlocked things can keep running even after
> the inode has disappeared as a result of unmounting.

Thank you for the explanation, that makes more sense.
iirc even in cacheless mode 9p should keep inode arounds if there's an
open fd somewhere

> > Although looking at the patches what 9p seems to need isn't a new stable
> > handle, but "just" not allocating new inodes in iget5...
> > This was attempted in 724a08450f74 ("fs/9p: simplify iget to remove
> > unnecessary paths"), but later reverted in be2ca3825372 ("Revert "fs/9p:
> > simplify iget to remove unnecessary paths"") because it broke too many
> > users, but if you're comfortable with a new mount option for the lookup
> > by path I think we could make a new option saying
> > "yes_my_server_has_unique_qids"... Which I assume would work for
> > landlock/fsnotify?
> 
> I noticed that, but assumed that simply reverting them without additional
> work (such as tracking the string path) would be a no go given the reason
> why they are reverted.

Yes, just reverting and using that as default broke too much things, so
this is unfortunately not acceptable... And 9p has no "negotiation"
phase on mount to say "okay this is qemu with remap mode so we can do
that" to enable to disable the behaviour automatically; which has been
annoying in the past too.

I understand you'd prefer something that works by default.

> > I'm not sure how much effort we want to spend on 32bit: as far as I
> > know, if we have inode number collision on 32 bit we're already in
> > trouble (tools like tar will consider such files to be hardlink of each
> > other and happily skip reading data, producing corrupted archives);
> > this is not a happy state but I don't know how to do better in any
> > reasonable way, so we can probably keep a similar limitation for 32bit
> > and use inode number directly...
> 
> I think if 9pfs export a handle it can be the full 64bit qid.path on any
> platform, right?

yes, file handle can be an arbitrary size.

> > I'm not familiar with the qid remap implementation in qemu, but I'm
> > curious in what case you hit that.
> > Deleting and recreating files? Or as you seem to say below the 'qid' is
> > "freed" when fd is closed qemu-side and re-used by later open of other
> > files?
> 
> I tried mounting a qemu-exported 9pfs backed on ext4, with
> multidevs=remap, and created a file, used stat to note its inode number,
> deleted the file, created another file (of the same OR different name),
> and that new file will have the same inode number.
> 
> (If I don't delete the file, then a newly created file would of course
> have a different ext4 inode number, and in that case QEMU exposes a
> different qid)

Ok so from Christian's reply this is just ext4 reusing the same inode..
I briefly hinted at this above, but in this case ext4 will give the
inode a different generation number (so the ext4 file handle will be
different, and accessing the old one will get ESTALE); but that's not
something qemu currently tracks and it'd be a bit of an overhaul...
In theory qemu could hash mount_id + file handle to get a properly
unique qid, if we need to improve that, but that'd be limited to root
users (and to filesystems that support name_to_handle_at) so I don't
think it's really appropriate either... hmm..

(I also thought of checking if nlink is 0 when getting a new inode, but
that's technically legimitate from /proc/x/fd opens so I don't think we
can do that either)

And then there's also all the servers that don't give unique qids at
all, so we'll just get weird landlock/fsnotify behaviours for them if we
go that way...

-----------------

Okay, you've convinced me something like path tracking seems more
appropriate; I'll just struggle one last time first with a few more open
questions:
 - afaiu this (reusing inodes) work in cached mode because the dentry is
kept around; I don't understand the vfs well enough but could the inodes
hold its dentry and dentries hold their parent dentry alive somehow?
So in cacheless mode, if you have a tree like this:
a
└── b
    ├── c
    └── d
with c 'open' (or a reference held by landlock), then dentries for a/b/c
would be kept, but d could be droppable?

My understanding is that in cacheless mode we're dropping dentries
aggressively so that things like readdir() are refreshed, but I'm
thinking this should work even if we keep some dentries alive when their
inode is held up.

 - if that doesn't work (or is too complicated), I'm thinking tracking
path is probably better than qid-based filtering based on what we
discussed as it only affects uncached mode.. I'll need to spend some
time testing but I think we can move forward with the current patchset
rather than try something new.

Thanks!
-- 
Dominique Martinet | Asmadeus

