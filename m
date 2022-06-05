Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C153DC41
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbiFEOi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiFEOi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:38:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25EA95B1;
        Sun,  5 Jun 2022 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cxz9vtDg6tQp33UVqRoZm+qra1+zb3h6BmXcevlS8kw=; b=MF3TfzT4Wexo7WfhudlQCzBRXq
        9ocyabD851lHuXfVbCJygE+JDdrImD3bgjctsUVRFMW6+orsrdS34q02RC73YRjnVZdbVfaMsXlQE
        bVit62RUfmuX2wLChWhG0P5zC0AUZqP3uFqdiM4KuTnPYn8FLPNT+0+otk8wH8CvJM+qD84RYz04b
        Bi4XeJ74lkO3exoVYwVqCmKtF1ICuHfD9J45z8CDAtwq6zvZvDShH3EkuN+ssNjNclb4xkTgJr8KH
        +BivtsxEnuvmxtNqeP7gUF0LOhnaqCvjGne9Pvn3f+WZgcVfANMoyV238YiB5eVl98OviuS1U5ofl
        CvzQUQYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxrOU-009mNo-JT; Sun, 05 Jun 2022 14:38:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Cache quota files in the page cache
Date:   Sun,  5 Jun 2022 15:38:12 +0100
Message-Id: <20220605143815.2330891-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
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

I don't really want to be working on this ... I'm a bit outside my zone
of knowledge here, and I'd much rather be working on folio conversions.
It mostly works, but a full xfstests run dies, probably from a memory
leak.

Matthew Wilcox (Oracle) (3):
  quota: Prevent memory allocation recursion while holding dq_lock
  quota: Support using the page cache for quota files
  ext4: Use generic_quota_read()

 fs/ext4/super.c          | 81 ++++++++++------------------------------
 fs/quota/dquot.c         | 77 ++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       |  2 +
 include/linux/quotaops.h |  1 +
 4 files changed, 100 insertions(+), 61 deletions(-)

-- 
2.35.1

