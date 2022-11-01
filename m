Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFCB615310
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 21:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKAUSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKAUSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CD1E739
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XddZtvz12J4PMqNOwHFEtGYxr2XJiGYYUDkBLtVIa84=; b=fRmojCXnjXwbuUooW2EtCQXx7p
        yWceOvYeY17kHKsyQ28KXZEDtOZGLZSptlglQPgBdCz0xTBTG+bQEH19r8erHSkn7rnzk2Kh3V7++
        niRSIaMl0PcU8RUREV1agU0aU81sZ9ZlZXKA7PBEQTy3mZ2EnqA4rBeide4gnDHu159XNITYXK0km
        kcSj8q0zgqfHoxSbi1dnycg/ukzPcaG1ZDJMC6x9moS6Ao05uAx+rf4FlcBk8XTk5SDQQUgifmB0p
        cGEoZpVxAFcXAKGJBrGiscIE9PnzKtGTP5GTOazlTRZwS+DcFD6gRRprrAF4wj9qKka//dqOog6ic
        Vy4Qf6Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opxiP-004uUS-Jy; Tue, 01 Nov 2022 20:18:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/2] Mapping an entire folio
Date:   Tue,  1 Nov 2022 20:18:26 +0000
Message-Id: <20221101201828.1170455-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I had intended to write and test one user before sending this out,
but Dave Howells says he has a user now that wants this functionality,
so here we go.  It is only compile tested.

Earlier thread on this: https://lore.kernel.org/all/YvvdFrtiW33UOkGr@casper.infradead.org/

v2:
 - Remove spurious blank line change in highmem.h (David Howells)
 - Insert missing "else" in folio_unmap_local() (Hyeonggon Yoo)
 - Use vm_unmap_ram() instead of vunmap() in folio_unmap_local() (Hyeonggon Yoo)
 - Factor vmap_alloc() out of vm_map_ram() (Uladzislau Rezki)

Matthew Wilcox (Oracle) (2):
  vmalloc: Factor vmap_alloc() out of vm_map_ram()
  mm: Add folio_map_local()

 include/linux/highmem.h | 40 ++++++++++++++++++++++
 include/linux/vmalloc.h |  6 ++--
 mm/vmalloc.c            | 73 +++++++++++++++++++++++++++++++----------
 3 files changed, 99 insertions(+), 20 deletions(-)

-- 
2.35.1

