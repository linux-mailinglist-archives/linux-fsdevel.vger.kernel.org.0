Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0728E751706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGMDzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjGMDze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:55:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9611FEE;
        Wed, 12 Jul 2023 20:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jhgPtDmYYOVv+edSxa1VnGYvAPEvu+uXYOqgq3fjTTY=; b=mT6ncVRduE6uK+2JV6NnGf9oby
        hkBuLFodEFApteZyC11j/xmfVGsn6iGS+DxvH2rHW9Os1KznCMCPTdEgr3sX7UkQWzEp21NPYmIbX
        K6hmv9UIp+OaFOnzrAGAagOdAjQ2Ttg1CHbR7Xjx2G5Blv5lMR0ictbeRdjRRqafNQtl8ACvltNCA
        1blLSWPKKXy628i3Llp9v5Tgs1Nrj1zQnFMOSVr5/0xzfW06HVeKqblGX1d25ikvVqLEwJi8L8UiB
        yvTldA8MC4r8gW2Yj4JM47U8jl4F5aHlbgFm1EKiFbjmb14JoCJckT2iwPKm6uMoxwzFFZ2fJXEXf
        /6+vzZ3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJnQA-00HMrc-52; Thu, 13 Jul 2023 03:55:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Tso" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 0/7] More filesystem folio conversions for 6.6
Date:   Thu, 13 Jul 2023 04:55:05 +0100
Message-Id: <20230713035512.4139457-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the only spots in affs which actually use a struct page; there
are a few places where one is mentioned, but it's part of the interface.

The rest of this is removing the remaining calls to set_bh_page(),
and then removing the function before any new users show up.

Matthew Wilcox (Oracle) (7):
  highmem: Add memcpy_to_folio() and memcpy_from_folio()
  affs: Convert affs_symlink_read_folio() to use the folio
  affs: Convert data read and write to use folios
  migrate: Use folio_set_bh() instead of set_bh_page()
  ntfs3: Convert ntfs_get_block_vbo() to use a folio
  jbd2: Use a folio in jbd2_journal_write_metadata_buffer()
  buffer: Remove set_bh_page()

 fs/affs/file.c              | 77 ++++++++++++++++++-------------------
 fs/affs/symlink.c           | 12 +++---
 fs/buffer.c                 | 15 --------
 fs/jbd2/journal.c           | 35 ++++++++---------
 fs/ntfs3/inode.c            | 10 ++---
 include/linux/buffer_head.h |  2 -
 include/linux/highmem.h     | 44 +++++++++++++++++++++
 mm/migrate.c                |  2 +-
 8 files changed, 109 insertions(+), 88 deletions(-)

-- 
2.39.2

