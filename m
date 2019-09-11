Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76D3B006C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfIKPog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:44:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfIKPog (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:44:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C03F2DA980;
        Wed, 11 Sep 2019 15:44:36 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-131.rdu2.redhat.com [10.10.124.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DED2D19C78;
        Wed, 11 Sep 2019 15:44:33 +0000 (UTC)
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <20190911151451.GH29434@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <19d9ea18-bd20-e02f-c1de-70e7322f5f22@redhat.com>
Date:   Wed, 11 Sep 2019 16:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190911151451.GH29434@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 11 Sep 2019 15:44:36 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/19 4:14 PM, Matthew Wilcox wrote:
> On Wed, Sep 11, 2019 at 04:05:37PM +0100, Waiman Long wrote:
>> When allocating a large amount of static hugepages (~500-1500GB) on a
>> system with large number of CPUs (4, 8 or even 16 sockets), performance
>> degradation (random multi-second delays) was observed when thousands
>> of processes are trying to fault in the data into the huge pages. The
>> likelihood of the delay increases with the number of sockets and hence
>> the CPUs a system has.  This only happens in the initial setup phase
>> and will be gone after all the necessary data are faulted in.
> Can;t the application just specify MAP_POPULATE?

Originally, I thought that this happened in the startup phase when the
pages were faulted in. The problem persists after steady state had been
reached though. Every time you have a new user process created, it will
have its own page table. It is the sharing of the of huge page shared
memory that is causing problem. Of course, it depends on how the
application is written.

Anyway, MAP_POPULATE will not be useful in this case.

Thanks,
Longman

