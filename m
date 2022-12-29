Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D37D658ECC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiL2QLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 11:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiL2QLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:11:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C4BE9D;
        Thu, 29 Dec 2022 08:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/OSTms68IPUXcD9mOyJwWhvTFEvxpirJZnFVgrc7HRI=; b=mG3Xd47oTUQecGZV2lFfDakfTy
        v9T6b0WubaweFmczUE/fgvx9Ej4TE34uR+iCTgXqcWAZEtr4nOwjmIu7RgbAexm9fF0FQQClyljLk
        26JoH5gI1K+5QiVdrRypcrfvoceq4NJW/JTha943AxPSp195deUacqWMuM6Hw4hLbyFsR5+6RgEUA
        Fn1sHTGv69ttZMtXYF7gIJkwL61CE3QVKLKPdS29QXQgMpfIwoP5p45q41XYs+lhHGRJDhPj5r0sc
        mLVdGFgskkvDGn9spGCbLcJnva/V2khDSMNj+mzAJRxEDup9kUduZRBnmm9ZYAUWooRXugVtUAP2G
        kI54fxzg==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvUO-00HKOB-Uf; Thu, 29 Dec 2022 16:10:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: [PATCH 5/6] ocfs2: use filemap_fdatawrite_wbc instead of generic_writepages
Date:   Thu, 29 Dec 2022 06:10:30 -1000
Message-Id: <20221229161031.391878-6-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229161031.391878-1-hch@lst.de>
References: <20221229161031.391878-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_fdatawrite_wbc is a fairly thing wrapper around do_writepages,
and the big difference there is support for cgroup writeback, which
is not supported by ocfs2, and the potential to use ->writepages instead
of ->writepage, which ocfs2 does not currently implement but eventually
should.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ocfs2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 59f612684c5178..25d8072ccfce46 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -852,7 +852,7 @@ static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 		.range_end = jinode->i_dirty_end,
 	};
 
-	return generic_writepages(mapping, &wbc);
+	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
 
 int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
-- 
2.35.1

