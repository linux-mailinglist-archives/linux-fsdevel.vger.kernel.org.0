Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814DA76BB08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjHARWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjHARWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:22:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E7213E;
        Tue,  1 Aug 2023 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KI7aWHvSDXmhxzHfaalEHg4CqR1G5kysSfQhkQhMeeQ=; b=qLtl8QrLHzZR3bYK8L7GyySX8I
        ui/iPrQEaxDZ2ZfzYU1SSMTdWMhYkH2FZalEJBLrDXxNFoxLyiD+GaUFKCZtShgsGlroNSM1mewkz
        +K/5Jr4SSllO2UPuk94IptV+69fj7W5EzAdX/LSLm+iTyTRDAoc9qtXJQ+EMnVvG7gkK9vU9FkQ0r
        NaOSrDyin3BImtyOJRNdcR2ARCfAsk+XaJq0t65rk7g31lgKcxWP7BClvjbC1USYJoOzx2Bkv7Jqb
        s/Fj+GkFQtVxuKUX/FEtRMkAUM2OUYp0VnZF8342fy2gBxlRZw8VAauLrGHX/slpc1KmP7X/xB17c
        1PuKU2JQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQt4P-002uSp-2j;
        Tue, 01 Aug 2023 17:22:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: allow building a kernel without buffer_heads v3
Date:   Tue,  1 Aug 2023 19:21:55 +0200
Message-Id: <20230801172201.1923299-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

This series is against Jens' for-6.6/block branch.

Changes since v2:
 - fix handling of a negative return value from blkdev_direct_IO
 - drop a WARN_ON that can happen when resizing block devices
 - define away IOMAP_F_BUFFER_HEAD to keep the intrusions to the
   iomap code minimal (even if that's not quite my preferred style)

Changes since v1:
 - drop the already merged prep patches
 - depend on FS_IOMAP not IOMAP
 - pick a better new name for block_page_mkwrite_return
