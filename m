Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BAC66D74A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 08:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjAQHwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 02:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjAQHws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:52:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5305D10E9;
        Mon, 16 Jan 2023 23:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wWqNbdlEEuCs/y5HTw1CM3CCuQAqqsU5LMt57a83JFM=; b=YK0AsGe+7P4xQCstLp/o07OGfR
        snqFhrqNK2vIOLX34s3ZdJoDWNwveeOr5cEQNFgGCscAHBq7L2Qw+MOF5srYdKYL8dZMCm1I3VadF
        lVHMqviQu2/wufQfo59NbhQZWzGJPWuVPI57GRU9GnjNWo7bvGr6BB92cDPwYhKkYAU6UfqxPAQal
        9Dr+D5oHF0WnaMsfLEleCH+Vg8yPOl9J8yib+SubE9iWtGisz9UI4XsPYEBLVI/SGjItgNrfBuQra
        4H8iVmu36NfuXT6yFy8lghc3Ck/K86zeVFDN3S46u40BleViZ8kMvU90mdto7oKPD8/bW0/KGTXrR
        wkvNHWLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHglv-00DFdD-9X; Tue, 17 Jan 2023 07:52:43 +0000
Date:   Mon, 16 Jan 2023 23:52:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in
 call_write_iter()
Message-ID: <Y8ZTyx7vM8NpnUAj@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> 
> This will allow drivers to use IOCB_WRITE instead of the iterator data
> source to determine the I/O direction.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
>  include/linux/fs.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 066555ad1bf8..649ff061440e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2183,6 +2183,7 @@ static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
>  static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
>  				      struct iov_iter *iter)
>  {
> +	kio->ki_flags |= IOCB_WRITE;
>  	return file->f_op->write_iter(kio, iter);
>  }

This doesn't remove the existing setting of IOCB_WRITE, and also
feelds like the wrong place.

I suspect the best is to:

 - rename init_sync_kiocb to init_kiocb
 - pass a new argument for the destination to it.  I'm not entirely
   sure if flags is a good thing, or an explicit READ/WRITE might be
   better because it's harder to get wrong, even if a the compiler
   might generate worth code for it.
 - also use it in the async callers (io_uring, aio, overlayfs, loop,
   nvmet, target, cachefs, file backed swap)
