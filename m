Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77F82F54EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbhAMWeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 17:34:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48526 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbhAMWdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:33:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DMO15C022373;
        Wed, 13 Jan 2021 22:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cbAaYYA369SOVtMavd6SqpAAxPSZNSJN5l6rUr3r578=;
 b=hw1PkC/sUHVQ3mQIsWe5wLnCnD2UBEsLkifv+QVZj58xK8X58jAvZHonkY4pgU3pvEDj
 Qbdg//OBSnnr5KhM1CRI+pUx8YpfyfYH6j9jCGSIiEjGCAW7ADrY1s+JbJ/rPaKRuNJ7
 PqW5Aff7qhKGiz3m9c3YZnYnV0paT2Loxi7cTh/BWnDyVYu5qdlqzBieH8mF1mYGr9+i
 WmNU4hCwh6GoY2StJhoj56q3c00HmJooyE3Mwy2Jczgsm0mtYCv1nuUF0ON7KkDArGIg
 9BElpiJWUeQU2dZSNnu4fGH2edtGH636RDEeJH74U0UD8GUsWHc3t9/2mS/wRnSnNS1u Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcywv8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 22:31:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DMTfZl061547;
        Wed, 13 Jan 2021 22:31:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360ke9591t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 22:31:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10DMUxqN029174;
        Wed, 13 Jan 2021 22:31:00 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 14:30:59 -0800
Subject: Re: [PATCH v12 03/13] mm: Introduce VM_WARN_ON_PAGE macro
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
 <20210106141931.73931-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <65b2103d-6198-3380-d36e-17dd774359bd@oracle.com>
Date:   Wed, 13 Jan 2021 14:30:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210106141931.73931-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/6/21 6:19 AM, Muchun Song wrote:
> Very similar to VM_WARN_ON_ONCE_PAGE and VM_BUG_ON_PAGE, add
> VM_WARN_ON_PAGE macro.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mmdebug.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

I was going to question the use/need for this macro in the following
patch.  Looks like Oscar has already done that, and free_bootmem_page
will now use VM_BUG_ON_PAGE.  So, this patch can be dropped.

-- 
Mike Kravetz
