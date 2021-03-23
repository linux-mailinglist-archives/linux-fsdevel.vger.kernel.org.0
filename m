Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A67E346485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhCWQKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:10:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233067AbhCWQKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:10:19 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NG4L4N002219;
        Tue, 23 Mar 2021 12:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4hzvEoyYDV3PN0LKOUT8ny7/qRJ4s6ME03W9y5J/WN0=;
 b=c0WYPQkU2gbVp5NhauTZVS0+4XdMoukaIkCyfbRy6Db1wWna0bHAQVVQ5i5wZ1rnQE4G
 1iAgkUOCf4U9Cem/EBvJyRT0UxiDsimAI4qu6NWj7zfw4h4uouvLdPRSmd47bhyl4iLa
 Iogd2oAtOpz8mjB6ozrPT2IEe7iSZtC1X4512lUhogU1ljYrn9pp6bRlVCV9zIlY6X3Z
 4b6jTqAtd/62Tf1D7A8nL3im9Dd613m22nTJO7SF/SuxWowryoP6MMJtnsOGohqCyNSa
 /LRSL3IDxemgn1/Ilm0GLozUQXVa3lntZIzkF4L4z2yTW6/D6laesfDkun4mXcjH2IC7 LA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fkh28e09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 12:10:02 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NG3oV4016988;
        Tue, 23 Mar 2021 16:09:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 37d9a6hts4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 16:09:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NG8jwv34799932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 16:08:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CA67AE057;
        Tue, 23 Mar 2021 16:09:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC58AE051;
        Tue, 23 Mar 2021 16:09:00 +0000 (GMT)
Received: from [9.199.34.65] (unknown [9.199.34.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 16:09:00 +0000 (GMT)
Subject: Re: [PATCH v3 04/10] fsdax: Introduce dax_iomap_cow_copy()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
Cc:     darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-5-ruansy.fnst@fujitsu.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <985f720c-0cf0-5ada-4df4-3405d5969b8d@linux.ibm.com>
Date:   Tue, 23 Mar 2021 21:38:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210319015237.993880-5-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_07:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/19/21 7:22 AM, Shiyang Ruan wrote:
> In the case where the iomap is a write operation and iomap is not equal
> to srcmap after iomap_begin, we consider it is a CoW operation.
> 
> The destance extent which iomap indicated is new allocated extent.
> So, it is needed to copy the data from srcmap to new allocated extent.
> In theory, it is better to copy the head and tail ranges which is
> outside of the non-aligned area instead of copying the whole aligned
> range. But in dax page fault, it will always be an aligned range.  So,
> we have to copy the whole range in this case.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/dax.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index a70e6aa285bb..181aad97136a 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1037,6 +1037,51 @@ static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
>   	return rc;
>   }
>   
> +/*
> + * Copy the head and tail part of the pages not included in the write but
> + * required for CoW, because pos/pos+length are not page aligned.  But in dax
> + * page fault case, the range is page aligned, we need to copy the whole range
> + * of data.  Use copy_edge to distinguish these cases.
> + */


Is this version better? Feel free to update/change.

dax_iomap_cow_copy(): This can be called from two places.
Either during DAX write fault, to copy the length size data to daddr.
Or, while doing normal DAX write operation, dax_iomap_actor() might call 
this to do the copy of either start or end unaligned address. In this 
case the rest of the copy of aligned ranges is taken care by 
dax_iomap_actor() itself.
Also, note DAX fault will always result in aligned pos and pos + length.

* @pos:		address to do copy from.
* @length:	size of copy operation.
* @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
* @srcmap:	iomap srcmap
* @daddr: 	destination address to copy to.

> +static int dax_iomap_cow_copy(loff_t pos, loff_t length, size_t align_size,
> +		struct iomap *srcmap, void *daddr, bool copy_edge)

do we need bool copy_edge here?
We can detect non-align case directly if head_off != pos or pd_end != 
end no?


> +{
> +	loff_t head_off = pos & (align_size - 1);
> +	size_t size = ALIGN(head_off + length, align_size);
> +	loff_t end = pos + length;
> +	loff_t pg_end = round_up(end, align_size);
> +	void *saddr = 0;
> +	int ret = 0;
> +
> +	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (!copy_edge)
> +		return copy_mc_to_kernel(daddr, saddr, length);
> +
> +	/* Copy the head part of the range.  Note: we pass offset as length. */
> +	if (head_off) {
> +		if (saddr)
> +			ret = copy_mc_to_kernel(daddr, saddr, head_off);
> +		else
> +			memset(daddr, 0, head_off);
> +	}
> +	/* Copy the tail part of the range */
> +	if (end < pg_end) {
> +		loff_t tail_off = head_off + length;
> +		loff_t tail_len = pg_end - end;
> +
> +		if (saddr)
> +			ret = copy_mc_to_kernel(daddr + tail_off,
> +					saddr + tail_off, tail_len);
> +		else
> +			memset(daddr + tail_off, 0, tail_len);
> +	}

Can you pls help me understand in which case where saddr is 0 and we
will fall back to memset API ?
I was thinking shouldn't such restrictions be coded inside 
copy_mc_to_kernel() function in general?


-ritesh
