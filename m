Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A327DB42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgI2V7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 17:59:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50086 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgI2V7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:59:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TLt6DF021214;
        Tue, 29 Sep 2020 21:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0SGyZSx2d5gFu9VCFrnHr0PbdBSEOfYbvoIkFctnKs8=;
 b=EBEs/IhygzDjI9NzSZTWBL+jlpXdRSkIVKO3BR0PTnYj13j/KT+YnFdpHIyMWwHKtPw6
 VdeeYVH42begstTcMHrPn7CjtPn3oB/ynSr0w5Xso4ukQstG8tMpGMZHofhFBqIk5P65
 XrSnIkpFCP0bFO36b8n148hmKqy2HkW7Ily3u/mu1a6x/RaENFBf37j14i6k1gyFLrol
 Lgp0N1e80RBQvfxng1lADe5bcUmNPgNhjD9zBQz8AYB2VfRQI68pntvE+QMw8Bnfd3sf
 nJDZS4pMLOkNaFbaKgyEYxhYUeLumTtuNxNn94jWtcRsqN+N5gQPS6tzHUqaJma5csPx HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33sx9n5bkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 21:58:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TLuQ58152440;
        Tue, 29 Sep 2020 21:58:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33tfhy882g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 21:58:28 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08TLwNJl026376;
        Tue, 29 Sep 2020 21:58:23 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 14:58:23 -0700
Subject: Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap pages of hugetlb
 page
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <31eac1d8-69ba-ed2f-8e47-d957d6bb908c@oracle.com>
Date:   Tue, 29 Sep 2020 14:58:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290188
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/20 5:59 AM, Muchun Song wrote:
> Hi all,
> 
> This patch series will free some vmemmap pages(struct page structures)
> associated with each hugetlbpage when preallocated to save memory.
...
> The mapping of the first page(index 0) and the second page(index 1) is
> unchanged. The remaining 6 pages are all mapped to the same page(index
> 1). So we only need 2 pages for vmemmap area and free 6 pages to the
> buddy system to save memory. Why we can do this? Because the content
> of the remaining 7 pages are usually same except the first page.
> 
> When a hugetlbpage is freed to the buddy system, we should allocate 6
> pages for vmemmap pages and restore the previous mapping relationship.
> 
> If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> substantial gain. On our server, run some SPDK applications which will
> use 300GB hugetlbpage. With this feature enabled, we can save 4797MB
> memory.

At a high level this seems like a reasonable optimization for hugetlb
pages.  It is possible because hugetlb pages are 'special' and mostly
handled differently than pages in normal mm paths.

The majority of the new code is hugetlb specific, so it should not be
of too much concern for the general mm code paths.  I'll start looking
closer at the series.  However, if someone has high level concerns please
let us know.  The only 'potential' conflict I am aware of is discussion
about support of double mapping hugetlb pages.

https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg02407.html

More care/coordination would be needed to support double mapping with
this new option.  However, this series provides a boot option to disable
freeing of unneeded page structs.
-- 
Mike Kravetz
