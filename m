Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416596616F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjAHQ5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 11:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjAHQ5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:57:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A502BF7;
        Sun,  8 Jan 2023 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=n6RpjOdLAh3obh1YrtVlLsrD/ixSNbLSLNkGemSOvQw=; b=Tplevrq0ZXmD/12xpMEYpMkDac
        PbPaoxYOWR4aUh46qukYYZiFJY5/zifkTJnuWRA4Mi8AcmWcLyOYRWr8gqJ4u05mryKVzansHNKxM
        obMID6UuA/yndMNoIlVywMjiEU5hkA3R2ZeFhqCfQ4fxJrp1Nrwey5MC17pZ2F3DSa5M+m4iUoH3M
        1lMnjRF0s5/FNZaJaBUmaL9a8vzGE56rcAmXPIJyAd0+z+MpttizMi7V6AYhVwxj1atl+9lARZwK8
        BlPSlWPN6ZYEWSrsFA6Hxc7vYrW3HrPbdOrGd7h3KzkdK3isaTmzoLOSxULnZXjxe5vN4BUcjhpwj
        mAGkrozg==;
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEYyV-00ERqE-Hb; Sun, 08 Jan 2023 16:56:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: remove write_one_page / folio_write_one
Date:   Sun,  8 Jan 2023 17:56:38 +0100
Message-Id: <20230108165645.381077-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes the write_one_page API, and it's folioized
implementation as folio_write_one.  These helpers internally call
->writepage which we are gradually removing from the kernel.

For most callers there are better APIs to use, and this cleans them up.
The big questionmark is jfs, where the metapage abstraction uses the
pagecache in a bit of an odd way, and which would probably benefit from
not using the page cache at all like the XFS buffer cache, but given
that jfs has been in minimum maintaince mode for a long time that might
not be worth it.  So for now it just moves the implementation of
write_one_page into jfs instead.

Diffstat:
 fs/btrfs/volumes.c      |   50 ++++++++++++++++++++++++------------------------
 fs/jfs/jfs_metapage.c   |   39 ++++++++++++++++++++++++++++++++-----
 fs/minix/dir.c          |   30 +++++++++++++++++++---------
 fs/ocfs2/refcounttree.c |    9 ++++----
 fs/sysv/dir.c           |   29 ++++++++++++++++++---------
 fs/ufs/dir.c            |   29 ++++++++++++++++++---------
 include/linux/pagemap.h |    6 -----
 mm/page-writeback.c     |   40 --------------------------------------
 8 files changed, 122 insertions(+), 110 deletions(-)
