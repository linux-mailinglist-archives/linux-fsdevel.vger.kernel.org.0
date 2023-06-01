Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAE7196E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjFAJ1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFAJ1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:27:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D04123
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 02:27:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D300967373; Thu,  1 Jun 2023 11:27:19 +0200 (CEST)
Date:   Thu, 1 Jun 2023 11:27:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zonefs: use iomap for synchronous direct writes
Message-ID: <20230601092719.GA5774@lst.de>
References: <20230601082652.181695-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601082652.181695-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +struct zonefs_bio {
> +	/* The target inode of the BIO */
> +	struct inode *inode;
> +
> +	/* For sync writes, the target write offset */
> +	u64 woffset;

Maybe spell out write_offset?

> +
> +static void zonefs_file_sync_write_dio_bio_end_io(struct bio *bio)
> +{
> +	struct zonefs_bio *zbio;
> +	struct zonefs_zone *z;
> +	sector_t wsector;
> +
> +	if (bio->bi_status != BLK_STS_OK)
> +		goto bio_end;
> +
> +	/*
> +	 * If the file zone was written underneath the file system, the zone
> +	 * append operation can still succedd (if the zone is not full) but
> +	 * the write append location will not be where we expect it to be.
> +	 * Check that we wrote where we intended to, that is, at z->z_wpoffset.
> +	 */
> +	zbio = zonefs_bio(bio);
> +	z = zonefs_inode_zone(zbio->inode);

I'd move thses to the lines where the variables are declared.

> +	wsector = z->z_sector + (zbio->woffset >> SECTOR_SHIFT);
> +	if (bio->bi_iter.bi_sector != wsector) {
> +		zonefs_warn(zbio->inode->i_sb,
> +			    "Invalid write sector %llu for zone at %llu\n",
> +			    bio->bi_iter.bi_sector, z->z_sector);
> +		bio->bi_status = BLK_STS_IOERR;
> +	}

Seems like all this is actually just debug code and could be conditional
and you could just use the normal bio pool otherwise?

> +static struct bio_set zonefs_file_write_dio_bio_set;
>  
