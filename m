Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F627DCB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 01:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgI2Xdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 19:33:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34360 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgI2Xdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:33:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TNTuQX144708;
        Tue, 29 Sep 2020 23:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vCUVxkJF1KTzevD8hJZdPyMLrTosl8vGHXyR/kr9L5c=;
 b=eB7ZIb4Ty9sgF7m8xhIdI3nl/7d181cMrdqy8wnTBRxO55xR4SeYR3vT42XldGsCfpXS
 iHEaSG+2GWT1JooP7giARK16ck7PLbFNPK49f+dzqThb5YMuCaJR76dP86vmw1CZF0jt
 fw26jr7YSD9a/UzW8jV2Bx+T5SGNTjnjyGRs3prLcDATMik5wdXHAyMfrdziJVNbEzOc
 xywG7i3TWOdE6p1pBhqIdJ6HM9azee37TIjWTFZ01rZcmiSP4/jwXEXJA81ElirWdc8E
 WDktlc3WHbW5DbVdFf5xldC8y2tGpR84Vk4b02fXBSWEllaQDrQYw0cr3MUTQ/Rw8rNM yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33su5awrrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 23:32:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TNP8ja185461;
        Tue, 29 Sep 2020 23:30:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33uv2ek4r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 23:30:16 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08TNUCxc023764;
        Tue, 29 Sep 2020 23:30:12 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 16:30:12 -0700
Subject: Re: [RFC PATCH 02/24] mm/memory_hotplug: Move
 {get,put}_page_bootmem() to bootmem_info.c
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915125947.26204-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <268655bf-ddc1-037e-e636-a60c301d4cca@oracle.com>
Date:   Tue, 29 Sep 2020 16:30:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915125947.26204-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=2 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290198
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/20 5:59 AM, Muchun Song wrote:
> In the later patch, we will use {get,put}_page_bootmem() to initialize
> the page for vmemmap or free vmemmap page to buddy. So move them out of
> CONFIG_MEMORY_HOTPLUG_SPARSE.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

More code movement.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  arch/x86/mm/init_64.c          |  2 +-
>  include/linux/bootmem_info.h   | 13 +++++++++++++
>  include/linux/memory_hotplug.h |  4 ----
>  mm/bootmem_info.c              | 26 ++++++++++++++++++++++++++
>  mm/memory_hotplug.c            | 27 ---------------------------
>  mm/sparse.c                    |  1 +
>  6 files changed, 41 insertions(+), 32 deletions(-)
