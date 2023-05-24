Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC570EDF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbjEXGih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbjEXGi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:38:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EFE1A2;
        Tue, 23 May 2023 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=K9OEPJ2y3KxK8hidKUbR1VTmLyisnYu63lotaUlNLQ0=; b=CFiG2Q5L3DvHhEcpxN6g3y+JyV
        +tQ8c9Awg3kiw/SwdIx0p5BORgK7UZGke6R3QxRMAkvW7r5o3wBvKl28CD/3dL4iSHIzO0QFZImSA
        X42haKCpdJPr0YrkOlcUG1HqZmGRgUAtbY/8CVMLUpxL6lYFR6L5N6WnqZH8jxu95M4+6MoMOsxbC
        r2rzMa2jnwltxxtusffO4jQuetKUyibfCw6hr4zFn5VIwRRJJZjd67gnb959dnBOHCyQg5CB9W8KM
        Vr07iDJ7eGFgC82+sQ5mjuwn3tWaNc3aheOsZeGE8wJIfEWME+IpDNCyhXoFN/JwELVRRZDnqh6tr
        5QD3qMJg==;
Received: from [2001:4bb8:188:23b2:cbb8:fcea:a637:5089] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1i8T-00CVeK-1p;
        Wed, 24 May 2023 06:38:13 +0000
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
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: cleanup the filemap / direct I/O interaction v2
Date:   Wed, 24 May 2023 08:37:59 +0200
Message-Id: <20230524063810.1595778-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series cleans up some of the generic write helper calling
conventions and the page cache writeback / invalidation for
direct I/O.  This is a spinoff from the no-bufferhead kernel
project, for which we'll want to an use iomap based buffered
write path in the block layer.

Changes since v1:
 - remove current->backing_dev_info entirely
 - fix the pos/end calculation in direct_write_fallback
 - rename kiocb_invalidate_post_write to
   kiocb_invalidate_post_direct_write
 - typo fixes

diffstat:
 block/fops.c            |   18 ----
 fs/btrfs/file.c         |    6 -
 fs/ceph/file.c          |    6 -
 fs/direct-io.c          |   10 --
 fs/ext4/file.c          |   11 --
 fs/f2fs/file.c          |    3 
 fs/fuse/file.c          |   36 +++-----
 fs/gfs2/file.c          |    6 -
 fs/iomap/buffered-io.c  |    9 +-
 fs/iomap/direct-io.c    |   88 ++++++++-------------
 fs/libfs.c              |   36 ++++++++
 fs/nfs/file.c           |    6 -
 fs/ntfs/file.c          |    2 
 fs/ntfs3/file.c         |    3 
 fs/xfs/xfs_file.c       |    6 -
 fs/zonefs/file.c        |    4 
 include/linux/fs.h      |    7 -
 include/linux/pagemap.h |    4 
 include/linux/sched.h   |    3 
 mm/filemap.c            |  194 +++++++++++++++++++++---------------------------
 20 files changed, 193 insertions(+), 265 deletions(-)
