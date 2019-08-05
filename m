Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97685824B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHESPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 14:15:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHESPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:15:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75I4NHs119532;
        Mon, 5 Aug 2019 18:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=WsdctHZW8T0F3ITXn+xjB7Ih4vj7K7b6ZR3bgMZ/3xQ=;
 b=WhTJOonDb5aFGf9v/aFNn8Yai08ZN6hYnekguzfP//HnYdHqxFRcZ0+HOIylzkDYcz+O
 2ZN12CI2vIJsri9Po6SGvObWLKqQ/fHbzLzLc1dU0mMTlc+si9s/oQO66GDhBVKQ93EU
 gKuv4zS1qofYSLHzNZ9BTj7wGEImpgkfjonb5ghOaKTGLu5h4r8+d8TzkQyY+fczcj86
 KiA/3DmMuFCqipTARllcPuXJVvTQlhSpbCeDl9CBVkVo+yNPG5xSDGdxloo/d40Lp4sF
 3y8thGc2WZNcbpRdqmVskLXelFUo5EhzEDY+a5mBmkm838IbfA766sdmVcG2ZogEazRL RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u52wr0u5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 18:15:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75IA9EP139414;
        Mon, 5 Aug 2019 18:15:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u51kmruce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 18:15:27 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x75IFPji020574;
        Mon, 5 Aug 2019 18:15:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 11:15:25 -0700
Date:   Mon, 5 Aug 2019 11:15:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>
Subject: Block device direct read EIO handling broken?
Message-ID: <20190805181524.GE7129@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908050188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050188
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Damien,

I noticed a regression in xfs/747 (an unreleased xfstest for the
xfs_scrub media scanning feature) on 5.3-rc3.  I'll condense that down
to a simpler reproducer:

# dmsetup table
error-test: 0 209 linear 8:48 0
error-test: 209 1 error 
error-test: 210 6446894 linear 8:48 210

Basically we have a ~3G /dev/sdd and we set up device mapper to fail IO
for sector 209 and to pass the io to the scsi device everywhere else.

On 5.3-rc3, performing a directio pread of this range with a < 1M buffer
(in other words, a request for fewer than MAX_BIO_PAGES bytes) yields
EIO like you'd expect:

# strace -e pread64 xfs_io -d -c 'pread -b 1024k 0k 1120k' /dev/mapper/error-test
pread64(3, 0x7f880e1c7000, 1048576, 0)  = -1 EIO (Input/output error)
pread: Input/output error
+++ exited with 0 +++

But doing it with a larger buffer succeeds(!):

# strace -e pread64 xfs_io -d -c 'pread -b 2048k 0k 1120k' /dev/mapper/error-test
pread64(3, "XFSB\0\0\20\0\0\0\0\0\0\fL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1146880, 0) = 1146880
read 1146880/1146880 bytes at offset 0
1 MiB, 1 ops; 0.0009 sec (1.124 GiB/sec and 1052.6316 ops/sec)
+++ exited with 0 +++

(Note that the part of the buffer corresponding to the dm-error area is
uninitialized)

On 5.3-rc2, both commands would fail with EIO like you'd expect.  The
only change between rc2 and rc3 is commit 0eb6ddfb865c ("block: Fix
__blkdev_direct_IO() for bio fragments").

AFAICT we end up in __blkdev_direct_IO with a 1120K buffer, which gets
split into two bios: one for the first BIO_MAX_PAGES worth of data (1MB)
and a second one for the 96k after that.

I think the problem is that every time we submit a bio, we increase ret
by the size of that bio, but at the time we do that we have no idea if
the bio is going to succeed or not.  At the end of the function we do:

	if (!ret)
		ret = blk_status_to_errno(dio->bio.bi_status);

Which means that we only pick up the IO error if we haven't already set
ret.  I suppose that was useful for being able to return a short read,
but now that we always increment ret by the size of the bio, we act like
the whole buffer was read.  I tried a -rc2 kernel and found that 40% of
the time I'd get an EIO and the rest of the time I got a short read.

Not sure where to go from here, but something's not right...

--D
