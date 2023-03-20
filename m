Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3F6C12CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 14:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjCTNLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCTNLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:11:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FFB76A;
        Mon, 20 Mar 2023 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+/9FCDUcz/9yyumayNm7HvxGQ4k/d4p/8qwiRrkpHdI=; b=X4GyKsIv0QTVIz6ae3YmM33lHX
        VBU9O+UrtEDNpJX70qptJmPQKFA3abRRe+j9f5PYJLaMjfBHzf6YU1XTRsWEF2tcqoWJ60HZw/ZY9
        t6HL2p0DIxaFiiV5kemuIZVAGq682ctS2u/pInLxhO5QbmB+g835D/22Pb3Vgv1KhfDDzSDsbZy9i
        lmpR3y1YYr6inC257Kit2JShOphUvvLieE79DRyIJFZX2I/WTKHZJQWoWcATKxDcwaJ51gtOSvX8F
        8ycRRX0udJsYRVCLiqXafKmJKeqAWwW6QvJgu8P321g8h6kVt1ESX9K9Y+0haeuwZSWlPWykgOLCa
        oLesLzCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peFHu-0093xe-1V;
        Mon, 20 Mar 2023 13:10:58 +0000
Date:   Mon, 20 Mar 2023 06:10:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v19 00/15] splice, block: Use page pinning and kill
 ITER_PIPE
Message-ID: <ZBhbYkTonYVY1xa4@infradead.org>
References: <20230315163549.295454-1-dhowells@redhat.com>
 <167890243414.54517.7660243890362126266.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167890243414.54517.7660243890362126266.b4-ty@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 11:47:14AM -0600, Jens Axboe wrote:
> > [...]
> 
> Applied, thanks!

Dave, now that the basic patchset is in, can you resurrect the
patch to conver the legacy direct-io code?  That would allow
us to instantly the PAGE_REF version of the bio_release_pages,
and also be a giant step toward never modifying page contents
from a regular get_user_pages, and thus fix the file system
problems around that.
