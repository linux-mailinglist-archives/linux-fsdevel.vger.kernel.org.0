Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B901F705E0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 05:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjEQDZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjEQDY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 23:24:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168AB2130
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 20:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6e3gVncYqL0+JWA6uRKnPQgmS4Ev7p8efpOspJp3ZDA=; b=b3b1PG+CUcfzfWLgesfJ+Jqr8A
        U3DJArLiZUUWtdD5o8UqybyvCNd3iqUk9qT08/A+Q8FX+RHqzDU2nPt4frB6FuwrkGoTRcE0hqMQI
        UI+hnreGare43EnSnKNivyz1SvGaM4uq+GBxO4Zg3BhU1uxXaXcQhiBHCXY/ZyLUl+SZZ0l+Or9Hr
        n113udmSbnxzLsPius2Z9fF9qTV9JLRlXnhedgQwdsXSJmP6OTX2AIVW6M1QClji00co3+7A+2IFF
        dxFMMWOtdjSOjfdXPTN/bnVVngs5G38gV7Yp4ObZYb+sAtlKeiIJ5zmFiYYHkhedBJFMsG0Gt2I5x
        xqSunyIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz7mN-004lN2-Kh; Wed, 17 May 2023 03:24:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/6] gfs2/buffer folio changes
Date:   Wed, 17 May 2023 04:24:36 +0100
Message-Id: <20230517032442.1135379-1-willy@infradead.org>
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

It probably makes most sense to take this through Andrew's tree, once
enough people have signed off on it?

Matthew Wilcox (Oracle) (6):
  gfs2: Use a folio inside gfs2_jdata_writepage()
  gfs2: Pass a folio to __gfs2_jdata_write_folio()
  gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
  buffer: Convert __block_write_full_page() to
    __block_write_full_folio()
  gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
  buffer: Make block_write_full_page() handle large folios correctly

 fs/buffer.c                 | 75 ++++++++++++++++++-------------------
 fs/gfs2/aops.c              | 66 ++++++++++++++++----------------
 fs/gfs2/aops.h              |  2 +-
 fs/ntfs/aops.c              |  2 +-
 fs/reiserfs/inode.c         |  2 +-
 include/linux/buffer_head.h |  2 +-
 6 files changed, 75 insertions(+), 74 deletions(-)

-- 
2.39.2

