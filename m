Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF2C5601CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiF2N7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2N7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:59:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F4522B2B;
        Wed, 29 Jun 2022 06:59:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE5F868AA6; Wed, 29 Jun 2022 15:59:10 +0200 (CEST)
Date:   Wed, 29 Jun 2022 15:59:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220629135910.GA15031@lst.de>
References: <20220624122334.80603-1-hch@lst.de> <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de> <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de> <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com> <20220629094547.xa27x7oiuhasglzl@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629094547.xa27x7oiuhasglzl@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:45:47AM +0200, Jan Kara wrote:
> So the only viable solution is really for the filesystem to detect such
> unprotectable pages if it cares and somehow deal with them (skip writeback,
> use bounce pages, ...). The good news is that we already have
> page_maybe_dma_pinned() call that at least allows detection of such
> unprotectable pages.

The bad news is that page_maybe_dma_pinned only accounts for FOLL_PIN
memory, and we till have a lot of users of FOLL_GET including direct I/O.

Now for FOLL_PIN I think most problems would be solved by
marking pages that are DMA pinned when writeback completes (that
is when PG_writeback is cleared) dirty again, and making sure the
equivalent of page_mkwrite is called for them again as well.  The
latter might be a bit ugly as PG_writeback could be cleared from
interrupt context, even if most modern file systems especially if
they do anything fancy like out of place writes or unwritten extents
defer it to a workqueue.

To reduce the overhead of this it would make sense to skip writing
these pages back at all unless it is a data integrity write.
