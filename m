Return-Path: <linux-fsdevel+bounces-45982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D8A80A00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617384E220D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093E267B96;
	Tue,  8 Apr 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXnYv04s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F01268685
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116288; cv=none; b=Gqh0szCIJKrmwYnDgyx7aD6WFmideozyxzfe1/baOgr/Ei/UABgiFCLeNa/bZYy4LpISyrXYiKU6ySehB3wwMu8yV+UsZ385Xv5j4mfbcOXm+fWCy9iBMfmr+n3u0soJGcRekQx5TCfcq1bercF2Ex6LTEG3YfSVzHxHhP2Gyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116288; c=relaxed/simple;
	bh=lSN5b+3pn6GuFYXsCICos1ZbeIgtlVptZ0UQ8zPXFKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9Bp+SqXwjUxW0PQtMI3hMwL+F8pOsYRofxZ8uBwNGD6jI9KeOfOy/8vqctkZqgrBI7bBC/ncloRVw2MqNSwerFwMeF0Dc17Ji/q/lrqtHvvT9PD7g+AmoNXeDAFXCRAORLzs+sWRPpwG0tNG4UGJ/1UwJW5jHejeSOpmDAubUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXnYv04s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91406C4CEE7;
	Tue,  8 Apr 2025 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744116287;
	bh=lSN5b+3pn6GuFYXsCICos1ZbeIgtlVptZ0UQ8zPXFKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXnYv04snjl1gj/yhYUJB/fGQAEfV+rYGzjmOgGO31Wdk6/j4gk+HuJZQ+yl7RRA0
	 IWCMWUnzgf1ze9HPp+8VHvGl5ptxjBvY4SCLE7ycPVNzng2hZnzUbAQdbVuwjODW4e
	 5NjzK7rUEpecyAYU/OfjtDGFRGNJenCv91mqYFdotUDlhyhh/SAn2VQ0J39i+uPTWa
	 68gXeeAC+Jej+4c7HJtY0KwS4Xztlo6erkZ+l5T51jK1WtZ9HimwDWMZaw+2XWttav
	 9TcnqzbWfc6APRjW9yK3a13EfXyTKMPorkE/nbyspYpToMLKlPXtXXt2bNh+AfAdMX
	 I7GW55fSBOxfg==
Date: Tue, 8 Apr 2025 14:44:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, mkoutny@suse.cz
Subject: Re: d_path() results in presence of detached mounts
Message-ID: <20250408-notizen-anzeichen-bd3aa5bb3cbf@brauner>
References: <rxytpo37ld46vclkts457zvwi6qkgwzlh3loavn3lddqxe2cvk@k7lifplt7ay6>
 <20250408-ungebeten-auskommen-5a2aaab8e23d@brauner>
 <20250408-nachverfolgen-deftig-19199bfc1801@brauner>
 <7tqv43wtdldjtlbizfhzjmwuoo6fo2xg537jpoxamkvjmckhbv@wiprprojwih2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7tqv43wtdldjtlbizfhzjmwuoo6fo2xg537jpoxamkvjmckhbv@wiprprojwih2>

On Tue, Apr 08, 2025 at 02:04:48PM +0200, Jan Kara wrote:
> On Tue 08-04-25 13:39:28, Christian Brauner wrote:
> > On Tue, Apr 08, 2025 at 10:55:07AM +0200, Christian Brauner wrote:
> > > On Mon, Apr 07, 2025 at 06:00:07PM +0200, Jan Kara wrote:
> > > > Hello!
> > > > 
> > > > Recently I've got a question from a user about the following:
> > > > 
> > > > # unshare --mount swapon /dev/sda3
> > > > # cat /proc/swaps
> > > > Filename                                Type            Size            Used            Priority
> > > > /sda3                                   partition       2098152         0               -2
> > > > 
> > > > Now everything works as expected here AFAICS. When namespace gets created
> > > > /dev mount is cloned into it. When swapon exits, the namespace is
> > > > destroyed and /dev mount clone is detached (no parent, namespace NULL).
> > 
> > That's not the issue you're seeing here though

Uh, sorry about this weird stray sentence. Not sure how that ended up in
here. I think that was supposed to be in another mail.

> > 
> > > > Hence when d_path() crawls the path it stops at the mountpoint root and
> > > > exits. There's not much we can do about this but when discussing the
> > > > situation internally, Michal proposed that d_path() could append something
> > > > like "(detached)" to the path string - similarly to "(deleted)". That could
> > > > somewhat reduce the confusion about such paths? What do people think about
> > > > this?
> > > 
> > > You can get into this situation in plenty of other ways. For example by
> > > using detached mount via open_tree(OPEN_TREE_CLONE) as layers in
> > > overlayfs. Or simply:
> > > 
> > >         int fd;
> > >         char dpath[PATH_MAX];
> > > 
> > >         fd = open_tree(-EBADF, "/var/lib/fwupd", OPEN_TREE_CLONE);
> > >         dup2(fd, 500);
> > >         close(fd);
> > >         readlink("/proc/self/fd/500", dpath, sizeof(dpath));
> > >         printf("dpath = %s\n", dpath);
> > > 
> > > Showing "(detached)" will be ambiguous just like "(deleted)" is. If that
> > > doesn't matter and it's clearly documented then it's probably fine. But
> > > note that this will also affect /proc/<pid>/fd/ as can be seen from the
> > > above example.
> > 
> > The other downside is that it will still be quite opaque because the
> > user will have to be aware of the concept of a detached mount. So it's
> > mostly useful for administrators tbh.
> 
> Thanks for the insights!
> 
> > In general, I think it needs to be made clear to userspace that paths
> > shown in such tables are open()-able in the best case and decorative or
> > even misleading in the worst case.
> 
> Yes, I know this and I was just wondering if we can at least somehow
> visibly indicate the path shown is likely unusable. If you think it would
> do more harm than good, I'm fine with that answer, I just thought I'll
> ask...

Oh yes, absolutely. It's good to bring this up. I just wonder whether
we could do better. Karel suggested using a stx_attribute and I had
pondered a statmount() extension but both have some issues though let me
pitch them nonetheless somewhat independent of the issue.

We could add a statmount() extension to mark detached mounts as being
detached. That however will only work for anonymous detached mounts,
i.e., mounts that have been created using OPEN_TREE_CLONE or fsmount().
Since statmount() uses the mount namespace rbtree to lookup mounts any
unmounted mount with mnt->mnt_ns == NULL cannot be found anymore. So
it's - currently at least - not useful to handle the /proc/swaps case.

A statx() extension would be more useful because it would work
independent of whether this is a detached mount or not. So we would
start reporting STATX_MNT_DETACHED in stx_attributes which allows
userspace to figure out that the thing was unmounted. That might be
genuinely useful.

But both solution wouldn't help with the /proc/swaps scenario because
it's not guaranteed that the file can be opened because it might be
outside the caller's mount namespace (or even deleted).

