Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18638B413
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhETQOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 12:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231927AbhETQOr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 12:14:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18A4611AE;
        Thu, 20 May 2021 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621527205;
        bh=blbDdIW8mhnerkvBEI8pXUbj83vi4wxNZwFLOFv3pVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hha6kVoXomOi+xBDo0LZe0mMl6zG9tmC3i1mKI4jK7JPaEZaHem17RX9/VAnA01rx
         joBk999gLLGQF/qrRLMfxUg/+aPjg/x73DFzjYAYUPxx/UhzKaGBtA6uAPXhBwnJnb
         i5GzuVxqvhlrIggdLROMmqSznDQpckTlaRDPXYcgh7xBahcOlPgN8gPeQ14lyvZEg1
         /cwRhroduSzLcV9HF4vhCuQaAkVKw/XgvZzXs6fygoV9cYSppSmceudbzsxGwOlA3O
         TnoSYTY8ANkFkJjSxkRG0fU4v7fLovle56/M/WJ0rIvxj8GbDV+oCLRWtdMkVb6cb6
         YD/UmS+sY7DKQ==
Date:   Thu, 20 May 2021 09:13:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
Subject: Re: [PATCH v26 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210520161325.GA9625@magnolia>
References: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 06:53:37PM +0300, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.
> 
> Having decades of expertise in commercial file systems development and huge
> test coverage, we at Paragon Software GmbH want to make our contribution to
> the Open Source Community by providing implementation of NTFS Read-Write
> driver for the Linux Kernel.
> 
> This is fully functional NTFS Read-Write driver. Current version works with
> NTFS(including v3.1) and normal/compressed/sparse files and supports journal replaying.
> 
> We plan to support this version after the codebase once merged, and add new
> features and fix bugs.

Questions for the ntfs3 maintainer(s):

1. What happens when you run ntfs3 through fstests with '-g all'?  I get
that the pass rate isn't going to be as high with ntfs3 as it is with
ext4/xfs/btrfs, but fstests can be adapted (see the recent attempts to
get exfat under test).

(And yes, not all the fstests will pass, since some of them are random
exercisers that we use to keep the bug backlog populated.  We can help
you figure out which tests are erratic like that).

2. Same question as #1, except for whatever internal QA suite Paragon
has used to qualify the ntfs3 driver over the years.  (If you haven't
been using fstests this whole time.)

3. If you (Paragon) do have an internal QA suite, are you willing to
contribute some of that to fstests to improve its ability to exercise
whatever features and quirks are unique to NTFS?

4. How often do you run QA validation (of any kind) on the ntfs3
codebase?

In case you're wondering why I ask these questions, my motivation is
in figuring out how easy it will be to extend QA coverage to the
community supported QA suite (fstests) so that people making treewide
and vfs level changes can check that their changes don't bitrot your
driver, and vice-versa.  My primary interest leans towards convincing
everyone to value QA and practice it regularly (aka sharing the load so
it's not entirely up to the maintainer to catch all problems) vs.
finding every coding error as a gate condition for merging.

As another fs maintainer, I know that this is key to preventing fs
drivers from turning into a rotting garbage fire, and probably the best
I can do for a review of ntfs3 since I don't anticipate having time for
a super-detailed review and you've been submitting this driver for a
while now.

After this gets merged, fixing the code warts and cognitive mismatches
with the vfs/mm apis becomes your problem. ;)  Oh, that brings me to my
last question:

5. Are you retiring the old ntfs driver too?

> For example, full journaling support over JBD will be
> added in later updates.

I remember jbd2.  Yikes. ;)

Anyway I'll try to do a once-over code scan while I procrastinate on
higher priority things. :P

--D

> 
> v2:
>  - patch splitted to chunks (file-wise)
>  - build issues fixed
>  - sparse and checkpatch.pl errors fixed
>  - NULL pointer dereference on mkfs.ntfs-formatted volume mount fixed
>  - cosmetics + code cleanup
> 
> v3:
>  - added acl, noatime, no_acs_rules, prealloc mount options
>  - added fiemap support
>  - fixed encodings support
>  - removed typedefs
>  - adapted Kernel-way logging mechanisms
>  - fixed typos and corner-case issues
> 
> v4:
>  - atomic_open() refactored
>  - code style updated
>  - bugfixes
> 
> v5:
> - nls/nls_alt mount options added
> - Unicode conversion fixes
> - Improved very fragmented files operations
> - logging cosmetics
> 
> v6:
> - Security Descriptors processing changed
>   added system.ntfs_security xattr to set
>   SD
> - atomic_open() optimized
> - cosmetics
> 
> v7:
> - Security Descriptors validity checks added (by Mark Harmstone)
> - atomic_open() fixed for the compressed file creation with directio
>   case
> - remount support
> - temporarily removed readahead usage
> - cosmetics
> 
> v8:
> - Compressed files operations fixed
> 
> v9:
> - Further cosmetics applied as suggested
> by Joe Perches
> 
> v10:
> - operations with compressed/sparse files on very fragmented volumes improved
> - reduced memory consumption for above cases
> 
> v11:
> - further compressed files optimizations: reads/writes are now skipping bufferization
> - journal wipe to the initial state optimized (bufferization is also skipped)
> - optimized run storage (re-packing cluster metainformation)
> - fixes based on Matthew Wilcox feedback to the v10
> - compressed/sparse/normal could be set for empty files with 'system.ntfs_attrib' xattr
> 
> v12:
> - nls_alt mount option removed after discussion with Pali Rohar
> - fixed ni_repack()
> - fixed resident files transition to non-resident when size increasing
> 
> v13:
> - nested_lock fix (lockdep)
> - out-of-bounds read fix (KASAN warning)
> - resident->nonresident transition fixed for compressed files
> - load_nls() missed fix applied
> - some sparse utility warnings fixes
> 
> v14:
> - support for additional compression types (we've adapted WIMLIB's
>   implementation, authored by Eric Biggers, into ntfs3)
> 
> v15:
> - kernel test robot warnings fixed
> - lzx/xpress compression license headers updated
> 
> v16:
> - lzx/xpress moved to initial ntfs-3g plugin code
> - mutexes instead of a global spinlock for compresions
> - FALLOC_FL_PUNCH_HOLE and FALLOC_FL_COLLAPSE_RANGE implemented
> - CONFIG_NTFS3_FS_POSIX_ACL added
> 
> v17:
> - FALLOC_FL_COLLAPSE_RANGE fixed
> - fixes for Mattew Wilcox's and Andy Lavr's concerns
> 
> v18:
> - ntfs_alloc macro splitted into two ntfs_malloc + ntfs_zalloc
> - attrlist.c: always use ntfs_cmp_names instead of memcmp; compare entry names
>   only for entry with vcn == 0
> - dir.c: remove unconditional ni_lock in ntfs_readdir
> - fslog.c: corrected error case behavior
> - index.c: refactored due to modification of ntfs_cmp_names; use rw_semaphore
>   for read/write access to alloc_run and bitmap_run while ntfs_readdir
> - run.c: separated big/little endian code in functions
> - upcase.c: improved ntfs_cmp_names, thanks to Kari Argillander for idea
>   and 'bothcase' implementation
> 
> v19:
> - fixed directory bitmap for 2MB cluster size
> - fixed rw_semaphore init for directories
> 
> v20:
> - fixed issue with incorrect hidden/system attribute setting on
>   root subdirectories
> - use kvmalloc instead of kmalloc for runs array
> - fixed index behavior on volumes with cluster size more than 4k
> - current build info is added into module info instead of printing on insmod
> 
> v21:
> - fixes for clang CFI checks
> - fixed sb->s_maxbytes for 32bit clusters
> - user.DOSATTRIB is no more intercepted by ntfs3
> - corrected xattr limits;  is used
> - corrected CONFIG_NTFS3_64BIT_CLUSTER usage
> - info about current build is added into module info and printing
> on insmod (by Andy Lavr's request)
> note: v21 is applicable for 'linux-next' not older than 2021.01.28
> 
> v22:
> - ntfs_cmp_names() fixed
> - raise warning if 'nls->uni2char' fails
> - hot fix free clusters code optimized
> - use clang-format 11.0 instead of 10.0 to format code
> 
> v23:
> - corrections for Kernel Test Robot warnings
> - kmem_cache_create() utilized to allocate memory in bitmap.c
> - cosmetics and comments thru the code
> 
> v24:
> - BIO_MAX_PAGES -> BIO_MAX_VECS (fix for build issue of v23 vs linux-next)
> - minor optimization for LogFile: do not fill it with -1, if it's already there
> - index.c: removed 'inline' in definition of hdr_find_split() and hdr_insert_head()
> 
> v25:
> - restore fs/Makefile in patch
> - refactor ntfs_create_inode() to use error-valued pointer
> - use mi_get_ref to fill MFT_REF
> - minimize checkpatch.pl warnings: replace LogFile with \x24LogFile when printing
> 
> v26:
> - fixed coccinelle warnings
> - fslog.c: fix memory leak and memory overwrite
> 
> Konstantin Komarov (10):
>   fs/ntfs3: Add headers and misc files
>   fs/ntfs3: Add initialization of super block
>   fs/ntfs3: Add bitmap
>   fs/ntfs3: Add file operations and implementation
>   fs/ntfs3: Add attrib operations
>   fs/ntfs3: Add compression
>   fs/ntfs3: Add NTFS journal
>   fs/ntfs3: Add Kconfig, Makefile and doc
>   fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
>   fs/ntfs3: Add MAINTAINERS
> 
>  Documentation/filesystems/ntfs3.rst |  107 +
>  MAINTAINERS                         |    7 +
>  fs/Kconfig                          |    1 +
>  fs/Makefile                         |    1 +
>  fs/ntfs3/Kconfig                    |   46 +
>  fs/ntfs3/Makefile                   |   34 +
>  fs/ntfs3/attrib.c                   | 2082 +++++++++++
>  fs/ntfs3/attrlist.c                 |  456 +++
>  fs/ntfs3/bitfunc.c                  |  135 +
>  fs/ntfs3/bitmap.c                   | 1519 ++++++++
>  fs/ntfs3/debug.h                    |   64 +
>  fs/ntfs3/dir.c                      |  594 +++
>  fs/ntfs3/file.c                     | 1130 ++++++
>  fs/ntfs3/frecord.c                  | 3071 ++++++++++++++++
>  fs/ntfs3/fslog.c                    | 5181 +++++++++++++++++++++++++++
>  fs/ntfs3/fsntfs.c                   | 2542 +++++++++++++
>  fs/ntfs3/index.c                    | 2641 ++++++++++++++
>  fs/ntfs3/inode.c                    | 2033 +++++++++++
>  fs/ntfs3/lib/decompress_common.c    |  332 ++
>  fs/ntfs3/lib/decompress_common.h    |  352 ++
>  fs/ntfs3/lib/lib.h                  |   26 +
>  fs/ntfs3/lib/lzx_decompress.c       |  683 ++++
>  fs/ntfs3/lib/xpress_decompress.c    |  155 +
>  fs/ntfs3/lznt.c                     |  452 +++
>  fs/ntfs3/namei.c                    |  578 +++
>  fs/ntfs3/ntfs.h                     | 1238 +++++++
>  fs/ntfs3/ntfs_fs.h                  | 1085 ++++++
>  fs/ntfs3/record.c                   |  609 ++++
>  fs/ntfs3/run.c                      | 1111 ++++++
>  fs/ntfs3/super.c                    | 1500 ++++++++
>  fs/ntfs3/upcase.c                   |  105 +
>  fs/ntfs3/xattr.c                    | 1046 ++++++
>  32 files changed, 30916 insertions(+)
>  create mode 100644 Documentation/filesystems/ntfs3.rst
>  create mode 100644 fs/ntfs3/Kconfig
>  create mode 100644 fs/ntfs3/Makefile
>  create mode 100644 fs/ntfs3/attrib.c
>  create mode 100644 fs/ntfs3/attrlist.c
>  create mode 100644 fs/ntfs3/bitfunc.c
>  create mode 100644 fs/ntfs3/bitmap.c
>  create mode 100644 fs/ntfs3/debug.h
>  create mode 100644 fs/ntfs3/dir.c
>  create mode 100644 fs/ntfs3/file.c
>  create mode 100644 fs/ntfs3/frecord.c
>  create mode 100644 fs/ntfs3/fslog.c
>  create mode 100644 fs/ntfs3/fsntfs.c
>  create mode 100644 fs/ntfs3/index.c
>  create mode 100644 fs/ntfs3/inode.c
>  create mode 100644 fs/ntfs3/lib/decompress_common.c
>  create mode 100644 fs/ntfs3/lib/decompress_common.h
>  create mode 100644 fs/ntfs3/lib/lib.h
>  create mode 100644 fs/ntfs3/lib/lzx_decompress.c
>  create mode 100644 fs/ntfs3/lib/xpress_decompress.c
>  create mode 100644 fs/ntfs3/lznt.c
>  create mode 100644 fs/ntfs3/namei.c
>  create mode 100644 fs/ntfs3/ntfs.h
>  create mode 100644 fs/ntfs3/ntfs_fs.h
>  create mode 100644 fs/ntfs3/record.c
>  create mode 100644 fs/ntfs3/run.c
>  create mode 100644 fs/ntfs3/super.c
>  create mode 100644 fs/ntfs3/upcase.c
>  create mode 100644 fs/ntfs3/xattr.c
> 
> 
> base-commit: 454c576c3f5e51d60f00a4ac0dde07f4f9d70e9d
> -- 
> 2.25.4
> 
