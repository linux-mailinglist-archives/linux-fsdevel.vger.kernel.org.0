Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AC56947ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBMOXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 09:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBMOXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:23:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEFF1B55B;
        Mon, 13 Feb 2023 06:23:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3E951F37F;
        Mon, 13 Feb 2023 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676298217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xI8t880WoH5RIgX7MmHkHOMY1R2Mkd9PP0v7yUbxzrM=;
        b=FejCCuo9F/1ynlgHsDBhIi9S5hH4MEbRMkX6V4fVllQfQz+Pvu43L3bCglZSBmTNDhNRJN
        3aS3N4ba6rEBi/I6xjFdC2zQv6vgmregXBDMxAvs3F5TsBeXNNYCej7A4XuvZqcnE8ueLq
        Zk4CH/H5bLzeEW32rCyj1TjJVuWh16E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676298217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xI8t880WoH5RIgX7MmHkHOMY1R2Mkd9PP0v7yUbxzrM=;
        b=zQFUpB1curciG/HW2rtt77UABs/cJcnsU1I9qdyoFKrG5KNyvp9T4FGiOtq3iJMkfmY1iH
        5B9gdsyOZJM5syAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 124AD138E6;
        Mon, 13 Feb 2023 14:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9NaxA+lH6mPvfgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Feb 2023 14:23:37 +0000
Message-ID: <5d83c330-2697-b0a2-f55a-434b12bd81f8@suse.cz>
Date:   Mon, 13 Feb 2023 15:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "tabba@google.com" <tabba@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vannapurve@google.com" <vannapurve@google.com>,
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
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
 <20221220072228.GA1724933@chaop.bj.intel.com>
 <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
 <20221221133905.GA1766136@chaop.bj.intel.com>
 <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
 <010a330c-a4d5-9c1a-3212-f9107d1c5f4e@suse.cz>
 <20230123151803.lwbjug6fm45olmru@box>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230123151803.lwbjug6fm45olmru@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 16:18, Kirill A. Shutemov wrote:
> On Mon, Jan 23, 2023 at 03:03:45PM +0100, Vlastimil Babka wrote:
>> On 12/22/22 01:37, Huang, Kai wrote:
>> >>> I argue that this page pinning (or page migration prevention) is not
>> >>> tied to where the page comes from, instead related to how the page will
>> >>> be used. Whether the page is restrictedmem backed or GUP() backed, once
>> >>> it's used by current version of TDX then the page pinning is needed. So
>> >>> such page migration prevention is really TDX thing, even not KVM generic
>> >>> thing (that's why I think we don't need change the existing logic of
>> >>> kvm_release_pfn_clean()). 
>> >>>
>> > This essentially boils down to who "owns" page migration handling, and sadly,
>> > page migration is kinda "owned" by the core-kernel, i.e. KVM cannot handle page
>> > migration by itself -- it's just a passive receiver.
>> > 
>> > For normal pages, page migration is totally done by the core-kernel (i.e. it
>> > unmaps page from VMA, allocates a new page, and uses migrate_pape() or a_ops-
>> >> migrate_page() to actually migrate the page).
>> > In the sense of TDX, conceptually it should be done in the same way. The more
>> > important thing is: yes KVM can use get_page() to prevent page migration, but
>> > when KVM wants to support it, KVM cannot just remove get_page(), as the core-
>> > kernel will still just do migrate_page() which won't work for TDX (given
>> > restricted_memfd doesn't have a_ops->migrate_page() implemented).
>> > 
>> > So I think the restricted_memfd filesystem should own page migration handling,
>> > (i.e. by implementing a_ops->migrate_page() to either just reject page migration
>> > or somehow support it).
>> 
>> While this thread seems to be settled on refcounts already, just wanted
>> to point out that it wouldn't be ideal to prevent migrations by
>> a_ops->migrate_page() rejecting them. It would mean cputime wasted (i.e.
>> by memory compaction) by isolating the pages for migration and then
>> releasing them after the callback rejects it (at least we wouldn't waste
>> time creating and undoing migration entries in the userspace page tables
>> as there's no mmap). Elevated refcount on the other hand is detected
>> very early in compaction so no isolation is attempted, so from that
>> aspect it's optimal.
> 
> Hm. Do we need a new hook in a_ops to check if the page is migratable
> before going with longer path to migrate_page().
> 
> Or maybe add AS_UNMOVABLE?

AS_UNMOVABLE should indeed allow a test in e.g. compaction to descide that
the page is not worth isolating in the first place.
