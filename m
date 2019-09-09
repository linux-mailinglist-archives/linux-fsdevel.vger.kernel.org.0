Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45C8AD421
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfIIHsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 03:48:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388282AbfIIHst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:48:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x897lQdO064479
        for <linux-fsdevel@vger.kernel.org>; Mon, 9 Sep 2019 03:48:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uwgtuvrg4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:48:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 9 Sep 2019 08:48:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 08:48:42 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x897mglB24444938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 07:48:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 051A242045;
        Mon,  9 Sep 2019 07:48:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04FE642042;
        Mon,  9 Sep 2019 07:48:40 +0000 (GMT)
Received: from [9.199.158.183] (unknown [9.199.158.183])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 07:48:39 +0000 (GMT)
Subject: Re: [PATCH v2 1/6] ext4: introduce direct IO read path using iomap
 infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <75a6ead09a10e362526a849af482510a0090f82a.1567978633.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 9 Sep 2019 13:18:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <75a6ead09a10e362526a849af482510a0090f82a.1567978633.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090907-0012-0000-0000-00000348A7F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090907-0013-0000-0000-0000218306FF
Message-Id: <20190909074840.04FE642042@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090086
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/9/19 4:48 AM, Matthew Bobrowski wrote:
> This patch introduces a new direct IO read path that makes use of the
> iomap infrastructure.
> 
> The new function ext4_dio_read_iter() is responsible for calling into
> the iomap infrastructure via iomap_dio_rw(). If the inode in question
> does not pass preliminary checks in ext4_dio_checks(), then we simply
> fallback to buffered IO and take that path to fulfil the request. It's
> imperative that we drop the IOCB_DIRECT flag from iocb->ki_flags in
> order to prevent generic_file_read_iter() from trying to take the
> direct IO code path again.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Looks good to me.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/file.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 70b0438dbc94..e52e3928dc25 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -34,6 +34,53 @@
>   #include "xattr.h"
>   #include "acl.h"
> 
> +static bool ext4_dio_checks(struct inode *inode)
> +{
> +#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> +	if (IS_ENCRYPTED(inode))
> +		return false;
> +#endif
> +	if (ext4_should_journal_data(inode))
> +		return false;
> +	if (ext4_has_inline_data(inode))
> +		return false;
> +	return true;
> +}
> +
> +static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	/*
> +	 * Get exclusion from truncate and other inode operations.
> +	 */
> +	if (!inode_trylock_shared(inode)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		inode_lock_shared(inode);
> +	}
> +
> +	if (!ext4_dio_checks(inode)) {
> +		inode_unlock_shared(inode);
> +		/*
> +		 * Fallback to buffered IO if the operation being
> +		 * performed on the inode is not supported by direct
> +		 * IO. The IOCB_DIRECT flag flags needs to be cleared
> +		 * here to ensure that the direct IO code path within
> +		 * generic_file_read_iter() is not taken again.
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		return generic_file_read_iter(iocb, to);
> +	}
> +
> +	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL);
> +	inode_unlock_shared(inode);
> +
> +	file_accessed(iocb->ki_filp);
> +	return ret;
> +}
> +
>   #ifdef CONFIG_FS_DAX
>   static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
> @@ -64,16 +111,19 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
> 
>   static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>   		return -EIO;
> 
>   	if (!iov_iter_count(to))
>   		return 0; /* skip atime */
> 
> -#ifdef CONFIG_FS_DAX
> -	if (IS_DAX(file_inode(iocb->ki_filp)))
> +	if (IS_DAX(inode))
>   		return ext4_dax_read_iter(iocb, to);
> -#endif
> +
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return ext4_dio_read_iter(iocb, to);
>   	return generic_file_read_iter(iocb, to);
>   }
> 

