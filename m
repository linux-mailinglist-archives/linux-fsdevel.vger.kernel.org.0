Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9301D724FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbjFFWfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjFFWev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:34:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1611BDD
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=m7sCvulChVZh3qkKRAA07O+BjypE2rgiH0LpUY0B3Fw=; b=mHkNMmhtQboXl9TfrrtzFaOj/3
        6JFi4Q11pPek0QWW7yjIEI3tZJHazh8u+tw4w6C5RkofhL22/0JnNeSTg9C/s1COn+R1q2V0yTpOx
        zYG4mZ8HRAmd7/+Ok1FLriupgoFWh52KlwDUlJR6yCe3RXu6hJiUpjOpS8Hoyucz8+PaqPcgl9JF9
        ut1YpNRm9+QsPOJH9NU4qTHqyQPIVpZ50/OEjY02cBrCcZYI4uje23VdnAoXaReHFy9eI/ttdgh/k
        xzP5GjSb65qRhN76k7Q37Gw1tVmAJhXJfg1qWxIq6JUqaIIAO7ocFDITENnRyljX5Liciw7hBtCaP
        q1ktCvlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFU-00DbES-Ho; Tue, 06 Jun 2023 22:33:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 00/14] gfs2/buffer folio changes for 6.5
Date:   Tue,  6 Jun 2023 23:33:32 +0100
Message-Id: <20230606223346.3241328-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
  buffer; Convert page_zero_new_buffers() to folio_zero_new_buffers()
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

