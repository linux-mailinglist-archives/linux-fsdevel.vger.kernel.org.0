Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEA4107AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhIRQ7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 12:59:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233741AbhIRQ7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 12:59:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18IGtMUk015946;
        Sat, 18 Sep 2021 12:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PP393VMNIfIagseXHv1RYTSa7r9d/UPylxlf5lsNj28=;
 b=ZC2gx3agbLbAghY6n3b3FCOwe3mt1PIzfjUNcpC2phPX0kJiuITvMVr9Dm7sA0KGlvYo
 P5FHHgyOKGzCxEJWOogeX7IReWi4brmSPFRbr2c2RYfuAWdGtEM1XzISlkSEp1MuG2vu
 JzfxIEVXDspuR4e5/vhEbMgjnIln4DZg9WfAY70l+lBAcp54p9CMVJ3h0lKj9TnCypz4
 6dA9iJqvAV/nUwYZN/w6q/Y3ByhtTdB/CZbSjsP22RBLDKijfUgd8meGfP9Vd5FyIeuS
 BAS2/ct74GaCYGHh1R2zY3pYzTwQZAN22eaVzY6/rQH3UP+AgWQUIW1h0ZQJD99Kaa0I Mg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b5m2br0yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 12:58:22 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18IGvQ67030279;
        Sat, 18 Sep 2021 16:58:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3b57r83c46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 16:58:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18IGwHFX25821658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 16:58:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF14042049;
        Sat, 18 Sep 2021 16:58:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40BC742041;
        Sat, 18 Sep 2021 16:58:17 +0000 (GMT)
Received: from localhost (unknown [9.43.63.221])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 18 Sep 2021 16:58:17 +0000 (GMT)
Date:   Sat, 18 Sep 2021 22:28:16 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210918165816.jollbsjxygae5r3u@riteshh-domain>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192866125.417973.7293598039998376121.stgit@magnolia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FhFwGQW5c3njHWzwC_j9UZXG0IS6EHAW
X-Proofpoint-ORIG-GUID: FhFwGQW5c3njHWzwC_j9UZXG0IS6EHAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-18_06,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=979
 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109180117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/17 06:31PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> Add a new mode to fallocate to zero-initialize all the storage backing a
> file.

This patch looks pretty straight forward to me.

Thanks
-ritesh

>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/open.c                   |    5 +++++
>  include/linux/falloc.h      |    1 +
>  include/uapi/linux/falloc.h |    9 +++++++++
>  3 files changed, 15 insertions(+)
>
>
> diff --git a/fs/open.c b/fs/open.c
> index daa324606a41..230220b8f67a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -256,6 +256,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	    (mode & ~FALLOC_FL_INSERT_RANGE))
>  		return -EINVAL;
>
> +	/* Zeroinit should only be used by itself and keep size must be set. */
> +	if ((mode & FALLOC_FL_ZEROINIT_RANGE) &&
> +	    (mode != (FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE)))
> +		return -EINVAL;
> +
>  	/* Unshare range should only be used with allocate mode. */
>  	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
>  	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b1675..4597b416667b 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -29,6 +29,7 @@ struct space_resv {
>  					 FALLOC_FL_PUNCH_HOLE |		\
>  					 FALLOC_FL_COLLAPSE_RANGE |	\
>  					 FALLOC_FL_ZERO_RANGE |		\
> +					 FALLOC_FL_ZEROINIT_RANGE |	\
>  					 FALLOC_FL_INSERT_RANGE |	\
>  					 FALLOC_FL_UNSHARE_RANGE)
>
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6c..8144403b6102 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -77,4 +77,13 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>
> +/*
> + * FALLOC_FL_ZEROINIT_RANGE is used to reinitialize storage backing a file by
> + * writing zeros to it.  Subsequent read and writes should not fail due to any
> + * previous media errors.  Blocks must be not be shared or require copy on
> + * write.  Holes and unwritten extents are left untouched.  This mode must be
> + * used with FALLOC_FL_KEEP_SIZE.
> + */
> +#define FALLOC_FL_ZEROINIT_RANGE	0x80
> +
>  #endif /* _UAPI_FALLOC_H_ */
>
