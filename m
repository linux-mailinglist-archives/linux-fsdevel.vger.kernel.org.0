Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214FED5EF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfJNJcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 05:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730766AbfJNJcK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:32:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3994DBC2B;
        Mon, 14 Oct 2019 09:32:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AA55C1E4A86; Mon, 14 Oct 2019 11:32:08 +0200 (CEST)
Date:   Mon, 14 Oct 2019 11:32:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/2 v3] iomap: Waiting for IO in iomap_dio_rw()
Message-ID: <20191014093208.GC5939@quack2.suse.cz>
References: <20191014082418.13885-1-jack@suse.cz>
 <20191014085218.GA6102@athena.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014085218.GA6102@athena.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-10-19 19:52:18, Matthew Bobrowski wrote:
> On Mon, Oct 14, 2019 at 10:26:01AM +0200, Jan Kara wrote:
> > Original motivation:
> > 
> > when doing the ext4 conversion of direct IO code to iomap, we found it very
> > difficult to handle inode extension with what iomap code currently provides.
> > Ext4 wants to do inode extension as sync IO (so that the whole duration of
> > IO is protected by inode->i_rwsem), also we need to truncate blocks beyond
> > end of file in case of error or short write. Now in ->end_io handler we don't
> > have the information how long originally the write was (to judge whether we
> > may have allocated more blocks than we actually used) and in ->write_iter
> > we don't know whether / how much of the IO actually succeeded in case of AIO.
> > 
> > Thinking about it for some time I think iomap code makes it unnecessarily
> > complex for the filesystem in case it decides it doesn't want to perform AIO
> > and wants to fall back to good old synchronous IO. In such case it is much
> > easier for the filesystem if it just gets normal error return from
> > iomap_dio_rw() and not just -EIOCBQUEUED.
> > 
> > The first patch in the series adds argument to iomap_dio_rw() to wait for IO
> > completion (internally iomap_dio_rw() already supports this!) and the second
> > patch converts XFS waiting for unaligned DIO write to this new API.
> 
> Ah, wonderful, I was waiting for this to come through.
> 
> I'll rebase my EXT4 direct I/O port on top of these patches and apply
> the discussed changes. Any objections? :)

No, go ahead. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
