Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A596417721C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 10:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgCCJN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 04:13:28 -0500
Received: from foss.arm.com ([217.140.110.172]:44396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgCCJN2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:13:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D0B62F;
        Tue,  3 Mar 2020 01:13:27 -0800 (PST)
Received: from [10.162.16.51] (p8cg001049571a15.blr.arm.com [10.162.16.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802903F6C4;
        Tue,  3 Mar 2020 01:13:23 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC 3/3] mm/vma: Introduce some more VMA flag wrappers
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
 <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
Message-ID: <ce7dd2ac-26e8-d83c-46d0-0c61609be417@arm.com>
Date:   Tue, 3 Mar 2020 14:43:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 03/03/2020 12:04 PM, Hugh Dickins wrote:
> On Mon, 2 Mar 2020, Anshuman Khandual wrote:
> 
>> This adds the following new VMA flag wrappers which will replace current
>> open encodings across various places. This should not have any functional
>> implications.
>>
>> vma_is_dontdump()
>> vma_is_noreserve()
>> vma_is_special()
>> vma_is_locked()
>> vma_is_mergeable()
>> vma_is_softdirty()
>> vma_is_thp()
>> vma_is_nothp()
> 
> Why?? Please don't. I am not at all keen on your 1/3 and 2/3 (some
> of us actually like to see what the VM_ flags are where they're used,
> without having to chase through scattered wrappers hiding them),
> but this 3/3 particularly upset me.

Can understand your reservations regarding 3/3. But I had called that out
in the series cover letter that this patch can be dropped if related code
churn is not justified.

But 1/3 does create a default flag combination for VM_DATA_DEFAULT_FLAGS
with a value that is used by multiple platforms at the moment. This is
very similar to the existing VM_STACK_DEFAULT_FLAGS which has a default
value. Then why cannot VM_DATA_DEFAULT_FLAGS have one ? More over this
also saves some code duplication across platforms.

Regarding the patch 2/3, when there are many existing VMA flag overrides
like VM_STACK_FLAGS, VM_STACK_INCOMPLETE_SETUP, VM_INIT_DEF_MASK etc why
cannot a commonly used VMA flag combination with a very specific meaning
(i.e accessibility) get one. Do you have any particular concern here
which I might be missing.

> 
> There is a good reason for the (hideously named) is_vm_hugetlb_page(vma):
> to save "#ifdef CONFIG_HUGETLB_PAGE"s all over (though I suspect the
> same could have been achieved much more nicely by #define VM_HUGETLB 0);
> but hiding all flags in vma_is_whatever()s is counter-productive churn.

Makes sense, I can understand your reservation here.

> 
> Improved readability? Not to my eyes.

As mentioned before, I dont feel strongly about patch 3/3 and will drop.
