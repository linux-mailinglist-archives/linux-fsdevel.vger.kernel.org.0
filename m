Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F075B0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjGTOFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGTOFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:05:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B57132;
        Thu, 20 Jul 2023 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r6VPyu9gsZuH8VJquNMO+URB3eVHSlazkIbeLhLt+jY=; b=anw34U13y7O9T4LymqzZz9xQtJ
        k+/enaW+JpCm3OEJhNKlx2w+Ni8L2Luy9FamN3UndB2S67Cf77Rychmh9l7eB1AhZuXb6CYz1+1g+
        h6+KbKc6Un6+biqn42qgftFra2bfIrgEo+FeJpJJt4Pj+whPgbg1BFsPInxvH8FpJA4Ra6Z6F+2kR
        VRpCYKFUOoEiw9nvPIHPNZEpG7TgotBdka4TJ+dA+yADs/BZFpTpzRnk74gD+eNEeCC2zyw7afK4t
        jfsRh+bHFpb59/r6lPphmzSF9Ii5KcXXkW5EVyOIZRzR8DkMG3wKVukMq95nJSpg9qUF9CFbI+e9V
        itFDCzRQ==;
Received: from [2001:4bb8:19a:298e:a587:c3ea:b692:5b8d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMUH0-00BKni-2b;
        Thu, 20 Jul 2023 14:04:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: allow building a kernel without buffer_heads
Date:   Thu, 20 Jul 2023 16:04:46 +0200
Message-Id: <20230720140452.63817-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series allows to build a kernel without buffer_heads, which I
think is useful to show where the dependencies are, and maybe also
for some very much limited environments, where people just needs
xfs and/or btrfs and some of the read-only block based file systems.

It first switches buffered writes (but not writeback) for block devices
to use iomap unconditionally, but still using buffer_heads, and then
adds a CONFIG_BUFFER_HEAD selected by all file systems that need it
(which is most block based file systems), makes the buffer_head support
in iomap optional, and adds an alternative implementation of the block
device address_operations using iomap.  This latter implementation
will also be useful to support block size > PAGE_SIZE for block device
nodes as buffer_heads won't work very well for that.

Note that for now the md software raid drivers is also disabled as it has
some (rather questionable) buffer_head usage in the unconditionally built
bitmap code.  I have a series pending to make the bitmap code conditional
and deprecated it, but it hasn't been merged yet.

Changes since v1:
 - drop the already merged prep patches
 - depend on FS_IOMAP not IOMAP
 - pick a better new name for block_page_mkwrite_return
