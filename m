Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A796276D259
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHBPlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjHBPlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:41:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10DDA;
        Wed,  2 Aug 2023 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b4U6bkV1Hpe1BTMHR6FYKzJdXgCv2eIo7grqFPPTqjk=; b=mEmIb7uaUaKOwJY8lv1GETQvVo
        WNRAbVgAX3I0Nq8v6CM/Qo1DrhqE34m6F/BDf6xyn9aDiz8ir/jR+j+b6N3vmF4ctRKkZekSnf/xi
        uUswI0ekQNU4ccZrtb1iKIfKRkjifCinoSifA+mjBzEDaNBg7gOhnCnHmtnIl+lP+7yi1X0U5ECrV
        CBu/ROThv8CXmTxygF8pUmZ+UHKpiHPjUS4CpeuY+nPNuUWnZTnad0/okenZbctCPywHMdIKttcRj
        Mov5cp0eIKS0KO0w/8rDBjKZPumqCJP1eChnKXGXEVAMc4/RbvHBDfEltpKwT7S55Y91Tb9SGytMS
        jH+0LgHw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDyh-005GCS-2F;
        Wed, 02 Aug 2023 15:41:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: more blkdev_get and holder work
Date:   Wed,  2 Aug 2023 17:41:19 +0200
Message-Id: <20230802154131.2221419-1-hch@lst.de>
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

this series sits on top of the vfs.super branch in the VFS tree and does a
few closely related things:

  1) it also converts nilfs2 and btrfs to the new scheme where the file system
     only opens the block devices after we know that a new super_block was
     allocated.
  2) it then makes sure that for all file system openers the super_block is
     stored in bd_holder, and makes use of that fact in the mark_dead method
     so that it doesn't have to fall get_super and thus can also work on
     block devices that sb->s_bdev doesn't point to
  3) it then drops the fs-specific holder ops in ext4 and xfs and uses the
     generic fs_holder_ops there

A git tree is available here:

    git://git.infradead.org/users/hch/misc.git fs-holder-rework

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fs-holder-rework

Diffstat:
 fs/btrfs/super.c           |   67 ++++++++++++++++---------------------
 fs/btrfs/volumes.c         |    8 ++--
 fs/btrfs/volumes.h         |    2 -
 fs/ext4/super.c            |   18 +++-------
 fs/f2fs/super.c            |    7 +--
 fs/nilfs2/super.c          |   81 ++++++++++++++++-----------------------------
 fs/super.c                 |   44 ++++++++++++++++++------
 fs/xfs/xfs_super.c         |   32 +++++++----------
 include/linux/blkdev.h     |    2 +
 include/linux/fs_context.h |    2 +
 10 files changed, 126 insertions(+), 137 deletions(-)
