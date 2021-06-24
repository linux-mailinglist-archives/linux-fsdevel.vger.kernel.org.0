Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306B33B2C79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhFXKfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 06:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhFXKfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:35:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2E8161358;
        Thu, 24 Jun 2021 10:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624530774;
        bh=5veRctjnSL/jrcMhupA+suH7OAIQylpXsv4ZVHXTaUY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lW15ZReRIowI7E/XQoLbVPxbT9ssHWVDkyy8FUEh/bonEGlgW1ifDeWjpCGCUlSlJ
         hMDuRxa+Sp5y6wfNFZAoCr+EtbzaP8pn+6KYH6t39sNkj62oZ/LGJhdr0R8tL2uTab
         UVMOo7lEdAQDEZEiFwRaEtp2cz9AVk/TUOrWDFajAKDiSJP8nH2j/spbm7NA9YamQq
         Haazi0CpuGnWM625TasQsZEmAJbZMSeaj3HEKSqL17keeW3zoWS2GE6rWG8J83r69N
         7m2Ak0j2zu7qeaxGsc+4C06sWGt6LXWowAs0CKHQEyyYpeM+aGfyB1BTHp6cCFLC1Z
         4sg3xi7XvAaKQ==
Message-ID: <1224262b5f6ec7d646b85ed43b55b64063c35ecf.camel@kernel.org>
Subject: Re: [GIT PULL] netfs, afs: Fix write_begin/end
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     Andrew W Elble <aweits@rit.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Jun 2021 06:32:51 -0400
In-Reply-To: <2842348.1624308062@warthog.procyon.org.uk>
References: <2842348.1624308062@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-21 at 21:41 +0100, David Howells wrote:
> Hi Linus,
> 
> Could you pull this please?  It includes patches to fix netfs_write_begin()
> and afs_write_end() in the following ways:
> 
>  (1) In netfs_write_begin(), extract the decision about whether to skip a
>      page out to its own helper and have that clear around the region to be
>      written, but not clear that region.  This requires the filesystem to
>      patch it up afterwards if the hole doesn't get completely filled.
> 
>  (2) Use offset_in_thp() in (1) rather than manually calculating the offset
>      into the page.
> 
>  (3) Due to (1), afs_write_end() now needs to handle short data write into
>      the page by generic_perform_write().  I've adopted an analogous
>      approach to ceph of just returning 0 in this case and letting the
>      caller go round again.
> 
> It also adds a note that (in the future) the len parameter may extend
> beyond the page allocated.  This is because the page allocation is deferred
> to write_begin() and that gets to decide what size of THP to allocate.
> 
> Thanks,
> David
> 
> Link: https://lore.kernel.org/r/20210613233345.113565-1-jlayton@kernel.org/
> Link: https://lore.kernel.org/r/162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/162429000639.2770648.6368710175435880749.stgit@warthog.procyon.org.uk/ # v3
> 
> Changes
> =======
> 
> ver #3:
>    - Drop the bits that make afs take account of len exceeding the end of
>      the page in afs_write_begin/end().
> 
> ver #2:
>    - Removed a var that's no longer used (spotted by the kernel test robot)
>    - Removed a forgotten "noinline".
> 
> ver #1:
>    - Prefixed the Jeff's new helper with "netfs_".
>    - Don't call zero_user_segments() for a full-page write.
>    - Altered the beyond-last-page check to avoid a DIV.
>    - Removed redundant zero-length-file check.
>    - Added patches to fix afs.
> 
> ---
> The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:
> 
>   Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-fixes-20210621
> 
> for you to fetch changes up to 827a746f405d25f79560c7868474aec5aee174e1:
> 
>   netfs: fix test for whether we can skip read when writing beyond EOF (2021-06-21 21:24:07 +0100)
> 
> ----------------------------------------------------------------
> netfslib fixes
> 
> ----------------------------------------------------------------
> David Howells (1):
>       afs: Fix afs_write_end() to handle short writes
> 
> Jeff Layton (1):
>       netfs: fix test for whether we can skip read when writing beyond EOF
> 
>  fs/afs/write.c         | 11 +++++++++--
>  fs/netfs/read_helper.c | 49 ++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 45 insertions(+), 15 deletions(-)
> 

Hi Linus,

Is there some reason you haven't pulled these fixes? The netfs fix in
particular fixes a data corruption bug in cephfs, so we're quite keen to
get that in before v5.13 ships.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

