Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3F778B12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjHKKKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjHKKJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:09:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49B3C1E;
        Fri, 11 Aug 2023 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h0y45HSXMdqvAsXX+rWjCQySRpy/tzHE4F4xXnA9hUA=; b=X5N6D2RuIJPEACFdN87bByqqvJ
        nDb/0S8vM5RMj7KWJFBH9dRSEsy+APYfjAaTiF6M2sAxWoDhHeidLglhhFrGZQwKudhJzKh19bAbd
        DE+hk+Eip05VhTLNh4lGjQknDZ0/AAiyQ/qHcWLyq5iXy33xKctf765bORgQbXrlvINF4pSJ9VBf5
        NOGbB5cuTGjmnp/c7b/YhDRHoi0oXqApTNi5I7eH9V9mk+dChbywou7rWIlB4B3k5JiGaNc4lqRIj
        qA/FAhDmCNpvgUae10Rjh/aNeh9jff95JVbPEU9KGhX81wE39DgChRpEqCmS7PgLY8tB3rEunaLAA
        jlXANyXg==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4k-00A5lf-03;
        Fri, 11 Aug 2023 10:08:58 +0000
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
Subject: [PATCH 09/17] floppy: call disk_force_media_change when changing the format
Date:   Fri, 11 Aug 2023 12:08:20 +0200
Message-Id: <20230811100828.1897174-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
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

While changing the format of a floppy isn't strictly speaking a media
change, the effects are the same in that the content of the media
changes and the diskseq should be increased and uevent should be
sent.  Switch from calling __invalidate_device to
disk_force_media_change to do so.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 2db9b186b977ac..ea4eb88a2e45f4 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3255,7 +3255,7 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
 
 			if (!disk || ITYPE(drive_state[cnt].fd_device) != type)
 				continue;
-			__invalidate_device(disk->part0, true);
+			disk_force_media_change(disk);
 		}
 		mutex_unlock(&open_lock);
 	} else {
-- 
2.39.2

