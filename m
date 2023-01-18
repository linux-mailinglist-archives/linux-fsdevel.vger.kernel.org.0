Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673A967192E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjARKkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjARKkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:40:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EC1C4EB8;
        Wed, 18 Jan 2023 01:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ewY31mbHxOfBtCPdgdKzYjQ0wPkqac5AmSjDkb40tFw=; b=mSCDCWinUY/HS19oiHLIYU7HTJ
        xzmM8Qtfxh3HIuymTISooTmX6MPgoflOa0QEqARdl58+fsr8DnAM2OmWVtGDhwxK56ZTcXRoTQBYc
        N7fS0PP9RlpPUqBe8Z+JfSMNivMFeCH8O7mEix/D9DJC2FhilwruTYNIfFp2CAtuxiaCqX8cB8ypc
        i6fXmBJvEW6wRvYpqVZjOFWDrJdIQ7/z/dJm65mWiD83UIjIo8LqP0ZpBFAIe1yPaI115hKSn+ooa
        r/wDnRGHqtfS0o2zlJoQ8uewHgGSm9sJ9WvQUpk1dqyVo0wKkPBdMHEn+BtUTrCt3neypSrdkLX+J
        OaMKoOxQ==;
Received: from 213-147-167-250.nat.highway.webapn.at ([213.147.167.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI4zN-000ABI-Gv; Wed, 18 Jan 2023 09:44:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: handle a NULL folio in extent_range_redirty_for_io
Date:   Wed, 18 Jan 2023 10:43:28 +0100
Message-Id: <20230118094329.9553-9-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118094329.9553-1-hch@lst.de>
References: <20230118094329.9553-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_get_folio can return NULL, skip those cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d55e4531ffd212..a54d2cf74ba020 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -230,6 +230,8 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 
 	while (index <= end_index) {
 		folio = filemap_get_folio(mapping, index);
+		if (!folio)
+			continue;
 		filemap_dirty_folio(mapping, folio);
 		folio_account_redirty(folio);
 		index += folio_nr_pages(folio);
-- 
2.39.0

