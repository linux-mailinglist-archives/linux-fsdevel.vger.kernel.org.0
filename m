Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF286F6D5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 15:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjEDNzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDNzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 09:55:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2477D9F;
        Thu,  4 May 2023 06:55:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A7D4368AA6; Thu,  4 May 2023 15:55:15 +0200 (CEST)
Date:   Thu, 4 May 2023 15:55:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the
 block device
Message-ID: <20230504135515.GA17048@lst.de>
References: <20230504105624.9789-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504105624.9789-1-idryomov@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 12:56:24PM +0200, Ilya Dryomov wrote:
> Commit 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue
> and a sb flag") introduced a regression for the raw block device use
> case.  Capturing QUEUE_FLAG_STABLE_WRITES flag in set_bdev_super() has
> the effect of respecting it only when there is a filesystem mounted on
> top of the block device.  If a filesystem is not mounted, block devices
> that do integrity checking return sporadic checksum errors.

With "If a file system is not mounted" you want to say "when accessing
a block device directly" here, right?  The two are not exclusive..

> Additionally, this commit made the corresponding sysfs knob writeable
> for debugging purposes.  However, because QUEUE_FLAG_STABLE_WRITES flag
> is captured when the filesystem is mounted and isn't consulted after
> that anywhere outside of swap code, changing it doesn't take immediate
> effect even though dumping the knob shows the new value.  With no way
> to dump SB_I_STABLE_WRITES flag, this is needlessly confusing.

But very much intentional.  s_bdev often is not the only device
in a file system, and we should never reference if from core
helpers.

So I think we should go with something like this:

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index db794399900734..aa36cc2a4530c1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3129,7 +3129,11 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
  */
 void folio_wait_stable(struct folio *folio)
 {
-	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
+	struct inode *inode = folio_inode(folio);
+	struct super_block *sb = inode->i_sb;
+
+	if ((sb->s_iflags & SB_I_STABLE_WRITES) ||
+	    (sb_is_blkdev_sb(sb) && bdev_stable_writes(I_BDEV(inode))))
 		folio_wait_writeback(folio);
 }
 EXPORT_SYMBOL_GPL(folio_wait_stable);
