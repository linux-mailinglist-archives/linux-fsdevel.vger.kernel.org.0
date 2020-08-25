Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF47A251A8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYOLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 10:11:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37678 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgHYOL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:11:28 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07PEAKeX001465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 10:10:21 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4DA5542010C; Tue, 25 Aug 2020 10:10:20 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:10:20 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        yebin <yebin10@huawei.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200825141020.GA668551@mit.edu>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825121616.GA10294@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(Adding the OCFS2 maintainers, since my possibly insane idea proposed
below would definitely impact them!)

On Tue, Aug 25, 2020 at 01:16:16PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
> > Discarding blocks and buffers under a mounted filesystem is hardly
> > anything admin wants to do. Usually it will confuse the filesystem and
> > sometimes the loss of buffer_head state (including b_private field) can
> > even cause crashes like:
> 
> Doesn't work if the file system uses multiple devices.  I think we
> just really need to split the fs buffer_head address space from the
> block device one.  Everything else is just going to cause a huge mess.

I wonder if we should go a step further, and stop using struct
buffer_head altogether in jbd2 and ext4 (as well as ocfs2).

This would involve moving whatever structure elements from the
buffer_head struct into journal_head, and manage writeback and reads
requests directly in jbd2.  This would allow us to get detailed write
errors back, which is currently not possible from the buffer_head
infrastructure.

The downside is this would be a pretty massive change in terms of LOC,
since we use struct buffer_head in a *huge* number of places.  If
we're careful, most of it could be handled by a Coccinelle script to
rename "struct buffer_head" to "struct journal_head".  Fortunately, we
don't actually use that much of the fs/buffer_head functions in
fs/{ext4,ocfs2}/*.c.

One potentially tricky bit is that ocfs2 hasn't been converted to
using iomap, so it's still using __blockdev_direct_IO.  So it's data
blocks for DIO would still have to use struct buffer_head (which means
the Coccinelle script won't really work for fs/ocfs2, without a lot of
manual rework) --- or ocfs2 would have to switched to use iomap at
least for DIO support.

What do folks think?

						- Ted

