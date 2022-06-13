Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816E547F19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 07:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiFMFio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 01:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiFMFi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:38:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F15FD9;
        Sun, 12 Jun 2022 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4iGKXCdzOSBsnfT6PGZIBueRKnuIrW79kSxrD8/D1F8=; b=uG9AbDJFexhlocyTyg+u6QlAcS
        jLR0WwJwLc8R94lZ9B+cgiQgZWVTwWDfzpDN6WNFTjR+boyCwOLrj5CwUXutcpi/4NTV3Sg/cjoOi
        hL5MGvekXsVnmFWTvNr/RNN4MgLaLV8ltHN76cLX3aImpifyv6JdE6LegXbGct3LgrJEEjWjanKz7
        FBeWsxWYPCIOxECEToVhO9OXdggtbDGKwcTG2/7ZE/9uoSyWZ2yQL19ZGLZ5lXK6MadXjMX8DR/lX
        ispGKTd8K4aMvDpiFl3uYXsvFo3GcNKByDM/OqwWrM4f8VDUS7TfcNJvLK0g91cSwll0ugbulHdIV
        GaaRcHnQ==;
Received: from [2001:4bb8:180:36f6:f125:c38b:d3d6:ae6c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0clK-001V3f-Up; Mon, 13 Jun 2022 05:37:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev
Subject: remove the nobh helpers v2
Date:   Mon, 13 Jun 2022 07:37:09 +0200
Message-Id: <20220613053715.2394147-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series (against the pagecache for-next branch) removes the nobh
helpers which are a variant of the "normal" buffer head helpers with
special tradeoffs for machines with a lot of highmem, and thus rather
obsolete.  They pass xfstests, or in case of jfs at least get as far
as the baseline.

This might not be as nice as an actual iomap conversion, but already
removes some hairy code in the way of removing ->writepage.

Changes since v1:
 - handle non-resident data in ->writepages in ntfs3 properly

Diffstat:
 Documentation/filesystems/ext2.rst |    2 
 fs/buffer.c                        |  324 -------------------------------------
 fs/ext2/ext2.h                     |    1 
 fs/ext2/inode.c                    |   51 -----
 fs/ext2/namei.c                    |   10 -
 fs/ext2/super.c                    |    6 
 fs/jfs/inode.c                     |   18 +-
 fs/mpage.c                         |   47 -----
 fs/ntfs3/inode.c                   |    8 
 include/linux/buffer_head.h        |    8 
 include/linux/mpage.h              |    2 
 11 files changed, 32 insertions(+), 445 deletions(-)
