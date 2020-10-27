Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5329CBBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 23:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1797473AbgJ0WGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 18:06:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505742AbgJ0WGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:06:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RLxgac183243;
        Tue, 27 Oct 2020 22:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CrxcAKxlL6zTKrSy5aqsXey/yRGR5KD+DfWfZGHFeZE=;
 b=Vzhp/ZRmRv3MkRxXLZDa6adkxTJtQ7xwyJZoUgOJQ3e1IIDg/xm5McMNtfMKLEVNibPu
 Bc/l9I21h6c/nYgFHGUQiHTO+/HueN7Q2sQRFo1jK3zdR5RL8hPKLpAgZwU78cIXe1/R
 GzXEqh7MbuLAiG4nz3D3aCcnL2yFsJaYVcmz66j/l4xLXJBxW3XZa/TPEe6VwZe7+KPR
 9DYYP1vMujDapkFKWb6vyH5wl4dR5s97EohbXRy0woLTTxchJzO4QbG7gRwjH9AOOLJl
 IJ8iNLGWwOKu2I+dBe0t2u2Nd/jV9azrN9jb7QqkpCl/cQM8nFTo9PVYVSbl5lEqSRpj Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9savpnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 22:03:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RM04Rc051004;
        Tue, 27 Oct 2020 22:03:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34cx5xmprm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 22:03:43 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09RM3WaA025266;
        Tue, 27 Oct 2020 22:03:33 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 15:03:32 -0700
Subject: Re: [PATCH v2 04/19] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <344cbb0a-7b82-3d81-403a-1a2c1a7d6fb1@oracle.com>
Date:   Tue, 27 Oct 2020 15:03:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201026145114.59424-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=2
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270127
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/26/20 7:50 AM, Muchun Song wrote:
> If the size of hugetlb page is 2MB, we need 512 struct page structures
> (8 pages) to be associated with it. As far as I know, we only use the
> first 4 struct page structures.

Use of first 4 struct page structures comes from HUGETLB_CGROUP_MIN_ORDER.
You could point that out here.

I thought about creating a HUGETLB_MIN_ORDER definition that could be used
to calculate RESERVE_VMEMMAP_NR.  However, I think a hard coded value of
2U as in the patch is OK.

> For tail pages, the value of compound_dtor is the same. So we can reuse
> first page of tail page structs. We map the virtual addresses of the
> remaining 6 pages of tail page structs to the first tail page struct,
> and then free these 6 pages. Therefore, we need to reserve at least 2
> pages as vmemmap areas.
> 
> So we introduce a new nr_free_vmemmap_pages field in the hstate to
> indicate how many vmemmap pages associated with a hugetlb page that we
> can free to buddy system.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

Patch looks fine with updated commit message.
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
