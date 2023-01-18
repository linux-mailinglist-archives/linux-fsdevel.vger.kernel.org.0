Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920BE672B32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 23:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjARWTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 17:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjARWTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:19:07 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BBA65EE0;
        Wed, 18 Jan 2023 14:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=afuJng7oPx7uuacLqACHC95XAapdL6M+Vp9I11Mjg/c=; b=P94xXEwVLF+0g3HlNxc3bGIzfh
        z2kHnyswepqw17ESp0zp12Fr/epS2ALte+qk7FXKrlOnaUK4+NItHlBs/RvoU7jWpjnUYwkIPk+Hw
        3/DM1+54lHP82PB85J+GdtJ8pQQyMBnsV8dYnwbw2RRtDbyHoBVt93UPeuyXG+6cvH2JEeKttZYdL
        oLIIi4jQBdYrqjHm/0F2ykrks+lDZr5grzRFv8+rTt2qxD/XORjJz++MmWGTgFIjpSehhojHTA+82
        GQBd02LTe7Dg1qLRuhKd+0/Y5P5RdWgCxCQEVUUlh4Eip5lEq0L+vFQdxZQGpP8k8SvCMRpPyctPJ
        uncilvcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIGlh-002d3w-11;
        Wed, 18 Jan 2023 22:18:53 +0000
Date:   Wed, 18 Jan 2023 22:18:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/34] iov_iter: Use IOCB/IOMAP_WRITE/op_is_write
 rather than iterator direction
Message-ID: <Y8hwTQZziwA6U+bn@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391049698.2311931.13641162904441620555.stgit@warthog.procyon.org.uk>
 <Y8ZUXEB/W+K0Jt6k@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ZUXEB/W+K0Jt6k@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:55:08PM -0800, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 11:08:17PM +0000, David Howells wrote:
> > Use information other than the iterator direction to determine the
> > direction of the I/O:
> > 
> >  (*) If a kiocb is available, use the IOCB_WRITE flag.
> > 
> >  (*) If an iomap_iter is available, use the IOMAP_WRITE flag.
> > 
> >  (*) If a request is available, use op_is_write().
> 
> The really should be three independent patches.  Plus another one
> to drop the debug checks in cifs.
> 
> The changes themselves look good to me.
> 
> >  
> > +static unsigned char iov_iter_rw(const struct iov_iter *i)
> > +{
> > +	return i->data_source ? WRITE : READ;
> > +}
> 
> It might as well make sense to just open code this in the only
> caller as well (yet another patch).

Especially since
		/* if it's a destination, tell g-u-p we want them writable */
                if (!i->data_source)
			gup_flags |= FOLL_WRITE;
is less confusing than the current
                if (iov_iter_rw(i) != WRITE)
			gup_flags |= FOLL_WRITE;

