Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A046A72D17E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbjFLVFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbjFLVEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8E4216
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=txt62ANlIkQygLpGavEyhBItsoRiI+JGiyGc+VsF2/I=; b=tV6The7lOFSZXGB14T35A5+EPO
        UsO8P5kjU2Ho3f1ASnPWU5NsccZhU6UlkxX7KswhXhsKk3da34R2ShBfTAK2r0FPy20I9Hmz7dtIE
        NOJQrSXg8tRIfmMzignb6CdfppMxMjgL3tG3xpoNKz6V45WMmB1Mr+vUtFSkcuAuSoWi1SXF8nIZp
        FyOHnzJ01QKsYZ7VPkQ7C2aJgu2al8vl1QR42nGxJfC7QflFVFav0aSTHtPjQBlIHxHMo2sMnd0JO
        u3Gi1m6NNihgUSYHHJlSqzyHKTl/Jnv4XPpGoR/Szex7qgN5Nhca9ucwOg6mevbIfhVtJZhMvxEl5
        IKSMmaVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofW-0033wc-R9; Mon, 12 Jun 2023 21:01:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 00/14] gfs2/buffer folio changes for 6.5
Date:   Mon, 12 Jun 2023 22:01:27 +0100
Message-Id: <20230612210141.730128-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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

This kind of started off as a gfs2 patch series, then became entwined
with buffer heads once I realised that gfs2 was the only remaining
caller of __block_write_full_page().  For those not in the gfs2 world,
the big point of this series is that block_write_full_page() should now
handle large folios correctly.

Andrew, if you want, I'll drop it into the pagecache tree, or you
can just take it.

v3:
 - Fix a patch title
 - Fix some checks against i_size to be >= instead of >
 - Call folio_mark_dirty() instead of folio_set_dirty()

Matthew Wilcox (Oracle) (14):
  gfs2: Use a folio inside gfs2_jdata_writepage()
  gfs2: Pass a folio to __gfs2_jdata_write_folio()
  gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
  buffer: Convert __block_write_full_page() to
    __block_write_full_folio()
  gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
  buffer: Make block_write_full_page() handle large folios correctly
  buffer: Convert block_page_mkwrite() to use a folio
  buffer: Convert __block_commit_write() to take a folio
  buffer: Convert page_zero_new_buffers() to folio_zero_new_buffers()
  buffer: Convert grow_dev_page() to use a folio
  buffer: Convert init_page_buffers() to folio_init_buffers()
  buffer: Convert link_dev_buffers to take a folio
  buffer: Use a folio in __find_get_block_slow()
  buffer: Convert block_truncate_page() to use a folio

 fs/buffer.c                 | 257 ++++++++++++++++++------------------
 fs/ext4/inode.c             |   4 +-
 fs/gfs2/aops.c              |  69 +++++-----
 fs/gfs2/aops.h              |   2 +-
 fs/ntfs/aops.c              |   2 +-
 fs/reiserfs/inode.c         |   9 +-
 include/linux/buffer_head.h |   4 +-
 7 files changed, 172 insertions(+), 175 deletions(-)

-- 
2.39.2

