Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43FE89E6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfHLMcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 08:32:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbfHLMcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:32:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CCT03d020986
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 08:32:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ub62wcxpb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 08:32:08 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 12 Aug 2019 13:32:05 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 13:32:03 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CCVhXr14942510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 12:31:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B57EC52050;
        Mon, 12 Aug 2019 12:32:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 904205204F;
        Mon, 12 Aug 2019 12:32:01 +0000 (GMT)
Subject: Re: [PATCH 07/13] btrfs: basic direct read operation
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        ruansy.fnst@cn.fujitsu.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-8-rgoldwyn@suse.de>
From:   RITESH HARJANI <riteshh@linux.ibm.com>
Date:   Mon, 12 Aug 2019 18:02:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802220048.16142-8-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081212-4275-0000-0000-00000358325E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081212-4276-0000-0000-0000386A3EB6
Message-Id: <20190812123201.904205204F@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120141
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/3/19 3:30 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> Add btrfs_dio_iomap_ops for iomap.begin() function. In order to
> accomodate dio reads, add a new function btrfs_file_read_iter()
> which would call btrfs_dio_iomap_read() for DIO reads and
> fallback to generic_file_read_iter otherwise.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/btrfs/ctree.h |  2 ++
>   fs/btrfs/file.c  | 10 +++++++++-
>   fs/btrfs/iomap.c | 20 ++++++++++++++++++++
>   3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7a4ff524dc77..9eca2d576dd1 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3247,7 +3247,9 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
>   loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
>   			      struct file *file_out, loff_t pos_out,
>   			      loff_t len, unsigned int remap_flags);
> +/* iomap.c */
>   size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from);
> +ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to);
>   
>   /* tree-defrag.c */
>   int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f7087e28ac08..997eb152a35a 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2839,9 +2839,17 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
>   	return generic_file_open(inode, filp);
>   }
>   
> +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return btrfs_dio_iomap_read(iocb, to);

No provision to fallback to bufferedIO read? Not sure from btrfs 
perspective,
but earlier generic_file_read_iter may fall through to bufferedIO read 
say in case where directIO could not be completed (returned 0 or less 
than the requested read bytes).
Is it not required anymore in case of btrfs when we move to iomap 
infrastructure, to still fall back to bufferedIO read?
Correct me if I am missing anything here.

> +
> +	return generic_file_read_iter(iocb, to);
> +}
> +
>   const struct file_operations btrfs_file_operations = {
>   	.llseek		= btrfs_file_llseek,
> -	.read_iter      = generic_file_read_iter,
> +	.read_iter      = btrfs_file_read_iter,
>   	.splice_read	= generic_file_splice_read,
>   	.write_iter	= btrfs_file_write_iter,
>   	.mmap		= btrfs_file_mmap,
> diff --git a/fs/btrfs/iomap.c b/fs/btrfs/iomap.c
> index 879038e2f1a0..36df606fc028 100644
> --- a/fs/btrfs/iomap.c
> +++ b/fs/btrfs/iomap.c
> @@ -420,3 +420,23 @@ size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
>   	return written;
>   }
>   
> +static int btrfs_dio_iomap_begin(struct inode *inode, loff_t pos,
> +		loff_t length, unsigned flags, struct iomap *iomap,
> +		struct iomap *srcmap)
> +{
> +	return get_iomap(inode, pos, length, iomap);
> +}
> +
> +static const struct iomap_ops btrfs_dio_iomap_ops = {
> +	.iomap_begin            = btrfs_dio_iomap_begin,
> +};
> +
> +ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	ssize_t ret;
> +	inode_lock_shared(inode);
> +	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, NULL);
> +	inode_unlock_shared(inode);
> +	return ret;
> +}

