Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA0672C54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 00:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjARXQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 18:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjARXQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:16:01 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA1613E1;
        Wed, 18 Jan 2023 15:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MB9kq0fFFlGTsboelqAWCteqxEtqCr2RNwDw4mwuDis=; b=vB/sKZ5ty7EdMSxKZeNMzxWY1F
        zGbSqs74vKdUGL2TL5qC9uwj6oKK7gnVoCozYR0/DYyNGrhEK5LXYtGct7NUf7Fnkx1xA6WET+yy3
        QLD43JVTtZoT9VT+2x714a/oSr8/LJNTfb9moCoEIRq4tvipgCWdxAyMJtVEHM8wzBMaPuDBbaHTi
        1Ny8gb7pGDu+/YR6CyahAaLAgzi63yRTCyOujmCf3EHtNmIj4YnbNoZlQBm2WDyvXqSBIN2rVWSNy
        KVAAvODuwUUrNnQumoYojbGIrWUbUZWAJyZ/SXrMTQiN6lktCbzjDvftamhBy9y/CjYWrbqeA9fzS
        AgYmBZPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIHeq-002dSD-3C;
        Wed, 18 Jan 2023 23:15:53 +0000
Date:   Wed, 18 Jan 2023 23:15:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/34] iov_iter: Use the direction in the iterator
 functions
Message-ID: <Y8h9qAZ9ePz+8MFj@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391052497.2311931.9463379582932734164.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391052497.2311931.9463379582932734164.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:08:44PM +0000, David Howells wrote:
> Use the direction in the iterator functions rather than READ/WRITE.
> 
> Add a check into __iov_iter_get_pages_alloc() that the supplied
> FOLL_SOURCE/DEST_BUF gup_flag matches the ITER_SOURCE/DEST flag on the
> iterator.

Incidentally, s/iterator/initializer/ (or constructor, for that matter).
Those are not iterators...
