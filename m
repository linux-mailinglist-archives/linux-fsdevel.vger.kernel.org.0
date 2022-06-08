Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2515436CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbiFHPN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243520AbiFHPMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:12:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23DF51580;
        Wed,  8 Jun 2022 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rgqoGQEPuGySXdQMGxM8jwQfjueapzW0nSo9VnuwjIc=; b=abPFe16yTSqRoZ8mtpEcykWTsp
        gC7b3qW+iZYlBBV0Z4nLU+1qVb+u9n9uLU07M00D0/tvJH40ZtXGoJY99/0KA8TZNDwzvicV6zE75
        L2/hLKARFAk0JKGmYbhmADfZF/k5UpwwqiZiI6MW+VDlRcupg4mi2YzenuzZ2es/YRSfoaTLVEdYf
        n+C0YowC3ziOx2BsDsTSHjxz7542GDmOcf1Gy8Oz4xMRTHW8Jsb99szyuLGfz97A2EyX0H3b5GPeQ
        FE6QTbLmAPPn4HRN/F4OVG/jPpctv96fhoM7yt5LTp8e45VxHBuR5k8zGDthyyULiHX62GbvhgY9/
        i8JEu6wg==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxEs-00DtE0-4T; Wed, 08 Jun 2022 15:04:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: remove the nobh helpers
Date:   Wed,  8 Jun 2022 17:04:46 +0200
Message-Id: <20220608150451.1432388-1-hch@lst.de>
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

Diffstat:
 Documentation/filesystems/ext2.rst |    2 
 fs/buffer.c                        |  324 -------------------------------------
 fs/ext2/ext2.h                     |    1 
 fs/ext2/inode.c                    |   51 -----
 fs/ext2/namei.c                    |   10 -
 fs/ext2/super.c                    |    6 
 fs/jfs/inode.c                     |   18 +-
 fs/mpage.c                         |   47 -----
 include/linux/buffer_head.h        |    8 
 include/linux/mpage.h              |    2 
 10 files changed, 29 insertions(+), 440 deletions(-)
