Return-Path: <linux-fsdevel+bounces-13074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3986AE95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697921C213AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F7E7352C;
	Wed, 28 Feb 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDUJKwhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0A73508;
	Wed, 28 Feb 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121667; cv=none; b=sYZfEvx1HdS5q9kp5KREqRmIoO3IMdQKVD7eUEEC0OeQjd5/C8veV1MNYPwfr444T6/XPXELdbKOnmB5QzUiSv7PxuNMGaDJ8moMOfaq4wgFWeXUmaylmhWSQ1brgQ17OFjzVJ5Uke4h5+tOjHjJRTprJBbBWV5hjSekjzx3xUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121667; c=relaxed/simple;
	bh=hVazY1d0emHvRzCxZNwlYR6F4hA5Q4Ce9ItobThStms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egFztu75g4dC8mIE2bWAVtP7JGPjJDb7Tr4iedJLLoOlA2i5HQhpNzsZWo55YnlwELaAf9ADvRuTo8603PVbh48JdzOLYWXobMWLQ6fTjOtuMkqpneYcbbM/TpRLzzT8g/3iOW+bFM/HjgKJ8BQGPEF3OMIe16vWtzZ5Pk7OBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDUJKwhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6B3C43390;
	Wed, 28 Feb 2024 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709121667;
	bh=hVazY1d0emHvRzCxZNwlYR6F4hA5Q4Ce9ItobThStms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDUJKwhhKseNNVOjdrlsmPQPiJ++lTrAIQqDZXBG+d4rvgIbZuSpnc5/O3c/Z0S7q
	 7Jc/8DOerepy5EaPgL2EUKQJZnfYmh8m5MCrdhNvONr+j8sUGGTTHZ81Jyfd9R8zM6
	 oWFPnTjVY5L929WIvi55tZj3xGQdCl6/ez/puCQl6+vH0s201+ch+MCPjefRinotX3
	 A30wdbNluJuXIWCKVawgCxJQvEs0DINtET7p/5VGsvLWBLvRMN61u9+r3gyLEDG412
	 42iff7Tp0hcQPgPt6h/sFsHCP4hxEDa0DWVxpiKPSDEvD1voUgxZq39MYt0Qpr3wMq
	 K/vmdMilz5Zkg==
Date: Wed, 28 Feb 2024 13:01:00 +0100
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
Message-ID: <20240228-entworfen-verkabeln-a036afc976ec@brauner>
References: <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
 <20240227-mammut-tastatur-d791ca2f556b@brauner>
 <6jrtl2vc4dmi5b6db6tte2ckiyjmiwezbtlwrtmm464v65wkhj@znzv2mwjfgsk>
 <20240228-zecken-zonen-d07e89c6f536@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228-zecken-zonen-d07e89c6f536@brauner>

On Wed, Feb 28, 2024 at 11:07:20AM +0100, Christian Brauner wrote:
> > I wasn't aware of the new fsconfig interface. Is there documentation or a
> > file sytsem that already uses it that I should refer to? I didn't find an
> > obvious candidate, but it might be me. If it should be obvious from the
> > example above, tell me and I'll try harder.
> > 
> > My famfs code above was copied from ramfs. If you point me to 
> 
> Ok, but that's the wrong filesystem to use as a model imho. Because it
> really doesn't deal with devices at all. That's why it uses
> get_tree_nodev() with "nodev" as in "no device" kinda. So ramfs doesn't
> have any of these issues. Whereas your filesystems is dealing with
> devices dax (or pmem).
> 
> > documentation I might send you a ramfs fsconfig patch too :D.
> 
> So the manpages are at:
> 
> https://github.com/brauner/man-pages-md
> 
> But really, there shouldn't be anything that needs to change for ramfs.
> 
> > > What errno is EALREADY? Isn't that socket stuff. In any case, it seems
> > > you want EBUSY?
> > 
> > Thanks... That should probaby be EBUSY. But the whole famfs_context_list
> > should probably also be removed. More below...
> > 
> > > 
> > > But bigger picture I'm lost. And why do you keep that list based on
> > > strings? What if I do:
> > > 
> > > mount -t famfs /dev/pmem1234 /mnt # succeeds
> > > 
> > > mount -t famfs /dev/pmem1234 /opt # ah, fsck me, this fails.. But wait a minute....
> > > 
> > > mount --bind /dev/pmem1234 /evil-masterplan
> > > 
> > > mount -t famfs /evil-masterplan /opt # succeeds. YAY
> > > 
> > > I believe that would trivially defeat your check.
> > > 
> > 
> > And I suspect this is related to the get_tree issue you noticed below.
> > 
> > This famfs code was working in 6.5 without keeping the linked list of devices,
> > but in 6.6/6.7/6.8 it works provided you don't try to repeat a mount command
> > that has already succeeded. I'm not sure why 6.5 protected me from that,
> > but the later versions don't. In 6.6+ That hits a BUG_ON (have specifics on 
> > that but not handy right now).
> 
> get_tree_nodev() by default will always allocate a new superblock. This
> is how tmpfs and ramfs work. If you do:
> 
> mount -t tmpfs tmpfs /mnt
> mount -t tmpfs tmpfs /opt
> 
> You get two new, independent superblocks. This is what you want for
> these multi-instance filesystems: each new mount creates a new instance.
> 
> If famfs doesn't want to allow reusing devices - which I very much think
> it wants to prevent - then it cannot use get_tree_nodev() directly
> without having a hack like you did. Because you'll get a new superblock
> no problem. So the fact that it did work somehow likely was a bug in
> your code.
> 
> The reason your code causes crashes is very likely this:
> 
> struct famfs_fs_info *fsi = sb->s_fs_info;
> handlep = bdev_open_by_path(fc->source, FAMFS_BLKDEV_MODE, fsi, &fs_holder_ops);
> 
> If you look at Documentation/filesystems/porting.rst you should see that
> if you use @fs_holder_ops then your holder should be the struct
> super_block, not your personal fsinfo.
> 
> > So for a while we just removed repeated mount requests from the famfs smoke
> > tests, but eventually I implemented the list above, which - though you're right
> > it would be easy to circumvent and therefore is not right - it did solve the
> > problem that we were testing for.
> > 
> > I suspect that correctly handling get_tree might solve this problem.
> > 
> > Please assume that linked list will be removed - it was not the right solution.
> > 
> > More below...
> > 
> > > > +		}
> > > > +	}
> > > > +
> > > > +	list_add(&fsi->fsi_list, &famfs_context_list);
> > > > +	mutex_unlock(&famfs_context_mutex);
> > > > +
> > > > +	return get_tree_nodev(fc, famfs_fill_super);
> > > 
> > > So why isn't this using get_tree_bdev()? Note that a while ago I
> > > added FSCONFIG_CMD_CREAT_EXCL which prevents silent superblock reuse. To
> > > implement that I added fs_context->exclusive. If you unconditionally set
> > > fc->exclusive = 1 in your famfs_init_fs_context() and use
> > > get_tree_bdev() it will give you EBUSY if fc->source is already in use -
> > > including other famfs instances.
> > > 
> > > I also fail to yet understand how that function which actually opens the block
> > > device and gets the dax device figures into this. It's a bit hard to follow
> > > what's going on since you add all those unused functions and types so there's
> > > never a wider context to see that stuff in.
> > 
> > Clearly that's a bug in my code. That get_tree_nodev() is from ramfs, which
> > was the starting point for famfs.
> > 
> > I'm wondering if doing this correctly (get_tree_bdev() when it's pmem) would
> > have solved my double mount problem on 6.6 onward.
> > 
> > However, there's another wrinkle: I'm concluding
> > (see https://lore.kernel.org/linux-fsdevel/ups6cvjw6bx5m3hotn452brbbcgemnarsasre6ep2lbe4tpjsy@ezp6oh5c72ur/)
> > that famfs should drop block support and just work with /dev/dax. So famfs 
> > may be the first file system to be hosted on a character device? Certainly 
> > first on character dax. 
> 
> Ugh, ok. I defer to others whether that makes sense or not. It would be
> a lot easier for you if you used pmem block devices, I guess because it
> would be easy to detect reuse in common infrastructure.
> 
> But also, I'm looking at your code a bit closer. There's a bit of a
> wrinkle the way it's currently written...
> 
> Say someone went a bit weird and did:
> 
> mount -t xfs xfs /dev/sda /my/xfs-filesystem
> mknod DAX_DEVICE /my/xfs-filesystem/dax1234
> 
> and then did:
> 
> mount -t famfs famfs /my/xfs-filesystem/dax1234 /mnt
> 
> Internally in famfs you do:
> 
> fsi->dax_filp = filp_open(fc->source, O_RDWR, 0);
> 
> and you stash that file... Which means that you are pinning that xfs
> filesystems implicitly. IOW, if someone does:
> 
> umount /my/xfs-filesystem
> 
> they get EBUSY for completely opaque reasons. And if they did:
> 
> umount -l /my/xfs-filesystem
> 
> followed by mounting that xfs filesystem again they'd get the same
> superblock for that xfs filesystem.
> 
> What I'm trying to say is that I think you cannot pin another filesystem
> like this when you open that device.
> 
> IOW, you either need to stash the plain dax device or dax needs to
> become it's own tiny internal pseudo fs such that we can open dax
> devices internally just like files. Which might actually also be worth
> doing. But I'm not the maintainer of that.

Ah, I see it's already like that and I was looking at the wrong file.
Great! So in that case you could add helper to open dax devices as
files:

struct file *dax_file_open(struct dax_device *dev, int flags, /* other stuff */)
{
	/* open that thing */
        dax_file = alloc_file_pseudo(dax_inode, dax_vfsmnt, "", flags | O_LARGEFILE, &something_fops);
}

and then you can treat them as regular files without running into the
issues I pointed out.

