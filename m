Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C58779F68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjHLK71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 06:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbjHLK70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:59:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C154B10C;
        Sat, 12 Aug 2023 03:59:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12BF567373; Sat, 12 Aug 2023 12:51:34 +0200 (CEST)
Date:   Sat, 12 Aug 2023 12:51:33 +0200
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
Subject: Re: [PATCH 13/17] block: consolidate __invalidate_device and
 fsync_bdev
Message-ID: <20230812105133.GA11904@lst.de>
References: <20230811100828.1897174-1-hch@lst.de> <20230811100828.1897174-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-14-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The buildbot pointed out correctly (but rather late), that the special
s390/dasd export needs a _MODULE postfix, so this will have to be
folded in:

diff --git a/block/bdev.c b/block/bdev.c
index 2a035be7f3ee90..a20263fa27a462 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -967,7 +967,7 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
 
 	invalidate_bdev(bdev);
 }
-#ifdef CONFIG_DASD
+#ifdef CONFIG_DASD_MODULE
 /*
  * Drivers should not use this directly, but the DASD driver has historically
  * had a shutdown to offline mode that doesn't actually remove the gendisk
