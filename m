Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC646764A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjAUG6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAUG6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:58:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B913344B;
        Fri, 20 Jan 2023 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o5i5qXxICSG+cq4jO8TGXskNtUwwrBBqvoBV9YksFl0=; b=WOXQpn1PzakC+RFN34/XzUonXP
        vsoTRXKMhhTh26lIMHpqZJCj89ilMzL9Xs9wuuOgcKtvV4w7MNLKQ24CYHAmpB7yKqLM9N2sObTUq
        C3atVe/a0mm/s2AFxCA3H4HDAbsOdwh1j1HF0GKBTpIaBh0MKmsv040zNn/2nMVy/bIE2x/B1PAtJ
        5LQq9MjNF9Td8J/WqI13GW1GkKbc8hl/wa0C4JIGvGU1KDiDq13qGaCMLPK7aUb09i2TcD6ByW4+3
        mlDvAbBEJ+VGbuw628D7djrokVdfqZbOirBrNjGQmL8Q7vdXaHGVHqotN7Z00B3pMNKCRjhh93Qcz
        ONM5PLwA==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7p7-00DSLx-RA; Sat, 21 Jan 2023 06:57:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: return an ERR_PTR from __filemap_get_folio v2
Date:   Sat, 21 Jan 2023 07:57:48 +0100
Message-Id: <20230121065755.1140136-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

__filemap_get_folio and its wrappers can return NULL for three different
conditions, which in some cases requires the caller to reverse engineer
the decision making.  This is fixed by returning an ERR_PTR instead of
NULL and thus transporting the reason for the failure.  But to make
that work we first need to ensure that no xa_value special case is
returned and thus return the FGP_ENTRY flag.  It turns out that flag
is barely used and can usually be deal with in a better way.

Note that the shmem patches in here are non-trivial and need some
careful review and testing.

Changes since v1:
 - drop the patches to check for errors in btrfs and gfs2
 - document the new calling conventions for the wrappers around
   __filemap_get_folio
 - rebased against the iomap changes in latest linux-next

Diffstat
 fs/afs/dir.c             |   10 +++----
 fs/afs/dir_edit.c        |    2 -
 fs/afs/write.c           |    4 +-
 fs/btrfs/disk-io.c       |    2 -
 fs/ext4/inode.c          |    2 -
 fs/ext4/move_extent.c    |    8 ++---
 fs/hugetlbfs/inode.c     |    2 -
 fs/iomap/buffered-io.c   |   15 +----------
 fs/netfs/buffered_read.c |    4 +-
 fs/nilfs2/page.c         |    6 ++--
 include/linux/pagemap.h  |   15 +++++------
 include/linux/shmem_fs.h |    1 
 mm/filemap.c             |   27 ++++++++-----------
 mm/folio-compat.c        |    4 +-
 mm/huge_memory.c         |    5 +--
 mm/memcontrol.c          |    2 -
 mm/mincore.c             |    2 -
 mm/shmem.c               |   64 +++++++++++++++++++----------------------------
 mm/swap_state.c          |   17 ++++++------
 mm/swapfile.c            |    4 +-
 mm/truncate.c            |   15 +++++------
 21 files changed, 94 insertions(+), 117 deletions(-)
