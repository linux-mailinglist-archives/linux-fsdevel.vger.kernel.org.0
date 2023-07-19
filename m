Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE19758FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGSHzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 03:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjGSHzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:55:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F83210A;
        Wed, 19 Jul 2023 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689753290; x=1721289290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1N+W8cRNC9pUexWe7qJQhUtuOwgwVBF4LoLojnPzLGM=;
  b=MixlU4/EWVcHlWqrt6Hw8mbKHeXxoeGFES3zm7xofvpXmrZrVumYhy+B
   YqUYb46t+UKPkTsNgLiqajuhdJvXGF01ACu2lxkvSEIqS3vkU39IwbOJs
   cHwft5ioO0Z9VFEVy5BKDPFQg7u5QxNtDoQwpGn99OI9OTXJ9n+0j/moX
   uXd5hZexZet+n4BIlgZBEORiygVlEtqnNQmYt+PpsqasLpsS1arQqqjmf
   lktJpa9sAGv+xfbQxQapRqWqAHLbSnF/Z4Zo9Ua6QRyNW53t/DyChJkqz
   ypca3FEhhBZ+xs8TlSgoJgFCxngVKRKOg9iI26X6oTjGzaDBsC6amxwly
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397250599"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397250599"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 00:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="814045464"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="814045464"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2023 00:54:41 -0700
Date:   Wed, 19 Jul 2023 15:54:40 +0800
From:   Yuan Yao <yuan.yao@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v11 07/29] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <20230719075440.m3h653frqggaiusc@yy-desk-7060>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-8-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718234512.1690985-8-seanjc@google.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 04:44:50PM -0700, Sean Christopherson wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> This new KVM exit allows userspace to handle memory-related errors. It
> indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> The flags includes additional information for userspace to handle the
> error. Currently bit 0 is defined as 'private memory' where '1'
> indicates error happens due to private memory access and '0' indicates
> error happens due to shared memory access.

Now it's bit 3:

#define KVM_MEMORY_EXIT_FLAG_PRIVATE (1ULL << 3)

I remember some other attributes were introduced in v10 yet:

#define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
#define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
#define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)

So KVM_MEMORY_EXIT_FLAG_PRIVATE changed to bit 3 due to above things,
or other reason ? (Sorry I didn't follow v10 too much before).

>
> When private memory is enabled, this new exit will be used for KVM to
> exit to userspace for shared <-> private memory conversion in memory
> encryption usage. In such usage, typically there are two kind of memory
> conversions:
>   - explicit conversion: happens when guest explicitly calls into KVM
>     to map a range (as private or shared), KVM then exits to userspace
>     to perform the map/unmap operations.
>   - implicit conversion: happens in KVM page fault handler where KVM
>     exits to userspace for an implicit conversion when the page is in a
>     different state than requested (private or shared).
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 22 ++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |  8 ++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index c0ddd3035462..34d4ce66e0c8 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6700,6 +6700,28 @@ array field represents return values. The userspace should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>
> +::
> +
> +		/* KVM_EXIT_MEMORY_FAULT */
> +		struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
> +			__u64 flags;
> +			__u64 gpa;
> +			__u64 size;
> +		} memory;
> +
> +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
> +encountered a memory error which is not handled by KVM kernel module and
> +userspace may choose to handle it. The 'flags' field indicates the memory
> +properties of the exit.
> +
> + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> +   private memory access when the bit is set. Otherwise the memory error is
> +   caused by shared memory access when the bit is clear.
> +
> +'gpa' and 'size' indicate the memory range the error occurs at. The userspace
> +may handle the error and return to KVM to retry the previous memory access.
> +
>  ::
>
>      /* KVM_EXIT_NOTIFY */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4d4b3de8ac55..6c6ed214b6ac 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -274,6 +274,7 @@ struct kvm_xen_exit {
>  #define KVM_EXIT_RISCV_SBI        35
>  #define KVM_EXIT_RISCV_CSR        36
>  #define KVM_EXIT_NOTIFY           37
> +#define KVM_EXIT_MEMORY_FAULT     38
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -520,6 +521,13 @@ struct kvm_run {
>  #define KVM_NOTIFY_CONTEXT_INVALID	(1 << 0)
>  			__u32 flags;
>  		} notify;
> +		/* KVM_EXIT_MEMORY_FAULT */
> +		struct {
> +#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
> +			__u64 flags;
> +			__u64 gpa;
> +			__u64 size;
> +		} memory;
>  		/* Fix the size of the union. */
>  		char padding[256];
>  	};
> --
> 2.41.0.255.g8b1d071c50-goog
>
