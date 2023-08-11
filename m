Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A4779414
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjHKQPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjHKQPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:15:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DFF2694;
        Fri, 11 Aug 2023 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/SgsMibri9UER3bCvfxitKCEIq/eI1Hjbt8i8axvil0=; b=rXg+L9YttUI4wMHcDVF5lapTgj
        Io4fgj7Nqkg9taPr7lHlNxpUkq+13bnMtYfYYcQz0MBOXB56GQUHUTABoxv8U5qEjKgM0C1ypJIJV
        u94/+DLuitS6Si0GGVILTLORaFKi1wlSzVF+hD2G/jb+AqDqHrPlY4vghUZCqxNF9rq9G3Qdrkb0A
        I/34BpF8PdADWIiGGjW3ia+pddf8kpVimk98qHy/oMGM50iPb8DSU8NocH4FEL3XkQiMn1Be/S7LN
        SXakB4UomwPE4MY/LgsovJV/HSvvfKUS4CTTcjO1DVOU5kGSZikrfCKEgxtS2R2SyYnkM5YQNLcYV
        lJ+A/IjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUUnS-0027kU-TC; Fri, 11 Aug 2023 16:15:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH 0/3] Add and use bdev_getblk()
Date:   Fri, 11 Aug 2023 17:15:25 +0100
Message-Id: <20230811161528.506437-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series fixes a bug reported by Hui Zhu; see proposed
patches v1 and v2:
https://lore.kernel.org/linux-fsdevel/20230811035705.3296-1-teawaterz@linux.alibaba.com/
https://lore.kernel.org/linux-fsdevel/20230811071519.1094-1-teawaterz@linux.alibaba.com/

I decided to go in a rather different direction for this fix, and
fix a related problem at the same time.  I don't think there's any
urgency to rush this into Linus' tree, nor have I marked it for stable.
Reasonable people may disagree.

Matthew Wilcox (Oracle) (3):
  buffer: Pass GFP flags to folio_alloc_buffers()
  buffer: Hoist GFP flags from grow_dev_page() to __getblk_gfp()
  ext4: Use bdev_getblk() to avoid memory reclaim in readahead path

 fs/buffer.c                 | 75 +++++++++++++++++++++++--------------
 fs/ext4/super.c             |  3 +-
 include/linux/buffer_head.h |  4 +-
 3 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.40.1

