Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF82A21E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfH2RLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 13:11:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfH2RLv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:11:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7FEFAA2D04148C798350;
        Fri, 30 Aug 2019 01:11:45 +0800 (CST)
Received: from [10.177.249.225] (10.177.249.225) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 01:11:37 +0800
Reply-To: <miaoxie@huawei.com>
Subject: Re: [PATCH v8 00/24] erofs: promote erofs from staging v8
To:     Gao Xiang <gaoxiang25@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, "Pavel Machek" <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
From:   Miao Xie <miaoxie@huawei.com>
Organization: Huawei Technologies Co., LTD.
Message-ID: <6e21095b-ede3-70d4-abd9-376ed8e89816@huawei.com>
Date:   Fri, 30 Aug 2019 01:11:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190815044155.88483-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.249.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



on 2019/8/15 at 12:41, Gao Xiang wrote:
> [I strip the previous cover letter, the old one can be found in v6:
>  https://lore.kernel.org/r/20190802125347.166018-1-gaoxiang25@huawei.com/]
> 
> We'd like to submit a formal moving patch applied to staging tree
> for 5.4, before that we'd like to hear if there are some ACKs,
> suggestions or NAKs, objections of EROFS. Therefore, we can improve
> it in this round or rethink about the whole thing.

ACK since it is stable enough and doesn't affect vfs or other filesystems.
And then, it could attract more users, we can get more feedback, and they
can help us to further improve it.

Thanks
Miao

> 
> As related materials mentioned [1] [2], the goal of EROFS is to
> save extra storage space with guaranteed end-to-end performance
> for read-only files, which has better performance over exist Linux
> compression filesystems based on fixed-sized output compression
> and inplace decompression. It even has better performance in
> a large compression ratio range compared with generic uncompressed
> filesystems with proper CPU-storage combinations. And we think this
> direction is correct and a dedicated kernel team is continuously /
> actively working on improving it, enough testers and beta / end
> users using it.
> 
> EROFS has been applied to almost all in-service HUAWEI smartphones
> (Yes, the number is still increasing by time) and it seems like
> a success. It can be used in more wider scenarios. We think it's
> useful for Linux / Android OS community and it's the time moving
> out of staging.
> 
> In order to get started, latest stable mkfs.erofs is available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b dev
> 
> with README in the repository.
> 
> We are still tuning sequential read performance for ultra-fast
> speed NVME SSDs like Samsung 970PRO, but at least now you can
> try on your PC with some data with proper compression ratio,
> the latest Linux kernel, USB stick for convenience sake and
> a not very old-fashioned CPU. There are also benchmarks available
> in the above materials mentioned.
> 
> EROFS is a self-contained filesystem driver. Although there are
> still some TODOs to be more generic, we will actively keep on
> developping / tuning EROFS with the evolution of Linux kernel
> as the other in-kernel filesystems.
> 
> As I mentioned before in LSF/MM 2019, in the future, we'd like
> to generalize the decompression engine into a library for other
> fses to use after the whole system is mature like fscrypt.
> However, such metadata should be designed respectively for
> each fs, and synchronous metadata read cost will be larger
> than EROFS because of those ondisk limitation. Therefore EROFS
> is still a better choice for read-only scenarios.
> 
> EROFS is now ready for reviewing and moving, and the code is
> already cleaned up as shiny floors... Please kindly take some
> precious time, share your comments about EROFS and let us know
> your opinion about this. It's really important for us since
> generally speaking, we like to use Linux _in-tree_ stuffs rather
> than lack of supported out-of-tree / orphan stuffs as well.
> 
> Thank you in advance,
> Gao Xiang
> 
> [1] https://kccncosschn19eng.sched.com/event/Nru2/erofs-an-introduction-and-our-smartphone-practice-xiang-gao-huawei
> [2] https://www.usenix.org/conference/atc19/presentation/gao
> 
> Changelog from v7:
>  o keep up with the latest staging tree in addition to
>    the latest staging patch:
>    https://lore.kernel.org/r/20190814103705.60698-1-gaoxiang25@huawei.com/
>    - use EUCLEAN for fs corruption cases suggested by Pavel;
>    - turn EIO into EOPNOTSUPP for unsupported on-disk format;
>    - fix all misused ENOTSUPP into EOPNOTSUPP pointed out by Chao;
>  o update cover letter
> 
> It can also be found in git at tag "erofs_2019-08-15" (will be shown later) at:
>  https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/
> 
> and the latest fs code is available at:
>  https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/tree/fs/erofs?h=erofs-outofstaging
> 
> Changelog from v6:
>  o keep up with the latest staging patchset
>    https://lore.kernel.org/linux-fsdevel/20190813023054.73126-1-gaoxiang25@huawei.com/
>    in order to fix the following cases:
>    - inline erofs_inode_is_data_compressed() in erofs_fs.h;
>    - remove incomplete cleancache;
>    - remove all BUG_ON in EROFS.
>  o Removing the file names from the comments at the top of the files
>    suggested by Stephen will be applied to the real moving patch later.
> 
> Changelog from v5:
>  o keep up with "[PATCH v2] staging: erofs: updates according to erofs-outofstaging v4"
>     https://lore.kernel.org/lkml/20190731155752.210602-1-gaoxiang25@huawei.com/
>    which mainly addresses review comments from Chao:
>   - keep the marco EROFS_IO_MAX_RETRIES_NOFAIL in internal.h;
>   - kill a redundant NULL check in "__stagingpage_alloc";
>   - add some descriptions in document about "use_vmap";
>   - rearrange erofs_vmap of "staging: erofs: kill CONFIG_EROFS_FS_USE_VM_MAP_RAM";
> 
>  o all changes have been merged into staging tree, which are under staging-testing:
>     https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/?h=staging-testing
> 
> Changelog from v4:
>  o rebase on Linux 5.3-rc1;
> 
>  o keep up with "staging: erofs: updates according to erofs-outofstaging v4"
>    in order to get main code bit-for-bit identical with staging tree:
>     https://lore.kernel.org/lkml/20190729065159.62378-1-gaoxiang25@huawei.com/
> 
> Changelog from v3:
>  o use GPL-2.0-only for SPDX-License-Identifier suggested by Stephen;
> 
>  o kill all kconfig cache strategies and turn them into mount options
>    "cache_strategy={disable|readahead|readaround}" suggested by Ted.
>    As the first step, cached pages can still be usable after cache is
>    disabled by remounting, and these pages will be fallen out over
>    time, which can be refined in the later version if some requirement
>    is needed. Update related document as well;
> 
>  o turn on CONFIG_EROFS_FS_SECURITY by default suggested by David;
> 
>  o kill CONFIG_EROFS_FS_IO_MAX_RETRIES and fold it into code; turn
>    EROFS_FS_USE_VM_MAP_RAM into a module parameter ("use_vmap")
>    suggested by David.
> 
> Changelog from v2:
>  o kill sbi->dev_name and clean up all failure handling in
>    fill_super() suggested by Al.
>    Note that the initialzation of managed_cache is now moved
>    after s_root is assigned since it's more preferred to iput()
>    in .put_super() and all inodes should be evicted before
>    the end of generic_shutdown_super(sb);
> 
>  o fold in the following staging patches (and thanks):
>    staging: erofs:converting all 'unsigned' to 'unsigned int'
>    staging: erofs: Remove function erofs_kill_sb()
>     - However it was revoked due to erofs_kill_sb reused...
>    staging: erofs: avoid opened loop codes
>    staging: erofs: support bmap
> 
>  o move EROFS_SUPER_MAGIC_V1 from linux/fs/erofs/erofs_fs.h to
>    include/uapi/linux/magic.h for userspace utilities.
> 
> Changelog from v1:
>  o resend the whole filesystem into a patchset suggested by Greg;
>  o code is more cleaner, especially for decompression frontend.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: David Sterba <dsterba@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Darrick J . Wong <darrick.wong@oracle.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Jan Kara <jack@suse.cz> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Miao Xie <miaoxie@huawei.com>
> Cc: Li Guifu <bluce.liguifu@huawei.com>
> Cc: Fang Wei <fangwei1@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> 
> Gao Xiang (24):
>   erofs: add on-disk layout
>   erofs: add erofs in-memory stuffs
>   erofs: add super block operations
>   erofs: add raw address_space operations
>   erofs: add inode operations
>   erofs: support special inode
>   erofs: add directory operations
>   erofs: add namei functions
>   erofs: support tracepoint
>   erofs: update Kconfig and Makefile
>   erofs: introduce xattr & posixacl support
>   erofs: introduce tagged pointer
>   erofs: add compression indexes support
>   erofs: introduce superblock registration
>   erofs: introduce erofs shrinker
>   erofs: introduce workstation for decompression
>   erofs: introduce per-CPU buffers implementation
>   erofs: introduce pagevec for decompression subsystem
>   erofs: add erofs_allocpage()
>   erofs: introduce generic decompression backend
>   erofs: introduce LZ4 decompression inplace
>   erofs: introduce the decompression frontend
>   erofs: introduce cached decompression
>   erofs: add document
> 
>  Documentation/filesystems/erofs.txt |  225 +++++
>  fs/Kconfig                          |    1 +
>  fs/Makefile                         |    1 +
>  fs/erofs/Kconfig                    |   98 ++
>  fs/erofs/Makefile                   |   11 +
>  fs/erofs/compress.h                 |   62 ++
>  fs/erofs/data.c                     |  425 ++++++++
>  fs/erofs/decompressor.c             |  360 +++++++
>  fs/erofs/dir.c                      |  148 +++
>  fs/erofs/erofs_fs.h                 |  316 ++++++
>  fs/erofs/inode.c                    |  333 +++++++
>  fs/erofs/internal.h                 |  555 +++++++++++
>  fs/erofs/namei.c                    |  253 +++++
>  fs/erofs/super.c                    |  666 +++++++++++++
>  fs/erofs/tagptr.h                   |  110 +++
>  fs/erofs/utils.c                    |  335 +++++++
>  fs/erofs/xattr.c                    |  705 ++++++++++++++
>  fs/erofs/xattr.h                    |   94 ++
>  fs/erofs/zdata.c                    | 1405 +++++++++++++++++++++++++++
>  fs/erofs/zdata.h                    |  195 ++++
>  fs/erofs/zmap.c                     |  463 +++++++++
>  fs/erofs/zpvec.h                    |  159 +++
>  include/trace/events/erofs.h        |  256 +++++
>  include/uapi/linux/magic.h          |    1 +
>  24 files changed, 7177 insertions(+)
>  create mode 100644 Documentation/filesystems/erofs.txt
>  create mode 100644 fs/erofs/Kconfig
>  create mode 100644 fs/erofs/Makefile
>  create mode 100644 fs/erofs/compress.h
>  create mode 100644 fs/erofs/data.c
>  create mode 100644 fs/erofs/decompressor.c
>  create mode 100644 fs/erofs/dir.c
>  create mode 100644 fs/erofs/erofs_fs.h
>  create mode 100644 fs/erofs/inode.c
>  create mode 100644 fs/erofs/internal.h
>  create mode 100644 fs/erofs/namei.c
>  create mode 100644 fs/erofs/super.c
>  create mode 100644 fs/erofs/tagptr.h
>  create mode 100644 fs/erofs/utils.c
>  create mode 100644 fs/erofs/xattr.c
>  create mode 100644 fs/erofs/xattr.h
>  create mode 100644 fs/erofs/zdata.c
>  create mode 100644 fs/erofs/zdata.h
>  create mode 100644 fs/erofs/zmap.c
>  create mode 100644 fs/erofs/zpvec.h
>  create mode 100644 include/trace/events/erofs.h
> 
