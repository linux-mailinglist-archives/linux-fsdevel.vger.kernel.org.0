Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8144D6EB3CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjDUVo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjDUVoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A392116;
        Fri, 21 Apr 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LRGm8v+C2VnFh3pJYXzbKwj2NvliqmXVbLHOoz9D9rs=; b=Gv4xXUfwg6Tqrov7HtOq12Iot5
        YO5wR1wBRRe+FoidC8runo8IO16BDwaMfjnowR194HePAotck078Dc52Y5LhgHsJWaSdFz/ExDOoW
        7UvJg+gaENVFRZFuUklS2jbQPIu6sP031vvUKDVO8op0VWHJ/pcNAbKtxQ6EJtE3JOGWA8i9aCI4G
        c82Y5dwvzAyUa4CC4Jt/QPxPn6XSF0jejQ+JpFEAjr1mjFYM6xQTv/oz9ZsmadJRNPxXXDoGL2kGk
        x5ARZON7gmkNiGzDhbMd8jQFJ5x3RYgTnUCgMJhDF50jxO3kH/6kEmfu6+iJAJL3r0nsysDSme+ZO
        aDY1SY0g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btou-2Z;
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
Subject: [RFC 7/8] shmem: add high order page support
Date:   Fri, 21 Apr 2023 14:43:59 -0700
Message-Id: <20230421214400.2836131-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421214400.2836131-1-mcgrof@kernel.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
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

To support high order block sizes we want to support a high order
folios so to treat the larger block atomically. Add support for this
for tmpfs mounts.

Right now this produces no functional changes since we only allow one
single block size, matching the PAGE_SIZE and so the order is always 0.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a64efd1f3c2..740b4448f936 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1621,9 +1621,15 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
 {
 	struct vm_area_struct pvma;
 	struct folio *folio;
+	struct inode *inode = &info->vfs_inode;
+	struct super_block *i_sb = inode->i_sb;
+	int order = 0;
+
+	if (!(i_sb->s_flags & SB_KERNMOUNT))
+		order = i_sb->s_blocksize_bits - PAGE_SHIFT;
 
 	shmem_pseudo_vma_init(&pvma, info, index);
-	folio = vma_alloc_folio(gfp, 0, &pvma, 0, false);
+	folio = vma_alloc_folio(gfp, order, &pvma, 0, false);
 	shmem_pseudo_vma_destroy(&pvma);
 
 	return folio;
-- 
2.39.2

