Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221D54EFA32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351416AbiDAS4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiDAS4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:56:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F9B16E7DD;
        Fri,  1 Apr 2022 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XJOrGSYKrpUl9P2lPia9/j6W+jG3jYIdXlwX/9aolig=; b=KXmbrtA6cve8ospoF0xCATPBnS
        69TOJVSsG59t6tR9ysHMuyLR7Ov4Fk/D1vAomEge1/lvRnlaJWlxNTlpybDSd2ACZ5Jqm6qlrhUzC
        nNYaqb/mVMx1ECXF5CT7Kjenfqzqa0IyZ2G0VHgCRkcQ+mPo9tmDV5ri4HW1E1royqOKAdXJxilnK
        E7LITeQU1sguywYOJfyqP6UkRoOIPTJ29QepPTrOIAv0VX8T3QWDTfIKMEO0Nklueos22YKeOvvxo
        Bm6hqxZ0fXdtM/L+wo6jLUJYGMji8WpJU5DLp1o1UpdSburjv7Bj2Lq+g4xGxcXTDrtQrfrIRwuH1
        iIFUqFMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naMQF-003UqQ-Vy; Fri, 01 Apr 2022 18:55:00 +0000
Date:   Fri, 1 Apr 2022 19:54:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Folio fixes for 5.18
Message-ID: <YkdKgzil38iyc7rX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A mixture of odd changes that didn't quite make it into the original
pull and fixes for things that did.  Also the readpages changes had to
wait for the NFS tree to be pulled first.

The following changes since commit d888c83fcec75194a8a48ccd283953bdba7b2550:

  fs: fix fd table size alignment properly (2022-03-29 23:29:18 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18d

for you to fetch changes up to 5a60542c61f3cce6e5dff2a38c8fb08a852a517b:

  btrfs: Remove a use of PAGE_SIZE in btrfs_invalidate_folio() (2022-04-01 14:40:44 -0400)

----------------------------------------------------------------
Filesystem/VFS changes for 5.18, part two

 - Remove ->readpages infrastructure
 - Remove AOP_FLAG_CONT_EXPAND
 - Move read_descriptor_t to networking code
 - Pass the iocb to generic_perform_write
 - Minor updates to iomap, btrfs, ext4, f2fs, ntfs

----------------------------------------------------------------
Christoph Hellwig (2):
      mm: remove the pages argument to read_pages
      mm: remove the skip_page argument to read_pages

Matthew Wilcox (Oracle) (13):
      readahead: Remove read_cache_pages()
      fs: Remove ->readpages address space operation
      readahead: Update comments
      iomap: Simplify is_partially_uptodate a little
      fs: Remove read_actor_t
      fs, net: Move read_descriptor_t to net.h
      fs: Pass an iocb to generic_perform_write()
      filemap: Remove AOP_FLAG_CONT_EXPAND
      ext4: Correct ext4_journalled_dirty_folio() conversion
      f2fs: Correct f2fs_dirty_data_folio() conversion
      f2fs: Get the superblock from the mapping instead of the page
      ntfs: Correct mark_ntfs_record_dirty() folio conversion
      btrfs: Remove a use of PAGE_SIZE in btrfs_invalidate_folio()

 Documentation/filesystems/fsverity.rst |   6 +-
 Documentation/filesystems/locking.rst  |   6 -
 Documentation/filesystems/vfs.rst      |  11 --
 fs/btrfs/inode.c                       |   2 +-
 fs/btrfs/reflink.c                     |   4 +-
 fs/buffer.c                            |   3 +-
 fs/ceph/file.c                         |   2 +-
 fs/cifs/cifssmb.c                      |   2 +-
 fs/cifs/inode.c                        |   2 +-
 fs/crypto/crypto.c                     |   2 +-
 fs/ext4/file.c                         |   2 +-
 fs/ext4/inode.c                        |   2 +-
 fs/ext4/readpage.c                     |   2 +-
 fs/f2fs/checkpoint.c                   |   2 +-
 fs/f2fs/data.c                         |   6 +-
 fs/f2fs/file.c                         |   2 +-
 fs/f2fs/node.c                         |   4 +-
 fs/fuse/fuse_i.h                       |   2 +-
 fs/iomap/buffered-io.c                 |   9 +-
 fs/nfs/file.c                          |   2 +-
 fs/ntfs/aops.c                         |   2 +-
 fs/verity/verify.c                     |   4 +-
 include/linux/fs.h                     |  31 +----
 include/linux/fsverity.h               |   2 +-
 include/linux/net.h                    |  19 +++
 include/linux/pagemap.h                |   2 -
 mm/filemap.c                           |  12 +-
 mm/readahead.c                         | 204 +++++++++------------------------
 28 files changed, 113 insertions(+), 236 deletions(-)


