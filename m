Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3837A53DDFC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351651AbiFETjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351617AbiFETje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3874F11A00;
        Sun,  5 Jun 2022 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pFaDJUkNgKV/oU+nKufi51KbavXmhswow0vSfNYzKrI=; b=IQQ3chWAAqod3iNOvZPz+sg3JL
        Hk+ApUMeqh7NT3g6IWWJNzgueSDKfvvNhBx6utIRkRDW0gX3AiQfvMXnwsyaJ/64KiwRfHwjSy/dv
        8J6uezBFHQnTUj8EMV7+h4tSlGa2WN04lIzx/EyXL84mDYJOn+khSbti+8XKflhn9L4r/WhR6xbM7
        +MZ9IYhStDA3yihxRhpkHHC+OXeBpvNCGWk5fEeGTb1H9CRJG5lEjoY1+jSkJw8hVgtSw7cxw6GvV
        KZogb0QToLdgR6kEf13Hcr4syZG2xfRXsnqeCO+zpSb6FDBtT5Fx6Rp6rYpWkgGY3OjWTTkHnJk29
        kJYadcSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5Q-009wsN-GO; Sun, 05 Jun 2022 19:38:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 00/10] Convert to filemap_get_folios()
Date:   Sun,  5 Jun 2022 20:38:44 +0100
Message-Id: <20220605193854.2371230-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series removes find_get_pages_range(), pagevec_lookup()
and pagevec_lookup_range(), converting all callers to use the new
filemap_get_folios().  I've only run xfstests over ext4 ... some other
testing might be appropriate.

Matthew Wilcox (Oracle) (10):
  filemap: Add filemap_get_folios()
  buffer: Convert clean_bdev_aliases() to use filemap_get_folios()
  ext4: Convert mpage_release_unused_pages() to use filemap_get_folios()
  ext4: Convert mpage_map_and_submit_buffers() to use
    filemap_get_folios()
  f2fs: Convert f2fs_invalidate_compress_pages() to use
    filemap_get_folios()
  hugetlbfs: Convert remove_inode_hugepages() to use
    filemap_get_folios()
  nilfs2: Convert nilfs_copy_back_pages() to use filemap_get_folios()
  vmscan: Add check_move_unevictable_folios()
  shmem: Convert shmem_unlock_mapping() to use filemap_get_folios()
  filemap: Remove find_get_pages_range() and associated functions

 fs/buffer.c             | 26 +++++++--------
 fs/ext4/inode.c         | 40 ++++++++++++-----------
 fs/f2fs/compress.c      | 35 +++++++++-----------
 fs/hugetlbfs/inode.c    | 44 ++++++++-----------------
 fs/nilfs2/page.c        | 60 +++++++++++++++++-----------------
 include/linux/pagemap.h |  5 ++-
 include/linux/pagevec.h | 10 ------
 include/linux/swap.h    |  3 +-
 mm/filemap.c            | 72 +++++++++++++++++------------------------
 mm/shmem.c              | 13 ++++----
 mm/swap.c               | 29 -----------------
 mm/vmscan.c             | 55 ++++++++++++++++++-------------
 12 files changed, 166 insertions(+), 226 deletions(-)

-- 
2.35.1

