Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0A3575C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhDGUTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhDGUTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:19:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C58C061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=boOZ6odN95JfQTQcrAbiRlKBjORjrvS9gOpCq1OuCqQ=; b=r4y/1Ouoczw+VPYtSXXebcjtGa
        siH9TWgbMVJT1nGUwXsZbowJ3eVrwZ4t2zrwaIVkyrz0RA3ncxccNWbLB436mNMygVM2+ZujTu4x9
        1oCvDzikkG/I5jGK4t8ENWTtic23NVSGu6lcDbQVty6CUG+obuz/R69ivPrneLORqcoIFO4Oa7ajL
        9nlUoiZHU4otXiVPleZueBQEglWdYhOiQXvPi0eWjT3bgmqLK14HspD/w4WLYhZI5dOgdhU4dBRjL
        /43/kfBwBy1OUZcValfzfW13tyS6NET0g8NSEbDPcT4Fwr5w1d03PjRMS3T4jO08Mo4RyRipaBzly
        7nx+TQIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUEde-00F23x-KJ; Wed, 07 Apr 2021 20:19:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] readahead improvements
Date:   Wed,  7 Apr 2021 21:18:54 +0100
Message-Id: <20210407201857.3582797-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As requested, fix up readahead_expand() so as to not confuse the ondemand
algorithm.  Also make the documentation slightly better.  Dave, could you
put in some debug and check this actually works?  I don't generally test
with any filesystems that use readahead_expand(), but printing (index,
nr_to_read, lookahead_size) in page_cache_ra_unbounded() would let a human
(such as your good self) determine whether it's working approximately
as designed.

This is against linux-next 20210407.

Matthew Wilcox (Oracle) (3):
  mm/filemap: Pass the file_ra_state in the ractl
  fs: Document file_ra_state
  mm/readahead: Adjust file_ra in readahead_expand

 fs/ext4/verity.c        |  2 +-
 fs/f2fs/file.c          |  2 +-
 fs/f2fs/verity.c        |  2 +-
 include/linux/fs.h      | 24 ++++++++++++++----------
 include/linux/pagemap.h | 20 +++++++++++---------
 mm/filemap.c            |  4 ++--
 mm/internal.h           |  7 +++----
 mm/readahead.c          | 25 ++++++++++++++-----------
 8 files changed, 47 insertions(+), 39 deletions(-)

-- 
2.30.2

