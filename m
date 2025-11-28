Return-Path: <linux-fsdevel+bounces-70118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB81C91211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE3C3AC1F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8052D7DF2;
	Fri, 28 Nov 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lJufLKry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D417736;
	Fri, 28 Nov 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318041; cv=none; b=a6395da+vHfjLjbIzc2/AvgkexCfBeW+pvC521RCBPL+ajDUqxk0DsEUrYGmiw5MRRGkbvNea/OkAPu1AzBISSWLzAYUMtda0fiCNFv+peuMYFd2ZypR5LCG+YxmZRaTMRKcPyJFOYKjps8xHC/DnO9E+Iq1vHoG1JgZEr7ZZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318041; c=relaxed/simple;
	bh=TQn/39jZd8Nij32dz91Mn1/PqR+1h5GhxkAekaeG+lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoGPICOIPnz5bxgRSH3bLUBbIOIS5LusrjExJo5XvrjEViRplsmilLijY4DC+TqP1KxgWn5fN4YPTpw85RzN5o+r0GNivyGEjR1LJPL1tIK4uYk3yYdpWgAk5+KZnpHY/k6KRNu2BW4g2MmiXNRWNT/ZIypTmaw525rZqyCNRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lJufLKry; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARF7DvW007498;
	Fri, 28 Nov 2025 08:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0n4FVkc2gRAaBac4anyGAx/VsJafne
	eEvoWXajT5/bA=; b=lJufLKryHwZdoUkjbLaKabfqy3reMj/Cous/mhJQwXGZ9N
	LVIOeyqBfiTIY4ewjXuOUu90s4kzZOm6JYRb0Pv8IIVsBplL/eP4H8R0T59K5+Cx
	GuUYSfj9qVje8HQZ/1wcTakWYoO9ewFvxogCNxRohw3Dq0wYCsKaaf7jrZgZ07lJ
	pslNeBZXWtEMNm53ZZNb9bW/vRIhIcbCOw4lag8LSFoerWURp8BDmD3yhji5uehi
	GbkWTXzWwDOg3mH8bZYfqEZxIXbdR5IxVz4KXMs7CERJexqp/i3Fy6lCmkjG1pSF
	MwloVzc6jz7n/wX+Lj/EbsSlgVV0c2ribCc/oZJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kqbxpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:20:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AS89FEI017881;
	Fri, 28 Nov 2025 08:20:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kqbxpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:20:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS7N8HZ030768;
	Fri, 28 Nov 2025 08:20:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgsv5k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:20:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS8KGI343712790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:20:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CD3F20043;
	Fri, 28 Nov 2025 08:20:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D03BF20040;
	Fri, 28 Nov 2025 08:20:13 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 08:20:13 +0000 (GMT)
Date: Fri, 28 Nov 2025 13:50:11 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 08/13] ext4: cleanup useless out tag in
 __es_remove_extent()
Message-ID: <aSlbOzFimJ8Y9-u1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-9-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX2I2kO33mBb3A
 npruZE4L/5HNcHI87tkK6bnueeGfJdBKQJgtie6bF1DBikGv2ARBwu/Ya+ifMdkQEJsMHbU50CX
 r9EfyU5gz2E9IIuIy+uQaIBXE90KuUkNNY+rmZooV0y7fJDiCz8fKIuIayivaKR5NMsNEgsvXNF
 8Mf+f0IIgOJ1cKoPNDatCYUKyAxRBsC8V7cuMQW+b7z5eP+2tp1WCAEnJ8Sqi79biIlMjn+472e
 QrdoKjaphjH9snZtEeX7IuTXoLki/ChvxIFAT7I+2WZpaU0rSC5OZ85pGYQRT4gzLu31j44uOFW
 EknNmhP2oKAp9gt0QOGUhyAuMhL+/ZJhrdnqKsRuqbM6O3gK3VITPnZtBKv8JrMlLeikRjty44j
 Y8GoWpBwjjGqLxt1GY/eQePIbIuFGA==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=69295b43 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=IVw0R-UW6hKKdETk9q4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 0AiFHbPEGX-_vlbMbSAZQ0P56e0z6noN
X-Proofpoint-ORIG-GUID: JfhpL7ht0m-apwOZ6pGJrFkO4kZhF4ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

On Fri, Nov 21, 2025 at 02:08:06PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The out tag in __es_remove_extent() is just return err value, we can
> return it directly if something bad happens. Therefore, remove the
> useless out tag and rename out_get_reserved to out.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents_status.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index e04fbf10fe4f..04d56f8f6c0c 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1434,7 +1434,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status orig_es;
>  	ext4_lblk_t len1, len2;
>  	ext4_fsblk_t block;
> -	int err = 0;
> +	int err;
>  	bool count_reserved = true;
>  	struct rsvd_count rc;
>  
> @@ -1443,9 +1443,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	es = __es_tree_search(&tree->root, lblk);
>  	if (!es)
> -		goto out;
> +		return 0;
>  	if (es->es_lblk > end)
> -		goto out;
> +		return 0;
>  
>  	/* Simply invalidate cache_es. */
>  	tree->cache_es = NULL;
> @@ -1480,7 +1480,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  				es->es_lblk = orig_es.es_lblk;
>  				es->es_len = orig_es.es_len;
> -				goto out;
> +				return err;
>  			}
>  		} else {
>  			es->es_lblk = end + 1;
> @@ -1494,7 +1494,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		if (count_reserved)
>  			count_rsvd(inode, orig_es.es_lblk + len1,
>  				   orig_es.es_len - len1 - len2, &orig_es, &rc);
> -		goto out_get_reserved;
> +		goto out;
>  	}
>  
>  	if (len1 > 0) {
> @@ -1536,11 +1536,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		}
>  	}
>  
> -out_get_reserved:
> +out:
>  	if (count_reserved)
>  		*reserved = get_rsvd(inode, end, es, &rc);
> -out:
> -	return err;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.46.1
> 

