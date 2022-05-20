Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F352F1F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352370AbiETR5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiETR5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 13:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6113A185C90;
        Fri, 20 May 2022 10:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA4D860EE3;
        Fri, 20 May 2022 17:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABACEC385A9;
        Fri, 20 May 2022 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653069464;
        bh=zWCwftlejUqTmbDmnupK8x4rMoq86l14ym8GOJl1Vus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JxH9rJ90e0wDL/jdzIjTJxmZhEpDMrRjJIMUx2sa6kb221GDAtu2VbFDQOBj59hCr
         guVOEe1jNrYERLB4NBxjj/KFnQkO8Z/84oeszUfZSb8VnnSpRPy8yMRtGAPYe7ZS1A
         D3XFII/b4mizSxjM9c8yeG1DZsawt5/OzqQa5d/0OhDiwpiip9YrglBMwCNwJ3A81X
         sxEk+YBXvT0hWRhvycNKDkxKxBiyFwlGXVZ8EQU6g/oTseuSwwSJC/oJMAdmfEEV7X
         +65DZBOwtR9GL41sAgm1wqyIqsd1PNs/HNHB+xOU3bqYhNak20Fsr3iWeaiGKqm0VQ
         gvoN3AIWAdrug==
Message-ID: <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
Date:   Fri, 20 May 2022 10:57:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220519153713.819591-5-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/22 08:37, Chao Peng wrote:
> Extend the memslot definition to provide guest private memory through a
> file descriptor(fd) instead of userspace_addr(hva). Such guest private
> memory(fd) may never be mapped into userspace so no userspace_addr(hva)
> can be used. Instead add another two new fields
> (private_fd/private_offset), plus the existing memory_size to represent
> the private memory range. Such memslot can still have the existing
> userspace_addr(hva). When use, a single memslot can maintain both
> private memory through private fd(private_fd/private_offset) and shared
> memory through hva(userspace_addr). A GPA is considered private by KVM
> if the memslot has private fd and that corresponding page in the private
> fd is populated, otherwise, it's shared.
> 


So this is a strange API and, IMO, a layering violation.  I want to make 
sure that we're all actually on board with making this a permanent part 
of the Linux API.  Specifically, we end up with a multiplexing situation 
as you have described. For a given GPA, there are *two* possible host 
backings: an fd-backed one (from the fd, which is private for now might 
might end up potentially shared depending on future extensions) and a 
VMA-backed one.  The selection of which one backs the address is made 
internally by whatever backs the fd.

This, IMO, a clear layering violation.  Normally, an fd has an 
associated address space, and pages in that address space can have 
contents, can be holes that appear to contain all zeros, or could have 
holes that are inaccessible.  If you try to access a hole, you get 
whatever is in the hole.

But now, with this patchset, the fd is more of an overlay and you get 
*something else* if you try to access through the hole.

This results in operations on the fd bubbling up to the KVM mapping in 
what is, IMO, a strange way.  If the user punches a hole, KVM has to 
modify its mappings such that the GPA goes to whatever VMA may be there. 
  (And update the RMP, the hypervisor's tables, or whatever else might 
actually control privateness.)  Conversely, if the user does fallocate 
to fill a hole, the guest mapping *to an unrelated page* has to be 
zapped so that the fd's page shows up.  And the RMP needs updating, etc.

I am lukewarm on this for a few reasons.

1. This is weird.  AFAIK nothing else works like this.  Obviously this 
is subjecting, but "weird" and "layering violation" sometimes translate 
to "problematic locking".

2. fd-backed private memory can't have normal holes.  If I make a memfd, 
punch a hole in it, and mmap(MAP_SHARED) it, I end up with a page that 
reads as zero.  If I write to it, the page gets allocated.  But with 
this new mechanism, if I punch a hole and put it in a memslot, reads and 
writes go somewhere else.  So what if I actually wanted lazily allocated 
private zeros?

2b. For a hypothetical future extension in which an fd can also have 
shared pages (for conversion, for example, or simply because the fd 
backing might actually be more efficient than indirecting through VMAs 
and therefore get used for shared memory or entirely-non-confidential 
VMs), lazy fd-backed zeros sound genuinely useful.

3. TDX hardware capability is not fully exposed.  TDX can have a private 
page and a shared page at GPAs that differ only by the private bit. 
Sure, no one plans to use this today, but baking this into the user ABI 
throws away half the potential address space.

3b. Any software solution that works like TDX (which IMO seems like an 
eminently reasonable design to me) has the same issue.


The alternative would be to have some kind of separate table or bitmap 
(part of the memslot?) that tells KVM whether a GPA should map to the fd.

What do you all think?
