Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47DA5301AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiEVHnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiEVHnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 03:43:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69613F8AE
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 00:43:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D3DCA68B05; Sun, 22 May 2022 09:43:27 +0200 (CEST)
Date:   Sun, 22 May 2022 09:43:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <20220522074327.GA15562@lst.de>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk> <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org> <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org> <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk> <20210621143501.GA3789@lst.de> <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 21, 2022 at 05:48:42PM +0000, Al Viro wrote:
> There's a problem with that variant.  Take a look at btrfs_direct_write():
>         const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
> 	...
>         /*
> 	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
> 	 * calls generic_write_sync() (through iomap_dio_complete()), because
> 	 * that results in calling fsync (btrfs_sync_file()) which will try to
> 	 * lock the inode in exclusive/write mode.
> 	 */
> 	if (is_sync_write)
> 		iocb->ki_flags &= ~IOCB_DSYNC;
> 	...
> 
> 	/*
> 	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do  
> 	 * the fsync (call generic_write_sync()).
> 	 */
> 	if (is_sync_write)
> 		iocb->ki_flags |= IOCB_DSYNC;
> 
> will run into trouble.  How about this (completely untested):

Which is pretty gross.  We can just add a IOMAP_DIO_NOSYNC flag
to do what btrfs wants is a much less gross way.

> Precalculate iocb_flags()
> 
> Store the value in file->f_i_flags; calculate at open time (do_dentry_open()
> for opens, alloc_file() for pipe(2)/socket(2)/etc.), update at FCNTL_SETFL
> time.

Eww.  I don't think we should grow struct file for tht.
