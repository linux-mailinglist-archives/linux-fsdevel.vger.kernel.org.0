Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FBE3670C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbhDUQ6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:58:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36342 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238561AbhDUQ6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:58:54 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13LGvd3R003456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 12:57:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CBF4815C3B0D; Wed, 21 Apr 2021 12:57:39 -0400 (EDT)
Date:   Wed, 21 Apr 2021 12:57:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, adilger.kernel@dilger.ca,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
Message-ID: <YIBZgx4cm0j7OObj@mit.edu>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
 <20210415145235.GD2069063@infradead.org>
 <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
 <20210420130841.GA3618564@infradead.org>
 <20210421134634.GT8706@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421134634.GT8706@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:46:34PM +0200, Jan Kara wrote:
> 
> Indeed, after 12 years in kernel .bdev_try_to_free_page is implemented only
> by ext4. So maybe it is not that important? I agree with Zhang and
> Christoph that getting the lifetime rules sorted out will be hairy and it
> is questionable, whether it is worth the additional pages we can reclaim.
> Ted, do you remember what was the original motivation for this?

The comment in fs/ext4/super.c is I thought a pretty good explanation:

/*
 * Try to release metadata pages (indirect blocks, directories) which are
 * mapped via the block device.  Since these pages could have journal heads
 * which would prevent try_to_free_buffers() from freeing them, we must use
 * jbd2 layer's try_to_free_buffers() function to release them.
 */

When we modify a metadata block, we attach a journal_head (jh)
structure to the buffer_head, and bump the ref count to prevent the
buffer from being freed.  Before the transaction is committed, the
buffer is marked jbddirty, but the dirty bit is not set until the
transaction commit.

At that back, writeback happens entirely at the discretion of the
buffer cache.  The jbd layer doesn't get notification when the I/O is
completed, nor when there is an I/O error.  (There was an attempt to
add a callback but that was NACK'ed because of a complaint that it was
jbd specific.)

So we don't actually know when it's safe to detach the jh from the
buffer_head and can drop the refcount so that the buffer_head can be
freed.  When the space in the journal starts getting low, we'll look
at at the jh's attached to completed transactions, and see how many of
them have clean bh's, and at that point, we can release the buffer
heads.

The other time when we'll attempt to detach jh's from clean buffers is
via bdev_try_to_free_buffers().  So if we drop the
bdev_try_to_free_page hook, then when we are under memory pressure,
there could be potentially a large percentage of the buffer cache
which can't be freed, and so the OOM-killer might trigger more often.

Now, if we could get a callback on I/O completion on a per-bh basis,
then we could detach the jh when the buffer is clean --- and as a
bonus, we'd get a notification when there was an I/O error writing
back a metadata block, which would be even better.

So how about an even swap?  If we can get a buffer I/O completion
callback, we can drop bdev_to_free_swap hook.....

	     	      			- Ted

	  
						
