Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46527DC48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 00:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgI2Wqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 18:46:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgI2Wqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:46:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TMTWb6135669;
        Tue, 29 Sep 2020 22:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4L4hjQcgguBex9d3H5e7ELEzL5by2MBMQY742lzhLWU=;
 b=zc+ED4evDYOuH9/g9HbbLzAy52RmgdTFRjAEctGbHVOWP3KnwRs4t2WJ0Mk/zCAIZNDx
 x/SILLXci+TPEZd1PatwpY/ExXM6dYnvoxhn85fM4+0CqK6NOFtslkAWmcqaTHHy6pw9
 DsrSoS8pyLmCV9NHtZZwDcIGn6o+9OVusjw1ElpjpWAmZickvLYFso5jmBwDDk4mGhDW
 b9hTV+UMjiQlmNTh98hj9MTtNbQ1ADgw93FEK/OmyTBCXj7QdOz1mKqlAcAQvYkSrC3u
 Fi+rtyLWONTJjhHktk8jo4wfoEWv02YFWn3FdAxFtyh57otB29/Lqu1/iybJgMOr/S5g bQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33swkkwk9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 22:46:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TMTjUd017138;
        Tue, 29 Sep 2020 22:46:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33tfjxmect-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 22:46:13 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08TMk76u025850;
        Tue, 29 Sep 2020 22:46:08 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 15:46:07 -0700
Subject: Re: [RFC PATCH 01/24] mm/memory_hotplug: Move bootmem info
 registration API to bootmem_info.c
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
 <20200915125947.26204-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c8b8de11-1e50-1e84-d2fb-d81e29fea593@oracle.com>
Date:   Tue, 29 Sep 2020 15:46:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915125947.26204-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290192
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/20 5:59 AM, Muchun Song wrote:
> Move bootmem info registration common API to individual bootmem_info.c
> for later patch use.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This is just code movement.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  arch/x86/mm/init_64.c          |  1 +
>  include/linux/bootmem_info.h   | 27 ++++++++++
>  include/linux/memory_hotplug.h | 23 --------
>  mm/Makefile                    |  1 +
>  mm/bootmem_info.c              | 99 ++++++++++++++++++++++++++++++++++
>  mm/memory_hotplug.c            | 91 +------------------------------
>  6 files changed, 129 insertions(+), 113 deletions(-)
>  create mode 100644 include/linux/bootmem_info.h
>  create mode 100644 mm/bootmem_info.c
