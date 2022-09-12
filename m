Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995E05B5BB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiILN6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiILN6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:58:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792EE13D38;
        Mon, 12 Sep 2022 06:58:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64C9868AFE; Mon, 12 Sep 2022 15:58:35 +0200 (CEST)
Date:   Mon, 12 Sep 2022 15:58:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        osandov@osandov.com
Subject: Re: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <20220912135835.GC723@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-8-hch@lst.de> <YxkFUeLBWhnufb7U@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxkFUeLBWhnufb7U@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 07, 2022 at 04:55:45PM -0400, Josef Bacik wrote:
> I'm worried about this for the ONE_ORDERED case.  We specifically used the
> ONE_ORDERED thing because our file_offset was the start, but our length could go
> past the range of the ordered extent, and then we wouldn't find our ordered
> extent and things would go quite wrong.
> 
> Instead we should do something like
> 
> if (!(orig->bi_opf & REQ_BTRFS_ONE_ORDERED))
> 	orig_bbio->file_offset += map_length;
> 
> I've cc'ed Omar since he's the one who added this and I'm a little confused
> about how this can happen.

I have to say I found the logic quite confusing as well, and when I
broke it during development of this series xfstests did not complain
either.  So shedding some more light on the flag would be really
helpful.
