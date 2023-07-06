Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEDC74A0FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjGFP3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjGFP3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:29:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5261BF3;
        Thu,  6 Jul 2023 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VaWrOj7qxCfN/aR/+wlf6fU45vuCjby7Nm0Ri4aQJmw=; b=JaE/0fWXQgO2xj2f3aFJmBZT5Q
        j6++1w0jrD7V6RkWJs3PDshW7GjlpZfvyQoTTJ1CWgonZ+2AktQ2W0WMpn0QR1xiTmqU319iICsGC
        64kKXFo/nIsWzCAc8Lw66uKl2P9PtTuqTKQDsMNt7jFOA5TB1a6i1gnN8D7RNImMSYEq1hFweL5NN
        OsN9HNt3EaMVo61D1E2z8zoD/Yc2hUlbIXLlqAOaYKzR7yZpvUAaLNm+TilvBWp1EB2Cm5KPpvMAz
        k2dTNjwEazjsUUv4U4jC6XLDA+aFIhco1jmCE66xnS8Evo0WHqgKu3FkOk82Grau21wfT9osTZx/7
        QTSa18og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQv8-0020SQ-2T;
        Thu, 06 Jul 2023 15:29:26 +0000
Date:   Thu, 6 Jul 2023 08:29:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 03/11] vfs: Use init_kiocb() to initialise new IOCBs
Message-ID: <ZKbd1vwqeCFnQcjU@infradead.org>
References: <20230630152524.661208-1-dhowells@redhat.com>
 <20230630152524.661208-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152524.661208-4-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 04:25:16PM +0100, David Howells wrote:
> A number of places that generate kiocbs didn't use init_sync_kiocb() to
> initialise the new kiocb.  Fix these to always use init_kiocb().
> 
> Note that aio and io_uring pass information in through ki_filp through an
> overlaid union before I can call init_kiocb(), so that gets reinitialised.
> I don't think it clobbers anything else.
> 
> After this point, IOCB_WRITE is only set by init_kiocb().

Nothing in this patch touches the VFS, so the subject line is
wrong.  And I think we're better off splitting it into one per
subsystem, which also allows documenting the exact changes.

Which includes now setting the flags from f_iocb_flags and setting
and I/O priority.  Please explain why this is harmless or even useful.

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 37511d2b2caf..ea92235c5ba2 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -439,16 +439,17 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	}
>  	atomic_set(&cmd->ref, 2);
>  
> -	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
> +	iov_iter_bvec(&iter, rw == WRITE ? ITER_SOURCE : ITER_DEST,
> +		      bvec, nr_bvec, blk_rq_bytes(rq));

Given the cover letter I expect this is going to go away, but the
changes would probably a lot more readable if you had a helper
to convert from READ/WRITE to the iter flags inbetween.

Or maybe do it the other way - add a helper to init the 

> @@ -490,12 +491,12 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
>  	case REQ_OP_WRITE:
>  		if (cmd->use_aio)
> -			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
> +			return lo_rw_aio(lo, cmd, pos, WRITE);
>  		else
>  			return lo_write_simple(lo, rq, pos);
>  	case REQ_OP_READ:
>  		if (cmd->use_aio)
> -			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
> +			return lo_rw_aio(lo, cmd, pos, READ);

I don't think there is any need to pass the rw argument at all,
lo_rw_aio can just do an op_is_write(req_op(rq))

> -static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
> +static int io_rw_init_file(struct io_kiocb *req, unsigned int io_direction)
>  {
>  	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
>  	struct kiocb *kiocb = &rw->kiocb;
>  	struct io_ring_ctx *ctx = req->ctx;
>  	struct file *file = req->file;
> +	fmode_t mode = (io_direction == WRITE) ? FMODE_WRITE : FMODE_READ;
>  	int ret;
>  
>  	if (unlikely(!file || !(file->f_mode & mode)))

I'd just move this check into the two callers, that way you can hard
code the mode instead of adding a conversion.

