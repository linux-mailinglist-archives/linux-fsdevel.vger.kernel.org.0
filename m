Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D793E322D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Aug 2021 01:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbhHFXta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 19:49:30 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:33106 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240164AbhHFXt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 19:49:29 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 629C51142E81;
        Sat,  7 Aug 2021 09:49:09 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mC9aO-00FLzu-AW; Sat, 07 Aug 2021 09:49:08 +1000
Date:   Sat, 7 Aug 2021 09:49:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: optimise generic_file_read_iter
Message-ID: <20210806234908.GC2566745@dread.disaster.area>
References: <07bd408d6cad95166b776911823b40044160b434.1628248975.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bd408d6cad95166b776911823b40044160b434.1628248975.git.asml.silence@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=MhDmnRu9jo8A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=0ShQZFDq3J1pPZILnEgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 06, 2021 at 12:42:43PM +0100, Pavel Begunkov wrote:
> Unless direct I/O path of generic_file_read_iter() ended up with an
> error or a short read, it doesn't use inode. So, load inode and size
> later, only when they're needed. This cuts two memory reads and also
> imrpoves code generation, e.g. loads from stack.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> NOTE: as a side effect, it reads inode->i_size after ->direct_IO(), and
> I'm not sure whether that's valid, so would be great to get feedback
> from someone who knows better.

I can see that it changes behaviour in a very subtle way. It depends
on what each individual filesystem does with direct IO as to whether
this may introduce potential data coherency/corruption issues, so I
can't say that it's a safe change. It doesn't affect XFS, because
XFS doesn't do direct IO through generic_file_read_iter().

Fundamentally, the issue is that ->direct_IO() can race with inode
size extensions due to write IO completions while the read IO is in
flight.

>  mm/filemap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d1458ecf2f51..0030c454ec35 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2658,10 +2658,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		struct file *file = iocb->ki_filp;
>  		struct address_space *mapping = file->f_mapping;
> -		struct inode *inode = mapping->host;
> -		loff_t size;
> +		struct inode *inode;
>  
> -		size = i_size_read(inode);
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
>  						iocb->ki_pos + count - 1))
> @@ -2693,8 +2691,10 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		 * the rest of the read.  Buffered reads will not work for
>  		 * DAX files, so don't bother trying.
>  		 */
> -		if (retval < 0 || !count || iocb->ki_pos >= size ||
> -		    IS_DAX(inode))

Hence this check in the current code is determining if the IO file
offset *after* the IO completed is at or beyond the EOF *before the
IO was started*. i.e. it always detects a short read, because the
EOF can only ascend while a DIO is in progress - truncation cannot
run concurrently with DIO reads. Hence if we get less bytes read
than we ask for, and we are beyond the EOF we sampled at the start
of the IO, we know for certain we got a short read and we drop out
without going through the buffered read path.

> +		if (retval < 0 || !count)
> +			return retval;
> +		inode = mapping->host;
> +		if (iocb->ki_pos >= i_size_read(inode) || IS_DAX(inode))
>  			return retval;

This changes the check to read the inode size after the read IO
completed. This means the IO could have raced with size extensions
from other concurrent DIO writes (or even racing buffered IO
writeback), so despite getting less bytes than we asked for, we
won't detect it as a short DIO read. Hence we now fall through to the
buffered read path.

So at minimum, this is a _very subtle_ change of behaviour in the
direct IO code, resulting in short reads at EOF now sometimes
falling through to the buffered IO path where they never did before.
It may not be an issue but per-filesystem audits will be needed to
determine that....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
