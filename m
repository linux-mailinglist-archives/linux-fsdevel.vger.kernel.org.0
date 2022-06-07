Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8637854201A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiFHAQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839180AbiFHACr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:02:47 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCE0171265
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KqdnhchzPI3nZoD9zBlvVNGe977WwLRDNr5FwOVoJ70=; b=qV7JhZX0gVEQFBXrRm/q4OclPr
        3jd/1NSCiy3gTp9es4PAs5rExeb4LevOekCByRoGOVaqsawFP2qutI9lLPWl5xPUQqpx8hRVy4+/p
        W5Ka3Bs68jbpjZaRQWP6iC0chnDlPt8u538bPlWO6rlLv6bn1YIdBcShPVMJtW9isAVGJDodcmlxk
        rxV/5G1DCSyZuhkukVxjkZpUy+6nWeeL0YtNriV1lbzemg2xOYqBd1bQf7ZpqWS3cg2HX0gQ9dZq8
        8rXQgz8LJiPiamvcYMrNApbk27gF5wOETzKobmJDK/27aGR2NZaGCFpS9o4crY2IRwfdI7kYzuZGW
        Gto5nd9Q==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyfdg-004qZ9-R8; Tue, 07 Jun 2022 20:17:20 +0000
Date:   Tue, 7 Jun 2022 20:17:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] btrfs_direct_write(): cleaner way to handle
 generic_write_sync() suppression
Message-ID: <Yp+yUJuA8vjE70T4@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <Yp7PlaCTJF19m2sG@zeniv-ca.linux.org.uk>
 <Yp9ldUZMmDmBaPSU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp9ldUZMmDmBaPSU@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:49:25PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 07, 2022 at 04:09:57AM +0000, Al Viro wrote:
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index e552097c67e0..95de0c771d37 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -353,6 +353,8 @@ struct iomap_dio_ops {
> >   */
> >  #define IOMAP_DIO_PARTIAL		(1 << 2)
> >  
> > +#define IOMAP_DIO_NOSYNC		(1 << 3)
> > +
> >  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> >  		unsigned int dio_flags, void *private, size_t done_before);
> 
> You didn't like the little comment I added?

I didn't have your patch in front of my eyes at the time...
Comment folded in now.
