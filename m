Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B72778AE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjHKKIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKKIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:08:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063EEA;
        Fri, 11 Aug 2023 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hcbvw/RfBq8JHr30xw9G1Ra3s1wKjT/PtsrPUt7GxO0=; b=lu2+QOoKycflUw3sVvBPND/Cj+
        XTbtxhvdxSyGd5ObrfLgXyuf/MlGn3ic0Qeo3NkdDwkW0THLSAQ70FV9T9f7YlkbHYP4MCZBFz5n0
        LJrhRWNiAMuS6BRWdZHHKc5kvZ19+oSA3ubIyV1NgGhs4yy2lQDw2rXNQSJaonRC/dXJHLmY0ZAPa
        Cz3D/MCTrgZY+3NHmytpoiir3/bEV47uqe5Sp0fFYjsWXp6K/C/CIAZZnz2oIz+eVtJ+eleP+gvk/
        c1QD0c1cBmOfoGQPBXwN/zqxR67IkgXLVZYAj+cOMmuh4oTvvCSmRZ9GQGltc3k3csGhK5qdPUxnq
        9MblYUNA==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4I-00A5Xm-25;
        Fri, 11 Aug 2023 10:08:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: remove get_super
Date:   Fri, 11 Aug 2023 12:08:11 +0200
Message-Id: <20230811100828.1897174-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series against the VFS vfs.super branch finishes off the work to remove
get_super and move (almost) all upcalls to use the holder ops.

The first part is the missing btrfs bits so that all file systems use the
super_block as holder.

The second part is various block driver cleanups so that we use proper
interfaces instead of raw calls to __invalidate_device and fsync_bdev.

The last part than replaces __invalidate_device and fsync_bdev with upcalls
to the file system through the holder ops, and finally removes get_super.

It leaves user_get_super and get_active_super around.  The former is not
used for upcalls in the traditional sense, but for legacy UAPI that for
some weird reason take a dev_t argument (ustat) or a block device path
(quotactl).  get_active_super is only used for calling into the file system
on freeze and should get a similar treatment, but given that Darrick has
changes to that code queued up already this will be handled in the next
merge window.

A git tree is available here:

    git://git.infradead.org/users/hch/misc.git remove-get_super

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/remove-get_super

Diffstat:
 block/bdev.c              |   61 ++++++++++++++++++++-------------------------
 block/disk-events.c       |   23 ++++-------------
 block/genhd.c             |   45 +++++++++++++++++----------------
 block/ioctl.c             |    9 +++++-
 block/partitions/core.c   |    5 ---
 drivers/block/amiflop.c   |    1 
 drivers/block/floppy.c    |    2 -
 drivers/block/loop.c      |    6 ++--
 drivers/block/nbd.c       |    8 ++---
 drivers/s390/block/dasd.c |    7 +----
 fs/btrfs/disk-io.c        |    4 +-
 fs/btrfs/super.c          |   59 ++++++++++++++++++++++---------------------
 fs/btrfs/volumes.c        |   58 ++++++++++++++++++++++---------------------
 fs/btrfs/volumes.h        |    8 +++--
 fs/inode.c                |   16 +----------
 fs/internal.h             |    2 -
 fs/super.c                |   62 +++++++++++++++-------------------------------
 include/linux/blkdev.h    |   13 +++++----
 include/linux/fs.h        |    1 
 19 files changed, 175 insertions(+), 215 deletions(-)
