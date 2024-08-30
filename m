Return-Path: <linux-fsdevel+bounces-28093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F017B966CD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F194B21339
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016D18E344;
	Fri, 30 Aug 2024 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpKWq3HA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4C14AD38;
	Fri, 30 Aug 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060166; cv=none; b=RJBx12E2svO7EQ76mJE1SL0BSQ6UPKmiQTjusaLUIoUVmxvwcxePQBJF4IU5EBy2sTMoGTiDO8rjbqj1hdoNWah01ZfoNViElLxhzkZEuPeKS2A1iwfFqQW6XCtdFLJ7Wyuu4SRUhQ2RSe1MCBTiaf0cPI3awXCX8zqGJvjSlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060166; c=relaxed/simple;
	bh=TwY5ILjzFeVouNSp+613u9t1eDYzDUrQdpJ4Gct+aXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRBQ85SeDTggo/ovKOtN2VO5923IQuaZWXbDEbVsp1QARvR4oIMiYWbsR4C+0C3GrCmyxRFMft3U2cG5Oywx5fpCxwaOkKIvfJOTc12P1uBdIwitNlM/DAfsyxWcEF/HxKCFJ6CA1hSAUSpROrB88uwSh+MGp+c2D3aD6DLKZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpKWq3HA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F6FC4CEC7;
	Fri, 30 Aug 2024 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060166;
	bh=TwY5ILjzFeVouNSp+613u9t1eDYzDUrQdpJ4Gct+aXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpKWq3HAj56ksCfHR38Bi3eDO6Ee+X8RBtOCvZAQI6lwW6Zk5R8/jKvEGW+mcADSe
	 dQZqbW3iCbkEe/GNt10E66YbDbut/JNUIBO/8J/MhntT72CcqFAVDye1pvD8FFe6br
	 yDy9tm4cy2k4xmJbjD/1Xjb+HBGYdu7qcKw9yP3vFfv5yAOI8T6Dtm1ZQuf/2Dm74l
	 vI5JLFgbWUxbZ+gvRBy/GOpkd6n4ZUiDyzMAhP/PJKtOwBcptLvVIceGk2qWIBT9wk
	 be26yPelEFuI6LUpj1f9spWblmGXfWbq45wZQKf1MPBN8Vmpmv/dF08FKyguZlX3DH
	 09OQBRvz9bcOA==
Date: Fri, 30 Aug 2024 16:22:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 00/16] fanotify: add pre-content hooks
Message-ID: <20240830232245.GQ6216@frogsfrogsfrogs>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <20240829214153.GP6224@frogsfrogsfrogs>
 <CAOQ4uxh+zD1A18VPyoRHeaBt+XCpt2LB18K6ZHQJR-VqdGrCVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh+zD1A18VPyoRHeaBt+XCpt2LB18K6ZHQJR-VqdGrCVw@mail.gmail.com>

On Fri, Aug 30, 2024 at 10:55:10AM +0200, Amir Goldstein wrote:
> On Thu, Aug 29, 2024 at 11:41 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Aug 14, 2024 at 05:25:18PM -0400, Josef Bacik wrote:
> > > v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
> > > v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
> > > v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/
> > >
> > > v3->v4:
> > > - Trying to send a final verson Friday at 5pm before you go on vacation is a
> > >   recipe for silly mistakes, fixed the xfs handling yet again, per Christoph's
> > >   review.
> > > - Reworked the file system helper so it's handling of fpin was a little less
> > >   silly, per Chinner's suggestion.
> > > - Updated the return values to not or in VM_FAULT_RETRY, as we have a comment
> > >   in filemap_fault that says if VM_FAULT_ERROR is set we won't have
> > >   VM_FAULT_RETRY set.
> > >
> > > v2->v3:
> > > - Fix the pagefault path to do MAY_ACCESS instead, updated the perm handler to
> > >   emit PRE_ACCESS in this case, so we can avoid the extraneous perm event as per
> > >   Amir's suggestion.
> > > - Reworked the exported helper so the per-filesystem changes are much smaller,
> > >   per Amir's suggestion.
> > > - Fixed the screwup for DAX writes per Chinner's suggestion.
> > > - Added Christian's reviewed-by's where appropriate.
> > >
> > > v1->v2:
> > > - reworked the page fault logic based on Jan's suggestion and turned it into a
> > >   helper.
> > > - Added 3 patches per-fs where we need to call the fsnotify helper from their
> > >   ->fault handlers.
> > > - Disabled readahead in the case that there's a pre-content watch in place.
> > > - Disabled huge faults when there's a pre-content watch in place (entirely
> > >   because it's untested, theoretically it should be straightforward to do).
> > > - Updated the command numbers.
> > > - Addressed the random spelling/grammer mistakes that Jan pointed out.
> > > - Addressed the other random nits from Jan.
> > >
> > > --- Original email ---
> > >
> > > Hello,
> > >
> > > These are the patches for the bare bones pre-content fanotify support.  The
> > > majority of this work is Amir's, my contribution to this has solely been around
> > > adding the page fault hooks, testing and validating everything.  I'm sending it
> > > because Amir is traveling a bunch, and I touched it last so I'm going to take
> > > all the hate and he can take all the credit.
> > >
> > > There is a PoC that I've been using to validate this work, you can find the git
> > > repo here
> > >
> > > https://github.com/josefbacik/remote-fetch
> > >
> > > This consists of 3 different tools.
> > >
> > > 1. populate.  This just creates all the stub files in the directory from the
> > >    source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
> > >    recursively create all of the stub files and directories.
> > > 2. remote-fetch.  This is the actual PoC, you just point it at the source and
> > >    destination directory and then you can do whatever.  ./remote-fetch ~/linux
> > >    ~/hsm-linux.
> > > 3. mmap-validate.  This was to validate the pagefault thing, this is likely what
> > >    will be turned into the selftest with remote-fetch.  It creates a file and
> > >    then you can validate the file matches the right pattern with both normal
> > >    reads and mmap.  Normally I do something like
> > >
> > >    ./mmap-validate create ~/src/foo
> > >    ./populate ~/src ~/dst
> > >    ./rmeote-fetch ~/src ~/dst
> > >    ./mmap-validate validate ~/dst/foo
> > >
> > > I did a bunch of testing, I also got some performance numbers.  I copied a
> > > kernel tree, and then did remote-fetch, and then make -j4
> > >
> > > Normal
> > > real    9m49.709s
> > > user    28m11.372s
> > > sys     4m57.304s
> > >
> > > HSM
> > > real    10m6.454s
> > > user    29m10.517s
> > > sys     5m2.617s
> > >
> > > So ~17 seconds more to build with HSM.  I then did a make mrproper on both trees
> > > to see the size
> > >
> > > [root@fedora ~]# du -hs /src/linux
> > > 1.6G    /src/linux
> > > [root@fedora ~]# du -hs dst
> > > 125M    dst
> > >
> > > This mirrors the sort of savings we've seen in production.
> > >
> > > Meta has had these patches (minus the page fault patch) deployed in production
> > > for almost a year with our own utility for doing on-demand package fetching.
> > > The savings from this has been pretty significant.
> > >
> > > The page-fault hooks are necessary for the last thing we need, which is
> > > on-demand range fetching of executables.  Some of our binaries are several gigs
> > > large, having the ability to remote fetch them on demand is a huge win for us
> > > not only with space savings, but with startup time of containers.
> >
> > So... does this pre-content fetcher already work for regular reads and
> > writes, and now you're looking to wire up page faults?  Or does it only
> > handle page faults?  Judging from Amir's patches I'm guessing the
> > FAN_PRE_{ACCESS,MODIFY} events are new, so this only sends notifications
> > prior to read and write page faults?  The XFS change looks reasonable to
> > me, but I'm left wondering "what does this shiny /do/?"
> >
> 
> I *think* I understand the confusion.
> 
> Let me try to sort it out.
> 
> This patch set collaboration aims to add the functionality of HSM
> service by adding events FS_PRE_{ACCESS,MODIFY} prior to
> read/write and page faults.
> 
> Maybe you are puzzled by not seeing any new read/write hooks?
> This is because the HSM events utilize the existing fsnotify_file_*perm()
> hooks that are in place for the legacy FS_ACCESS_PERM event.
> 
> So why is a new FS_PRE_ACCESS needed?
> Let me first quote commit message of patch 2/16 [1]:
> ---
> The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
> but it meant for a different use case of filling file content before
> access to a file range, so it has slightly different semantics.
> 
> Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
> we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.
> 
> FS_PRE_MODIFY is a new permission event, with similar semantics as
> FS_PRE_ACCESS, which is called before a file is modified.
> 
> FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
> pre-content events are only reported for regular files and dirs.
> 
> The pre-content events are meant to be used by hierarchical storage
> managers that want to fill the content of files on first access.
> ---
> 
> And from my man page draft [2]:
> ---
>        FAN_PRE_ACCESS (since Linux 6.x)
>               Create  an  event before a read from a directory or a file range,
>               that provides an opportunity for the event listener to
> modify the content of the object
>               before the reader is going to access the content in the
> specified range.
>               An additional information record of type
> FAN_EVENT_INFO_TYPE_RANGE is returned
>              for each event in the read buffer.
> ...
> ---
> 
> So the semantics of the two events is slightly different, but also the
> meaning of "an opportunity for the event listener to modify the content".
> 
> FS_ACCESS_PERM already provided this opportunity on old kernels,
> but prior to "Tidy up file permission hooks" series [3] in v6.8, writing
> file content in FS_ACCESS_PERM event context was prone to deadlocks.
> 
> Therefore, an application using FS_ACCESS_PERM may be prone
> for deadlocks, while an application using FAN_PRE_ACCESS should
> be safe in that regard.

Ah, ok, that's where the missing pieces are. :)

--D

> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/all/a96217d84dfebb15582a04524dc9821ba3ea1406.1723670362.git.josef@toxicpanda.com/
> [2] https://github.com/amir73il/man-pages/commits/fan_pre_path
> [3] https://lore.kernel.org/all/20231122122715.2561213-1-amir73il@gmail.com/
> 

