Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266C770936B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjESJhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjESJg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:36:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDA1985;
        Fri, 19 May 2023 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b3wyyoN4jHO/Zsak1kxh+5wE+B9r8QbYeNrqiPeGC/c=; b=4xTOmJL4SZkwf23SC5mh6Q9d6w
        8QH+KDswZ+2G1P8ZxhVXqL1acWhwalcFL5gjcp3rESRLiy81SrWQdPrUu152ypZAPtBDcl6X36MA4
        vAst5eyD9qhG/KfmnSBIFG+NF9yhRKBBRmZNaI8vIy17R3fThdmR69/MqckQ4qgUCNeZGKzTMMcVz
        2TqWKRcmurv0ffpUIKtLL9SAnCsvVJYqK3Vxy9oIZEp1JM7CCl6kyRl1OEtwAtY0TDaY3+gbGMQ56
        XaESPbY0EvWVD3HutDMlMkv/S0olqmVZSZKfI3fMnDixVDyZ4fUPizXA+cgLmqQiMzDCVIdTZlqTA
        VDm5obdg==;
Received: from [2001:4bb8:188:3dd5:e8d0:68bb:e5be:210a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzwWC-00FjZy-2X;
        Fri, 19 May 2023 09:35:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: cleanup the filemap / direct I/O interaction
Date:   Fri, 19 May 2023 11:35:08 +0200
Message-Id: <20230519093521.133226-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series cleans up some of the generic write helper calling
conventions and the page cache writeback / invalidation for
direct I/O.  This is a spinoff from the no-bufferhead kernel
project, for while we'll want to an use iomap based buffered
write path in the block layer.

diffstat:
 block/fops.c            |   18 ----
 fs/ceph/file.c          |    6 -
 fs/direct-io.c          |   10 --
 fs/ext4/file.c          |   12 ---
 fs/f2fs/file.c          |    3 
 fs/fuse/file.c          |   47 ++----------
 fs/gfs2/file.c          |    7 -
 fs/iomap/buffered-io.c  |   12 ++-
 fs/iomap/direct-io.c    |   88 ++++++++--------------
 fs/libfs.c              |   36 +++++++++
 fs/nfs/file.c           |    6 -
 fs/xfs/xfs_file.c       |    7 -
 fs/zonefs/file.c        |    4 -
 include/linux/fs.h      |    7 -
 include/linux/pagemap.h |    4 +
 mm/filemap.c            |  184 +++++++++++++++++++++---------------------------
 16 files changed, 190 insertions(+), 261 deletions(-)
