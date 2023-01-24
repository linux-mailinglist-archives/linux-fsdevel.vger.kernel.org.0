Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489DF679255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 08:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjAXHxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 02:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjAXHxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:53:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23844A9;
        Mon, 23 Jan 2023 23:53:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E57DA1F889;
        Tue, 24 Jan 2023 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674546816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ruXNUJNdlgxTcKpGQIIryFyEkOXceoGZmlzFPRxeoas=;
        b=KBZy/6rf1TQ67g44L7GTiJ8oSbfhPfVBczpwAWnzfsUxhfC2iuCIk6qk9LBZzqbdqHS9ij
        Xo/ephBOmafeSayjs7c5/FPCJUSd2Msf8a1NMzxX8FC7m33OJCMAr4kwrcZhMcXrY5NeLZ
        PTRszq6e6uAR3JoT+NAAk5grhZN/cnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674546816;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ruXNUJNdlgxTcKpGQIIryFyEkOXceoGZmlzFPRxeoas=;
        b=5qR8OroDRbnLzHCA3YaBwq02hXFJllZS99kT3/fzfEAfh1RBI9ipdG1fjVOHFRLXyqtRUK
        okE5lPcauQAR8tCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA32C139FB;
        Tue, 24 Jan 2023 07:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E4c3MH+Oz2OlHgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 Jan 2023 07:53:35 +0000
Message-ID: <8ac234a3-9dc3-3ebf-309a-b4a6bcb72d2d@suse.cz>
Date:   Tue, 24 Jan 2023 08:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "tabba@google.com" <tabba@google.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Annapurve, Vishal" <vannapurve@google.com>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
References: <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
 <20221220072228.GA1724933@chaop.bj.intel.com>
 <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
 <20221221133905.GA1766136@chaop.bj.intel.com>
 <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
 <010a330c-a4d5-9c1a-3212-f9107d1c5f4e@suse.cz>
 <0959c72ec635688f4b6c1b516815f79f52543b31.camel@intel.com>
 <Y88aX+MIZeteDQju@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y88aX+MIZeteDQju@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23 00:38, Sean Christopherson wrote:
> On Mon, Jan 23, 2023, Huang, Kai wrote:
>> On Mon, 2023-01-23 at 15:03 +0100, Vlastimil Babka wrote:
>>> On 12/22/22 01:37, Huang, Kai wrote:
>>>>>> I argue that this page pinning (or page migration prevention) is not
>>>>>> tied to where the page comes from, instead related to how the page will
>>>>>> be used. Whether the page is restrictedmem backed or GUP() backed, once
>>>>>> it's used by current version of TDX then the page pinning is needed. So
>>>>>> such page migration prevention is really TDX thing, even not KVM generic
>>>>>> thing (that's why I think we don't need change the existing logic of
>>>>>> kvm_release_pfn_clean()). 
>>>>>>
>>>> This essentially boils down to who "owns" page migration handling, and sadly,
>>>> page migration is kinda "owned" by the core-kernel, i.e. KVM cannot handle page
>>>> migration by itself -- it's just a passive receiver.
>>>>
>>>> For normal pages, page migration is totally done by the core-kernel (i.e. it
>>>> unmaps page from VMA, allocates a new page, and uses migrate_pape() or a_ops-
>>>>> migrate_page() to actually migrate the page).
>>>> In the sense of TDX, conceptually it should be done in the same way. The more
>>>> important thing is: yes KVM can use get_page() to prevent page migration, but
>>>> when KVM wants to support it, KVM cannot just remove get_page(), as the core-
>>>> kernel will still just do migrate_page() which won't work for TDX (given
>>>> restricted_memfd doesn't have a_ops->migrate_page() implemented).
>>>>
>>>> So I think the restricted_memfd filesystem should own page migration handling,
>>>> (i.e. by implementing a_ops->migrate_page() to either just reject page migration
>>>> or somehow support it).
>>>
>>> While this thread seems to be settled on refcounts already, 
>>>
>>
>> I am not sure but will let Sean/Paolo to decide.
> 
> My preference is whatever is most performant without being hideous :-)
> 
>>> just wanted
>>> to point out that it wouldn't be ideal to prevent migrations by
>>> a_ops->migrate_page() rejecting them. It would mean cputime wasted (i.e.
>>> by memory compaction) by isolating the pages for migration and then
>>> releasing them after the callback rejects it (at least we wouldn't waste
>>> time creating and undoing migration entries in the userspace page tables
>>> as there's no mmap). Elevated refcount on the other hand is detected
>>> very early in compaction so no isolation is attempted, so from that
>>> aspect it's optimal.
>>
>> I am probably missing something,
> 
> Heh, me too, I could have sworn that using refcounts was the least efficient way
> to block migration.

Well I admit that due to my experience with it, I do mostly consider
migration through memory compaction POV, which is a significant user of
migration on random pages that's not requested by userspace actions on
specific ranges.

And compaction has in isolate_migratepages_block():

/*
 * Migration will fail if an anonymous page is pinned in memory,
 * so avoid taking lru_lock and isolating it unnecessarily in an
 * admittedly racy check.
 */
mapping = page_mapping(page);
if (!mapping && page_count(page) > page_mapcount(page))
        goto isolate_fail;

so that prevents migration of pages with elevated refcount very early,
before they are even isolated, so before migrate_pages() is called.

But it's true there are other sources of "random pages migration" - numa
balancing, demotion in lieu of reclaim... and I'm not sure if all have
such early check too.

Anyway, whatever is decided to be a better way than elevated refcounts,
would ideally be checked before isolation as well, as that's the most
efficient way.

>> but IIUC the checking of refcount happens at very last stage of page migration too 

