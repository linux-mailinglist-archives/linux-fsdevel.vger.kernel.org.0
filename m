Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999C3282D41
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJDTZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 15:25:05 -0400
Received: from relay.sw.ru ([185.231.240.75]:42160 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbgJDTZF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:25:05 -0400
Received: from [172.16.25.93] (helo=amikhalitsyn-pc0.sw.ru)
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kP9cE-00318e-8c; Sun, 04 Oct 2020 22:24:14 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     miklos@szeredi.hu
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] overlayfs: C/R enhancments (RFC)
Date:   Sun,  4 Oct 2020 22:24:00 +0300
Message-Id: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some time ago we discussed about the problem of Checkpoint-Restoring
overlayfs mounts [1]. Big thanks to Amir for review and suggestions.

Brief from previous discussion.
Problem statement: to checkpoint-restore overlayfs mounts we need
to save overlayfs mount state and save it into the image. Basically,
this state for us it's just mount options of overlayfs mount. But
here we have two problems:

I. during mounting overlayfs user may specify relative paths in upperdir,
workdir, lowerdir options

II. also user may unmount mount from which these paths was opened during mounting

This is real problems for us. My first patch was attempt to address both problems.
1. I've added refcnt get for mounts from which overlayfs was mounted.
2. I've changed overlayfs mountinfo show algorithm, so overlayfs started to *always*
show full paths for upperdir,workdir,lowerdirs.
3. I've added mnt_id show-time only option which allows to determine from which mnt_id
we opened options paths.

Pros:
- we can determine full information about overlayfs mount
- we hold refcnt to mount, so, user may unmount source mounts only
with lazy flag

Cons:
- by adding refcnt get for mount I've changed possible overlayfs usecases
- by showing *full* paths we can more easily reache PAGE_SIZE limit of 
mounts options in procfs
- by adding mnt_id show-only option I've added inconsistency between
mount-time options and show-time mount options

After very productive discussion with Amir and Pavel I've decided to write new
implementation. In new approach we decided *not* to take extra refcnts to mounts.
Also we decided to use exportfs fhandles instead of full paths. To determine
full path we plan to use the next algo:
1. Export {s_dev; fhandle} from overlayfs for *all* sources
2. User open_by_handle_at syscall to open all these fhandles (we need to
determine mount for each fhandle, looks like we can do this by s_dev by linear
search in /proc/<pid>/mountinfo)
3. Then readlink /proc/<pid>/fd/<opened fd>
4. Dump this full path+mnt_id

But there is question. How to export this {s_dev; fhandle} from kernel to userspace?
- We decided not to use procfs.
- Amir proposed solution - use xattrs. But after diving into it I've meet problem
where I can set this xattrs?
If I set this xattrs on overlayfs dentries then during rsync, or cp -p=xattr we will copy
this temporary information.
- ioctls? (this patchset implements this approach)
- fsinfo subsystem (not merged yet) [2]

Problems with ioctls:
1. We limited in output data size (16 KB AFAIK)
but MAX_HANDLE_SZ=128(bytes), OVL_MAX_STACK=500(num lowerdirs)
So, MAX_HANDLE_SZ*OVL_MAX_STACK = 64KB which is bigger than limit.
So, I've decided to give user one fhandle by one call. This is also
bad from the performance point of view.
2. When using ioctls we need to have *fixed* size of input and output.
So, if MAX_HANDLE_SZ will change in the future our _IOR('o', 2, struct ovl_mnt_opt_fh)
will also change with struct ovl_mnt_opt_fh.

So, I hope that we discuss about this patchset and try to make possible solutions together.

Thanks.
Regards, Alex.

[1] https://lore.kernel.org/linux-unionfs/20200604161133.20949-1-alexander.mikhalitsyn@virtuozzo.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fsinfo-core

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Alexander Mikhalitsyn (1):
  overlayfs: add ioctls that allows to get fhandle for layers dentries

 fs/overlayfs/readdir.c | 160 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

-- 
2.25.1

