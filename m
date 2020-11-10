Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF812ADFEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 20:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgKJTlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 14:41:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKJTlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:41:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJdr5l115875;
        Tue, 10 Nov 2020 19:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9B6dG5PJmz4EQQkDr5Dh7n2gEWp/DBIVSw1s14fCJVU=;
 b=OlyTE7Om0d0VNz3I0ukpe//2qZClROzGZwZCra5xUP//qOlqKCfittNeQ6mhcqNM8AK3
 jpETHFilEFxcaTWWblHtv8USZeUNuSMVTpGUi4YVaslCWBNu6+Dhl9b8vud45A7iQLiD
 G++yb9f1m3QW036sQQ9m4kZkFje6y7Jce0fN5A1d8yzz4z0w1P0+q+1BaowMuMV/qFxe
 tvkyDaZbDcEEeIcEpC17/LWNXLlgvetZx5KDzPXqXPtxHI+Fow0b66cIhFtCmuTsCIqv
 hJNOFsux3fIKHNZwGfagU1zvvQdpD/tbZSQjzZwxBwcXcA9dBBoK+Rws/6gxX23kk9Ye xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhkwgbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 19:40:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJZ6RW047872;
        Tue, 10 Nov 2020 19:38:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34qgp7agsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 19:38:43 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AAJceZ3016558;
        Tue, 10 Nov 2020 19:38:40 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 11:38:39 -0800
Subject: Re: [External] Re: [PATCH v3 04/21] mm/hugetlb: Introduce
 nr_free_vmemmap_pages in the struct hstate
To:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-5-songmuchun@bytedance.com>
 <20201109164825.GA17356@linux>
 <CAMZfGtWxNV874j9io_xcsVm+C6_shrZCw=W9ugJzxrnBpXb_Mw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <877a4620-fa5c-c5b5-8a42-fdd67a869a38@oracle.com>
Date:   Tue, 10 Nov 2020 11:38:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWxNV874j9io_xcsVm+C6_shrZCw=W9ugJzxrnBpXb_Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/9/20 6:42 PM, Muchun Song wrote:
> On Tue, Nov 10, 2020 at 12:48 AM Oscar Salvador <osalvador@suse.de> wrote:
>>
>> On Sun, Nov 08, 2020 at 10:10:56PM +0800, Muchun Song wrote:
>>
>> Unrelated to this patch but related in general, I am not sure about Mike but
>> would it be cleaner to move all the vmemmap functions to hugetlb_vmemmap.c?
>> hugetlb code is quite tricky, so I am not sure about stuffing more code
>> in there.
>>
> 
> I also think that you are right, moving all the vmemmap functions to
> hugetlb_vmemmap.c may make the code cleaner.
> 
> Hi Mike, what's your opinion?

I would be happy to see this in a separate file.  As Oscar mentions, the
hugetlb.c file/code is already somethat difficult to read and understand.
-- 
Mike Kravetz
