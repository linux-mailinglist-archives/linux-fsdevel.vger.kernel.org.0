Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E137640494
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 11:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiLBK1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 05:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiLBK1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:27:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8126AC0;
        Fri,  2 Dec 2022 02:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=y5ud92nQf37ZqSh+JetkXlw12So9y6VeRppDRV99M7g=; b=4zgnIMqUuuHUVJitlEUYYYmcM3
        kEsixiasYAjMMM5btmQIU+Zpfae0Lkl0d/VgRiT0cVctnlluIqtGna14M5iCcdN3h0Ew0rEik2/4d
        fWLNknQ18SZSE/Ly9TVNlqNGRO7s5sTCSBfJlT7VDUzcKA0Co24ispszFFmX9PbeFYIIvjvYcYeGb
        eXqTyL7EYkd/JrlE2RK/cLP9EYCvJzudmk+wc84VuY/nGJtsLrD/ZASRSmRcHACAq/9RkrB2A6BWX
        5K/UGcRKqwfqzpiJbFmUFmGLlYSyg/Tovfe8z9j/3QLyGCwXe7Ppu+pk6A13jwtUAULbBrtWXHVe1
        1/EZJ7Ow==;
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p13Fm-00FQvi-FR; Fri, 02 Dec 2022 10:26:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: start removing writepage instances v2
Date:   Fri,  2 Dec 2022 11:26:37 +0100
Message-Id: <20221202102644.770505-1-hch@lst.de>
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

Andrew, can you pick this up through the -mm tree?

Changes since v1:
 - dropped the ext2 and udf patches that Jan merged through
   his tree
 - collected a bunch of ACKs

Diffstat:
 exfat/inode.c   |    9 ++-------
 fat/inode.c     |    9 ++-------
 hfs/inode.c     |    2 +-
 hfsplus/inode.c |    2 +-
 hpfs/file.c     |    9 ++-------
 jfs/inode.c     |    7 +------
 omfs/file.c     |    7 +------
 7 files changed, 10 insertions(+), 35 deletions(-)
