Return-Path: <linux-fsdevel+bounces-16171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C306B899B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E613B1C20AFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7716ABC3;
	Fri,  5 Apr 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US0mLwcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449891474DC;
	Fri,  5 Apr 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314072; cv=none; b=uw6sJD8nlYoboEO2k41dxlZtEeWOao4TItAeUKvp1U+2m6MOSV/fnLwhs+hX3ApKsxQIC5XBuiUTCBkyV2T10NyRBm/G+qn/fjLZS11SVAN/VdxWYVEXs57fgp8oL9YX5jDeT/hfIXpYOrk/vACH018ZjUUrRvxXZwbtagiwS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314072; c=relaxed/simple;
	bh=w3gv16hWhQOTk178aOx4KwMpMU7NKvm5pP8h9qn985s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGzao7Uy5LyTruVXFy2pnQB3CD+Wjy/+dJjMWn+oih9kFCNvEvrRrswt5COingokq9igRSjJOIgY90TLuTCleQaC3HtI7viEf5KR/4VUQpBi3u8OFQN8GrrPT9QIn1hXVPtNhynyV5Kxx4oOvfU7cR6lEpFOBQalnv/c6i8gI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US0mLwcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4617EC433C7;
	Fri,  5 Apr 2024 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314071;
	bh=w3gv16hWhQOTk178aOx4KwMpMU7NKvm5pP8h9qn985s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=US0mLwcYJa8P+1fVrSqw4WDCrnVvlzxpPTq4gXVT/TormCbqLVLFrX8BJflLcbdo1
	 vO5U3O/Jz1pJlDRYPvbLXxuohtmwp5s71p8JwuPHWErE2sbcZy2AB+r2pfynt2R3+e
	 EhbaN4HHmyftf7S+X0Z773x8E9P2+jdSnt1ZMlrfNwPqRqaSVz2RsmKg/hgXRfLkva
	 WasfArMM9LkyykGedaHFDX/01zUYwuR/Niux/MBGCPmR9Zl6cqUsp+epIaqorfMy1o
	 Z/cyVGdsx3kAp0qiTzSW/HIHQg43AGP0OZlZ8cgog1wwMuYyz7MDhW/OZBHMhnmGik
	 iojWRqhxebaGg==
Date: Fri, 5 Apr 2024 12:47:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240405-speerwerfen-quetschen-d3de254cf830@brauner>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>

On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
> On Thu, Apr 4, 2024 at 11:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Apr 04, 2024 at 09:11:22AM +0100, Al Viro wrote:
> > > On Thu, Apr 04, 2024 at 09:54:35AM +0300, Amir Goldstein wrote:
> > > >
> > > > In the lockdep dependency chain, overlayfs inode lock is taken
> > > > before kernfs internal of->mutex, where kernfs (sysfs) is the lower
> > > > layer of overlayfs, which is sane.
> > > >
> > > > With /sys/power/resume (and probably other files), sysfs also
> > > > behaves as a stacking filesystem, calling vfs helpers, such as
> > > > lookup_bdev() -> kern_path(), which is a behavior of a stacked
> > > > filesystem, without all the precautions that comes with behaving
> > > > as a stacked filesystem.
> > >
> > > No.  This is far worse than anything stacked filesystems do - it's
> > > an arbitrary pathname resolution while holding a lock.
> > > It's not local.  Just about anything (including automounts, etc.)
> > > can be happening there and it pushes the lock in question outside
> > > of *ALL* pathwalk-related locks.  Pathname doesn't have to
> > > resolve to anything on overlayfs - it can just go through
> > > a symlink on it, or walk into it and traverse a bunch of ..
> > > afterwards, etc.
> > >
> > > Don't confuse that with stacking - it's not even close.
> > > You can't use that anywhere near overlayfs layers.
> > >
> > > Maybe isolate it into a separate filesystem, to be automounted
> > > on /sys/power.  And make anyone playing with overlayfs with
> > > sysfs as a layer mount the damn thing on top of power/ in your
> > > overlayfs.  But using that thing as a part of layer is
> > > a non-starter.
> 
> I don't follow what you are saying.
> Which code is in non-starter violation?
> kernfs for calling lookup_bdev() with internal of->mutex held?
> Overlayfs for allowing sysfs as a lower layer and calling
> vfs_llseek(lower_sysfs_file,...) during copy up while ovl inode is held
> for legit reasons (e.g. from ovl_rename())?
> 
> >
> > Incidentally, why do you need to lock overlayfs inode to call
> > vfs_llseek() on the underlying file?  It might (or might not)
> > need to lock the underlying file (for things like ->i_size,
> > etc.), but that will be done by ->llseek() instance and it
> > would deal with the inode in the layer, not overlayfs one.
> 
> We do not (anymore) lock ovl inode in ovl_llseek(), see:
> b1f9d3858f72 ovl: use ovl_inode_lock in ovl_llseek()
> but ovl inode is held in operations (e.g. ovl_rename)
> which trigger copy up and call vfs_llseek() on the lower file.
> 
> >
> > Similar question applies to ovl_write_iter() - why do you
> > need to hold the overlayfs inode locked during the call of
> > backing_file_write_iter()?
> >
> 
> Not sure. This question I need to defer to Miklos.
> I see in several places the pattern:
>         inode_lock(inode);
>         /* Update mode */
>         ovl_copyattr(inode);
>         ret = file_remove_privs(file);
> ...
>         /* Update size */
>         ovl_file_modified(file);
> ...
>         inode_unlock(inode);
> 
> so it could be related to atomic remove privs and update mtime,
> but possibly we could convert all of those inode_lock() to
> ovl_inode_lock() (i.e. internal lock below vfs inode lock).
> 
> [...]
> > Consider the scenario when unlink() is called on that sucker
> > during the write() that triggers that pathwalk.  We have
> >
> > unlink: blocked on overlayfs inode of file, while holding the parent directory.
> > write: holding the overlayfs inode of file and trying to resolve a pathname
> > that contains .../power/suspend_stats/../../...; blocked on attempt to lock
> > parent so we could do a lookup in it.
> 
> This specifically cannot happen because sysfs is not allowed as an
> upper layer only as a lower layer, so overlayfs itself will not be writing to
> /sys/power/resume.

I don't understand that part. If overlayfs uses /sys/power/ as a lower
layer it can open and write to /sys/power/resume, no?

Honestly, why don't you just block /sys/power from appearing in any
layer in overlayfs? This seems like such a niche use-case that it's so
unlikely that this will be used that I would just try and kill it.

If you do it like Al suggested and switch it to an automount you get
that for free. But I guess you can also just block it without that.

(Frankly, I find it weird that sysfs is allowed as a layer in any case. I
completely forgot about this. Imho, both procfs and sysfs should not be
usable as a lower layer - procfs is, I know - and then only select parts
should be like /sys/fs/cgroup or sm where I can see the container people
somehow using this to mess with the cgroup tree or something.)

> 
> >
> > No llseek involved anywhere, kernfs of->mutex held, but not contended,
> > deadlock purely on ->i_rwsem of overlayfs inodes.
> >
> > Holding overlayfs inode locked during the call of lookup_bdev() is really
> > no-go.
> 
> Yes. I see that, but how can this be resolved?
> 
> If the specific file /sys/power/resume will not have FMODE_LSEEK,
> then ovl_copy_up_file() will not try to skip_hole on it at all and the
> llseek lock dependency will be averted.
> 
> The question is whether opt-out of FMODE_LSEEK for /sys/power/resume
> will break anything or if we should mark seq files in another way so that
> overlayfs would not try to seek_hole on any of them categorically.
> 
> Thanks,
> Amir.

