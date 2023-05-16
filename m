Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A670535F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEPQRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEPQRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:17:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834735596;
        Tue, 16 May 2023 09:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B11C63558;
        Tue, 16 May 2023 16:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B764C433EF;
        Tue, 16 May 2023 16:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253859;
        bh=OqIhC9v/aw7ef1NCuaqC6x3nL6C6Dtwug2I6ADMpdHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uke+d3OgToR8BjN8FiEdNB6ggKq9FhwB5lmwhW5YxyZMFRXU5tgeT3exbSYdI17X2
         giJqiU0clnU/0NtIJTgxTs1v7mFo+y2gAQt+x86azSJZpZraMZWKpsbQLRfJQLQcI9
         FQgA8dFoZVf87w5zrHpdzEO3EDLVBKIm9poe5h+HqPsPvkcUegeErFEycK/piJUFdJ
         ACj+B2K96RKyqYNQyRuaLfqChDBbIyXjERElXtewILaNP6nUyylaVHSY77IDzF2/0I
         CLYklgn3Qyuuk3Z2zEPoPy0COstaZUEJXlMu+pvye9uBHav+LvcsiNHzfUwzu+a5oq
         oTOLrwEtJuuUA==
Date:   Tue, 16 May 2023 18:17:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/9] block: add a mark_dead holder operation
Message-ID: <20230516-deeskalation-glasur-3f9700216475@brauner>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-7-hch@lst.de>
 <20230507191946.lwndaj75bxpldeab@quack3>
 <20230509133209.GC841@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230509133209.GC841@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 03:32:09PM +0200, Christoph Hellwig wrote:
> On Sun, May 07, 2023 at 09:19:46PM +0200, Jan Kara wrote:
> > > @@ -602,6 +624,8 @@ void blk_mark_disk_dead(struct gendisk *disk)
> > >  	 * Prevent new I/O from crossing bio_queue_enter().
> > >  	 */
> > >  	blk_queue_start_drain(disk->queue);
> > > +
> > > +	blk_report_disk_dead(disk);
> > 
> > Hum, but this gets called from del_gendisk() after blk_drop_partitions()
> > happens. So how is this going to be able to iterate anything?
> 
> It isn't, and doesn't work for partitions right now.  I guess del_gendisk
> needs a bit of refacoring that we do two pases over the inode and/or
> move the ->mark_deal call for partitions into blk_drop_partitions.

Might be worth a comment. Otherwise looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
