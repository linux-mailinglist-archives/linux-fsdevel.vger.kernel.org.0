Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189B78C4C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjH2ND4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjH2NDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:03:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B4FCED;
        Tue, 29 Aug 2023 06:03:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 93D3A6732D; Tue, 29 Aug 2023 15:03:27 +0200 (CEST)
Date:   Tue, 29 Aug 2023 15:03:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] block: open code __generic_file_write_iter for
 blkdev writes
Message-ID: <20230829130327.GA26482@lst.de>
References: <20230801172201.1923299-1-hch@lst.de> <20230801172201.1923299-4-hch@lst.de> <20230829020614.GB325446@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829020614.GB325446@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:06:14AM +0100, Al Viro wrote:
> On Tue, Aug 01, 2023 at 07:21:58PM +0200, Christoph Hellwig wrote:
> > @@ -569,7 +594,23 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  		iov_iter_truncate(from, size);
> >  	}
> >  
> > -	ret = __generic_file_write_iter(iocb, from);
> > +	ret = file_remove_privs(file);
> > +	if (ret)
> > +		return ret;
> 
> That chunk is a bit of a WTF generator...  Thankfully,
> 
> static int __file_remove_privs(struct file *file, unsigned int flags)
> {
>         struct dentry *dentry = file_dentry(file);
> 	struct inode *inode = file_inode(file);
> 	int error = 0;
> 	int kill;
> 
> 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
> 		return 0;
> 
> means that it's really a no-op.  But I'd still suggest
> removing it, just to reduce the amount of head-scratching
> for people who'll be reading that code later...

I'll send an incremental patch to remove it once the changes hit
Linus' tree.
