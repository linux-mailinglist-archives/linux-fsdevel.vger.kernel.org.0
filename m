Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBC49BD5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 21:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiAYUnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 15:43:41 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:59206 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232319AbiAYUnk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:43:40 -0500
X-Greylist: delayed 1337 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 15:43:40 EST
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1nCSJ4-0006nf-3P; Tue, 25 Jan 2022 21:20:46 +0100
Message-ID: <a121e766-900d-2135-1516-e1d3ba716834@maciej.szmigiero.name>
Date:   Tue, 25 Jan 2022 21:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
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
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 12/12] KVM: Expose KVM_MEM_PRIVATE
In-Reply-To: <20220118132121.31388-13-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.01.2022 14:21, Chao Peng wrote:
> KVM_MEM_PRIVATE is not exposed by default but architecture code can turn
> on it by implementing kvm_arch_private_memory_supported().
> 
> Also private memslot cannot be movable and the same file+offset can not
> be mapped into different GFNs.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
(..)
>   
>   static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
> -				      gfn_t start, gfn_t end)
> +				      struct file *file,
> +				      gfn_t start, gfn_t end,
> +				      loff_t start_off, loff_t end_off)
>   {
>   	struct kvm_memslot_iter iter;
> +	struct kvm_memory_slot *slot;
> +	struct inode *inode;
> +	int bkt;
>   
>   	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
>   		if (iter.slot->id != id)
>   			return true;
>   	}
>   
> +	/* Disallow mapping the same file+offset into multiple gfns. */
> +	if (file) {
> +		inode = file_inode(file);
> +		kvm_for_each_memslot(slot, bkt, slots) {
> +			if (slot->private_file &&
> +			     file_inode(slot->private_file) == inode &&
> +			     !(end_off <= slot->private_offset ||
> +			       start_off >= slot->private_offset
> +					     + (slot->npages >> PAGE_SHIFT)))
> +				return true;
> +		}
> +	}

That's a linear scan of all memslots on each CREATE (and MOVE) operation
with a fd - we just spent more than a year rewriting similar linear scans
into more efficient operations in KVM.

Thanks,
Maciej
