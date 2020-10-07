Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588062855E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgJGBH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbgJGBHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=467Pzkhteq6dUGiT2xllw2GXu89PM4GJT0vhc0lwI9o=;
        b=RnAeSWEl9tuNgnrCBKOk9JWjyu6BOvFHQTn/pXZeb7N6c7oTbUIC0xgiW+w9+sajnxcydh
        fxA6Zi9JdrzepJSM3079+qKTtENriwF3sIQ4u7y2A8h4Hm8Duv9kEiNd1MMEhey01crv+2
        r3TlOLDTHrFqay38hjI2UGjC8RGz88E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-3apOz9fcMiWYuND54Xd-9A-1; Tue, 06 Oct 2020 21:07:12 -0400
X-MC-Unique: 3apOz9fcMiWYuND54Xd-9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2903C80402E;
        Wed,  7 Oct 2020 01:07:11 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0F105D9D2;
        Wed,  7 Oct 2020 01:07:09 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 00/14] Small step toward KSM for file back page.
Date:   Tue,  6 Oct 2020 21:05:49 -0400
Message-Id: <20201007010603.3452458-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This patchset is a step toward a larger objective: generalize existing
KSM into a mechanism allowing exclusive write control for a page; either
anonymous memory (like KSM today) or file back page (modulo GUP which
would block that like it does today for KSM).

Exclusive write control page allow multiple different features to be
implemented:

    - KSM kernel share page, ie de-duplicate pages with same content
      to use a single page for all. From many pages to one read only
      page. We have that today for anonymous memory only. The overall
      patchset extends it to file back page ie sharing the same struct
      page accross different file or accross same file. This can be
      be usefull for containers for instance ... or for deduplication
      in same file.

    - NUMA duplication, duplicate a page into multiple local read only
      copy. This is the opposite of KSM in a sense, instead of saving
      memory. Using more memory to get better memory access performance.
      For instance duplicating libc code to local node copy; or big
      read only dataset duplicated on each nodes.

    - Exclusive write access, owner of page write protection is the only
      that can write to the page (and must still abide by fs rules for
      fileback page in respect to writeback...). One use case is for
      fast atomic operation using non atomic instruction. For instance
      by PCIE device, if all mapping of the page is read only then PCIE
      device driver knows device write can not race with CPU write. This
      is a performance optimization.

    - Use main memory as cache for persistent memory ie the page is
      read only and write will trigger callback and different strategy
      can be use like write combining (ie acumulating change in main
      memory before copying to persistent memory).

Like KSM today such protection can be broken at _any_ time. The owner
of the protection gets a callback (KSM code for instance get calls) so
that it can unprotect the page. Breaking protection should not block
and must happens quickly (like KSM code today).


Convertion of existing KSM into generic mechanism is straightforward
for anonymous page (just factorize out KSM code that deals with page
protection from KSM code that deals with de-duplication).


The big changes here is the support for file back pages. The idea to
achieve it is that we almost always have the mapping a page belongs
to within the call stack as we operate on such page either from:
  - Syscall/kernel against a file (file -> inode -> mapping).
  - Syscall/kernel against virtual address (vma -> file -> mapping).
  - Write back for a given mapping (mapping -> pages).

They are few exceptions:
  - Reclaim, but reclaim does not care about mapping. Reclaim wants to
    unmap page to free it up. So all we have to do is provide special
    path to do that just like KSM does today for anonymous pages.

  - Compaction, again we do not care about the mapping for compaction.
    All we need is way to move page (ie migrate).

  - Flush data cache on some architecture the cache line are tag with
    the virtual address so when flushing a page we need to find all of
    its virtual addresses. Again we do not care about the mapping, we
    just need a way to find all virtual address in all process pointing
    to the page.

  - GUP user that want to set a page dirty. This is easy, we just do
    not allow protection to work on GUPed page and GUP also will break
    the protection. There is just no way to synchronize with GUP user
    as they violate all mm and fs rules anyway.

  - Some proc fs and other memory debugging API. Here we do not care
    about the mapping but about the page states. Also some of those
    API works on virtual address for which we can easily get the vma
    and thus the mapping.


So when we have the mapping for a page from the context and not from
page->mapping then we can use it as a key to lookup private and index
fields value for the page.

To avoid any regression risk, only protected pages sees their fields
overloaded. It means that if you are not using the page protection then
the page->mapping, page->private and page->index all stays as they are
today. Also page->mapping is always use as canonical place to lookup
the page mapping for unprotected page so that any existing code will
keep working as it does today even if the mapping we get from the
context does not match the page->mapping. More on this below.


Overview:
=========

The core idea is pretty dumb, it is just about passing new mapping
argument to every function that get a page and need the mapping
corresponding to that page. Most of the changes are done through
semantic patches. Adding new function argument on itself does not
bring any risk. The risk is in making sure that the mapping we pass as
function argument is the one corresponding to the page. To avoid any
regression we keep using page->mapping as the canonical mapping even
if it does not match what we get as a new argument ie:

Today:
    foo(struct page *page)
    {
        ... local variable declaration ...
        struct address_space *mapping = page->mapping;

        ... use mapping or inode from mapping ...
    }

After:
    foo(struct page *page, struct address_space *mapping)
    {
        ... local variable declaration ...

        mapping = fs_page_mapping(page, mapping);

        ... use mapping or inode from mapping ...
    }

With:
    struct address_space *fs_page_mapping(struct page *page,
                              struct address_space *mapping)
    {
        if (!PageProtected(page)) {
            WARN_ON(page->mapping != mapping);
            return page->mapping;
        }
        return mapping;
    }

So as long as you are not using page protection the end result before
and after the patchset is the same ie the same mapping value will be
use.


Strategy for passing down mapping of page:
==========================================

To make it easier to review that correct mapping is pass down, changes
are split in 3 steps:
    - First adds new __mapping argument to all functions that will need
      it and do not have it already (or inode as we can get mapping from
      inode). The argument is never use and thus in this step call site
      pass MAPPING_NULL which is just macro that alias to NULL but is
      easier to grep for.

    - Second replace MAPPING_NULL with the __mapping argument whereever
      possible. The rational is that if a function is passing down the
      mapping and already have it as a function argument then the real
      difficulty is not in that function but in caller of that function
      where we must ascertain that the mapping we pass down is the
      correct one.

      Replace any local MAPPING_NULL with local mapping variable or
      inode (some convertion are done manualy when they are multiple
      possible choice or when the automatic convertion would be wrong).

      At the end of this step there should not be any MAPPING_NULL left
      anywhere.

    - Finaly we replace any local mapping variable with __mapping and
      we add a check ie going from:
        foo(struct address_mapping *__mapping, struct page *page, ...){
            struct address_space *mapping = page->mapping;
            ...
        }
     To:
        foo(struct address_mapping *mapping, struct page *page, ...) {
            ...
            mapping = fs_page_mapping(mapping, page);
        }
     With:
        fs_page_mapping(struct address_mapping *mapping,
                        struct page *page) {
            if (!PageProtected(page))
                return page->mapping;
            return mapping;
        }

     Do the same for local inode that are looked up from page->mapping.

     So as long as you do not use the protection mechanism you will
     use the same mapping/inode as today.

I hope that over enough time we can build confidence so that people
start using page protection and KSM for file back pages without any
fear of regression. But in the meantime as explained in above section,
code will keep working as it does today if page is not protected.


----------------------------------------------------------------------


The present patchset just add mapping argument to the various vfs call-
backs. It does not make use of that new parameter to avoid regression.
I am posting this whole things as small contain patchset as it is rather
big and i would like to make progress step by step.


----------------------------------------------------------------------
FAQ:
----------------------------------------------------------------------

Why multiple pass in the coccinelle patches ?

    Two reasons for this:
      - To modify callback you first need to identify callback. It is
        common enough to have callback define in one file and set as
        callback in another. For that to work you would have one pass
        to identify all function use as a callback. Then anoter pass
        executed for each of the callback identified in the first pass
        to update each of them (like adding a new arugment).

      - Run time, some of the coccinelle patch are complex enough that
        they have a long runtime so to avoid spending hours on semantic
        patching it is better to run a first pass (with very simple
        semantic patch) that identify all the files that will need to
        be updated and then a second pass on each of the file with the
        actual update.


Why wrapping page->flags/index/private/mapping ?
    A protected page can (is not necessary the case) alias to multiple
    original page (also see "page alias" in glossary). Each alias do
    correspond to a different original page which had a different file
    (and thus mapping), likely at a different offset (page->index) and
    with different properties (page->flags and page->private). So we
    need to keep around all the original informations and we use the
    page and mapping (or anon_vma) as key to lookup alias and get the
    correct information for it.


Why keeping page->private for each page alias ?
    For KSM or NUMA duplication we expect the page to be uptodate and
    clean and thus we should be able to free buffers (or fs specific
    struct) and thus no need to keep around private.

    However for page exclusive access we will not alias the page with
    any other page and we might want to keep the page in a writeable
    state and thus we need to keep the page->private around.


Why a lot of patch move local variable out of declaration ?
    Many patch modify code from:
        foo(...) {
            some_type1 some_name1 = some_arg1;
            some_type2 some_name2 = some_arg2 || some_name1;
            DECLARATION...

            STATEMENT...
        }

    To:
        foo(...) {
            some_type1 some_name1;
            some_type2 some_name2;
            DECLARATION...

            some_name1 = some_arg1;
            some_name2 = some_arg2 || some_name1;

            STATEMENT...
        }

    This is done so that we can add a test to check if mapping/inode
    we get in argument does match the page->mapping field. We need to
    add such test after all declaration but before any assignment to
    local variable. Hence why declaration initializer need to become
    regular statement after all declarations.

    Saddly no way around that and this lead to a lot of code churn.


----------------------------------------------------------------------
Glossary:
----------------------------------------------------------------------

page alias
    A protected page can alias with different file and/or vma (and thus
    anon_vma). A page alias is just the information that correspond to
    each of the file/vma for that that.

    For instance let say that PA was a file back page it had:
        PA->mapping == mapping corresponding to the file PA belong
        PA->index   == offset into the file for PA
        PA->private == fs specific information (like buffer_head)
        PA->flags   == fs/mm specific informations

    PB was a anonymous page, it had:
        PB->mapping == anon_vma for the vma into which PB is map
        PB->index   == offset into the vma
        PB->private == usualy 0 but can contain a swap entry
        PB->flags   == fs/mm specific informations

    Now if PA and PB are merge together into a protect page then the
    protected page will have an alias struct for each of the original
    page ie:
        struct page_alias {
            struct list list;
            unsigned long flags;
            unsigned long index;
            void *mapping;
            void *private;
        };
        struct pxa {
            struct list aliases;
            ...
        };

    So now for the PXA (protected page) that replace PA and PB we have:
        PP->mapping == pointer to struct pxa for the page

    Note that PP->index/private are undefine for now but could be use
    for optimization like storing the most recent alias lookup.

    And the alias list will have one entry for PA and one for PB:
        PA_alias.mapping = PA.mapping
        PA_alias.private = PA.private
        PA_alias.index   = PA.index
        PA_alias.flags   = PA.flags

        PB_alias.mapping = PB.mapping
        PB_alias.private = PB.private
        PB_alias.index   = PB.index
        PB_alias.flags   = PB.flags


raw page
    A page that is not use as anonymous or file back. Many cases, can
    be a free page, a page use by a device driver or some kernel
    features. Each case can sometimes make use of the various struct
    page fields (mapping, private, index, lru, ...).

    To get proper education this patchset wrap usage of those field in
    those code with raw_page*() helpers. This also make it clears what
    kind of page we expect to see in such driver/feature.


Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <jbacik@fb.com>


Jérôme Glisse (14):
  mm/pxa: page exclusive access add header file for all helpers.
  fs: define filler_t as a function pointer type
  fs: directly use a_ops->freepage() instead of a local copy of it.
  mm: add struct address_space to readpage() callback
  mm: add struct address_space to writepage() callback
  mm: add struct address_space to set_page_dirty() callback
  mm: add struct address_space to invalidatepage() callback
  mm: add struct address_space to releasepage() callback
  mm: add struct address_space to freepage() callback
  mm: add struct address_space to putback_page() callback
  mm: add struct address_space to launder_page() callback
  mm: add struct address_space to is_partially_uptodate() callback
  mm: add struct address_space to isolate_page() callback
  mm: add struct address_space to is_dirty_writeback() callback

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  3 +-
 drivers/video/fbdev/core/fb_defio.c       |  3 +-
 fs/9p/vfs_addr.c                          | 24 ++++++---
 fs/adfs/inode.c                           |  6 ++-
 fs/affs/file.c                            |  9 ++--
 fs/affs/symlink.c                         |  4 +-
 fs/afs/dir.c                              | 15 ++++--
 fs/afs/file.c                             | 18 ++++---
 fs/afs/internal.h                         |  7 +--
 fs/afs/write.c                            |  9 ++--
 fs/befs/linuxvfs.c                        | 13 +++--
 fs/bfs/file.c                             |  6 ++-
 fs/block_dev.c                            | 10 ++--
 fs/btrfs/ctree.h                          |  3 +-
 fs/btrfs/disk-io.c                        | 16 +++---
 fs/btrfs/extent_io.c                      |  5 +-
 fs/btrfs/file.c                           |  2 +-
 fs/btrfs/free-space-cache.c               |  2 +-
 fs/btrfs/inode.c                          | 24 +++++----
 fs/btrfs/ioctl.c                          |  2 +-
 fs/btrfs/relocation.c                     |  2 +-
 fs/btrfs/send.c                           |  2 +-
 fs/buffer.c                               | 14 +++--
 fs/cachefiles/rdwr.c                      |  6 +--
 fs/ceph/addr.c                            | 26 +++++----
 fs/cifs/cifssmb.c                         |  2 +-
 fs/cifs/file.c                            | 15 ++++--
 fs/coda/symlink.c                         |  4 +-
 fs/cramfs/inode.c                         |  3 +-
 fs/ecryptfs/mmap.c                        |  8 ++-
 fs/efs/inode.c                            |  3 +-
 fs/efs/symlink.c                          |  4 +-
 fs/erofs/data.c                           |  4 +-
 fs/erofs/super.c                          |  8 +--
 fs/erofs/zdata.c                          |  4 +-
 fs/exfat/inode.c                          |  6 ++-
 fs/ext2/inode.c                           | 11 ++--
 fs/ext4/inode.c                           | 35 +++++++-----
 fs/f2fs/checkpoint.c                      |  8 +--
 fs/f2fs/data.c                            | 20 ++++---
 fs/f2fs/f2fs.h                            |  8 +--
 fs/f2fs/node.c                            |  8 +--
 fs/fat/inode.c                            |  6 ++-
 fs/freevxfs/vxfs_immed.c                  |  6 ++-
 fs/freevxfs/vxfs_subr.c                   |  6 ++-
 fs/fuse/dir.c                             |  4 +-
 fs/fuse/file.c                            |  9 ++--
 fs/gfs2/aops.c                            | 29 ++++++----
 fs/gfs2/inode.h                           |  3 +-
 fs/gfs2/meta_io.c                         |  4 +-
 fs/hfs/inode.c                            |  9 ++--
 fs/hfsplus/inode.c                        | 10 ++--
 fs/hostfs/hostfs_kern.c                   |  6 ++-
 fs/hpfs/file.c                            |  6 ++-
 fs/hpfs/namei.c                           |  4 +-
 fs/hugetlbfs/inode.c                      |  3 +-
 fs/iomap/buffered-io.c                    | 15 +++---
 fs/iomap/seek.c                           |  2 +-
 fs/isofs/compress.c                       |  3 +-
 fs/isofs/inode.c                          |  3 +-
 fs/isofs/rock.c                           |  4 +-
 fs/jffs2/file.c                           | 11 ++--
 fs/jffs2/os-linux.h                       |  3 +-
 fs/jfs/inode.c                            |  6 ++-
 fs/jfs/jfs_metapage.c                     | 15 ++++--
 fs/libfs.c                                | 13 +++--
 fs/minix/inode.c                          |  6 ++-
 fs/mpage.c                                |  2 +-
 fs/nfs/dir.c                              | 14 ++---
 fs/nfs/file.c                             | 16 +++---
 fs/nfs/read.c                             |  6 ++-
 fs/nfs/symlink.c                          |  7 +--
 fs/nfs/write.c                            |  9 ++--
 fs/nilfs2/inode.c                         | 11 ++--
 fs/nilfs2/mdt.c                           |  3 +-
 fs/nilfs2/page.c                          |  2 +-
 fs/nilfs2/segment.c                       |  4 +-
 fs/ntfs/aops.c                            | 10 ++--
 fs/ntfs/file.c                            |  2 +-
 fs/ocfs2/aops.c                           |  9 ++--
 fs/ocfs2/symlink.c                        |  4 +-
 fs/omfs/file.c                            |  6 ++-
 fs/orangefs/inode.c                       | 38 +++++++------
 fs/qnx4/inode.c                           |  3 +-
 fs/qnx6/inode.c                           |  3 +-
 fs/reiserfs/inode.c                       | 20 ++++---
 fs/romfs/super.c                          |  3 +-
 fs/squashfs/file.c                        |  4 +-
 fs/squashfs/symlink.c                     |  4 +-
 fs/sysv/itree.c                           |  6 ++-
 fs/ubifs/file.c                           | 21 +++++---
 fs/udf/file.c                             |  7 ++-
 fs/udf/inode.c                            |  8 +--
 fs/udf/symlink.c                          |  4 +-
 fs/ufs/inode.c                            |  6 ++-
 fs/vboxsf/file.c                          |  6 ++-
 fs/xfs/xfs_aops.c                         |  6 +--
 fs/zonefs/super.c                         |  6 ++-
 include/linux/balloon_compaction.h        | 11 ++--
 include/linux/buffer_head.h               | 12 +++--
 include/linux/fs.h                        | 38 +++++++------
 include/linux/iomap.h                     | 15 +++---
 include/linux/mm.h                        | 11 +++-
 include/linux/nfs_fs.h                    |  5 +-
 include/linux/page-xa.h                   | 66 +++++++++++++++++++++++
 include/linux/pagemap.h                   |  6 +--
 include/linux/swap.h                      | 10 ++--
 mm/balloon_compaction.c                   |  5 +-
 mm/filemap.c                              | 33 ++++++------
 mm/migrate.c                              |  6 +--
 mm/page-writeback.c                       | 16 +++---
 mm/page_io.c                              | 11 ++--
 mm/readahead.c                            |  6 +--
 mm/shmem.c                                |  5 +-
 mm/truncate.c                             |  9 ++--
 mm/vmscan.c                               | 12 ++---
 mm/z3fold.c                               |  6 ++-
 mm/zsmalloc.c                             |  6 ++-
 118 files changed, 722 insertions(+), 385 deletions(-)
 create mode 100644 include/linux/page-xa.h

-- 
2.26.2

