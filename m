Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4811C627086
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiKMQ3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMQ3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A009FE1;
        Sun, 13 Nov 2022 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zKYZfMyRptVHjTpWXdCQLIfvx+VJVihqG6A2BfSKUdg=; b=0zXulfsEPc9RMtLp8EmKdJiQeb
        R8G58ym2IKT0jPNx1fxDKWYvH0ideWHOt0wHALqprjbXdz7Dng6j+TD/edz4FZ3E0n/J1w+I4hpJ/
        l0utj3nBAKgcpNDB6VaKBHif7XHXlJyWOQUWY8wwptTonLf3bwr97FcL0KNwJrqglj21dyoH1Fcp3
        xDfGLZg4m4IC0LgzVU++0tL7TqWSBuHsL5NuHvNnVr2Ir/KFCWfak8ym8c5plD87O3HRCQTDtJLWP
        kzhL5CCMZX5SM8glBsMFh55uIChxNpWTs6jgW50N8S9eUvT9s4871eBgOdkemmASLmsb6HugHQCRA
        IG/Tvo9Q==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFr0-00CJlr-11; Sun, 13 Nov 2022 16:29:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: start removing writepage instances
Date:   Sun, 13 Nov 2022 17:28:53 +0100
Message-Id: <20221113162902.883850-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

The VM doesn't need or want ->writepage for writeback and is fine with
just having ->writepages as long as ->migrate_folio is implemented.

This series removes all ->writepage instances that use
block_write_full_page directly and also have a plain mpage_writepages
based ->writepages.

Diffstat:
 fs/exfat/inode.c   |    9 ++-------
 fs/ext2/inode.c    |    6 ------
 fs/fat/inode.c     |    9 ++-------
 fs/hfs/inode.c     |    2 +-
 fs/hfsplus/inode.c |    2 +-
 fs/hpfs/file.c     |    9 ++-------
 fs/jfs/inode.c     |    7 +------
 fs/omfs/file.c     |    7 +------
 fs/udf/inode.c     |    7 +------
 9 files changed, 11 insertions(+), 47 deletions(-)
