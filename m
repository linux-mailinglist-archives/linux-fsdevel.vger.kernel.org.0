Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67C94B263
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfFSGvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 02:51:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfFSGvS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:51:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6765AF97;
        Wed, 19 Jun 2019 06:51:16 +0000 (UTC)
Date:   Wed, 19 Jun 2019 08:51:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] Enable THP for text section of non-shmem files
Message-ID: <20190619065114.GD2968@dhcp22.suse.cz>
References: <20190619062424.3486524-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619062424.3486524-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc fsdevel and lkml]

On Tue 18-06-19 23:24:18, Song Liu wrote:
> Changes v2 => v3:
> 1. Removed the limitation (cannot write to file with THP) by truncating
>    whole file during sys_open (see 6/6);
> 2. Fixed a VM_BUG_ON_PAGE() in filemap_fault() (see 2/6);
> 3. Split function rename to a separate patch (Rik);
> 4. Updated condition in hugepage_vma_check() (Rik).
> 
> Changes v1 => v2:
> 1. Fixed a missing mem_cgroup_commit_charge() for non-shmem case.
> 
> This set follows up discussion at LSF/MM 2019. The motivation is to put
> text section of an application in THP, and thus reduces iTLB miss rate and
> improves performance. Both Facebook and Oracle showed strong interests to
> this feature.
> 
> To make reviews easier, this set aims a mininal valid product. Current
> version of the work does not have any changes to file system specific
> code. This comes with some limitations (discussed later).
> 
> This set enables an application to "hugify" its text section by simply
> running something like:
> 
>           madvise(0x600000, 0x80000, MADV_HUGEPAGE);
> 
> Before this call, the /proc/<pid>/maps looks like:
> 
>     00400000-074d0000 r-xp 00000000 00:27 2006927     app
> 
> After this call, part of the text section is split out and mapped to
> THP:
> 
>     00400000-00425000 r-xp 00000000 00:27 2006927     app
>     00600000-00e00000 r-xp 00200000 00:27 2006927     app   <<< on THP
>     00e00000-074d0000 r-xp 00a00000 00:27 2006927     app
> 
> Limitations:
> 
> 1. This only works for text section (vma with VM_DENYWRITE).
> 2. Original limitation #2 is removed in v3.
> 
> We gated this feature with an experimental config, READ_ONLY_THP_FOR_FS.
> Once we get better support on the write path, we can remove the config and
> enable it by default.
> 
> Tested cases:
> 1. Tested with btrfs and ext4.
> 2. Tested with real work application (memcache like caching service).
> 3. Tested with "THP aware uprobe":
>    https://patchwork.kernel.org/project/linux-mm/list/?series=131339
> 
> Please share your comments and suggestions on this.
> 
> Thanks!
> 
> Song Liu (6):
>   filemap: check compound_head(page)->mapping in filemap_fault()
>   filemap: update offset check in filemap_fault()
>   mm,thp: stats for file backed THP
>   khugepaged: rename collapse_shmem() and khugepaged_scan_shmem()
>   mm,thp: add read-only THP support for (non-shmem) FS
>   mm,thp: handle writes to file with THP in pagecache
> 
>  fs/inode.c             |   3 ++
>  fs/proc/meminfo.c      |   4 ++
>  include/linux/fs.h     |  31 ++++++++++++
>  include/linux/mmzone.h |   2 +
>  mm/Kconfig             |  11 +++++
>  mm/filemap.c           |   9 ++--
>  mm/khugepaged.c        | 104 +++++++++++++++++++++++++++++++++--------
>  mm/rmap.c              |  12 +++--
>  mm/truncate.c          |   7 ++-
>  mm/vmstat.c            |   2 +
>  10 files changed, 156 insertions(+), 29 deletions(-)
> 
> --
> 2.17.1

-- 
Michal Hocko
SUSE Labs
