Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183DD51F18A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiEHUhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiEHUga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6556272
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/8ALhSHIucoa1eUJcs8QV8IEzC0ThKQLD45HwuQCVKE=; b=HhA59nV8LlvNn5Olv2vNfQU6/V
        U4iKptgo57rKvizPgCfBaq2AYsamwfbWgQQ0HG6Lmq6/RagY5hgPC9HHhpzlVlUc6i+1z5kGAjjJk
        +/HXkelk2yiRLgRzu8JBDq+MHG3/n85CaORKZ1XjMD/pPUCI6n2wtbumX8pCSi35ByRyMcSnNNbwK
        ppEJaPDTaZRzFpl6TlaXrbmT2SgY1CBFEDQLRw8qqa2krheLUbufr+GEs0RPGs1IuY88yNOR5zIb/
        +b0LxNAZsmnISWQqhg+HTLYMLRi6/8j9fA6sdYigTQ5WKhu1EczsJqpB0UBY/xXicIay9wZHEQRLs
        auov9dfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnna0-002nxs-Bt; Sun, 08 May 2022 20:32:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/4] Unify filler_t and aops->read_folio
Date:   Sun,  8 May 2022 21:32:30 +0100
Message-Id: <20220508203234.668623-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YngbFluT9ftR5dqf@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
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

Make these two function signatures the same.  This should enable more
cleanup in the future, but for now it helps ensure a bit of type safety
and cleans up the filesystems a bit.

Matthew Wilcox (Oracle) (4):
  jffs2: Pass the file pointer to jffs2_do_readpage_unlock()
  nfs: Pass the file pointer to nfs_symlink_filler()
  fs: Change the type of filler_t
  mm/filemap: Hoist filler_t decision to the top of
    do_read_cache_folio()

 fs/gfs2/aops.c          | 29 ++++++++++---------------
 fs/jffs2/file.c         |  9 ++++----
 fs/jffs2/gc.c           |  2 +-
 fs/jffs2/os-linux.h     |  2 +-
 fs/nfs/symlink.c        | 16 +++++++-------
 include/linux/pagemap.h |  6 +++---
 mm/filemap.c            | 47 +++++++++++++++++++----------------------
 7 files changed, 50 insertions(+), 61 deletions(-)

-- 
2.34.1
