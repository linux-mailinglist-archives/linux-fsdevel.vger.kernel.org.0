Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0575ACB4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiIEGu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 02:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiIEGuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:50:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B9B5D;
        Sun,  4 Sep 2022 23:50:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 54EF368BEB; Mon,  5 Sep 2022 08:50:09 +0200 (CEST)
Date:   Mon, 5 Sep 2022 08:50:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Message-ID: <20220905065008.GF2092@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-18-hch@lst.de> <c2e15bee-cd4d-9699-621d-986029f337b6@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e15bee-cd4d-9699-621d-986029f337b6@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:38:50AM +0900, Damien Le Moal wrote:
> On 9/1/22 16:42, Christoph Hellwig wrote:
> > No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
> > splits and converts them to REQ_OP_ZONE_APPEND internally.
> 
> Hu... I wanted to use that for zonefs for doing ZONE APPEND with AIOs...
> Need to revisit that code anyway, so fine for now.

We could resurrect it.  But I suspect that you're better off doing
what btrfs does here - let iomap submit a write bio and then split
it in the submit_bio hook.

