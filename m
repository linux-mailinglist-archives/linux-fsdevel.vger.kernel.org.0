Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D665D6EB3C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjDUVoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDUVoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24281BFD;
        Fri, 21 Apr 2023 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kIm+HajOeoUPf2+lVY4BBZIQ0O/I9EyHtsPMg+rZ0Kc=; b=Len1yzwK9xjx59+qsKo1F+zvmo
        +aUn2YbUJugrJe8dXSdbxmZlTKxrreA9IzoGdLVdC1eGVczJTAELlOsRwcJUqNaEGPL5rddVTdiuR
        2paO6yV15AQmkvh/r2vO9b7zoXcIlpl5k+bxfP1tQYU7r0yIo0NJa57GpOa/vmN/iPcfQM25C9axc
        9fAyhFR1UcdzhDQCHEodaN0a2CLAr7FSbG6HJhhQkhBXWfR0VxRZJhpFpyKBbupNefaohXdKaGvs2
        iJXFqj+JOo/hz8cLkWi8cBerPGguStJhP3RoX47i5vHERUL+Etq2Peo/JaqIXZEyR3e8KdNnjBCCs
        VqLXYKLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btog-1d;
        Fri, 21 Apr 2023 21:44:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/8] shmem: add support for blocksize > PAGE_SIZE
Date:   Fri, 21 Apr 2023 14:43:52 -0700
Message-Id: <20230421214400.2836131-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an initial attempt to add support for block size > PAGE_SIZE for tmpfs.
Why would you want this? It helps us experiment with higher order folio uses
with fs APIS and helps us test out corner cases which would likely need
to be accounted for sooner or later if and when filesystems enable support
for this. Better review early and burn early than continue on in the wrong
direction so looking for early feedback.

I have other patches to convert shmem_write_begin() and shmem_file_read_iter()
to folios too but those are not yet working. In the swap world the next
thing to look at would be to convert swap_cluster_readahead() to folios.

If folks want to experiment with tmpfs, brd or with things related to larger
block sizes I've put a branch up with this, Hannes's brd patches, and some
still work-in-progress patches on my large-block-20230421 branch [0]. Similarly
you can also use kdevops with CONFIG_QEMU_ENABLE_EXTRA_DRIVE_LARGEIO support
to get everything with just as that branch is used for that:

  make
  make bringup
  make linux

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=large-block-20230421
[1] https://github.com/linux-kdevops/kdevops

Luis Chamberlain (8):
  shmem: replace BLOCKS_PER_PAGE with PAGE_SECTORS
  shmem: convert to use folio_test_hwpoison()
  shmem: account for high order folios
  shmem: add helpers to get block size
  shmem: account for larger blocks sizes for shmem_default_max_blocks()
  shmem: consider block size in shmem_default_max_inodes()
  shmem: add high order page support
  shmem: add support to customize block size on multiple PAGE_SIZE

 include/linux/shmem_fs.h |   3 +
 mm/shmem.c               | 146 +++++++++++++++++++++++++++++----------
 2 files changed, 114 insertions(+), 35 deletions(-)

-- 
2.39.2

