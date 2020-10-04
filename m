Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81EA282C3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 20:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgJDSFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgJDSEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:04:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190EC0613CE;
        Sun,  4 Oct 2020 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kq60hyf/JkVss6PLFja6RwjmdK1h2wopBDD0M0MxutQ=; b=HTM6IuREa2NKfNjD/1XHN4bmam
        asXq+hMHbW3IIMoYqhQ2hB5WpfrcCG6+YI/KOZlt0XYJBdycvCd+N6fKqCdAhgb8NYHU7c1MqPvDb
        bAcV3/0kJ8WQQ8sljWxsaHW06a8/FmGl8z7IHhKQqqhPcZTkMndg+S6OaVY1Na4jz0JoOrmnjndSZ
        YCKHQk/F952Sl76JYLmtLX1wj2HGWcOqT9UHx+D8PCdcyAtgFP60Fw6IoL29kHQMWum0kb4mpEsA9
        7q1lbKApiGGqiXkaM2motFy2ejSLJrzvyUOUhcUaw5dRknYlNOqITO8WwkOkiIvTthqzHXCHxW4+e
        7GDCOIfw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kP8N4-0003mV-Po; Sun, 04 Oct 2020 18:04:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, ericvh@gmail.com,
        lucho@ionkov.net, viro@zeniv.linux.org.uk, jlayton@kernel.org,
        idryomov@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-btrfs@vger.kernel.org,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH 0/7] Fix a pile of 4GB file problems on 32-bit
Date:   Sun,  4 Oct 2020 19:04:21 +0100
Message-Id: <20201004180428.14494-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I caught a bug in my own code where I forgot to cast to loff_t before
shifting.  So I thought I'd grep around and see if I could find any
other occurrences.  I found a few that were clearly bugs, and they're
fixed below.  There are other places where we don't cast, and I think
they're OK.  For example, some places we have a 'nr_pages' being shifted
by PAGE_SHIFT, and that's probably OK because it's probably a single I/O.

Also, I didn't touch AFFS or ROMFS or some other filesystems which
probably have never seen a 4GB file in their lives.  Might be worth
fixing to be sure nobody copies bad code from them, but not worth cc'ing
stable for.

I didn't look for SECTOR_SHIFT or SECTOR_SIZE (or bare 9/512), just
PAGE_SIZE and PAGE_SHIFT.

I can't find a GCC warning to enable for this pattern, so I filed
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97287

Matthew Wilcox (Oracle) (7):
  9P: Cast to loff_t before multiplying
  buffer: Promote to unsigned long long before shifting
  ceph: Promote to unsigned long long before shifting
  ocfs2: Promote to unsigned long long before shifting
  btrfs: Promote to unsigned long long before shifting
  btrfs: Promote to unsigned long long before shifting
  btrfs: Promote to unsigned long long before multiplying

 fs/9p/vfs_file.c  |  4 ++--
 fs/btrfs/ioctl.c  |  6 +++---
 fs/btrfs/raid56.c |  2 +-
 fs/btrfs/scrub.c  | 25 ++++++++++++++++---------
 fs/buffer.c       |  2 +-
 fs/ceph/addr.c    |  2 +-
 fs/ocfs2/alloc.c  |  2 +-
 7 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.28.0

