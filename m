Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E69EB02B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfIKR2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 13:28:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfIKR2m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:28:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BB09A37191;
        Wed, 11 Sep 2019 17:28:42 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-234.rdu2.redhat.com [10.10.123.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61251608C2;
        Wed, 11 Sep 2019 17:28:40 +0000 (UTC)
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
From:   Waiman Long <longman@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
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
 <40a511a4-5771-f9a9-40b6-64e39478bbcb@oracle.com>
 <5229662c-d709-7aca-be4c-53dea1a49fda@redhat.com>
Organization: Red Hat
Message-ID: <81464111-2335-9dc4-3465-5800348d5aba@redhat.com>
Date:   Wed, 11 Sep 2019 18:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5229662c-d709-7aca-be4c-53dea1a49fda@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 11 Sep 2019 17:28:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/19 6:15 PM, Waiman Long wrote:
> On 9/11/19 6:03 PM, Mike Kravetz wrote:
>> On 9/11/19 8:44 AM, Waiman Long wrote:
>>> On 9/11/19 4:14 PM, Matthew Wilcox wrote:
>>>> On Wed, Sep 11, 2019 at 04:05:37PM +0100, Waiman Long wrote:
>>>>> When allocating a large amount of static hugepages (~500-1500GB) on a
>>>>> system with large number of CPUs (4, 8 or even 16 sockets), performance
>>>>> degradation (random multi-second delays) was observed when thousands
>>>>> of processes are trying to fault in the data into the huge pages. The
>>>>> likelihood of the delay increases with the number of sockets and hence
>>>>> the CPUs a system has.  This only happens in the initial setup phase
>>>>> and will be gone after all the necessary data are faulted in.
>>>> Can;t the application just specify MAP_POPULATE?
>>> Originally, I thought that this happened in the startup phase when the
>>> pages were faulted in. The problem persists after steady state had been
>>> reached though. Every time you have a new user process created, it will
>>> have its own page table.
>> This is still at fault time.  Although, for the particular application it
>> may be after the 'startup phase'.
>>
>>>                          It is the sharing of the of huge page shared
>>> memory that is causing problem. Of course, it depends on how the
>>> application is written.
>> It may be the case that some applications would find the delays acceptable
>> for the benefit of shared pmds once they reach steady state.  As you say, of
>> course this depends on how the application is written.
>>
>> I know that Oracle DB would not like it if PMD sharing is disabled for them.
>> Based on what I know of their model, all processes which share PMDs perform
>> faults (write or read) during the startup phase.  This is in environments as
>> big or bigger than you describe above.  I have never looked at/for delays in
>> these environments around pmd sharing (page faults), but that does not mean
>> they do not exist.  I will try to get the DB group to give me access to one
>> of their large environments for analysis.
>>
>> We may want to consider making the timeout value and disable threshold user
>> configurable.
> Making it configurable is certainly doable. They can be sysctl
> parameters so that the users can reenable PMD sharing by making those
> parameters larger.

I suspect that the customer's application may be generating a new
process with its own address space for each transaction. That will be
causing a lot of PMD sharing operations when hundreds of threads are
pounding it simultaneously. I had inserted some instrumentation code to
a test kernel that the customers used for testing, the number of
timeouts after a certain time went up more than 20k.

On the other hands, if the application is structured in such a way that
there is limited number of separate address spaces with worker threads
processing the transaction, PMD sharing will be less of a problem. It
will be hard to convince users to make such a structural changes to
their application.

Cheers,
Longman


