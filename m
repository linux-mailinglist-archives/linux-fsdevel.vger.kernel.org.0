Return-Path: <linux-fsdevel+bounces-5463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F2880C779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212F81F2140C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6D347A2;
	Mon, 11 Dec 2023 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ojnCA0HE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36219F;
	Mon, 11 Dec 2023 02:57:43 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBAcjic011590;
	Mon, 11 Dec 2023 10:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=M1BWtUt0iko0Adg1ZOkNjmTGZ72097YAF9y4jIcKxGU=;
 b=ojnCA0HEGHQ9qrUscY1w6xO8r1ooEoc7j7AVYhWGo6ISun4rjqhl6uv3YU49EvYXryzS
 FlOIKr7WuGVwlXnQBVvMYnhtc8i28ZjbZaIDrseOd/NMRX/S75hjaFKjKMj+YggljZ3n
 QNeR15hIzHpiGAvrK+gu+QUKDQcAPl/Jwp8sKhWGnLSCXYO3r2E/Dv+bMHQ+bl3UzV9N
 uOqzK+47Sx4XeMq8oD+tzJpYe6jM/rI5/GokIvv7dOzk+Z4kwbdCmsDiohMOEdaK1XK1
 cmeSyS1+IMRLp1CUYUcAGv8pyGCiBiJmjXdM45fRChFnuB173q9vLvMhmFdne2nSfUpb Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ux0usre9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 10:57:38 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BBAdt9m015254;
	Mon, 11 Dec 2023 10:57:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ux0usre9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 10:57:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBAeHXD012585;
	Mon, 11 Dec 2023 10:57:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jngtn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 10:57:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BBAvYrf5505562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 10:57:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3B620040;
	Mon, 11 Dec 2023 10:57:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B92220043;
	Mon, 11 Dec 2023 10:57:33 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.31.44])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 Dec 2023 10:57:32 +0000 (GMT)
Date: Mon, 11 Dec 2023 16:27:30 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
Subject: Re: [RFC 5/7] block: export blkdev_atomic_write_valid() and refactor
 api
Message-ID: <ZXbrGvkJRIJmRtex@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <b53609d0d4b97eb9355987ac5ec03d4e89293b43.1701339358.git.ojaswin@linux.ibm.com>
 <cc43b1ba-e9ea-4ff1-b616-be3c11960eea@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc43b1ba-e9ea-4ff1-b616-be3c11960eea@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2qSPiO9EIfi0hMR8TWZ7coYjvt_2Rxt6
X-Proofpoint-GUID: wdXyzKPFaRaC5ZtASZOrE_sXJCXo-opo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_04,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=856
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110087

On Fri, Dec 01, 2023 at 10:47:59AM +0000, John Garry wrote:
> On 30/11/2023 13:53, Ojaswin Mujoo wrote:
> > Export the blkdev_atomic_write_valid() function so that other filesystems
> > can call it as a part of validating the atomic write operation.
> > 
> > Further, refactor the api to accept a len argument instead of iov_iter to
> > make it easier to call from other places.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> I was actually thinking of moving this functionality to vfs and maybe also
> calling earlier in write path, as the code is really common to blkdev and
> FSes.

This makes sense. The code to make sure the underlying device
will be able to support this atomic write can be moved higher up in vfs.
And then each fs can do extra fs-specific checks in their code.

> 
> However, Christoph Hellwig was not so happy about current interface with
> power-of-2 requirement et al, so I was going to wait until that discussion
> is concluded before deciding.

Got it, I'll leave this bit to you then :) 

> 
> Thanks,
> John
> 
> > ---
> >   block/fops.c           | 18 ++++++++++--------
> >   include/linux/blkdev.h |  2 ++
> >   2 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/block/fops.c b/block/fops.c
> > index 516669ad69e5..5dae95c49720 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -41,8 +41,7 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
> >   		!bdev_iter_is_aligned(bdev, iter);
> >   }
> > -static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
> > -			      struct iov_iter *iter)
> > +bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos, size_t len)
> >   {
> >   	unsigned int atomic_write_unit_min_bytes =
> >   			queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
> > @@ -53,16 +52,17 @@ static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
> >   		return false;
> >   	if (pos % atomic_write_unit_min_bytes)
> >   		return false;
> > -	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> > +	if (len % atomic_write_unit_min_bytes)
> >   		return false;
> > -	if (!is_power_of_2(iov_iter_count(iter)))
> > +	if (!is_power_of_2(len))
> >   		return false;
> > -	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
> > +	if (len > atomic_write_unit_max_bytes)
> >   		return false;
> > -	if (pos % iov_iter_count(iter))
> > +	if (pos % len)
> >   		return false;
> >   	return true;
> >   }
> > +EXPORT_SYMBOL_GPL(blkdev_atomic_write_valid);
> >   #define DIO_INLINE_BIO_VECS 4
> > @@ -81,7 +81,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
> >   	if (blkdev_dio_unaligned(bdev, pos, iter))
> >   		return -EINVAL;
> > -	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
> > +	if (atomic_write &&
> > +	    !blkdev_atomic_write_valid(bdev, pos, iov_iter_count(iter)))
> >   		return -EINVAL;
> >   	if (nr_pages <= DIO_INLINE_BIO_VECS)
> > @@ -348,7 +349,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
> >   	if (blkdev_dio_unaligned(bdev, pos, iter))
> >   		return -EINVAL;
> > -	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
> > +	if (atomic_write &&
> > +	    !blkdev_atomic_write_valid(bdev, pos, iov_iter_count(iter)))
> >   		return -EINVAL;
> >   	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index f70988083734..5a3124fc191f 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1566,6 +1566,8 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
> >   int freeze_bdev(struct block_device *bdev);
> >   int thaw_bdev(struct block_device *bdev);
> > +bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos, size_t len);
> > +
> >   struct io_comp_batch {
> >   	struct request *req_list;
> >   	bool need_ts;
> 

