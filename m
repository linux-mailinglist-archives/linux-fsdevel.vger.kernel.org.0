Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADEB0258
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfIKRDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 13:03:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfIKRDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:03:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BH0Ggv100146;
        Wed, 11 Sep 2019 17:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=tjDusgHWwwcPuTZyb2yaXH/a3BzidRe9zFpLRpAYF4g=;
 b=rahUj/tGvPrsXSREtfv19e5V4S+Aat3lWreLhWdAQ9x7+xLkfXGW4KF3+clgs2tdXqxW
 7ENlChx6ATWdWvhKqJJDXFe79tbQ9ja9/KN50pDbtsoDgkIC9sWcgi/NGDpy+ogROC9H
 2RMalKU6L3BcXF6TydcEKfB6sLDGAwU5iVAn5lvB2A8NGtQGjFrBhII6Vb+zax6sufO9
 V0leGK7NozKN8/zrqWZtytnCcuIKfNQc+I2m1AgRuolpDr7y/mu7/A1WaIZQaCgTAIEn
 lpGfhs5nspoPn6OfmijX1Usx3VYGUHvtWPt0DdkTOgqlv+W9mBNzq1Q8anqqvdK53kRz oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jybfmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:03:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BH3AIP145409;
        Wed, 11 Sep 2019 17:03:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2uxk0terde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 17:03:20 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BH3Iu2004387;
        Wed, 11 Sep 2019 17:03:18 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 10:03:17 -0700
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
To:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <20190911151451.GH29434@bombadil.infradead.org>
 <19d9ea18-bd20-e02f-c1de-70e7322f5f22@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <40a511a4-5771-f9a9-40b6-64e39478bbcb@oracle.com>
Date:   Wed, 11 Sep 2019 10:03:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <19d9ea18-bd20-e02f-c1de-70e7322f5f22@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/19 8:44 AM, Waiman Long wrote:
> On 9/11/19 4:14 PM, Matthew Wilcox wrote:
>> On Wed, Sep 11, 2019 at 04:05:37PM +0100, Waiman Long wrote:
>>> When allocating a large amount of static hugepages (~500-1500GB) on a
>>> system with large number of CPUs (4, 8 or even 16 sockets), performance
>>> degradation (random multi-second delays) was observed when thousands
>>> of processes are trying to fault in the data into the huge pages. The
>>> likelihood of the delay increases with the number of sockets and hence
>>> the CPUs a system has.  This only happens in the initial setup phase
>>> and will be gone after all the necessary data are faulted in.
>> Can;t the application just specify MAP_POPULATE?
> 
> Originally, I thought that this happened in the startup phase when the
> pages were faulted in. The problem persists after steady state had been
> reached though. Every time you have a new user process created, it will
> have its own page table.

This is still at fault time.  Although, for the particular application it
may be after the 'startup phase'.

>                          It is the sharing of the of huge page shared
> memory that is causing problem. Of course, it depends on how the
> application is written.

It may be the case that some applications would find the delays acceptable
for the benefit of shared pmds once they reach steady state.  As you say, of
course this depends on how the application is written.

I know that Oracle DB would not like it if PMD sharing is disabled for them.
Based on what I know of their model, all processes which share PMDs perform
faults (write or read) during the startup phase.  This is in environments as
big or bigger than you describe above.  I have never looked at/for delays in
these environments around pmd sharing (page faults), but that does not mean
they do not exist.  I will try to get the DB group to give me access to one
of their large environments for analysis.

We may want to consider making the timeout value and disable threshold user
configurable.
-- 
Mike Kravetz
