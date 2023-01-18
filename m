Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7E672B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjARWGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 17:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjARWFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:05:45 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83635630BD;
        Wed, 18 Jan 2023 14:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ph23ln2G3weWAIQMclCijpBxjfjqbvcIl1UPbyjflns=; b=m/Oc3dNKwITBehTqZzLwzPDz5K
        igmF/szwBv4jT+BwWx4trHSh9wDmQ9fPO5Rp/PtMfG/HFdtpb3K8OqZivOX8o9VYS3o1j2N0k0NzY
        etrpkOb0RbM4TRsLL9FuA0QJ2kPOz3hf88kQ8eM1DoKNJbgTVuk9EYO4NzWjkb4Sy/6dYcKevBr/Z
        LQlEVF+tf67BuZcQO3sMorpBlwIHxhvu95LITp2+MoX9vK/CpNYfPBCbwKeT6jlPoDaWjlZu/gtAX
        pR4pDHU4ebG1e9/zDM573RDjNMLdOZn2oqBhdqpA6QA6IT1lC9kOmzcH2u4Xb5oAnXuJ1xORdJwqx
        AqsMKpBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIGYs-002cyB-2r;
        Wed, 18 Jan 2023 22:05:38 +0000
Date:   Wed, 18 Jan 2023 22:05:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in
 call_write_iter()
Message-ID: <Y8htMvG33I73oG9z@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:08:09PM +0000, David Howells wrote:
> IOCB_WRITE is set by aio, io_uring and cachefiles before submitting a write
> operation to the VFS, but it isn't set by, say, the write() system call.
> 
> Fix this by setting IOCB_WRITE unconditionally in call_write_iter().

	Which does nothing for places that do not use call_write_iter()...
__kernel_write_iter() is one such; for less obvious specimen see
drivers/nvme/target/io-cmd-file.c:nvmet_file_submit_bvec() - there
we have iocb coming from the caller and *not* fed to init_sync_kiocb(),
so Christoph's suggestion doesn't work either.  Sure, we could take
care of that by adding ki_flags |= IOCB_WRITE in there, but...

FWIW, call chains for ->write_iter() (as an explicit method call) are:

->write_iter() <- __kernel_write_iter() [init_sync_kiocb()]
->write_iter() <- call_write_iter() <- new_sync_write() [init_sync_kiocb()]
->write_iter() <- call_write_iter() <- do_iter_read_write() [init_sync_kiocb()]
->write_iter() <- call_write_iter() <- aio_write() [sets KIOCB_WRITE]
->write_iter() <- call_write_iter() <- io_write() [sets KIOCB_WRITE]

->write_iter() <- nvmet_file_submit_bvec()
->write_iter() <- call_write_iter() <- lo_rw_aio()
->write_iter() <- call_write_iter() <- fd_execute_rw_aio()
->write_iter() <- call_write_iter() <- vfs_iocb_iter_write()

The last 4 neither set KIOCB_WRITE nor call init_sync_kiocb().  What's
more, there are places that call instances (or their guts - look at
btrfs_do_write_iter() callers) directly...
