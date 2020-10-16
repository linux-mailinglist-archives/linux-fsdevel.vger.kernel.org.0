Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F15290978
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410650AbgJPQO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409919AbgJPQO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:14:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED1C061755;
        Fri, 16 Oct 2020 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=A2r1qaPIFfrxY6pOJS0p2GeZCUo4+cjjTO0/Z2u8PNg=; b=QzudlnbkbsfrvMbUddT+oNa3AM
        bkGk2fQ0YpG7QyutD/NIJQYEzUM7xcc25QNTihG/5Bf8d0JCOAvP4U/CT+ACZJ6BjH7w1Tp4DE92u
        zGFBdS2CqWO7M2HSFEYvjIBSmaoqoIESL1QvFriHChn380NIbhopdAwGjn7ktq786onrTA61J1vhz
        pl3F3FcWz6QJPEAVxFSogvDrF5rMMmiUzeFvPqJ80xM6hDNX/WUwA/zDYxUedx6Gk3cKbMONgjOdz
        b+hqQTgOjuvwDj6IAeWsTGWqYcGLdDALk2l+j9cTgipXPIqU1CVHUWUnytELPR98NZhVzmLB8HZhZ
        b8dPrrsg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSN9-0005ew-PT; Fri, 16 Oct 2020 16:14:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/2] Killable synchronous BIO submission
Date:   Fri, 16 Oct 2020 17:14:24 +0100
Message-Id: <20201016161426.21715-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It would be nice to be able to report the actual errors from block devices
instead of the default -EIO.  In order to do that, we need to execute the
BIO synchronously as the only way to get the error back to the caller is
by returning it from readpage() -- we can't store it in the struct page.

But we need to be able to respond to a fatal signal, as we do today with
lock_page_killable().  This turns out to be quite hard.  The solution
I settled on is that the caller must pass in an alternate end_io to be
called asynchronously if a fatal signal arrives.

I believe the synchronize_rcu() call to be sufficient to ensure that the
old bi_end_io() will not be called.  If there are callers of bi_end_io()
from BH-enabled regions, it may not be!  Perhaps we could put a warning
in bio_endio() to make sure that's true?

Matthew Wilcox (Oracle) (2):
  block: Add submit_bio_killable
  fs: Make mpage_readpage synchronous

 block/bio.c                | 87 +++++++++++++++++++++++++++++---------
 fs/mpage.c                 | 25 +++++++++--
 include/linux/bio.h        |  1 +
 include/linux/completion.h |  1 +
 kernel/sched/completion.c  |  9 ++--
 5 files changed, 97 insertions(+), 26 deletions(-)

-- 
2.28.0

