Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B452D722D39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjFERFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjFERFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:05:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B2A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LBEHna36Uqv0DtI27xHHPAjPGLK1nkaVHaUv/vrGrqc=; b=H/yLWyeN4OqUM4cMLvEOC1taDO
        Hpa4Fe79T8Y4Y6SfisBrVTRWiQ5mpyoDtzgAYDsgPaGsbu+2uMLPGPua+IWXlicLctjfuVOBYWyR+
        TzNVy4P2Fr3yguKQH8E8xhCK0q3DWc4Ms8tclnh0ZEVjC2FhubQkQL2zT6BdXEcPpYg8J4lrd8qGE
        9qViKdZQq18AFRCSWGG6Rm5cdPx0V2s1rz/kjHQ5R5Vk7cGHjYh8BXMNJO73V/iit1QL06SFatwaY
        ZP0r6BCFNJBN7Wslh2rCt9R/saxvZkm2E9WdBtQDDBMnVXiSCzTHMv9tsUj5JXahTPxC/BVMDn/Hd
        Xc1dAm7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6Ddl-00CDQa-Eb; Mon, 05 Jun 2023 17:05:09 +0000
Date:   Mon, 5 Jun 2023 18:05:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] ubifs: Use a folio in do_truncation()
Message-ID: <ZH4VxTWB3d9oNW5X@casper.infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org>
 <20230605165029.2908304-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605165029.2908304-4-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 05:50:28PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert from the old page APIs to the new folio APIs which saves
> a few hidden calls to compound_head().

Argh.  This fix was supposed to be folded in.


diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 1b2055d5ec5f..67cf5138ccc4 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1161,7 +1161,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 		struct folio *folio;
 
 		folio = filemap_lock_folio(inode->i_mapping, index);
-		if (folio) {
+		if (!IS_ERR(folio)) {
 			if (folio_test_dirty(folio)) {
 				/*
 				 * 'ubifs_jnl_truncate()' will try to truncate
