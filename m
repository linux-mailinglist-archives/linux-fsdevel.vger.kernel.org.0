Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770D4EC713
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbiC3OvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiC3OvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07A015A13
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=m+GZBmqKDGa2Dt6KxAV/wOP4s9s9AeBToskwE8yANwk=; b=gZFS4FA59rX+T9VCflROulwDby
        sPLAU4/7TC34zpvTMS7enydSeHcsRpr34dgFHaCIwdKvspBLaLYRMVVFzslyUt8sK3X26p7rLIpBW
        EkbwrhJPLZEWmRUYozY4kpl5/D0EM5vFBjBZMg6yvftSBRoA+eDO3xH/jLSsLc9FKc73c8OuhkoTd
        zLXLBcI4mQgI5NN/5A3542mwECfmsQBunmsc4jexcoqyj96C8QfiFEJvt2nR12PWXNk0+HkAxyocV
        Bq/VxVJ80D04asMDZaZn58o2e0XHAUOS1uVBYxPX70/Hxb3HiV6/Zhh2dEZMhO9RflDkvLY3dE6D6
        biIpUVqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdb-001KCq-KI; Wed, 30 Mar 2022 14:49:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/12] Additional patches for 5.18
Date:   Wed, 30 Mar 2022 15:49:18 +0100
Message-Id: <20220330144930.315951-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are some misc patches that I'm going to send to Linus in a
couple of days.  Nothing earth-shattering, but no reason to delay them
to the next merge window.  I've pushed them out to
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
so they'll get a bit of testing in -next.

Matthew Wilcox (Oracle) (12):
  readahead: Remove read_cache_pages()
  fs: Remove ->readpages address space operation
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

 Documentation/filesystems/fsverity.rst |  6 +-
 Documentation/filesystems/locking.rst  |  6 --
 Documentation/filesystems/vfs.rst      | 11 ----
 fs/btrfs/inode.c                       |  2 +-
 fs/btrfs/reflink.c                     |  4 +-
 fs/buffer.c                            |  3 +-
 fs/ceph/file.c                         |  2 +-
 fs/cifs/cifssmb.c                      |  2 +-
 fs/cifs/inode.c                        |  2 +-
 fs/crypto/crypto.c                     |  2 +-
 fs/ext4/file.c                         |  2 +-
 fs/ext4/inode.c                        |  2 +-
 fs/ext4/readpage.c                     |  2 +-
 fs/f2fs/checkpoint.c                   |  2 +-
 fs/f2fs/data.c                         |  6 +-
 fs/f2fs/file.c                         |  2 +-
 fs/f2fs/node.c                         |  4 +-
 fs/fuse/fuse_i.h                       |  2 +-
 fs/iomap/buffered-io.c                 |  9 ++-
 fs/nfs/file.c                          |  2 +-
 fs/ntfs/aops.c                         |  2 +-
 fs/verity/verify.c                     |  4 +-
 include/linux/fs.h                     | 31 +--------
 include/linux/fsverity.h               |  2 +-
 include/linux/net.h                    | 19 ++++++
 include/linux/pagemap.h                |  2 -
 mm/filemap.c                           | 12 ++--
 mm/readahead.c                         | 91 +-------------------------
 28 files changed, 60 insertions(+), 176 deletions(-)

-- 
2.34.1

