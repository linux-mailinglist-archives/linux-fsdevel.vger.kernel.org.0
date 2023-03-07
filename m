Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2396AE2AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 15:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCGOgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 09:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCGOfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:35:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5968B337
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=41mhvkvrB0bBLLIOVbvwz5VT/I9ahbHz7mM/x4DoM28=; b=odY1pi/+EX0cHJBBQe7YoH4I2F
        49XnfZCvIJsvOdiuUGfrq+ZvUOhR7f9Ac6loLD7FC04i1U4tE534aVQhEzW46zQyIEFTI/cSp92ZI
        LPd06bNDi/GTnQ7OhQ+ppUKkP6jGjVtqeVyl5q/e58f+RxWQQQh7UY+Q7zRMzXT5vjRxzK5SdsHn2
        U7WrCyk1oSA3RWSdMuWUQvEfnF6MsBipuBQiqKZ/04MlxlQW+d+6ALNZZ4W/BlxaKDWT7GUQ5sYUh
        El3BHy7BFFf/GFns+JybtmEb4NjUGjeBn74i1ZsyKir6UTVz7+O7LaGEavPgv/5WZbQ/H2U55LKYL
        OjX2AzUg==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZYLf-000ol4-LU; Tue, 07 Mar 2023 14:31:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: remove most callers of write_one_page v4
Date:   Tue,  7 Mar 2023 15:31:22 +0100
Message-Id: <20230307143125.27778-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes most users of the write_one_page API.  These helpers
internally call ->writepage which we are gradually removing from the
kernel.

Changes since v3:
 - drop all patches merged in v6.3-rc1
 - re-add the jfs patch

Changes since v2:
 - more minix error handling fixes

Changes since v1:
 - drop the btrfs changes (queue up in the btrfs tree)
 - drop the finaly move to jfs (can't be done without the btrfs patches)
 - fix the existing minix code to properly propagate errors

Diffstat:
 fs/jfs/jfs_metapage.c   |   39 ++++++++++++++++++++++++++++++++++-----
 fs/ocfs2/refcounttree.c |    9 +++++----
 fs/ufs/dir.c            |   29 +++++++++++++++++++----------
 include/linux/pagemap.h |    6 ------
 mm/page-writeback.c     |   40 ----------------------------------------
 5 files changed, 58 insertions(+), 65 deletions(-)
