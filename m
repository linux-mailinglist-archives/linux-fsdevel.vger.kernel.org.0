Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32381520EC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiEJHop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 03:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiEJHoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 03:44:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8672B3F7D;
        Tue, 10 May 2022 00:35:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A7A91FA40;
        Tue, 10 May 2022 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652168112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XmhHsmMxly2ssjXZq07GT+YLgJJKJCm1DDtateBDTk=;
        b=IJuN4UGrs9rc2dJVVBhsa1bjZ3T3IclRPChNG+pU/f0P5j2jhqhJdBv6iHyS8YLVKXrX9O
        IgR+SAlvxejrlifKj7vvU9VRi+tTDzUTwOLC8ZzoO9LJStWIqpcJbGIH0Mg8qtBSPfOOXE
        DtIELQ9PZ5agpNUPUxAzWBC7OuPsRuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652168112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XmhHsmMxly2ssjXZq07GT+YLgJJKJCm1DDtateBDTk=;
        b=Hky868WPFR6DQGfmlvXKlSdXSBp6m/eni1+ZiF8ZqPIJzJCqTRAyxT9iOGNx5/1MoEmPNW
        oW/SwcsdgAngRzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFBA313AA5;
        Tue, 10 May 2022 07:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xutPNa8VemJXeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 May 2022 07:35:11 +0000
Message-ID: <0da1c63b-5cc3-7fc9-1fb4-fdc385539bbc@suse.cz>
Date:   Tue, 10 May 2022 09:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220404200250.321455-1-shy828301@gmail.com>
 <627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz>
 <CAHbLzkrZb6r1r6xFaEFvvJzwvVgDgeZWfjhq-SFu_mQZ0j5tTQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
In-Reply-To: <CAHbLzkrZb6r1r6xFaEFvvJzwvVgDgeZWfjhq-SFu_mQZ0j5tTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/22 22:34, Yang Shi wrote:
> On Mon, May 9, 2022 at 9:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 4/4/22 22:02, Yang Shi wrote:
>> >  include/linux/huge_mm.h        | 14 ++++++++++++
>> >  include/linux/khugepaged.h     | 59 ++++++++++++---------------------------------------
>> >  include/linux/sched/coredump.h |  3 ++-
>> >  kernel/fork.c                  |  4 +---
>> >  mm/huge_memory.c               | 15 ++++---------
>> >  mm/khugepaged.c                | 76 +++++++++++++++++++++++++++++++++++++-----------------------------
>> >  mm/mmap.c                      | 14 ++++++++----
>> >  mm/shmem.c                     | 12 -----------
>> >  8 files changed, 88 insertions(+), 109 deletions(-)
>>
>> Resending my general feedback from mm-commits thread to include the
>> public ML's:
>>
>> There's modestly less lines in the end, some duplicate code removed,
>> special casing in shmem.c removed, that's all good as it is. Also patch 8/8
>> become quite boring in v3, no need to change individual filesystems and also
>> no hook in fault path, just the common mmap path. So I would just handle
>> patch 6 differently as I just replied to it, and acked the rest.
>>
>> That said it's still unfortunately rather a mess of functions that have
>> similar names. transhuge_vma_enabled(vma). hugepage_vma_check(vma),
>> transparent_hugepage_active(vma), transhuge_vma_suitable(vma, addr)?
>> So maybe still some space for further cleanups. But the series is fine as it
>> is so we don't have to wait for it now.
> 
> Yeah, I agree that we do have a lot thp checks. Will find some time to
> look into it deeper later.

Thanks.

>>
>> We could also consider that the tracking of which mm is to be scanned is
>> modelled after ksm which has its own madvise flag, but also no "always"
>> mode. What if for THP we only tracked actual THP madvised mm's, and in
>> "always" mode just scanned all vm's, would that allow ripping out some code
>> perhaps, while not adding too many unnecessary scans? If some processes are
> 
> Do you mean add all mm(s) to the scan list unconditionally? I don't
> think it will scale.

It might be interesting to find out how many mm's (percentage of all mm's)
are typically in the list with "always" enabled. I wouldn't be surprised if
it was nearly all of them. Having at least one large enough anonymous area
sounds like something all processes would have these days?

>> being scanned without any effect, maybe track success separately, and scan
>> them less frequently etc. That could be ultimately more efficinet than
>> painfully tracking just *eligibility* for scanning in "always" mode?
> 
> Sounds like we need a couple of different lists, for example, inactive
> and active? And promote or demote mm(s) between the two lists? TBH I
> don't see too many benefits at the moment. Or I misunderstood you?

Yeah, something like that. It would of course require finding out whether
khugepaged is consuming too much cpu uselessly these days while not
processing fast enough mm's where it succeeds more.

>>
>> Even more radical thing to consider (maybe that's a LSF/MM level topic, too
>> bad :) is that we scan pagetables in ksm, khugepaged, numa balancing, soon
>> in MGLRU, and I probably forgot something else. Maybe time to think about
>> unifying those scanners?
> 
> We do have pagewalk (walk_page_range()) which is used by a couple of
> mm stuff, for example, mlock, mempolicy, mprotect, etc. I'm not sure
> whether it is feasible for khugepaged, ksm, etc, or not since I didn't
> look that hard. But I agree it should be worth looking at.

pagewalk is a framework to simplify writing code that processes page tables
for a given one-off task, yeah. But this would be something a bit different,
e.g. a kernel thread that does the sum of what khugepaged/ksm/etc do. Numa
balancing uses task_work instead of kthread so that would require
consideration on which mechanism the unified daemon would use.

>>
>>

