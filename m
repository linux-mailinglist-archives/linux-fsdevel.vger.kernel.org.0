Return-Path: <linux-fsdevel+bounces-1640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E97DCD49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 13:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B03B20F94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A0111BA;
	Tue, 31 Oct 2023 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv+F98F2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6B101D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 12:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A3CC433C7;
	Tue, 31 Oct 2023 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698756652;
	bh=ooYvuAJQsO+4SfLIgcsGGqWv3otTPgmJFxOPyynT+7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sv+F98F2VgXxWsDlITnsau6sxEh/4PSdQBoeFr+7GCqOiRN6plFi5vLkgQfSq7zZU
	 B0ZrYHcR01Rpeq6c4qnTpTmju7rACxDi8dQyt58JNkwwfCGu3zGx+ziBJ3gpDCXpU0
	 +EtSGL73Y1WKb+roiV84SekeFcZJXLUBpLqKeeZJ/ikxRtXPlTIGq/REBXyYzWlRVp
	 UGudZc4CKpzqq9+/d5s7enac0PixIdtxZqla2OjnYfOaSTRSEmuZOYCndyTt/zNQw3
	 iNCRmvCuw3EIqi7dozzOVwzwpHUhd0B4FLuqZzmnIymtwdmJ5cQAvPGTYOgQTjDHAz
	 BKodtTtI+0/Hw==
Date: Tue, 31 Oct 2023 13:50:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231031-anorak-sammeln-8b1c4264f0db@brauner>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUDxli5HTwDP6fqu@infradead.org>

On Tue, Oct 31, 2023 at 05:22:46AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 31, 2023 at 01:14:42PM +0100, Christian Brauner wrote:
> > What happens in the kernel right now I've mentiond in the mount api
> > conversion patch for btrfs I sent out in June at [1] because I tweaked
> > that behavior. Say I mount both subvolumes:
> > 
> > mount /dev/sda -o subvol=subvol1 /vol1 # sb1@vfsmount1
> > mount /dev/sda -o subvol=subvol2 /vol2 # sb1@vfsmount2
> > 
> > It creates a superblock for /dev/sda. It then creates two vfsmounts: one
> > for subvol1 and one for subvol2. So you end up with two subvolumes on
> > the same superblock.
> > 
> > So if you mount a subvolume today then you already get separate
> > vfsmounts. To put it another way. If you start 10,000 containers each
> > using a separate btrfs subvolume then you get 10,000 vfsmounts.
> 
> But only if you mount them explicitly, which you don't have to.

Yep, I'm aware.

> 
> > Or is it that you want a separate superblock per subvolume?
> 
> Does "you" refer to me here?  No, I don't.
> 
> > Because only
> > if you allocate a new superblock you'll get clean device number
> > handling, no? Or am I misunderstanding this?
> 
> If you allocate a super block you get it for free.  If you don't
> you have to manually allocate it report it in ->getattr.

So this is effectively a request for:

btrfs subvolume create /mnt/subvol1

to create vfsmounts? IOW,

mkfs.btrfs /dev/sda
mount /dev/sda /mnt
btrfs subvolume create /mnt/subvol1
btrfs subvolume create /mnt/subvol2

would create two new vfsmounts that are exposed in /proc/<pid>/mountinfo
afterwards?

That might be odd. Because these vfsmounts aren't really mounted, no?
And so you'd be showing potentially hundreds of mounts in
/proc/<pid>/mountinfo that you can't unmount?

And even if you treat them as mounted what would unmounting mean? I'm
not saying that it's a show stopper but we would need a clear
understanding what the semantics are were after?

My knee-jerk reaction is that if we wanted each btrfs subvolume to be a
vfsmount then we don't want to have them show up in
/proc/<pid>/mountinfo _unless_ they're actually mounted.


