Return-Path: <linux-fsdevel+bounces-27955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7724965232
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90367286C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6151BA861;
	Thu, 29 Aug 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvT1C3KT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0B28685;
	Thu, 29 Aug 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967714; cv=none; b=cfJCuN7OsCx0fySC9dFYR7e+pd3huRtdGXoz8Ae40SN/1RXC/vkrfVHIt09DXdkH+gXchgdWRz/owK/0IgFRqVZRWiJfXU2HyDtWr0FKpVeI4BsnWh6IxGPdO2BVGql28rpGtodfABrxC6yXeIKCRB5VTMQmmiAxDrJikuxVmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967714; c=relaxed/simple;
	bh=5CHiLCSWxrHScrTiMeie/NlFZn8hQDuxaHHeWBVyoVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fskmbprhYK728wmEYKx7oqqHb9F+pcz5wDpL/45YwqQhfTzNz1jMBLfhahped2lt+ztt1tAqV9JcR5E7s2f2VmNIOFMvcYpQ/O0LR2tjRe3o5UtYj/uGc9v47FZebCeLxH9cs4+j99mHT5rxfB1/ovqNQMtdo/4gmtCBxZ00gJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvT1C3KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FACC4CEC2;
	Thu, 29 Aug 2024 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724967713;
	bh=5CHiLCSWxrHScrTiMeie/NlFZn8hQDuxaHHeWBVyoVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvT1C3KTxKTXecr3dyDxHEgio1RyVXjITiihd85KV05xD1oN1fpvJ8iEgpVcnSoPE
	 DzKhFc/fN62D0KETTyQNfXoNO+vwwP1Csj7doUrwSYfu+ncH833lFyOIq9pMy+wGGr
	 hHkQ/YvZJ7xoywsKX0oE0pdfdWvsTM3Q0s8LByOqX8Zm4Qp+gTGIWfl6h20GEa+Y50
	 pSTRMAsN0Td9yOVJWozZa7+jP049kn8vB2GycRmhVDveBq/QWsvutrQckBfL70rBno
	 uP5flEgrBggqNw+AAViDjtbRC01RAAgXKH7aZyKQcBp/LSv7o1Ld4tzU3uMj525stc
	 ofoZjMESiEELg==
Date: Thu, 29 Aug 2024 14:41:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 00/16] fanotify: add pre-content hooks
Message-ID: <20240829214153.GP6224@frogsfrogsfrogs>
References: <cover.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>

On Wed, Aug 14, 2024 at 05:25:18PM -0400, Josef Bacik wrote:
> v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
> v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
> v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/
> 
> v3->v4:
> - Trying to send a final verson Friday at 5pm before you go on vacation is a
>   recipe for silly mistakes, fixed the xfs handling yet again, per Christoph's
>   review.
> - Reworked the file system helper so it's handling of fpin was a little less
>   silly, per Chinner's suggestion.
> - Updated the return values to not or in VM_FAULT_RETRY, as we have a comment
>   in filemap_fault that says if VM_FAULT_ERROR is set we won't have
>   VM_FAULT_RETRY set.
> 
> v2->v3:
> - Fix the pagefault path to do MAY_ACCESS instead, updated the perm handler to
>   emit PRE_ACCESS in this case, so we can avoid the extraneous perm event as per
>   Amir's suggestion.
> - Reworked the exported helper so the per-filesystem changes are much smaller,
>   per Amir's suggestion.
> - Fixed the screwup for DAX writes per Chinner's suggestion.
> - Added Christian's reviewed-by's where appropriate.
> 
> v1->v2:
> - reworked the page fault logic based on Jan's suggestion and turned it into a
>   helper.
> - Added 3 patches per-fs where we need to call the fsnotify helper from their
>   ->fault handlers.
> - Disabled readahead in the case that there's a pre-content watch in place.
> - Disabled huge faults when there's a pre-content watch in place (entirely
>   because it's untested, theoretically it should be straightforward to do).
> - Updated the command numbers.
> - Addressed the random spelling/grammer mistakes that Jan pointed out.
> - Addressed the other random nits from Jan.
> 
> --- Original email ---
> 
> Hello,
> 
> These are the patches for the bare bones pre-content fanotify support.  The
> majority of this work is Amir's, my contribution to this has solely been around
> adding the page fault hooks, testing and validating everything.  I'm sending it
> because Amir is traveling a bunch, and I touched it last so I'm going to take
> all the hate and he can take all the credit.
> 
> There is a PoC that I've been using to validate this work, you can find the git
> repo here
> 
> https://github.com/josefbacik/remote-fetch
> 
> This consists of 3 different tools.
> 
> 1. populate.  This just creates all the stub files in the directory from the
>    source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
>    recursively create all of the stub files and directories.
> 2. remote-fetch.  This is the actual PoC, you just point it at the source and
>    destination directory and then you can do whatever.  ./remote-fetch ~/linux
>    ~/hsm-linux.
> 3. mmap-validate.  This was to validate the pagefault thing, this is likely what
>    will be turned into the selftest with remote-fetch.  It creates a file and
>    then you can validate the file matches the right pattern with both normal
>    reads and mmap.  Normally I do something like
> 
>    ./mmap-validate create ~/src/foo
>    ./populate ~/src ~/dst
>    ./rmeote-fetch ~/src ~/dst
>    ./mmap-validate validate ~/dst/foo
> 
> I did a bunch of testing, I also got some performance numbers.  I copied a
> kernel tree, and then did remote-fetch, and then make -j4
> 
> Normal
> real    9m49.709s
> user    28m11.372s
> sys     4m57.304s
> 
> HSM
> real    10m6.454s
> user    29m10.517s
> sys     5m2.617s
> 
> So ~17 seconds more to build with HSM.  I then did a make mrproper on both trees
> to see the size
> 
> [root@fedora ~]# du -hs /src/linux
> 1.6G    /src/linux
> [root@fedora ~]# du -hs dst
> 125M    dst
> 
> This mirrors the sort of savings we've seen in production.
> 
> Meta has had these patches (minus the page fault patch) deployed in production
> for almost a year with our own utility for doing on-demand package fetching.
> The savings from this has been pretty significant.
> 
> The page-fault hooks are necessary for the last thing we need, which is
> on-demand range fetching of executables.  Some of our binaries are several gigs
> large, having the ability to remote fetch them on demand is a huge win for us
> not only with space savings, but with startup time of containers.

So... does this pre-content fetcher already work for regular reads and
writes, and now you're looking to wire up page faults?  Or does it only
handle page faults?  Judging from Amir's patches I'm guessing the
FAN_PRE_{ACCESS,MODIFY} events are new, so this only sends notifications
prior to read and write page faults?  The XFS change looks reasonable to
me, but I'm left wondering "what does this shiny /do/?"

--D

> There will be tests for this going into LTP once we're satisfied with the
> patches and they're on their way upstream.  Thanks,
> 
> Josef
> 
> Amir Goldstein (8):
>   fsnotify: introduce pre-content permission event
>   fsnotify: generate pre-content permission event on open
>   fanotify: introduce FAN_PRE_ACCESS permission event
>   fanotify: introduce FAN_PRE_MODIFY permission event
>   fanotify: pass optional file access range in pre-content event
>   fanotify: rename a misnamed constant
>   fanotify: report file range info with pre-content events
>   fanotify: allow to set errno in FAN_DENY permission response
> 
> Josef Bacik (8):
>   fanotify: don't skip extra event info if no info_mode is set
>   fanotify: add a helper to check for pre content events
>   fanotify: disable readahead if we have pre-content watches
>   mm: don't allow huge faults for files with pre content watches
>   fsnotify: generate pre-content permission event on page fault
>   bcachefs: add pre-content fsnotify hook to fault
>   gfs2: add pre-content fsnotify hook to fault
>   xfs: add pre-content fsnotify hook for write faults
> 
>  fs/bcachefs/fs-io-pagecache.c      |   4 +
>  fs/gfs2/file.c                     |   4 +
>  fs/namei.c                         |   9 ++
>  fs/notify/fanotify/fanotify.c      |  32 ++++++--
>  fs/notify/fanotify/fanotify.h      |  20 +++++
>  fs/notify/fanotify/fanotify_user.c | 116 +++++++++++++++++++++-----
>  fs/notify/fsnotify.c               |  14 +++-
>  fs/xfs/xfs_file.c                  |   4 +
>  include/linux/fanotify.h           |  20 +++--
>  include/linux/fsnotify.h           |  54 ++++++++++--
>  include/linux/fsnotify_backend.h   |  59 ++++++++++++-
>  include/linux/mm.h                 |   1 +
>  include/uapi/linux/fanotify.h      |  17 ++++
>  mm/filemap.c                       | 128 +++++++++++++++++++++++++++--
>  mm/memory.c                        |  22 +++++
>  mm/readahead.c                     |  13 +++
>  security/selinux/hooks.c           |   3 +-
>  17 files changed, 469 insertions(+), 51 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

