Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85EE6AE2B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 15:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjCGOin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 09:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCGOiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:38:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB75690792;
        Tue,  7 Mar 2023 06:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RTYnXq37uoN394QqLGZXYttCFm6XJ3t4CN0RE75GqWc=; b=XVZIgZBZrn0Q93uK2pkRc1mWp+
        9gCJOjZYoBVFJNRU8ro2V0t26CH/xSTyIukdflnaga4hrvrmjNzPdujYYT7XUE7wZEWmCczzSjMaq
        OG4wDRC4spS+V4/0mRgQQnqCluVp4VsQ4P2qJ9IMHftoyKZvCl0P8FcsOfC3sEO98y54nuXU8TET9
        jPRU/PnmafMiAYKfdD6XY17gSfUp4Ekho3ZfNSxqLj0WkF34VNf41B0Eme0XiGp2RQZz3ySQkqA40
        88A2cxE1Ciki4Y9lp4ZwkM8ziO7d5Mn8qFF6flab40ba8inffvp61urvVx80ObLGDBkoh98GepoYK
        IDZzQnDw==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZYOL-000q28-FV; Tue, 07 Mar 2023 14:34:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: return an ERR_PTR from __filemap_get_folio v3
Date:   Tue,  7 Mar 2023 15:34:03 +0100
Message-Id: <20230307143410.28031-1-hch@lst.de>
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

__filemap_get_folio and its wrappers can return NULL for three different
conditions, which in some cases requires the caller to reverse engineer
the decision making.  This is fixed by returning an ERR_PTR instead of
NULL and thus transporting the reason for the failure.  But to make
that work we first need to ensure that no xa_value special case is
returned and thus return the FGP_ENTRY flag.  It turns out that flag
is barely used and can usually be deal with in a better way.

Note that the shmem patches in here are non-trivial and I would appreicate
a careful review from Hugh.

Changes since v2:
 - rebased to v6.3-rc which includes a couple of new callsites

Changes since v1:
 - drop the patches to check for errors in btrfs and gfs2
 - document the new calling conventions for the wrappers around
   __filemap_get_folio
 - rebased against the iomap changes in latest linux-next

Diffstat
 fs/afs/dir.c             |   10 +++----
 fs/afs/dir_edit.c        |    2 -
 fs/afs/write.c           |    4 +-
 fs/ext4/inode.c          |    2 -
 fs/ext4/move_extent.c    |    8 ++---
 fs/hugetlbfs/inode.c     |    2 -
 fs/iomap/buffered-io.c   |   11 +-------
 fs/netfs/buffered_read.c |    4 +-
 fs/nfs/file.c            |    4 +-
 fs/nilfs2/page.c         |    6 ++--
 include/linux/pagemap.h  |   15 +++++------
 include/linux/shmem_fs.h |    1 
 mm/filemap.c             |   27 ++++++++-----------
 mm/folio-compat.c        |    4 +-
 mm/huge_memory.c         |    5 +--
 mm/hugetlb.c             |    6 ++--
 mm/memcontrol.c          |    2 -
 mm/mincore.c             |    2 -
 mm/shmem.c               |   64 +++++++++++++++++++----------------------------
 mm/swap_state.c          |   17 ++++++------
 mm/swapfile.c            |    4 +-
 mm/truncate.c            |   15 +++++------
 22 files changed, 99 insertions(+), 116 deletions(-)
