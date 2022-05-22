Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4D530320
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbiEVMll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiEVMlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:41:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6547F26562
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yEwPiL1GP2CZ2NCfZBofD/g3tWGkQ0LFrohdQ2bCJCM=; b=IOx07V5RuF5Cls16ds+xKEbppH
        uJwMJv5YB4vH6H7OkwLjmB8T+hhsvBhg54h1Y//e6fCgJdySHeOEOuPLlhq+xDLx8IaR7+uBhfcY3
        PNv58uZdCMJip/DOzqCCdbKPTQdznH/R/wsFOtCa+j0bjRPA00p+E1RLBNx+xDxLeE1Gb+cA84Rn8
        KNxIU3Q/d3omzNzIQ0NQkal46fERdWnFbtdk5snFXXmmrp7fm8Gz8F+HeNIgKBtNDAWMrclOWQKKx
        1ZtUVaQc+1z4CFuWx3XX/xChGaH/E5uXT1xoX+AKKqxG0WNvHdE5jgNBY3MvqNoFy7SCI3MIZlhw1
        T9lsxQaw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nskts-00HB2O-Et; Sun, 22 May 2022 12:41:36 +0000
Date:   Sun, 22 May 2022 12:41:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YoovgBe6MZPtemlI@zeniv-ca.linux.org.uk>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de>
 <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de>
 <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de>
 <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de>
 <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <20220522074327.GA15562@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522074327.GA15562@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 09:43:27AM +0200, Christoph Hellwig wrote:
> On Sat, May 21, 2022 at 05:48:42PM +0000, Al Viro wrote:
> > There's a problem with that variant.  Take a look at btrfs_direct_write():
> >         const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
> > 	...
> >         /*
> > 	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
> > 	 * calls generic_write_sync() (through iomap_dio_complete()), because
> > 	 * that results in calling fsync (btrfs_sync_file()) which will try to
> > 	 * lock the inode in exclusive/write mode.
> > 	 */
> > 	if (is_sync_write)
> > 		iocb->ki_flags &= ~IOCB_DSYNC;
> > 	...
> > 
> > 	/*
> > 	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do  
> > 	 * the fsync (call generic_write_sync()).
> > 	 */
> > 	if (is_sync_write)
> > 		iocb->ki_flags |= IOCB_DSYNC;
> > 
> > will run into trouble.  How about this (completely untested):
> 
> Which is pretty gross.  We can just add a IOMAP_DIO_NOSYNC flag
> to do what btrfs wants is a much less gross way.

Add
#define IOMAP_DIO_NOSYNC (1 << 3)
in iomap.h, pass IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC in btrfs and do
                if (iocb_is_dsync(iocb) && !(dio->flags & IOMAP_DIO_NOSYNC)) {
in __iomap_dio_rw(), you mean?

I wonder if we want something of that sort in another user of IOMAP_DIO_PARTIAL
(gfs2, that is)...

> Eww.  I don't think we should grow struct file for tht.

Not a problem - this one is only used before the refcount hits zero and
neither fu_llist nor fu_rcuhead are used until that happens.  So it can
go into the same union (and it's past time to make it that union anonymous,
IMO)
