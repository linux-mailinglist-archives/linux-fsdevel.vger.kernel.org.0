Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F5109A42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 09:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfKZIex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 03:34:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbfKZIex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:34:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQ8QdsQ093871
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 03:34:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wfju94w6x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 03:34:51 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 26 Nov 2019 08:34:49 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Nov 2019 08:34:46 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQ8YjDC35914064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 08:34:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9A2CA405F;
        Tue, 26 Nov 2019 08:34:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1FD5A405B;
        Tue, 26 Nov 2019 08:34:43 +0000 (GMT)
Received: from [9.199.158.76] (unknown [9.199.158.76])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Nov 2019 08:34:43 +0000 (GMT)
Subject: Re: [PATCH] f2fs: Fix direct IO handling
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 26 Nov 2019 14:04:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191126075719.1046485-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112608-0028-0000-0000-000003C017DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112608-0029-0000-0000-000024831879
Message-Id: <20191126083443.F1FD5A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_01:2019-11-21,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260076
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Damien,

IIUC, you are trying to fix a stale data read by DIO read for the case
you explained in your patch w.r.t. DIO-write forced to write as buffIO.

Coincidentally I was just looking at the same code path just now.
So I do have a query to you/f2fs group. Below could be silly one, as I
don't understand F2FS in great detail.

How is the stale data by DIO read, is protected against a mmap
writes via f2fs_vm_page_mkwrite?

f2fs_vm_page_mkwrite()		 f2fs_direct_IO (read)
					filemap_write_and_wait_range()
	-> f2fs_get_blocks()				
					 -> submit_bio()

	-> set_page_dirty()

Is above race possible with current f2fs code?
i.e. f2fs_direct_IO could read the stale data from the blocks
which were allocated due to mmap fault?

Am I missing something here?

-ritesh

On 11/26/19 1:27 PM, Damien Le Moal wrote:
> f2fs_preallocate_blocks() identifies direct IOs using the IOCB_DIRECT
> flag for a kiocb structure. However, the file system direct IO handler
> function f2fs_direct_IO() may have decided that a direct IO has to be
> exececuted as a buffered IO using the function f2fs_force_buffered_io().
> This is the case for instance for volumes including zoned block device
> and for unaligned write IOs with LFS mode enabled.
> 
> These 2 different methods of identifying direct IOs can result in
> inconsistencies generating stale data access for direct reads after a
> direct IO write that is treated as a buffered write. Fix this
> inconsistency by combining the IOCB_DIRECT flag test with the result
> of f2fs_force_buffered_io().
> 
> Reported-by: Javier Gonzalez <javier@javigon.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   fs/f2fs/data.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 5755e897a5f0..8ac2d3b70022 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1073,6 +1073,8 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>   	int flag;
>   	int err = 0;
>   	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
> +	bool do_direct_io = direct_io &&
> +		!f2fs_force_buffered_io(inode, iocb, from);
>   
>   	/* convert inline data for Direct I/O*/
>   	if (direct_io) {
> @@ -1081,7 +1083,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>   			return err;
>   	}
>   
> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
> +	if (do_direct_io && allow_outplace_dio(inode, iocb, from))
>   		return 0;
>   
>   	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
> 

