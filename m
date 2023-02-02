Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594DD688865
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 21:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBBUok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 15:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjBBUog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:44:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A47D9E;
        Thu,  2 Feb 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=N5DDGPQCQApO6zBKJzZWPvZ6faGorf6EH2GURRa+zbA=; b=f4UYhP5SSJPpuEBQlMz7006pDd
        WeQsd33O7QvKUktKYkseuuQqIsrRzMbMano2OEp7/OVp1r4Ju5WDAzuV18VtLzT1zpKgn8X3LiS+X
        0KZ440PySw2UE0+App6GnHcRpyR1dv6db6hSXFy10sM/IrIvqjprUdz1/eMCYBlcPNdK62mwSV4Qo
        fWcmX/9pX+GGhMX3t9j4AI+3LzBfgZQywwgfU8HlnpzVU2kTuewBcClrYN230HBQ8fY8ayQUEM4e7
        hUvYLBXkHgKja0q7ZQVy1jDr9XdCj/gydOTLtWUeEBJt41cTkeTBvK7mPXfYvHbapXcjikAganER/
        KyJPX82A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNgRa-00Di7J-HD; Thu, 02 Feb 2023 20:44:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 0/5] Fix a minor POSIX conformance problem
Date:   Thu,  2 Feb 2023 20:44:22 +0000
Message-Id: <20230202204428.3267832-1-willy@infradead.org>
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

POSIX requires that on ftruncate() expansion, the new bytes must read
as zeroes.  If someone's mmap()ed the file and stored past EOF, for
most filesystems the bytes in that page will be not-zero.  It's a
pretty minor violation; someone could race you and write to the file
between the ftruncate() call and you reading from it, but it's a bit
of a QOI violation.  

I've tested xfs (passes before & after), ext4 and tmpfs (both fail
before, pass after).  Testing from other FS developers appreciated.
fstest to follow; not sure how to persuade git-send-email to work on
multiple repositories

Matthew Wilcox (Oracle) (5):
  truncate: Zero bytes after 'oldsize' if we're expanding the file
  ext4: Zero bytes after 'oldsize' if we're expanding the file
  tmpfs: Zero bytes after 'oldsize' if we're expanding the file
  afs: Zero bytes after 'oldsize' if we're expanding the file
  btrfs: Zero bytes after 'oldsize' if we're expanding the file

 fs/afs/inode.c   | 2 ++
 fs/btrfs/inode.c | 1 +
 fs/ext4/inode.c  | 1 +
 mm/shmem.c       | 2 ++
 mm/truncate.c    | 7 +++++--
 5 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.35.1

