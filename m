Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633165DE23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbjADVO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjADVO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:14:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689731B9DA;
        Wed,  4 Jan 2023 13:14:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so1873607pjb.1;
        Wed, 04 Jan 2023 13:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XF0rWcwOaeOy9W3XDndGOlTI6VOcqMAlw6Z0kSP+ZIE=;
        b=mwUaRHyXO3QpRK5P0JqCEjtDjkmGl7YgUMaT1I2YjsKhseOwqNkNS33mOlEf/eRTXu
         Dx4cepCH0DpI7UZias9hAXzrqhmP9FqJPQ5SpCcrNsEip5tDid5QCJ8rq3xSJ7zfXgzS
         VkkY41Iwf5a5gzpho+eHq9V7JD1kKJVPOfzCuRJq6ljFPE+NlmpfzNYoSMe4wocuCgzf
         S6i7hTWrnSsU5BeCV3tLAdKHoc+E6ZXdQXMGE1pFenz1nLeHJTOMKZAollRFOqAqS7OZ
         auFae1eJ8Ii2yGyYjhvy6b6WvXd1YJI0BgZbYV7R5btP09Ol+PqZuvdKcR/Dbg+8nqw5
         sxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XF0rWcwOaeOy9W3XDndGOlTI6VOcqMAlw6Z0kSP+ZIE=;
        b=VXUdT2qJNV2+51ymPdStnnbXkLEO+YYaaZqRzKkqvwyTrB8ZiM5kvLPWDZuyIkp40t
         KwuvYPgYLdFs/AUWR1oj/IwdEjYnv62J6K63fw4Nbou1Kn2jEe2nc+rE1fyYps2SiMUC
         fp6hb2ErAaJvfFtth+DS50MmNNkmUzIiOzsGMPQqtFI/SSMdMyAe43GLUzqGHTILSa51
         tOnjlpsIH3s3BHucazaHZuRefdP1Ck0jooQbGJrg93ia6AE0opLYo1RLoXeIXAPXz8iU
         lRRg350TTraGEnL8udJCWl0NpSfUElVywgRHTY3nPau69R8Js2uGBvSw8TSVckoJAFvB
         X3dA==
X-Gm-Message-State: AFqh2kpDWAd7wjlled99pb0sBQSDjMptgWcma3nf84rFxSYBdwaC6ju8
        TTv6m3s2goEH2Fqi5mlXfd6hHv/26T0=
X-Google-Smtp-Source: AMrXdXuHWcLr2ISD1AWLN6noveXBmNIMzDKhC6iHCDPkCElkMLkDu5P/j13SKsDU15gZnXatqrr41A==
X-Received: by 2002:a17:90a:cc0b:b0:219:5955:7570 with SMTP id b11-20020a17090acc0b00b0021959557570mr23943541pju.46.1672866895416;
        Wed, 04 Jan 2023 13:14:55 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:14:54 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v5 00/23] Convert to filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:25 -0800
Message-Id: <20230104211448.4804-1-vishal.moola@gmail.com>
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

I've run xfstests on xfs, btrfs, ext4, f2fs, and nilfs2, but more testing may
be beneficial. The page-writeback and filemap changes implicitly work. Still
looking for review of cifs, gfs2, and ext4.

---
v5:
  Rebased onto upstream 6.2-rc2
  Filesystems modified to use folio_get() instead of folio_ref_inc()
  F2fs modified to maintain use of F2FS_ONSTACK_PAGES

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

 fs/afs/write.c          | 116 ++++++++++++++++++++--------------------
 fs/btrfs/extent_io.c    |  57 ++++++++++----------
 fs/ceph/addr.c          |  58 ++++++++++----------
 fs/cifs/file.c          |  32 +++++++++--
 fs/ext4/inode.c         |  65 +++++++++++-----------
 fs/f2fs/checkpoint.c    |  49 +++++++++--------
 fs/f2fs/data.c          |  84 ++++++++++++++++++++---------
 fs/f2fs/node.c          |  72 +++++++++++++------------
 fs/gfs2/aops.c          |  64 ++++++++++++----------
 fs/nilfs2/btree.c       |  14 ++---
 fs/nilfs2/page.c        |  59 ++++++++++----------
 fs/nilfs2/segment.c     |  44 +++++++--------
 include/linux/pagemap.h |  32 +++++++----
 include/linux/pagevec.h |   8 ---
 mm/filemap.c            |  84 ++++++++++++++---------------
 mm/page-writeback.c     |  44 +++++++--------
 mm/swap.c               |  10 ----
 17 files changed, 481 insertions(+), 411 deletions(-)

-- 
2.38.1

