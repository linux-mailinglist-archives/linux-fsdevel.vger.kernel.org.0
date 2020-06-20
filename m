Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5E202248
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFTHQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFTHQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:16:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE91C06174E;
        Sat, 20 Jun 2020 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7UuadO7cHzr0SgICIdLV+S1e1Yzn89GfPoCa26xuTL0=; b=N+a+lZvXKyctQKCqkhY31VqL6d
        Qpg4hn6nmagnhRMYG+s1wdDtoORJR+Yocunj9d92ePhJLbJZn0IS/nhMGa8BwiuzqZY/GqhPlfYGt
        eER6/0qUN7R5BEP2gqxv8si8jcXRlfxRVQVYTu9B7dclbu25YBuCJWIvMSRyI00dRjCQUVfAtEFuL
        ufR7hSIb5G4+GZal2ExAlS0UpizKF7XauY7GXHzarhsk2b81mB04Dcpkl7shFVgcvw7UuESVwo8oA
        aFOGjAe5k5nl7ks6zjZC+af0u6MSlGrrxDK8/r5u6h4OMDBOevQofSI4mInQ7jNrfTWFfqHx1Wu97
        u36Vs7lQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXk6-0003ql-N7; Sat, 20 Jun 2020 07:16:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: move block bits out of fs.h
Date:   Sat, 20 Jun 2020 09:16:34 +0200
Message-Id: <20200620071644.463185-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series removes various remaining block bits out of fs.h and cleans
up a few loose ends around that.

Diffstat:
 drivers/tty/sysrq.c         |    2 
 fs/adfs/super.c             |    1 
 fs/affs/file.c              |    1 
 fs/befs/linuxvfs.c          |    1 
 fs/block_dev.c              |    5 -
 fs/efs/super.c              |    1 
 fs/hfs/inode.c              |    1 
 fs/internal.h               |   17 +++-
 fs/jfs/jfs_mount.c          |    1 
 fs/jfs/resize.c             |    1 
 fs/ntfs/dir.c               |    1 
 fs/proc/devices.c           |    1 
 fs/quota/dquot.c            |    1 
 fs/reiserfs/procfs.c        |    1 
 include/linux/bio.h         |    3 
 include/linux/blk_types.h   |   39 +++++++++-
 include/linux/blkdev.h      |  140 ++++++++++++++++++++++--------------
 include/linux/buffer_head.h |    1 
 include/linux/dasd_mod.h    |    2 
 include/linux/fs.h          |  169 --------------------------------------------
 include/linux/genhd.h       |   39 ++++++++--
 include/linux/jbd2.h        |    1 
 security/loadpin/loadpin.c  |    1 
 23 files changed, 192 insertions(+), 238 deletions(-)
