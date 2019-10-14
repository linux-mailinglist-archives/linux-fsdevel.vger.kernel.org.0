Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB1D67E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJNRA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 13:00:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJNRA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:00:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EGmuot021062;
        Mon, 14 Oct 2019 17:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=drp32Hf0z+K1NYvV7OdTo/hSVCjFrH0pn7yk+X1yaas=;
 b=mNjaGKWBZtyeMjFFnapWg2GN0oFCdyb2LibNHok6lOjc5vC3XeFDfFWesawiuKq5Mcbh
 Q9jRisl1nhuRQH3puvbbqogLUTD6wBwMMCv9fUaZiCDj/MnwyCzSiBI6z2tU6cktl8wc
 Ko5FVseq1+LguhSW5PstvWqy15LXnAWZR293FQMSw372k3RpVuvwM2TqJQPwe1ZX5wZj
 zxYxrWnWow08TIy1qBIcdyZfffc7egTIVNWlruovMjDjvgT7Olc5jyP0pn6bWKeZ0sDz
 zW7kQbWzJKgsVLBNu/MkLsy/IIc9/iilyfZMhPmULfbNV+f2y/6ic6KNPeYRwBj7Vq2a 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vk7fr253r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 17:00:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EGrieE103194;
        Mon, 14 Oct 2019 17:00:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vkr9xat2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 17:00:45 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9EH0hLH027091;
        Mon, 14 Oct 2019 17:00:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 17:00:43 +0000
Date:   Mon, 14 Oct 2019 10:00:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v3] loop: fix no-unmap write-zeroes request behavior
Message-ID: <20191014170041.GT13108@magnolia>
References: <20191010170239.GC13098@magnolia>
 <20191014155030.GS13108@magnolia>
 <9605de8e-ecd7-9e30-ab48-943211d8f931@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9605de8e-ecd7-9e30-ab48-943211d8f931@sandeen.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140144
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:39:43AM -0500, Eric Sandeen wrote:
> On 10/14/19 10:50 AM, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Currently, if the loop device receives a WRITE_ZEROES request, it asks
> > the underlying filesystem to punch out the range.  This behavior is
> > correct if unmapping is allowed.  However, a NOUNMAP request means that
> > the caller doesn't want us to free the storage backing the range, so
> > punching out the range is incorrect behavior.
> > 
> > To satisfy a NOUNMAP | WRITE_ZEROES request, loop should ask the
> > underlying filesystem to FALLOC_FL_ZERO_RANGE, which is (according to
> > the fallocate documentation) required to ensure that the entire range is
> > backed by real storage, which suffices for our purposes.
> > 
> > Fixes: 19372e2769179dd ("loop: implement REQ_OP_WRITE_ZEROES")
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> > v3: refactor into a single fallocate function
> > v2: reorganize a little according to hch feedback
> > ---
> >   drivers/block/loop.c |   26 ++++++++++++++++++--------
> >   1 file changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index f6f77eaa7217..ef6e251857c8 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -417,18 +417,20 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
> >   	return ret;
> >   }
> > -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> > +static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> > +			int mode)
> >   {
> >   	/*
> > -	 * We use punch hole to reclaim the free space used by the
> > -	 * image a.k.a. discard. However we do not support discard if
> > -	 * encryption is enabled, because it may give an attacker
> > -	 * useful information.
> > +	 * We use fallocate to manipulate the space mappings used by the image
> > +	 * a.k.a. discard/zerorange. However we do not support this if
> > +	 * encryption is enabled, because it may give an attacker useful
> > +	 * information.
> >   	 */
> >   	struct file *file = lo->lo_backing_file;
> > -	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> >   	int ret;
> > +	mode |= FALLOC_FL_KEEP_SIZE;
> > +
> >   	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> >   		ret = -EOPNOTSUPP;
> >   		goto out;
> > @@ -596,9 +598,17 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> >   	switch (req_op(rq)) {
> >   	case REQ_OP_FLUSH:
> >   		return lo_req_flush(lo, rq);
> > -	case REQ_OP_DISCARD:
> >   	case REQ_OP_WRITE_ZEROES:
> > -		return lo_discard(lo, rq, pos);
> cxz ÿbvVBV

Yes.

> > +	case REQ_OP_DISCARD:
> > +		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
> 
> I get lost in the twisty passages.  What happens if the filesystem hosting the
> backing file doesn't support fallocate, and REQ_OP_DISCARD / REQ_OP_WRITE_ZEROES
> returns EOPNOTSUPP - discard is advisory, is it ok to fail REQ_OP_WRITE_ZEROES?
> Does something at another layer fall back to writing zeros?

If the REQ_OP_WRITE_ZEROES request was initiated by blkdev_issue_zeroout
and we send back an error code, blkdev_issue_zeroout will fall back to
writing zeroes if BLKDEV_ZERO_NOFALLBACK wasn't set its caller.

Note that calling FALLOC_FL_ZERO_RANGE on a block device will generate
a REQ_OP_WRITE_ZEROES | REQ_OP_NOUNMAP request, which means that it will
try fallocate zeroing and fall back to writing zeroes.

--D

> 
> -Eric
> 
> >   	case REQ_OP_WRITE:
> >   		if (lo->transfer)
> >   			return lo_write_transfer(lo, rq, pos);
> > 
