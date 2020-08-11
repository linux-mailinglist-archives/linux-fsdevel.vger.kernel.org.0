Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB38241634
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgHKGNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 02:13:20 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:37833 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgHKGNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:13:20 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 91FE9760815;
        Tue, 11 Aug 2020 16:13:16 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k5NX8-0002CA-9F; Tue, 11 Aug 2020 16:13:14 +1000
Date:   Tue, 11 Aug 2020 16:13:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: RWF_NOWAIT should imply IOCB_NOIO
Message-ID: <20200811061314.GF2079@dread.disaster.area>
References: <e8325bef-7e91-5fd4-fa25-74cfa169ffd2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8325bef-7e91-5fd4-fa25-74cfa169ffd2@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=4G0RZZJQyTIlTLWZrEUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:48:19PM -0600, Jens Axboe wrote:
> With the change allowing read-ahead for IOCB_NOWAIT, we changed the
> RWF_NOWAIT semantics of only doing cached reads. Since we know have
> IOCB_NOIO to manage that specific side of it, just make RWF_NOWAIT
> imply IOCB_NOIO as well to restore the previous behavior.
> 
> Fixes: 2e85abf053b9 ("mm: allow read-ahead with IOCB_NOWAIT set")
> Reported-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> This was a known change with the buffered async read change, but we
> didn't have IOCB_NOIO until late in 5.8. Now that bases are synced,
> make the change to make RWF_NOWAIT behave like past kernels.
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bd7ec3eaeed0..f1cca4bfdd7b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3293,7 +3293,7 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>  	if (flags & RWF_NOWAIT) {
>  		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
>  			return -EOPNOTSUPP;
> -		kiocb_flags |= IOCB_NOWAIT;
> +		kiocb_flags |= IOCB_NOWAIT | IOCB_NOIO;
>  	}
>  	if (flags & RWF_HIPRI)
>  		kiocb_flags |= IOCB_HIPRI;

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
