Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EFE5353F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348758AbiEZT3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345948AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A6B36C5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QYulGt4krpBmevJpBluzqPg1U+NZrkxxC3VbHwa6WgE=; b=WJUh4ypE6G1Ij5mGH8aq7WLwkv
        vy+qZ7YLhc2oXeneYj+mUEgA0UEJ/RmEg3r/QLSQLREU6796l9uR8n8vW1jaLgfJMHsIrnpMoQ6IL
        gUBtdwBWTqYfrad2emWtYgnV/PoRke9RoqqUkocDtDxAGE2m8ZttrUXjeF/Qh51Ek95uyjX3gIxim
        fiOo5zuUMg4zVAy/1ysrLK6EtY/PPr+ZoZMSqz+xyRQYZhmP7phtSqi/8wpTU5N1nMzlIOcJjCuiE
        Z2lBX7kP2x9+vog+jdPLvq/r9dTEGPwdlI1lzANgzpuH3UJpI8wblQfAtUcwOUrdtfy18icXqWvOh
        y+RkwvAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAa-001Uu9-Cm; Thu, 26 May 2022 19:29:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 0/9] Convert JFS to use iomap
Date:   Thu, 26 May 2022 20:29:01 +0100
Message-Id: <20220526192910.357055-1-willy@infradead.org>
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

This patchset does not work.  It will eat your filesystem.  Do not apply.

The bug starts to show up with the fourth patch ("Convert direct_IO write
support to use iomap").  generic/013 creates a corrupt filesystem and
fsck fails to fix it, which shows all kinds of fun places in xfstests
where we neglect to check that 'mount' actually mounted the filesystem.
set -x or die.

I'm hoping one of the people who knows iomap better than I do can just
point at the bug and say "Duh, it doesn't work like that".

It's safe to say that every patch after patch 6 is untested.  I'm not
convinced that I really tested patch 6 either.

Matthew Wilcox (Oracle) (9):
  IOMAP_DIO_NOSYNC
  jfs: Add jfs_iomap_begin()
  jfs: Convert direct_IO read support to use iomap
  jfs: Convert direct_IO write support to use iomap
  jfs: Remove old direct_IO support
  jfs: Handle bmap with iomap
  jfs: Read quota through the page cache
  jfs: Write quota through the page cache
  jfs: Convert buffered IO paths to iomap

 fs/iomap/direct-io.c  |   3 +-
 fs/jfs/file.c         |  56 +++++++++++++++++-
 fs/jfs/inode.c        | 128 ++++++++++++++++--------------------------
 fs/jfs/jfs_inode.h    |   2 +-
 fs/jfs/jfs_logmgr.c   |   1 -
 fs/jfs/jfs_metapage.c |   1 -
 fs/jfs/super.c        | 127 +++++++++++++++++++----------------------
 include/linux/iomap.h |   6 ++
 8 files changed, 168 insertions(+), 156 deletions(-)

-- 
2.34.1

