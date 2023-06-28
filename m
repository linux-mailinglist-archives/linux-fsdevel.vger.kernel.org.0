Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66B74150C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjF1PcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjF1Pb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:31:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A3E4;
        Wed, 28 Jun 2023 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7cXDSoXnsPtrtwlDwaOV0p1cnFvFUPDgkfZIJ82AM7s=; b=iSAYmGh8RE25GSZRBSCfDC28Un
        7wDRoE3F7X92PI6bQt7nUdb40+6uNukYRhZE8R1f+0Crct+m95VF/rF8CQleSfa18C1otbitIMghC
        pxyzDkqM4z8SaaVEz36rn7jx/8H2wBxbsPxYS9LuwFZIh2Ehfy+dyD6xAw3uvBDyzOYbhol7xP1t1
        vRI8JAISLPFrQsg3nkdNA1VxDvKQB+uVqKUXJK2gHPJ3b32jyAwROjpv7Lgi6PNr+QQy5zg2dDq3M
        Iml3Ij+3DlfQ6uFT5dkzzDOfq+sMsppi7aaFO4fMMjnMYP3SwWWvLHBiVS9AAAyayZas3QXZJl2/r
        9cCqzXrw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX92-00G028-2e;
        Wed, 28 Jun 2023 15:31:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: btrfs compressed writeback cleanups
Date:   Wed, 28 Jun 2023 17:31:21 +0200
Message-Id: <20230628153144.22834-1-hch@lst.de>
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

this series is a prequel to another big set of writeback patches, and
mostly deals with compressed writeback, which does a few things very
different from other writeback code.  The biggest results are the removal
of the magic redirtying when handing off to the worker thread, and a fix
for out of zone active resources handling when using compressed writeback
on a zoned file system, but mostly it just removes a whole bunch of code.

Note that the first 5 patches have been out on the btrfs list as
standalone submissions for a while, but they are included for completeness
so that this series can be easily applied to the btrfs misc-next tree.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git btrfs-compressed-writeback

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-compressed-writeback


Diffstat:
 fs/btrfs/btrfs_inode.h    |    6 
 fs/btrfs/extent_io.c      |  304 ++++++++-------------
 fs/btrfs/extent_io.h      |    9 
 fs/btrfs/inode.c          |  652 +++++++++++++++++-----------------------------
 fs/btrfs/ordered-data.c   |    4 
 include/linux/writeback.h |    5 
 mm/page-writeback.c       |   49 ---
 7 files changed, 383 insertions(+), 646 deletions(-)
