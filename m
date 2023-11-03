Return-Path: <linux-fsdevel+bounces-1931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635257E05BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5981C21061
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9247E1C685;
	Fri,  3 Nov 2023 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3LiV0fI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1601C680
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF56C433C8;
	Fri,  3 Nov 2023 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699026427;
	bh=KeIiqguBYlSRF8vx5WKfpqQAOYEKESQgLTzJDzV/9G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3LiV0fIB07MkHAxmfMtxayrp1mb92tS2MjHIIFuuQPvD/C1T5UCjvr6Pno3tgTW2
	 +MBSp3c+SDdvmoOJDYuWQCz1kW+LIVaa5DByHF9+FWXinF/YzPG5cCzIhmfv8FLNqM
	 a6LB587DKSjP35vJT++8/p3R8Q1mONgCEqZ+e7uiFCPHONlp6On4Piyai21ydX+umT
	 cAuMxnFoi7S6Pbt84/ocM9xNIkVh4ZmAAEtFHU1iS7GovbjxNkWjpydhmo8ZI5MTcO
	 eY8+2NgQSZIGUT2IZYqhAtlCb1S1o3yjDlrH2/NfSA7+z0atnbGy37Zp5s/YAn2krA
	 EpMBmF82uN6Qw==
Date: Fri, 3 Nov 2023 16:47:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
References: <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUUDmu8fTB0hyCQR@infradead.org>

On Fri, Nov 03, 2023 at 07:28:42AM -0700, Christoph Hellwig wrote:
> On Thu, Nov 02, 2023 at 12:07:47PM +0100, Christian Brauner wrote:
> > But at that point we really need to ask if it makes sense to use
> > vfsmounts per subvolume in the first place:
> > 
> > (1) We pollute /proc/<pid>/mountinfo with a lot of mounts.
> > (2) By calling ->getattr() from show_mountinfo() we open the whole
> >     system up to deadlocks.
> > (3) We change btrfs semantics drastically to the point where they need a
> >     new mount, module, or Kconfig option.
> > (4) We make (initial) lookup on btrfs subvolumes more heavyweight
> >     because you need to create a mount for the subvolume.
> > 
> > So right now, I don't see how we can make this work even if the concept
> > doesn't seem necessarily wrong.
> 
> How else do you want to solve it?  Crossing a mount point is the
> only legitimate boundary for changing st_dev and having a new inode
> number space.  And we can't fix that retroactively.

I think the idea of using vfsmounts for this makes some sense if the
goal is to retroactively justify and accommodate the idea that a
subvolume is to be treated as equivalent to a separate device.

I question that premise though. I think marking them with separate
device numbers is bringing us nothing but pain at this point and this
solution is basically bending the vfs to make that work somehow.

And the worst thing is that I think that treating subvolumes like
vfsmounts will hurt vfsmounts more than it will hurt subvolumes.

Right now all that vfsmounts technically are is a topological
abstraction on top of filesystem objects such as files, directories,
sockets, even devices that are exposed as filesystems objects. None of
them get to muck with core properties of what a vfsmount is though.

Additionally, vfsmount are tied to a superblock and share the device
numbers with the superblock they belong to.

If we make subvolumes and vfsmounts equivalent we break both properties.
And I think that's wrong or at least really ugly.

And I already see that the suggested workaround for (2) will somehow end
up being stashing device numbers in struct mount or struct vfsmount so
we can show it in mountinfo and if that's the case I want to express a
proactive nak for that solution.

The way I see it is that a subvolume at the end is nothing but a
subclass of directories a special one but whatever.

I would feel much more comfortable if the two filesystems that expose
these objects give us something like STATX_SUBVOLUME that userspace can
raise in the request mask of statx().

If userspace requests STATX_SUBVOLUME in the request mask, the two
filesystems raise STATX_SUBVOLUME in the statx result mask and then also
return the _real_ device number of the superblock and stop exposing that
made up device number.

This can be accompanied by a vfs ioctl that is identical for both btrfs
and bcachefs and returns $whatever unique property to mark the inode
space of the subvolume.

And then we leave innocent vfs objects alone and we also avoid
bringing in all that heavy vfsmount machinery on top of subvolumes.

