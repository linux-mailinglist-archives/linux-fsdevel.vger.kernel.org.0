Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97B673150
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 06:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjASFoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 00:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjASFoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:44:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419093EFFD;
        Wed, 18 Jan 2023 21:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SqW0v/EkIt7PtzYVYVy8XHYBmIfK+dd+RxA56Bj0xgI=; b=J4mRK+L+vON3wTlT6dZ9vBHOSb
        efhlDtESJ/cQayW1P5zs8CXcslqZyPKWQ1yYGgt4J3SS98Nbj/wJVvxXogbrNTIAXhTKsYTew42PQ
        lLck9PCXiqAM84fn9gnIIsYVkPgbvxQl58n7Y7e7j5mSKqneY5FtnWnYcMtujNAXaigEwFuK4lZ/2
        HjYhmcl2j9q4fkF/QiaqsFaWrizDgSnbb+V1fZOF6lDnCXgtBS7dKHQkyPi+g11ckpvp+kF/cbI5O
        2vW11RV0rsk2UnprHLD3qhWYwA9PdLB1C6quBuXMm0XiTD4ClJoaC5M7f5hxPoVx6GrFQLrf4KjKM
        QXg4p8hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pINif-003h34-Gl; Thu, 19 Jan 2023 05:44:13 +0000
Date:   Wed, 18 Jan 2023 21:44:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in
 call_write_iter()
Message-ID: <Y8jYrahu45kkCRlq@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
 <Y8ZTyx7vM8NpnUAj@infradead.org>
 <Y8huoSe4j6ysLUTT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8huoSe4j6ysLUTT@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:11:45PM +0000, Al Viro wrote:
> On Mon, Jan 16, 2023 at 11:52:43PM -0800, Christoph Hellwig wrote:
> 
> > This doesn't remove the existing setting of IOCB_WRITE, and also
> > feelds like the wrong place.
> > 
> > I suspect the best is to:
> > 
> >  - rename init_sync_kiocb to init_kiocb
> >  - pass a new argument for the destination to it.  I'm not entirely
> >    sure if flags is a good thing, or an explicit READ/WRITE might be
> >    better because it's harder to get wrong, even if a the compiler
> >    might generate worth code for it.
> >  - also use it in the async callers (io_uring, aio, overlayfs, loop,
> >    nvmet, target, cachefs, file backed swap)
> 
> Do you want it to mess with get_current_ioprio() for those?  Looks
> wrong...

We want to be consistent for sync vs async submission.  So I think yes,
we want to do the get_current_ioprio for most of them, exceptions
beeing aio and io_uring - those could use a __init_iocb or
init_iocb_ioprio variant that passs in the explicit priority if we want
to avoid the call if it would be overriden later.
