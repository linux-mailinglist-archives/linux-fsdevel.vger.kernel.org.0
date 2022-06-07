Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455ED54202C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349399AbiFHASs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835877AbiFGX5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:57:07 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A423A717
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tYVsPhLgr0P8lJA99ZuibqfiOSiOCH7DSOwzTk3Smh8=; b=hXzO7sSIo72AlSanuVAgldDaZ9
        yx82bfV1SazotIzw1A8gy9WmM9nPY8wfvoIA4fs1S9NAbcQmQDmduZA0NK6CHHiJQ6WNQUgR/x8O/
        EAff63L5ON3kEkwSyVPN6w2xQAQ4AFIp9PGiKzG+jwXP0SY3lo3za2nviMk8292olTK2Fz599aRRB
        hKcAUAUWDOL4JMHcEINVWKuxJPJ0of9jefRxMt5CUzm6vu/E78Os6hZOJyFWXit3cCGmYTN7ga7lZ
        I2kIrXLxg4GLydaCqIJylbKVyvOPqHZn14wapx5gEfDT8DT3yVTC/rSQAVy79Bisi5XQXOpuLvVGZ
        bOeqVTzA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyic4-004tna-VL; Tue, 07 Jun 2022 23:27:53 +0000
Date:   Tue, 7 Jun 2022 23:27:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/9] btrfs_direct_write(): cleaner way to handle
 generic_write_sync() suppression
Message-ID: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <Yp7PlaCTJF19m2sG@zeniv-ca.linux.org.uk>
 <20220607044217.GB7887@lst.de>
 <Yp93nbSBggvxjVqa@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp93nbSBggvxjVqa@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:06:53PM +0000, Al Viro wrote:
> On Tue, Jun 07, 2022 at 06:42:17AM +0200, Christoph Hellwig wrote:
> 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 370c3241618a..0f16479b13d6 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -548,7 +548,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >  		}
> > >  
> > >  		/* for data sync or sync, we need sync completion processing */
> > > -		if (iocb->ki_flags & IOCB_DSYNC)
> > > +		if (iocb->ki_flags & IOCB_DSYNC && !(dio_flags & IOMAP_DIO_NOSYNC))
> > 
> > Same here.
> 
> Dealt with in the next commit, actually.
> 
> > Also the FUA check below needs to check IOMAP_DIO_NOSYNC as
> > well.
> 
> Does it?  AFAICS, we don't really care about REQ_FUA on any requests - what
> btrfs hack tries to avoid is stepping into
>         if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> 		ret = generic_write_sync(iocb, ret);
> with generic_write_sync() called by btrfs_do_write_iter() after it has
> dropped the lock held through btrfs_direct_write().  Do we want to
> suppress REQ_FUA on the requests generated by __iomap_dio_rw() in
> that case (DSYNC, !SYNC)?  Confused...

Anyway, updated branch force-pushed...
