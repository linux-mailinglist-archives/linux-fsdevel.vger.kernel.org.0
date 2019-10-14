Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD49D6787
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbfJNQjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 12:39:45 -0400
Received: from sandeen.net ([63.231.237.45]:42480 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfJNQjp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:39:45 -0400
Received: from Liberator-6.local (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id BDFF51164F;
        Mon, 14 Oct 2019 11:39:08 -0500 (CDT)
Subject: Re: [PATCH v3] loop: fix no-unmap write-zeroes request behavior
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
References: <20191010170239.GC13098@magnolia>
 <20191014155030.GS13108@magnolia>
From:   Eric Sandeen <sandeen@sandeen.net>
Message-ID: <9605de8e-ecd7-9e30-ab48-943211d8f931@sandeen.net>
Date:   Mon, 14 Oct 2019 11:39:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191014155030.GS13108@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/14/19 10:50 AM, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Currently, if the loop device receives a WRITE_ZEROES request, it asks
> the underlying filesystem to punch out the range.  This behavior is
> correct if unmapping is allowed.  However, a NOUNMAP request means that
> the caller doesn't want us to free the storage backing the range, so
> punching out the range is incorrect behavior.
> 
> To satisfy a NOUNMAP | WRITE_ZEROES request, loop should ask the
> underlying filesystem to FALLOC_FL_ZERO_RANGE, which is (according to
> the fallocate documentation) required to ensure that the entire range is
> backed by real storage, which suffices for our purposes.
> 
> Fixes: 19372e2769179dd ("loop: implement REQ_OP_WRITE_ZEROES")
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
> v3: refactor into a single fallocate function
> v2: reorganize a little according to hch feedback
> ---
>   drivers/block/loop.c |   26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index f6f77eaa7217..ef6e251857c8 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -417,18 +417,20 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
>   	return ret;
>   }
>   
> -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> +static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> +			int mode)
>   {
>   	/*
> -	 * We use punch hole to reclaim the free space used by the
> -	 * image a.k.a. discard. However we do not support discard if
> -	 * encryption is enabled, because it may give an attacker
> -	 * useful information.
> +	 * We use fallocate to manipulate the space mappings used by the image
> +	 * a.k.a. discard/zerorange. However we do not support this if
> +	 * encryption is enabled, because it may give an attacker useful
> +	 * information.
>   	 */
>   	struct file *file = lo->lo_backing_file;
> -	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
>   	int ret;
>   
> +	mode |= FALLOC_FL_KEEP_SIZE;
> +
>   	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
>   		ret = -EOPNOTSUPP;
>   		goto out;
> @@ -596,9 +598,17 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>   	switch (req_op(rq)) {
>   	case REQ_OP_FLUSH:
>   		return lo_req_flush(lo, rq);
> -	case REQ_OP_DISCARD:
>   	case REQ_OP_WRITE_ZEROES:
> -		return lo_discard(lo, rq, pos);
cxz ÿbvVBV
> +	case REQ_OP_DISCARD:
> +		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);

I get lost in the twisty passages.  What happens if the filesystem hosting the
backing file doesn't support fallocate, and REQ_OP_DISCARD / REQ_OP_WRITE_ZEROES
returns EOPNOTSUPP - discard is advisory, is it ok to fail REQ_OP_WRITE_ZEROES?
Does something at another layer fall back to writing zeros?

-Eric

>   	case REQ_OP_WRITE:
>   		if (lo->transfer)
>   			return lo_write_transfer(lo, rq, pos);
> 
