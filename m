Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0811166EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 05:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgBUEvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 23:51:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729371AbgBUEvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:51:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L4nZGJ041350
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 23:51:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uc2391g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 23:51:15 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 21 Feb 2020 04:51:14 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 04:51:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L4pBdM53018724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 04:51:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F88C52054;
        Fri, 21 Feb 2020 04:51:11 +0000 (GMT)
Received: from [9.199.159.36] (unknown [9.199.159.36])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 612705204E;
        Fri, 21 Feb 2020 04:51:10 +0000 (GMT)
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com
References: <20200220152355.5ticlkptc7kwrifz@fiona>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 21 Feb 2020 10:21:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200220152355.5ticlkptc7kwrifz@fiona>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022104-0012-0000-0000-00000388D60C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022104-0013-0000-0000-000021C56EC3
Message-Id: <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210031
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/20/20 8:53 PM, Goldwyn Rodrigues wrote:
> In case of a block device error, written parameter in iomap_end()
> is zero as opposed to the amount of submitted I/O.
> Filesystems such as btrfs need to account for the I/O in ordered
> extents, even if it resulted in an error. Having (incomplete)
> submitted bytes in written gives the filesystem the amount of data
> which has been submitted before the error occurred, and the
> filesystem code can choose how to use it.
> 
> The final returned error for iomap_dio_rw() is set by
> iomap_dio_complete().
> 
> Partial writes in direct I/O are considered an error. So,
> ->iomap_end() using written == 0 as error must be changed
> to written < length. In this case, ext4 is the only user.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/ext4/inode.c      | 2 +-
>   fs/iomap/direct-io.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e60aca791d3f..e50e7414351a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3475,7 +3475,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>   	 * the I/O. Any blocks that may have been allocated in preparation for
>   	 * the direct I/O will be reused during buffered I/O.
>   	 */
> -	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
> +	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written < length)
>   		return -ENOTBLK;
>   
>   	return 0;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 41c1e7c20a1f..01865db1bd09 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>   		size_t n;
>   		if (dio->error) {
>   			iov_iter_revert(dio->submit.iter, copied);
> -			copied = ret = 0;
> +			ret = 0;
>   			goto out;
>   		}

But if I am seeing this correctly, even after there was a dio->error
if you return copied > 0, then the loop in iomap_dio_rw will continue
for next iteration as well. Until the second time it won't copy
anything since dio->error is set and from there I guess it may return
0 which will break the loop.

Is this the correct flow? Shouldn't the while loop doing
iomap_apply in iomap_dio_rw should also break in case of
dio->error? Or did I miss anything?


-ritesh

