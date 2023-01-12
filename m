Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBAD6678BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbjALPNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 10:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjALPM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:12:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446E551DE;
        Thu, 12 Jan 2023 07:02:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 274BA68BEB; Thu, 12 Jan 2023 16:02:05 +0100 (CET)
Date:   Thu, 12 Jan 2023 16:02:04 +0100
From:   Christoph Hellwig <hch@lst.de>
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
Message-ID: <20230112150204.GA11315@lst.de>
References: <Y8AWY991ilrO5Yco@infradead.org> <Y7+6YVkhZsvdW+Hr@infradead.org> <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk> <167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk> <15237.1673519321@warthog.procyon.org.uk> <Y8AUjB5hxkwxhnGK@infradead.org> <147887.1673535529@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147887.1673535529@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:58:49PM +0000, David Howells wrote:
> That's kind of what I'm doing - though I've left out the else just in case the
> VM decides to indicate back both FOLL_GET and FOLL_PIN.  I'm not sure why it
> would but...

It really can't - they are exclusive.  Maybe we need an assert for that
somewhere, but we surely shouldn't try to deal with it.
