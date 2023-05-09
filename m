Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE91D6FC7EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 15:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjEINcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjEINcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 09:32:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D892E6D;
        Tue,  9 May 2023 06:32:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 599C76732A; Tue,  9 May 2023 15:32:10 +0200 (CEST)
Date:   Tue, 9 May 2023 15:32:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/9] block: add a mark_dead holder operation
Message-ID: <20230509133209.GC841@lst.de>
References: <20230505175132.2236632-1-hch@lst.de> <20230505175132.2236632-7-hch@lst.de> <20230507191946.lwndaj75bxpldeab@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507191946.lwndaj75bxpldeab@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 09:19:46PM +0200, Jan Kara wrote:
> > @@ -602,6 +624,8 @@ void blk_mark_disk_dead(struct gendisk *disk)
> >  	 * Prevent new I/O from crossing bio_queue_enter().
> >  	 */
> >  	blk_queue_start_drain(disk->queue);
> > +
> > +	blk_report_disk_dead(disk);
> 
> Hum, but this gets called from del_gendisk() after blk_drop_partitions()
> happens. So how is this going to be able to iterate anything?

It isn't, and doesn't work for partitions right now.  I guess del_gendisk
needs a bit of refacoring that we do two pases over the inode and/or
move the ->mark_deal call for partitions into blk_drop_partitions.
