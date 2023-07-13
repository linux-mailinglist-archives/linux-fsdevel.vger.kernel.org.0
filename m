Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0836D7522E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjGMNGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjGMNFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:05:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A6135A9;
        Thu, 13 Jul 2023 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UG1b1jSL5/n5WdPpDCvVvxGjVq1RWhBxylnzxxyo1KA=; b=4m2mYFYh2yWcM739MjBWCZC/Zt
        JAuv0SqHHzYNOktIz0lM9ap2ZKrl0YHJ8lcIjiGpvGkNc99qWwmeFaCCR6Oax+5eJYxXuVfjCAs0A
        wBD+a5/NX8Sx9w9EpynNKmXLDquWTNuF7bCWuOrtop7eFd/96EL1piAGascaggT6ip9jOv9PiTowt
        Lx8kaqOXvIf/0j35YGo2VBHKurumZvnHHx/C6ZdrJOEijcifrf9wnovLs9SOaJ3AbMPNpeygBwEYu
        QDdXoCl3gTw4v8q8CKH3ixHRZfGInjCyHEUA5UHXYpJtVMnSnaEkYy39wm8SmBu+kHqyRijDbxSKC
        XbHS6msw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJvzn-003LLK-0v;
        Thu, 13 Jul 2023 13:04:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: small writeback fixes
Date:   Thu, 13 Jul 2023 15:04:22 +0200
Message-Id: <20230713130431.4798-1-hch@lst.de>
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

this series has various fixes for bugs found in inspect or only triggered
with upcoming changes that are a fallout from my work on bound lifetimes
for the ordered extent and better confirming to expectations from the
common writeback code.

Note that this series builds on the "btrfs compressed writeback cleanups"
series sent out previously.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git btrfs-writeback-fixes

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-writeback-fixes

Diffatat:
 extent_io.c |  182 ++++++++++++++++++++++++++++++++++++------------------------
 inode.c     |   16 +----
 2 files changed, 117 insertions(+), 81 deletions(-)
