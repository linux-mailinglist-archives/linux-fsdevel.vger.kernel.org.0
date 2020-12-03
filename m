Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452B52CE31A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgLCXuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 18:50:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51946 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388142AbgLCXuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:50:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3NTGIg175539;
        Thu, 3 Dec 2020 23:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Cqu3KSehMgp5GC1qcLE5nXes+mExlunWbJeDddKy1dI=;
 b=Qj+OW82lbGdB/QOBVDKQpK5t89U+g29d/oivBaqtOXx4PDZuIn5c/njHsVYxvgf4OoqW
 adzVM1RYDyMabKkkm+zq1HbYbfz6sPBEr88ra9501mSnKxNAVttnFFbzCzguTO6yJ2/Q
 Kukl4ri0WFV/dJXhH9UYAotKOyzyKWGILmxrHWwhzgsoCtCXUm2cYU6yOBsHIq7aIrFW
 gcQs+AKRrVlQ6eMFJg1sEXYuYgyDFCW7086Gq9h/lgQxZ/QtMd+j2V05blnsLprnKE/S
 xqeRI8RZx/t1jA3aNbK3QtxQUM1W5gfMNMOWomBvmbApqqPl2XEJiBLENVSxwcCw40lB RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 353c2b8urx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 23:48:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3NkdhD063885;
        Thu, 3 Dec 2020 23:48:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540ax1d1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 23:48:50 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B3NmYSG029888;
        Thu, 3 Dec 2020 23:48:35 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 15:48:34 -0800
Subject: Re: [PATCH v7 00/15] Free some vmemmap pages of hugetlb page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, bp@alien8.de, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, mchehab+huawei@kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk,
        Peter Zijlstra <peterz@infradead.org>, luto@kernel.org,
        oneukum@suse.com, jroedel@suse.de,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        anshuman.khandual@arm.com, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <CAMZfGtWvLEytN5gBN+OqntrNXNd3eNRWrfnkeCozvARmpTNAXw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <600fd7e2-70b4-810f-8d12-62cba80af80d@oracle.com>
Date:   Thu, 3 Dec 2020 15:48:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWvLEytN5gBN+OqntrNXNd3eNRWrfnkeCozvARmpTNAXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=2
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/3/20 12:35 AM, Muchun Song wrote:
> On Mon, Nov 30, 2020 at 11:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> Hi all,
>>
>> This patch series will free some vmemmap pages(struct page structures)
>> associated with each hugetlbpage when preallocated to save memory.
> 
> Hi Mike,
> 
> What's your opinion on this version?  Any comments or suggestions?
> And hoping you or more people review the series. Thank you very
> much.

Sorry Muchun, I have been busy with other things and have not looked at
this new version.  Should have some time soon.

As previously mentioned, I feel qualified to review the hugetlb changes
and some other closely related changes.  However, this patch set is
touching quite a few areas and I do not feel qualified to make authoritative
statements about them all.  I too hope others will take a look.
-- 
Mike Kravetz
