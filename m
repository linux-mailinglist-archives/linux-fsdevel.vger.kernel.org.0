Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB126FB7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIRLae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 07:30:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbgIRLaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:30:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08IB2YRI089428;
        Fri, 18 Sep 2020 07:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3lF15t/M6ZHB7nmYDJTYaYsdaEXWYx4HfuUV1rWSBE4=;
 b=o1YUb82u85swYFAAIcXzI4/8h/gKPbnM5X8aiy+OSaY9IIKpNzK0fp58DV0lHP22PDIs
 dLnE3nFmCyvT5MJ5XIeUMBpy+fg7eHe3De3rEvKS7mCEZY9mKHORUZrNNb/3rQ6pxWTp
 YOsz+8S8j+/gKdJowjm6/DROHPY34aNeotIq50aamNQ9bLiAFqRHrKTV8cEgh+wIMhov
 0US3Vfac0HYuzl28uY1Tq+Znuay3iHxf9VpWLW4Rs9pX6JNYTeL+eIIA2nAmX2j3K9zH
 LnwOjHc6XeYBNunGOqT3MUv8G7Eo3wvzkL6l/7rsNqsSJRH84Wb2IMxfHt0FWqJHUyMS /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33mun9grgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 07:29:49 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08IB3nI4093098;
        Fri, 18 Sep 2020 07:29:49 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33mun9grfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 07:29:49 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08IBRfuo003128;
        Fri, 18 Sep 2020 11:29:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 33k623hm1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 11:29:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08IBTi6T28508498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 11:29:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA2E2A4055;
        Fri, 18 Sep 2020 11:29:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DFB3A4040;
        Fri, 18 Sep 2020 11:29:43 +0000 (GMT)
Received: from [9.199.45.180] (unknown [9.199.45.180])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Sep 2020 11:29:43 +0000 (GMT)
Subject: Re: [PATCH v3 1/1] dax: Fix stack overflow when mounting fsdax pmem
 device
To:     Adrian Huang <adrianhuang0701@gmail.com>, linux-nvdimm@lists.01.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, Jan Kara <jack@suse.cz>,
        Adrian Huang <ahuang12@lenovo.com>, Coly Li <colyli@suse.de>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200917111549.6367-1-adrianhuang0701@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <356f8764-9699-e268-681f-0531d284079f@linux.ibm.com>
Date:   Fri, 18 Sep 2020 16:59:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917111549.6367-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_14:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180086
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ccing fs list

On 9/17/20 4:45 PM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When mounting fsdax pmem device, commit 6180bb446ab6 ("dax: fix
> detection of dax support for non-persistent memory block devices")
> introduces the stack overflow [1][2]. Here is the call path for
> mounting ext4 file system:
>    ext4_fill_super
>      bdev_dax_supported
>        __bdev_dax_supported
>          dax_supported
>            generic_fsdax_supported
>              __generic_fsdax_supported
>                bdev_dax_supported
> 
> The call path leads to the infinite calling loop, so we cannot
> call bdev_dax_supported() in __generic_fsdax_supported(). The sanity
> checking of the variable 'dax_dev' is moved prior to the two
> bdev_dax_pgoff() checks [3][4].
> 
> [1] https://lore.kernel.org/linux-nvdimm/1420999447.1004543.1600055488770.JavaMail.zimbra@redhat.com/
> [2] https://lore.kernel.org/linux-nvdimm/alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com/
> [3] https://lore.kernel.org/linux-nvdimm/CA+RJvhxBHriCuJhm-D8NvJRe3h2MLM+ZMFgjeJjrRPerMRLvdg@mail.gmail.com/
> [4] https://lore.kernel.org/linux-nvdimm/20200903160608.GU878166@iweiny-DESK2.sc.intel.com/
> 
> Fixes: 6180bb446ab6 ("dax: fix detection of dax support for non-persistent memory block devices")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Cc: Coly Li <colyli@suse.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Pittman <jpittman@redhat.com>

Although I see that this is fix is already applied but ccing fsdevel and
ext4 since I ended up debugging and coming to the same conclusion as
this patch is fixing the recursion loop.
If not already applied then feel free to add:

Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
> Changelog:
> v3:
>      1. Add Reviewed-by from Jan
>      2. Add Reported-by
>      3. Replace lists.01.org with lore.kernel
> v2:
>      Remove the checking for the returned value '-EOPNOTSUPP' of
>      dax_direct_access(). Jan has prepared a patch to address the
>      issue in dm.
> ---
>   drivers/dax/super.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e5767c83ea23..11d0541e6f8f 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -85,6 +85,12 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>   		return false;
>   	}
>   
> +	if (!dax_dev) {
> +		pr_debug("%s: error: dax unsupported by block device\n",
> +				bdevname(bdev, buf));
> +		return false;
> +	}
> +
>   	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
>   	if (err) {
>   		pr_info("%s: error: unaligned partition for dax\n",
> @@ -100,12 +106,6 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>   		return false;
>   	}
>   
> -	if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
> -		pr_debug("%s: error: dax unsupported by block device\n",
> -				bdevname(bdev, buf));
> -		return false;
> -	}
> -
>   	id = dax_read_lock();
>   	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
>   	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
> 
