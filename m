Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380C4C1AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiBWSde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 13:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbiBWSdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:33:32 -0500
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F0F123;
        Wed, 23 Feb 2022 10:33:02 -0800 (PST)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1nMwRP-0003AV-QA; Wed, 23 Feb 2022 19:32:43 +0100
Message-ID: <7822c00f-5a2d-b6a2-2f81-cf3330801ad3@maciej.szmigiero.name>
Date:   Wed, 23 Feb 2022 19:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, qemu-devel@nongnu.org
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-13-chao.p.peng@linux.intel.com>
 <a121e766-900d-2135-1516-e1d3ba716834@maciej.szmigiero.name>
 <20220217134548.GA33836@chaop.bj.intel.com>
 <45148f5f-fe79-b452-f3b2-482c5c3291c4@maciej.szmigiero.name>
 <20220223120047.GB53733@chaop.bj.intel.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 12/12] KVM: Expose KVM_MEM_PRIVATE
In-Reply-To: <20220223120047.GB53733@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.02.2022 13:00, Chao Peng wrote:
> On Tue, Feb 22, 2022 at 02:16:46AM +0100, Maciej S. Szmigiero wrote:
>> On 17.02.2022 14:45, Chao Peng wrote:
>>> On Tue, Jan 25, 2022 at 09:20:39PM +0100, Maciej S. Szmigiero wrote:
>>>> On 18.01.2022 14:21, Chao Peng wrote:
>>>>> KVM_MEM_PRIVATE is not exposed by default but architecture code can turn
>>>>> on it by implementing kvm_arch_private_memory_supported().
>>>>>
>>>>> Also private memslot cannot be movable and the same file+offset can not
>>>>> be mapped into different GFNs.
>>>>>
>>>>> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
>>>>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>>>>> ---
>>>> (..)
>>>>>     static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
>>>>> -				      gfn_t start, gfn_t end)
>>>>> +				      struct file *file,
>>>>> +				      gfn_t start, gfn_t end,
>>>>> +				      loff_t start_off, loff_t end_off)
>>>>>     {
>>>>>     	struct kvm_memslot_iter iter;
>>>>> +	struct kvm_memory_slot *slot;
>>>>> +	struct inode *inode;
>>>>> +	int bkt;
>>>>>     	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
>>>>>     		if (iter.slot->id != id)
>>>>>     			return true;
>>>>>     	}
>>>>> +	/* Disallow mapping the same file+offset into multiple gfns. */
>>>>> +	if (file) {
>>>>> +		inode = file_inode(file);
>>>>> +		kvm_for_each_memslot(slot, bkt, slots) {
>>>>> +			if (slot->private_file &&
>>>>> +			     file_inode(slot->private_file) == inode &&
>>>>> +			     !(end_off <= slot->private_offset ||
>>>>> +			       start_off >= slot->private_offset
>>>>> +					     + (slot->npages >> PAGE_SHIFT)))
>>>>> +				return true;
>>>>> +		}
>>>>> +	}
>>>>
>>>> That's a linear scan of all memslots on each CREATE (and MOVE) operation
>>>> with a fd - we just spent more than a year rewriting similar linear scans
>>>> into more efficient operations in KVM.
>>>
(..)
>>> So linear scan is used before I can find a better way.
>>
>> Another option would be to simply not check for overlap at add or move
>> time, declare such configuration undefined behavior under KVM API and
>> make sure in MMU notifiers that nothing bad happens to the host kernel
>> if it turns out somebody actually set up a VM this way (it could be
>> inefficient in this case, since it's not supposed to ever happen
>> unless there is a bug somewhere in the userspace part).
> 
> Specific to TDX case, SEAMMODULE will fail the overlapping case and then
> KVM prints a message to the kernel log. It will not cause any other side
> effect, it does look weird however. Yes warn that in the API document
> can help to some extent.

So for the functionality you are adding this code for (TDX) this scan
isn't necessary and the overlapping case (not supported anyway) is safely
handled by the hardware (or firmware)?
Then I would simply remove the scan and, maybe, add a comment instead
that the overlap check is done by the hardware.

By the way, if a kernel log message could be triggered by (misbehaving)
userspace then it should be rate limited (if it isn't already).

> Thanks,
> Chao

Thanks,
Maciej
