Return-Path: <linux-fsdevel+bounces-13059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAAE86ABDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7D51F238BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374BD364D2;
	Wed, 28 Feb 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuM1xVIX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213A249F7;
	Wed, 28 Feb 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114849; cv=none; b=HmlLx4Kmsmx2AgkhYnHDgFHQVKHY6bFiljo72t0ORGV84fwTp+fIq3Lr3F2VTo0o5MeorhiflKMWU22zL8LxIzD0rDM5AiPaHnZtB1cz5FdwpNz13Xh+9H5/oJrW1gvB0iTNpTdGDJnzdN3abxa9gUDDvVENuLPhTVbFLZudpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114849; c=relaxed/simple;
	bh=rZo0ydXrxvyEza4GJeAVdGqsDl2NljfQHPEeT26VUQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUgnjmyzpRTsITJcMIIpFq4ong/dcOt/WzfbgG/arbP+9vbhoQfId0H0QqQ0fGQqg+yooxZdaeNIjlWYDlg02OXiaeDqPNNwThi6PE1bvAILSxbZW3cMpQTh8zMG2bqx5s2W7irqtWAtmH96k2elRX/DYWwOwi9TJzfSkVjS4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuM1xVIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187EBC433C7;
	Wed, 28 Feb 2024 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709114849;
	bh=rZo0ydXrxvyEza4GJeAVdGqsDl2NljfQHPEeT26VUQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuM1xVIXTrnvPCUNb1upoTRr6ZnMNWc28k/bJOaWRcgrBqQN9L8bhr8QcnlVpxmig
	 UU5d/n7Jv9j4xry3qIvV6rFL1KMlE80Dph11hGAdHsRBFr2V6vxAvafZ5CDvVfNC9c
	 aY6CoJwHd/x76McxmCzal+7v3iHJCSgei6rh9XCtVfIwQ3EydBzYjTTzr2y9twVqFS
	 DhDnBwjWSerNtKR7iyS3Oupd8PSDPe+dylGQmN9ZrvPhUU291xSzDz+AT4epFE9eEM
	 OsbLXdQb28XUZ1cunSl1Kn0mr3b3U/AwiXOc8I+U0QzhO2FhBIMjBLXtpkyjk7qod0
	 vChwXxkI40VPQ==
Date: Wed, 28 Feb 2024 11:07:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: John Groves <John@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 11/20] famfs: Add fs_context_operations
Message-ID: <20240228-zecken-zonen-d07e89c6f536@brauner>
References: <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
 <20240227-mammut-tastatur-d791ca2f556b@brauner>
 <6jrtl2vc4dmi5b6db6tte2ckiyjmiwezbtlwrtmm464v65wkhj@znzv2mwjfgsk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6jrtl2vc4dmi5b6db6tte2ckiyjmiwezbtlwrtmm464v65wkhj@znzv2mwjfgsk>

> I wasn't aware of the new fsconfig interface. Is there documentation or a
> file sytsem that already uses it that I should refer to? I didn't find an
> obvious candidate, but it might be me. If it should be obvious from the
> example above, tell me and I'll try harder.
> 
> My famfs code above was copied from ramfs. If you point me to 

Ok, but that's the wrong filesystem to use as a model imho. Because it
really doesn't deal with devices at all. That's why it uses
get_tree_nodev() with "nodev" as in "no device" kinda. So ramfs doesn't
have any of these issues. Whereas your filesystems is dealing with
devices dax (or pmem).

> documentation I might send you a ramfs fsconfig patch too :D.

So the manpages are at:

https://github.com/brauner/man-pages-md

But really, there shouldn't be anything that needs to change for ramfs.

> > What errno is EALREADY? Isn't that socket stuff. In any case, it seems
> > you want EBUSY?
> 
> Thanks... That should probaby be EBUSY. But the whole famfs_context_list
> should probably also be removed. More below...
> 
> > 
> > But bigger picture I'm lost. And why do you keep that list based on
> > strings? What if I do:
> > 
> > mount -t famfs /dev/pmem1234 /mnt # succeeds
> > 
> > mount -t famfs /dev/pmem1234 /opt # ah, fsck me, this fails.. But wait a minute....
> > 
> > mount --bind /dev/pmem1234 /evil-masterplan
> > 
> > mount -t famfs /evil-masterplan /opt # succeeds. YAY
> > 
> > I believe that would trivially defeat your check.
> > 
> 
> And I suspect this is related to the get_tree issue you noticed below.
> 
> This famfs code was working in 6.5 without keeping the linked list of devices,
> but in 6.6/6.7/6.8 it works provided you don't try to repeat a mount command
> that has already succeeded. I'm not sure why 6.5 protected me from that,
> but the later versions don't. In 6.6+ That hits a BUG_ON (have specifics on 
> that but not handy right now).

get_tree_nodev() by default will always allocate a new superblock. This
is how tmpfs and ramfs work. If you do:

mount -t tmpfs tmpfs /mnt
mount -t tmpfs tmpfs /opt

You get two new, independent superblocks. This is what you want for
these multi-instance filesystems: each new mount creates a new instance.

If famfs doesn't want to allow reusing devices - which I very much think
it wants to prevent - then it cannot use get_tree_nodev() directly
without having a hack like you did. Because you'll get a new superblock
no problem. So the fact that it did work somehow likely was a bug in
your code.

The reason your code causes crashes is very likely this:

struct famfs_fs_info *fsi = sb->s_fs_info;
handlep = bdev_open_by_path(fc->source, FAMFS_BLKDEV_MODE, fsi, &fs_holder_ops);

If you look at Documentation/filesystems/porting.rst you should see that
if you use @fs_holder_ops then your holder should be the struct
super_block, not your personal fsinfo.

> So for a while we just removed repeated mount requests from the famfs smoke
> tests, but eventually I implemented the list above, which - though you're right
> it would be easy to circumvent and therefore is not right - it did solve the
> problem that we were testing for.
> 
> I suspect that correctly handling get_tree might solve this problem.
> 
> Please assume that linked list will be removed - it was not the right solution.
> 
> More below...
> 
> > > +		}
> > > +	}
> > > +
> > > +	list_add(&fsi->fsi_list, &famfs_context_list);
> > > +	mutex_unlock(&famfs_context_mutex);
> > > +
> > > +	return get_tree_nodev(fc, famfs_fill_super);
> > 
> > So why isn't this using get_tree_bdev()? Note that a while ago I
> > added FSCONFIG_CMD_CREAT_EXCL which prevents silent superblock reuse. To
> > implement that I added fs_context->exclusive. If you unconditionally set
> > fc->exclusive = 1 in your famfs_init_fs_context() and use
> > get_tree_bdev() it will give you EBUSY if fc->source is already in use -
> > including other famfs instances.
> > 
> > I also fail to yet understand how that function which actually opens the block
> > device and gets the dax device figures into this. It's a bit hard to follow
> > what's going on since you add all those unused functions and types so there's
> > never a wider context to see that stuff in.
> 
> Clearly that's a bug in my code. That get_tree_nodev() is from ramfs, which
> was the starting point for famfs.
> 
> I'm wondering if doing this correctly (get_tree_bdev() when it's pmem) would
> have solved my double mount problem on 6.6 onward.
> 
> However, there's another wrinkle: I'm concluding
> (see https://lore.kernel.org/linux-fsdevel/ups6cvjw6bx5m3hotn452brbbcgemnarsasre6ep2lbe4tpjsy@ezp6oh5c72ur/)
> that famfs should drop block support and just work with /dev/dax. So famfs 
> may be the first file system to be hosted on a character device? Certainly 
> first on character dax. 

Ugh, ok. I defer to others whether that makes sense or not. It would be
a lot easier for you if you used pmem block devices, I guess because it
would be easy to detect reuse in common infrastructure.

But also, I'm looking at your code a bit closer. There's a bit of a
wrinkle the way it's currently written...

Say someone went a bit weird and did:

mount -t xfs xfs /dev/sda /my/xfs-filesystem
mknod DAX_DEVICE /my/xfs-filesystem/dax1234

and then did:

mount -t famfs famfs /my/xfs-filesystem/dax1234 /mnt

Internally in famfs you do:

fsi->dax_filp = filp_open(fc->source, O_RDWR, 0);

and you stash that file... Which means that you are pinning that xfs
filesystems implicitly. IOW, if someone does:

umount /my/xfs-filesystem

they get EBUSY for completely opaque reasons. And if they did:

umount -l /my/xfs-filesystem

followed by mounting that xfs filesystem again they'd get the same
superblock for that xfs filesystem.

What I'm trying to say is that I think you cannot pin another filesystem
like this when you open that device.

IOW, you either need to stash the plain dax device or dax needs to
become it's own tiny internal pseudo fs such that we can open dax
devices internally just like files. Which might actually also be worth
doing. But I'm not the maintainer of that.

> 
> Given that, what variant of get_tree() should it call? Should it add 
> get_tree_dax()? I'm not yet familiar enough with that code to have a worthy 
> opinion on this.

I don't think we need a common helper if famfs would be the only user of this.
But maybe I'm wrong. But roughly you'd need something similar to what we
do for block devices, I'd reckon. So lookup_daxdev() which is similar to
lookup_bdev() and allows you to translate from path to dax device
number maybe.

lookup_daxdev(const char *name, struct dax_dev? *daxdev)
{
	/* Don't actually open the dax device pointlessly */
	kern_path(fc->source, LOOKUP_FOLLOW, path);
	if (!S_ISCHR(inode->i_mode))
		// fail
	if (!may_open_dev(&path))
		// fail

	// check dax device and pin

	// get rid of path references
	path_put(&path);
}

famfs_get_tree(/* broken broken broken */)
{

	lookup_daxdev(fc->source, &ddev);

	sb = sget_fc(fc, famfs_test_super, set_anon_super_fc)
	if (IS_ERR(sb))
		// Error here may mean (aside from memory):
		// * superblock incompatible bc of read-write vs read-only
		// * non-matching user namespace
		// * FSCONFIG_CMD_CREATE_EXCL requested by mounter

	if (!sb->s_root) {
		// fill_super; new sb; dax device currently not used.
	} else {
		// A superblock for that dax device already exists and
		// may be reused. Any additional rejection reasons for
		// such an sb are up to the filesystem.
	}

	// Now really open or claim the dax device.
	// If you fail get rid of the superblock
	// (deactivate_locked_super()).

All handwavy, I know and probably I forgot details. But for you to fill
that in. ;)

