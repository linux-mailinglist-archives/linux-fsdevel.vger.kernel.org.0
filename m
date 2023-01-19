Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C567315A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 06:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjASFri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 00:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjASFrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:47:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BB13C;
        Wed, 18 Jan 2023 21:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=celdJCuW2MxfsPTgwkOfFirInH8lpIvLyM4Klhajh4Y=; b=kHP2y3m14p/6+PjcgSmbkrsCRa
        7d0GWisWExNzMsYbr1XXKpHq7cXJGCidT9q/KWgdirjd0vAZQ85HPvk6mPxe9f4uaZYmYuSe6Iz2g
        gO26cFh7+6hzoy+GE2bTPIbPNoGRf2KZzPYiOYEq4/4JwIeA/ogz1IpRfCQvzGo3RDOlqDyCh5azL
        rfjtBVb6DzvYBaR3h2DyP1WsJFP+MnNqqAnbHcMcQj5J6xQowYXYdudsoEOhOkn+ZbinUh5PrScII
        NqDuO7aSRDrs/BSV2W1cw/Fp31Pym/kfNO9uzPh+V3zzdIhshFC7BtVsEtvVZIj1CpdlA7H+29m0g
        tHostaMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pINlM-003hDn-Vu; Thu, 19 Jan 2023 05:47:00 +0000
Date:   Wed, 18 Jan 2023 21:47:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
Message-ID: <Y8jZVNfeo3LWsIpV@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
 <Y8ZU1Jjx5VSetvOn@infradead.org>
 <Y8h62KsnI8g/xaRz@ZenIV>
 <Y8iLsPlSLy5YVffX@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8iLsPlSLy5YVffX@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 12:15:44AM +0000, Al Viro wrote:
> Actually, looking at that thing...  Currently we use it only for
> FOLL_PCI_P2PDMA.  It alters behaviour of get_user_pages_fast(), but...
> it is completely ignored for ITER_BVEC or ITER_PIPE.  So how the
> hell is it supposed to work?

It broadens the acceptance criteria for UBUF/IOVEC types.  It doesn't
change behavior for already accepted memory for those or any others.

> Could somebody give a braindump on that thing?  It looks like we
> have pages that should not be DMA'd to/from unless driver takes
> some precautions and we want to make sure they won't be fed to
> drivers that don't take such.  With checks done in a very odd
> place...

Yes, normal gup excludes P2P pages.  This flag allows it to get them.
