Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FCD61673F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKBQLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKBQLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D72C667;
        Wed,  2 Nov 2022 09:11:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b185so16820222pfb.9;
        Wed, 02 Nov 2022 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mngda3aHEeBTLGy2LfOMAwbMGwmKJm3kMZgi9Ib34ls=;
        b=CzwkZPeCCOjWsyC7BlL9IBJTrlmYa77xNpFSOioq+e8OPdv5fbZ/zAK/WD5VaCSnaf
         5wiT7RR/cG5GPZCjJ+Co+cRbnq0d7qvJjY3sdWpdys5S6A8w0OZe4/5smnTYFKe3NLzZ
         5wcozYB2mpTn2ymfQyRigL4lpLb5qvdDX4Kdyh4H+2z75vNY4RC4jXXiiTVaGfLOy97h
         uLbe3bGG1wM1TT2K00V5wMH2vpszUj/G4ZhsAUVnBiAEAK3CxOz0DxDqHYdVVOTDhWjV
         zp2OhnRtDn0qTZBfVT4zVHKT7w33B/qlC8Fh+c591akUyRXj9kHwG407cxvWxSpLW5pP
         0PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mngda3aHEeBTLGy2LfOMAwbMGwmKJm3kMZgi9Ib34ls=;
        b=w9VuzM3+4av5YPDjdTsGCrJgB88BI5SteH1uSjpOIPArMv/r7rxC5oA8fA/OXKMPLN
         QWsA/9/GJu+HMX+vBqSiXBzsQ2g+ISm0SdxA2yIbuFheWxmA1z7sYGxBKwo2T5b4ktUi
         yvtKZo8JRnf5ZQfk62p8fdpO41aUbXoBDaBtKPk1ZQcd8gazlJVuKbKMieJxoTRG0hf/
         webbdYKzJ7cSdkPeFfibMWJp6KXgoQF34Y/JQcMeVxp9WAVseUg6LCaf04dn/F/CtTzS
         d+u5R/OGURorFfJNYeJpEE3H1AFbQdWYcU3NGqfqXwOK6fNg2IVF19khxUP5khLBcjEc
         34kw==
X-Gm-Message-State: ACrzQf2oCZCoDfrfovZvAaTvyUBTB7roBqt+ndZ+GQ5dyFS/bIH1RzsD
        bYQ+YVHuCV746JZy7x8Y4sInFyl8MSHV3A==
X-Google-Smtp-Source: AMsMyM7hDOKBTXi34y4zB4HRcT4xPCgGrRzz1Zqhk7+jgpV1qJt102zpwOy+bMEbiQ6tv1xeWLGSXw==
X-Received: by 2002:a05:6a00:88f:b0:52c:6962:274f with SMTP id q15-20020a056a00088f00b0052c6962274fmr26591050pfj.12.1667405466831;
        Wed, 02 Nov 2022 09:11:06 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:06 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 00/23] Convert to filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:08 -0700
Message-Id: <20221102161031.5820-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series replaces find_get_pages_range_tag() with
filemap_get_folios_tag(). This also allows the removal of multiple
calls to compound_head() throughout.
It also makes a good chunk of the straightforward conversions to folios,
and takes the opportunity to introduce a function that grabs a folio
from the pagecache.

F2fs and Ceph have quite a lot of work to be done regarding folios, so
for now those patches only have the changes necessary for the removal of
find_get_pages_range_tag(), and only support folios of size 1 (which is
all they use right now anyways).

I've run xfstests on btrfs, ext4, f2fs, and nilfs2, but more testing may be
beneficial. The page-writeback and filemap changes implicitly work. Testing
and review of the other changes (afs, ceph, cifs, gfs2) would be appreciated.

---
v4:
  Fixed a bug with reference counting in cifs changes
  - Reported-by: kernel test robot <oliver.sang@intel.com> 
  Improved commit messages to be more meaningful
  Got some Acked-bys and Reviewed-bys

v3:
  Rebased onto upstream 6.1
  Simplified the ceph patch to only necessary changes
  Changed commit messages throughout to be clearer
  Got an Acked-by for another nilfs patch
  Got Tested-by for afs

v2:
  Got Acked-By tags for nilfs and btrfs changes
  Fixed an error arising in f2fs
  - Reported-by: kernel test robot <lkp@intel.com>

Vishal Moola (Oracle) (23):
  pagemap: Add filemap_grab_folio()
  filemap: Added filemap_get_folios_tag()
  filemap: Convert __filemap_fdatawait_range() to use
    filemap_get_folios_tag()
  page-writeback: Convert write_cache_pages() to use
    filemap_get_folios_tag()
  afs: Convert afs_writepages_region() to use filemap_get_folios_tag()
  btrfs: Convert btree_write_cache_pages() to use
    filemap_get_folio_tag()
  btrfs: Convert extent_write_cache_pages() to use
    filemap_get_folios_tag()
  ceph: Convert ceph_writepages_start() to use filemap_get_folios_tag()
  cifs: Convert wdata_alloc_and_fillpages() to use
    filemap_get_folios_tag()
  ext4: Convert mpage_prepare_extent_to_map() to use
    filemap_get_folios_tag()
  f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
  f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()
  gfs2: Convert gfs2_write_cache_jdata() to use filemap_get_folios_tag()
  nilfs2: Convert nilfs_lookup_dirty_data_buffers() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_btree_lookup_dirty_buffers() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_copy_dirty_pages() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_clear_dirty_pages() to use
    filemap_get_folios_tag()
  filemap: Remove find_get_pages_range_tag()

 fs/afs/write.c          | 114 +++++++++++++++++++++-------------------
 fs/btrfs/extent_io.c    |  57 ++++++++++----------
 fs/ceph/addr.c          |  58 ++++++++++----------
 fs/cifs/file.c          |  32 +++++++++--
 fs/ext4/inode.c         |  55 ++++++++++---------
 fs/f2fs/checkpoint.c    |  49 +++++++++--------
 fs/f2fs/compress.c      |  13 ++---
 fs/f2fs/data.c          |  69 +++++++++++++-----------
 fs/f2fs/f2fs.h          |   5 +-
 fs/f2fs/node.c          |  72 +++++++++++++------------
 fs/gfs2/aops.c          |  64 ++++++++++++----------
 fs/nilfs2/btree.c       |  14 ++---
 fs/nilfs2/page.c        |  59 +++++++++++----------
 fs/nilfs2/segment.c     |  44 ++++++++--------
 include/linux/pagemap.h |  32 +++++++----
 include/linux/pagevec.h |   8 ---
 mm/filemap.c            |  84 ++++++++++++++---------------
 mm/page-writeback.c     |  44 ++++++++--------
 mm/swap.c               |  10 ----
 19 files changed, 465 insertions(+), 418 deletions(-)

-- 
2.38.1

