Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA456675E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 15:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjALO0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 09:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbjALO0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:26:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83730559CB;
        Thu, 12 Jan 2023 06:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FOj+YraCL6uazHK4HsAlelpL2+zXlAQOgAoPSryEzvA=; b=cn7Zl5AY2FqhMrNth+lxKfIty3
        c+k+tAt1vZD8W5otygcqWMXsoi+ZE28+Utw2ry6fAtlD1aYPPcvCLIyMTRIRuncIHRCY5N/4G5N0K
        CjFje6K8DDDp3Ce4LxdPZXhDbIXL/wtt4ydOC/ndHGSjVTZUnvhDISJoyCIFckCxT1I4DOsIaCQP1
        HnIFI2susc/zhDlrOuWwQbxXA8OfeM3qHO/t8wveo0x5dea0RHCP2mswA2x6Q1TRM7avvkw5v1mnR
        /ie8EB1CwLvRcU7NFGvkRN2gibt40xbJznmppdQ5k4Z0+OyUq2PjQ4TAcNc2QEw+YXwJyEB5d5OE/
        0rQ784ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFyOC-00FKkF-0M; Thu, 12 Jan 2023 14:17:08 +0000
Date:   Thu, 12 Jan 2023 06:17:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] iov_iter, block: Make bio structs pin pages
 rather than ref'ing if appropriate
Message-ID: <Y8AWY991ilrO5Yco@infradead.org>
References: <Y7+6YVkhZsvdW+Hr@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk>
 <15237.1673519321@warthog.procyon.org.uk>
 <Y8AUjB5hxkwxhnGK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AUjB5hxkwxhnGK@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 06:09:16AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 12, 2023 at 10:28:41AM +0000, David Howells wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > 	if (cleanup_mode & FOLL_GET) {
> > > 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_PINNED));
> > > 		bio_set_flag(bio, BIO_PAGE_REFFED);
> > > 	}
> > > 	if (cleanup_mode & FOLL_PIN) {
> > > 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_REFFED));
> > > 		bio_set_flag(bio, BIO_PAGE_PINNED);
> > > 	}
> > 
> > That won't necessarily work as you might get back cleanup_mode == 0, in which
> > case both flags are cleared - and neither warning will trip on the next
> > addition.
> 
> Well, it will work for the intended use case even with
> cleanup_mode == 0, we just won't get the debug check.  Or am I missing
> something fundamental?

In fact looking at the code we can debug check that case too by doing:

	if (cleanup_mode & FOLL_GET) {
 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_PINNED));
 		bio_set_flag(bio, BIO_PAGE_REFFED);
 	} else if (cleanup_mode & FOLL_PIN) {
 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_REFFED));
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 	} else {
		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_PINNED) ||
			     bio_test_flag(bio, BIO_PAGE_REFFED));
	}

But given that all calls for the same iter type return the same
cleanup_mode by defintion I'm not even sure we need any of this
debug checking, and might as well just do:

	if (cleanup_mode & FOLL_GET)
 		bio_set_flag(bio, BIO_PAGE_REFFED);
 	else if (cleanup_mode & FOLL_PIN)
 		bio_set_flag(bio, BIO_PAGE_PINNED);
