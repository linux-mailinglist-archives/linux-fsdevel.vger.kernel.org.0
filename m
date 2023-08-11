Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613B77797AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjHKTXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHKTXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:23:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C0120;
        Fri, 11 Aug 2023 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SCjfE0ihVcOKQWLIcU8GEL15xW0kjppT5rqoPuDlnqU=; b=GzoTSGKJWneXfmwmwJytS9bRLm
        yuwJ6wSD5oilzUyqu9EYqjwALMw3krzY9689khfPDLvDqU8cdWrTWkcwzU6+/ghc4sp/5ZTrrwke6
        I8EaRWP3PJKgKNw0BDEur913Z0/1OAWthjSBwj0jcCPHN3elDWqiVmt2129ugispTm+GTPjdMsN/A
        gE16a1FOese/e1VWbqNfd1Qk+jmCXtehmwtNnyAsRaULoNOwBRux8lAvxptPOaRxMtAzvpscsIMDz
        o1lMBoysZ53LM9o1znL/Beq4BjsS+wyFdk65021lvKyjORnouttYzMgwZihSqfsZpsNZsfQ/Nm9SM
        2+oJAZzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUXj7-002vvW-41; Fri, 11 Aug 2023 19:23:13 +0000
Date:   Fri, 11 Aug 2023 20:23:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH 4/3] buffer: Use bdev_getblk() in __breadahead()
Message-ID: <ZNaKoWbYyOveesVc@casper.infradead.org>
References: <20230811161528.506437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811161528.506437-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


It occurs to me that this would also be useful and I'll include it in
the next version:

diff --git a/fs/buffer.c b/fs/buffer.c
index 122b7d16befb..b551a5b1196b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1470,7 +1470,9 @@ EXPORT_SYMBOL(__getblk_gfp);
  */
 void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 {
-       struct buffer_head *bh = __getblk(bdev, block, size);
+       struct buffer_head *bh = bdev_getblk(bdev, block, size,
+                       GFP_NOWAIT | __GFP_MOVABLE | __GFP_ACCOUNT);
+
        if (likely(bh)) {
                bh_readahead(bh, REQ_RAHEAD);
                brelse(bh);



