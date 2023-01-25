Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6AE67AAA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 07:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjAYG6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 01:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYG6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:58:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239947403;
        Tue, 24 Jan 2023 22:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=c8uXROnhoRBxz2QSyG58StOt84hyhilFEryXWBXQrqA=; b=SLY5hqs8d4kVTq5O4IZJ1szl2D
        PIZhkzjdWvwvObikTtxaQoyRDhpv8G1k9eKbDlHMYkD1OHLyiGR7FIsF3XzfODKYbpsybnETTyjB8
        PO2GdostdXuGf9pJNSfb3ugNblrGgXeXFK8JmNQGRscDcR8a1wp6HrJAQjAaGbT6HJj+nvRk/ZPEV
        rUW4M6kkPfijJBjRrS5ATFP5kD2a6QAt2V3PO8dY5HRmp1gvwvzFqNmvm/9ljypUwwPusUMd53Z2s
        VQkWYTA2aYFs8qlKG2hGZfTSI8Oo21u2nRuwi4z1hufrA56yLsDQWhWpzP9SKzOAHSH/eTTictx2C
        E6Nqe4rA==;
Received: from [2001:4bb8:19a:27af:97a1:70ca:d917:c407] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKZk2-006Cdx-5F; Wed, 25 Jan 2023 06:58:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: build direct-io.c conditionally
Date:   Wed, 25 Jan 2023 07:58:37 +0100
Message-Id: <20230125065839.191256-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
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

this series makes the build of direct-io.c conditional as only
about a dozen file systems actually use it.

Diffstat:
 Kconfig          |    4 ++++
 Makefile         |    3 ++-
 affs/Kconfig     |    1 +
 direct-io.c      |   24 ------------------------
 exfat/Kconfig    |    1 +
 ext2/Kconfig     |    1 +
 fat/Kconfig      |    1 +
 hfs/Kconfig      |    1 +
 hfsplus/Kconfig  |    1 +
 internal.h       |    4 +---
 jfs/Kconfig      |    1 +
 nilfs2/Kconfig   |    1 +
 ntfs3/Kconfig    |    1 +
 ocfs2/Kconfig    |    1 +
 reiserfs/Kconfig |    1 +
 super.c          |   24 ++++++++++++++++++++++++
 udf/Kconfig      |    1 +
 17 files changed, 43 insertions(+), 28 deletions(-)
