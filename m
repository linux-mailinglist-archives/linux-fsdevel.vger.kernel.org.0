Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF710E379
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 21:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLAUwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 15:52:03 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42677 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbfLAUwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 15:52:03 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8B1877EAA0C;
        Mon,  2 Dec 2019 07:51:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ibWCB-0004x6-QA; Mon, 02 Dec 2019 07:51:55 +1100
Date:   Mon, 2 Dec 2019 07:51:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 7/7] fs: Do not overload update_time
Message-ID: <20191201205155.GA2418@dread.disaster.area>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
 <20191130053030.7868-8-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130053030.7868-8-deepa.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=drOt6m5kAAAA:8 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8 a=0Q_S0N9JtFWJ8H0_tKkA:9
        a=CjuIK1q_8ugA:10 a=RMMjzBEyIzXRtoq5n5K6:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 29, 2019 at 09:30:30PM -0800, Deepa Dinamani wrote:
> update_time() also has an internal function pointer
> update_time. Even though this works correctly, it is
> confusing to the readers.
> 
> Use a different name for the local variable.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  fs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 12c9e38529c9..0be58a680457 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1675,12 +1675,12 @@ EXPORT_SYMBOL(generic_update_time);
>   */
>  static int update_time(struct inode *inode, struct timespec64 *time, int flags)
>  {
> -	int (*update_time)(struct inode *, struct timespec64 *, int);
> +	int (*cb)(struct inode *, struct timespec64 *, int);
>  
> -	update_time = inode->i_op->update_time ? inode->i_op->update_time :
> +	cb = inode->i_op->update_time ? inode->i_op->update_time :
>  		generic_update_time;
>  
> -	return update_time(inode, time, flags);
> +	return cb(inode, time, flags);

What's wrong with a simple if() like we use everywhere else for this
sort of thing?

	if (inode->i_op->update_time)
		return inode->i_op->update_time(inode, time, flags);
	return generic_update_time(inode, time, flags);

-Dave.
-- 
Dave Chinner
david@fromorbit.com
