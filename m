Return-Path: <linux-fsdevel+bounces-1712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC167DDEBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7AC1C20C87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 09:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF9D26B;
	Wed,  1 Nov 2023 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0ID5BAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D27475
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 09:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1632C433C7;
	Wed,  1 Nov 2023 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698832343;
	bh=gr9/ISQr++i5nHb8Hma92GyRHRag1n7JMO5W53UdNA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0ID5BAXhrIgl1T6GbN5L7EC/39F7BVlTSDBcEUg0LFcc8OywJD/pjIRn53soG65z
	 xCg0F+xEp1WTlpPybXZ8hKcaSQao6h06/x4dzarvju8PeGSNz9XnJMchxyJeZFXOPY
	 WQECPTDIb6W7XnJomtqJoal8d7ABjM0jJlt2VtbbIuoIxqYhZazPMQBz3k/xSTcE5r
	 fBMD0v0AGKg0U62x6s8Q4TqG6nV2PCyVgTVDWGcyHwFjYzBhgi/rF9xkix+M7Y0Bl2
	 D1XoNMDByksZo81YgBCwFBAJE0T2afVSxQeI2QSqWEurPorOu6pTn2CQgAL1vwSfNp
	 9rqw05KDFSeHg==
Date: Wed, 1 Nov 2023 10:52:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231101-neigen-storch-cde3b0671902@brauner>
References: <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>

On Wed, Nov 01, 2023 at 07:11:53PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/1 18:46, Christian Brauner wrote:
> > On Tue, Oct 31, 2023 at 10:06:17AM -0700, Christoph Hellwig wrote:
> > > On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote:
> > > > So this is effectively a request for:
> > > > 
> > > > btrfs subvolume create /mnt/subvol1
> > > > 
> > > > to create vfsmounts? IOW,
> > > > 
> > > > mkfs.btrfs /dev/sda
> > > > mount /dev/sda /mnt
> > > > btrfs subvolume create /mnt/subvol1
> > > > btrfs subvolume create /mnt/subvol2
> > > > 
> > > > would create two new vfsmounts that are exposed in /proc/<pid>/mountinfo
> > > > afterwards?
> > > 
> > > Yes.
> > > 
> > > > That might be odd. Because these vfsmounts aren't really mounted, no?
> > > 
> > > Why aren't they?
> > > 
> > > > And so you'd be showing potentially hundreds of mounts in
> > > > /proc/<pid>/mountinfo that you can't unmount?
> > > 
> > > Why would you not allow them to be unmounted?
> > > 
> > > > And even if you treat them as mounted what would unmounting mean?
> > > 
> > > The code in btrfs_lookup_dentry that does a hand crafted version
> > > of the file system / subvolume crossing (the location.type !=
> > > BTRFS_INODE_ITEM_KEY one) would not be executed.
> > 
> > So today, when we do:
> > 
> > mkfs.btrfs -f /dev/sda
> > mount -t btrfs /dev/sda /mnt
> > btrfs subvolume create /mnt/subvol1
> > btrfs subvolume create /mnt/subvol2
> > 
> > Then all subvolumes are always visible under /mnt.
> > IOW, you can't hide them other than by overmounting or destroying them.
> > 
> > If we make subvolumes vfsmounts then we very likely alter this behavior
> > and I see two obvious options:
> > 
> > (1) They are fake vfsmounts that can't be unmounted:
> > 
> >      umount /mnt/subvol1 # returns -EINVAL
> > 
> >      This retains the invariant that every subvolume is always visible
> >      from the filesystems root, i.e., /mnt will include /mnt/subvol{1,}
> 
> I'd like to go this option. But I still have a question.
> 
> How do we properly unmount a btrfs?
> Do we have some other way to record which subvolume is really mounted
> and which is just those place holder?

So the downside of this really is that this would be custom btrfs
semantics. Having mounts in /proc/<pid>/mountinfo that you can't unmount
only happens in weird corner cases today:

* mounts inherited during unprivileged mount namespace creation
* locked mounts

Both of which are pretty inelegant and effectively only exist because of
user namespaces. So if we can avoid proliferating such semantics it
would be preferable.

I think it would also be rather confusing for userspace to be presented
with a bunch of mounts in /proc/<pid>/mountinfo that it can't do
anything with.

> > (2) They are proper vfsmounts:
> > 
> >      umount /mnt/subvol1 # succeeds
> > 
> >      This retains standard semantics for userspace about anything that
> >      shows up in /proc/<pid>/mountinfo but means that after
> >      umount /mnt/subvol1 succeeds, /mnt/subvol1 won't be accessible from
> >      the filesystem root /mnt anymore.
> > 
> > Both options can be made to work from a purely technical perspective,
> > I'm asking which one it has to be because it isn't clear just from the
> > snippets in this thread.
> > 
> > One should also point out that if each subvolume is a vfsmount, then say
> > a btrfs filesystems with 1000 subvolumes which is mounted from the root:
> > 
> > mount -t btrfs /dev/sda /mnt
> > 
> > could be exploded into 1000 individual mounts. Which many users might not want.
> 
> Can we make it dynamic? AKA, the btrfs_insert_fs_root() is the perfect
> timing here.

Probably, it would be an automount. Though I would have to recheck that
code to see how exactly that would work but roughly, when you add the
inode for the subvolume you raise S_AUTOMOUNT on it and then you add
.d_automount for btrfs.

