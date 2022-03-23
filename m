Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF94E4CD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiCWGoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCWGoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:44:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA370044;
        Tue, 22 Mar 2022 23:42:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DA2C68AFE; Wed, 23 Mar 2022 07:42:48 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:42:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nfs@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
        device-mapper development <dm-devel@redhat.com>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        ntfs3@lists.linux.dev, Jack Wang <jinpu.wang@ionos.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        drbd-dev@lists.linbit.com
Subject: Re: [dm-devel] [PATCH 01/19] fs: remove mpage_alloc
Message-ID: <20220323064248.GA24874@lst.de>
References: <20220124091107.642561-1-hch@lst.de> <20220124091107.642561-2-hch@lst.de> <20220322211915.GA2413063@roeck-us.net> <CAKFNMonRd5QQMzLoH3T=M=C=2Q_j9d86EYzZeY4DU2HQAE3E8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKFNMonRd5QQMzLoH3T=M=C=2Q_j9d86EYzZeY4DU2HQAE3E8w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 06:38:22AM +0900, Ryusuke Konishi wrote:
> This looks because the mask of GFP_KERNEL is removed along with
> the removal of mpage_alloc().
> 

> The default value of the gfp flag is set to GFP_HIGHUSER_MOVABLE by
> inode_init_always().
> So, __GFP_HIGHMEM hits the gfp warning at bio_alloc() that
> do_mpage_readpage() calls.

Yeah.  Let's try this to match the iomap code:

diff --git a/fs/mpage.c b/fs/mpage.c
index 9ed1e58e8d70b..d465883edf719 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -148,13 +148,11 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	int op = REQ_OP_READ;
 	unsigned nblocks;
 	unsigned relative_block;
-	gfp_t gfp;
+	gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 
 	if (args->is_readahead) {
 		op |= REQ_RAHEAD;
-		gfp = readahead_gfp_mask(page->mapping);
-	} else {
-		gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+		gfp |= __GFP_NORETRY | __GFP_NOWARN;
 	}
 
 	if (page_has_buffers(page))
