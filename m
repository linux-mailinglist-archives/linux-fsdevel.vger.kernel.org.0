Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FDAD863C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 05:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbfJPDNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 23:13:04 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:37087 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727544AbfJPDNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:13:04 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4A37343E753;
        Wed, 16 Oct 2019 14:13:00 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iKZkB-0002ry-6g; Wed, 16 Oct 2019 14:12:59 +1100
Date:   Wed, 16 Oct 2019 14:12:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH v3] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20191016031259.GH15134@dread.disaster.area>
References: <20191014220940.GF13098@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191014220940.GF13098@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=XobE76Q3jBoA:10
        a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=TDX8A0Kee3vNHL822sIA:9 a=P0TfUWSjtx0ZhHvf:21 a=Tl8fea81EZ5SM3ls:21
        a=wPNLvfGTeEIA:10 a=cQPPKAXgyycSBL8etih5:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 03:09:40PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Andreas Grünbacher reports that on the two filesystems that support
> iomap directio, it's possible for splice() to return -EAGAIN (instead of
> a short splice) if the pipe being written to has less space available in
> its pipe buffers than the length supplied by the calling process.
> 
> Months ago we fixed splice_direct_to_actor to clamp the length of the
> read request to the size of the splice pipe.  Do the same to do_splice.
> 
> Fixes: 17614445576b6 ("splice: don't read more than available pipe space")
> Reported-by: syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com
> Reported-by: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/splice.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 98412721f056..e509239d7e06 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -945,12 +945,13 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
>  	WARN_ON_ONCE(pipe->nrbufs != 0);
>  
>  	while (len) {
> +		unsigned int pipe_pages;

define this as a size_t...

>  		size_t read_len;
>  		loff_t pos = sd->pos, prev_pos = pos;
>  
>  		/* Don't try to read more the pipe has space for. */
> -		read_len = min_t(size_t, len,
> -				 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
> +		pipe_pages = pipe->buffers - pipe->nrbufs;
> +		read_len = min(len, (size_t)pipe_pages << PAGE_SHIFT);

		read_len = min_t(size_t, len, pipe_pages << PAGER_SHIFT);

>  		ret = do_splice_to(in, &pos, pipe, read_len, flags);
>  		if (unlikely(ret <= 0))
>  			goto out_release;
> @@ -1180,8 +1181,15 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>  
>  		pipe_lock(opipe);
>  		ret = wait_for_space(opipe, flags);
> -		if (!ret)
> +		if (!ret) {
> +			unsigned int pipe_pages;
> +
> +			/* Don't try to read more the pipe has space for. */
> +			pipe_pages = opipe->buffers - opipe->nrbufs;
> +			len = min(len, (size_t)pipe_pages << PAGE_SHIFT);

And same here...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
