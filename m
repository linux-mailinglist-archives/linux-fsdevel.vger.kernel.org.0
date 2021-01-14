Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383962F5861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbhANCSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 21:18:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36732 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbhANCSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:18:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10E09vxB043707;
        Thu, 14 Jan 2021 00:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8fvI3uhDU/lFzBKxslGGP7n71gqZcVlfK/swNLvGpfc=;
 b=YEIfU30lASj8s4oEdpvFEcMZgaMpbjUuJP+p6CPOtp3Ss5fqSByAqZQRl+ZjmSBKSvC+
 yDmpRp0sE9YOEirX4wpQIAXHsDI4YyPMY2tdSZsG9WycCodjJ6WCIbDCXymlcXoo5IGL
 2ye4wRyUgz+AkzeKU+u+Tf10guAPbE/d0sHdjJyDm9YNRalMro2fb8/CxHv/5YgQ5cV9
 5abrJ7f3BgsDJYxw/4eOB6QnuN946XBhWtg7D/YiDL2RATp6Y7HMr5MnrpuaMZINVIUK
 wDcnPxH3YMQSfzTrs80YZ9kKqZXPAgLQwGKdJKNV9KnVmKMyuCuRZs5JptxDFm60xroP lQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 360kg1x6pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 00:18:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10E0Am1G162851;
        Thu, 14 Jan 2021 00:18:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 360kem9nsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 00:18:29 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10E0INsW018524;
        Thu, 14 Jan 2021 00:18:23 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 16:18:22 -0800
Subject: Re: [PATCH v12 12/13] mm/hugetlb: Gather discrete indexes of tail
 page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-13-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c4afa795-c679-420b-a228-d7f08cf49d02@oracle.com>
Date:   Wed, 13 Jan 2021 16:18:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210106141931.73931-13-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130147
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/6/21 6:19 AM, Muchun Song wrote:
> For HugeTLB page, there are more metadata to save in the struct page.
> But the head struct page cannot meet our needs, so we have to abuse
> other tail struct page to store the metadata. In order to avoid
> conflicts caused by subsequent use of more tail struct pages, we can
> gather these discrete indexes of tail struct page. In this case, it
> will be easier to add a new tail page index later.
> 
> There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
> so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/hugetlb.h        | 14 ++++++++++++++
>  include/linux/hugetlb_cgroup.h | 15 +++++++++------
>  mm/hugetlb.c                   | 25 ++++++++++++-------------
>  mm/hugetlb_vmemmap.c           |  8 ++++++++
>  4 files changed, 43 insertions(+), 19 deletions(-)

My apologies!  I did not get to this patch in previous versions of the
series.  My "RFC create hugetlb flags to consolidate state" was done
before I even noticed your efforts here.

At least we agree the metadata could be better organized. :)

IMO, using page.private of the head page to consolidate flags will be
easier to manage.  So, I would like to use that.

The BUILD_BUG_ON in this patch makes sense.
-- 
Mike Kravetz
