Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2FA75B756
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGTTCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGTTCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:02:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054481BF7;
        Thu, 20 Jul 2023 12:02:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b318c5a7so8462445ad.3;
        Thu, 20 Jul 2023 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879734; x=1690484534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MSKcIw1ixdNRcp/f0sV+4F1n8XKG7sdC3dJK2xndKs=;
        b=HmFZ4aH4Wab+GqCN9TB1hsoxANs59ZGyg6e/EgDXSJq0eYSI/1VDWVlSgNIChLUfV8
         T/IU56bnENLrhgdM87GnmjNFM0RpmjvZJl2xcorFy1mGsUnDs9zdzDKZrSPzHq2hoIH0
         vFw+TuHLIpDpLy2T1GRQp+A/ZwejC2JNC9/kx8GgLOzFDvivXFRt8pK7pg/RJqO6epII
         jU9EDNCAY3cGtv9Kz4M3mnp24C7KZYOlNZNUgyGjPKzywths6r+RNrsvvKuGeUeTpvFE
         KzSBguxslln865ERYszYEUEyvYxe2xDbUJMXe4XuzyfRHn+tbMW1SUTP9WASXJn7b+Pn
         qf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879734; x=1690484534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MSKcIw1ixdNRcp/f0sV+4F1n8XKG7sdC3dJK2xndKs=;
        b=kQXQNlxgIB6OGjSqiTLgzQ66SlvXOgSg9yeQPasHy1tRrZayJg1B67r2rTmhNCOAmJ
         F7IDmDSz4gavhtL6MebFqP/M+sAWzmLKUSVy2g+DQhBzwMX+L4waW5WrgRwkcsGaRjN2
         lmgppL5V1MGVzsIiBfnkaj3ci0xKdPZN7MiLjOmKwAgTMjRGsfviV7tIY4XEENMoS0Yh
         hxTG6v7L00u+xESshFlRqDHAbMXFDBsHVuvpyVwEMYG/Nmxm6sGPl+bZMs4dflKQtKns
         eNSmFFVH5HDZyZGd6536BENld/2tVAw+6QsZHqba17ZtIAZ8yv7E1uPtYa0O6X5+Jy0O
         x1bQ==
X-Gm-Message-State: ABy/qLY98PwLsoc/Y4ODRcX80gnRgU55VdT5rnQlFjk7AH/CUiWpJ3Dn
        Bwiack4mYzgRdu+vI/tvP00=
X-Google-Smtp-Source: APBJJlEk/mIAgGdv75eqlacWKafqLMEC8fcDRiP+uJ4q0KoW6Z/oWLHWzhtG4Xil0kxFMatYBl1SNg==
X-Received: by 2002:a17:902:cec9:b0:1ba:fe63:6622 with SMTP id d9-20020a170902cec900b001bafe636622mr138625plg.32.1689879733690;
        Thu, 20 Jul 2023 12:02:13 -0700 (PDT)
Received: from localhost ([192.55.54.50])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b9de4fb749sm1778146plh.20.2023.07.20.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:02:12 -0700 (PDT)
Date:   Thu, 20 Jul 2023 12:02:11 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
Subject: Re: [RFC PATCH v11 08/29] KVM: Introduce per-page memory attributes
Message-ID: <20230720190211.GF25699@ls.amr.corp.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-9-seanjc@google.com>
 <20230720080912.g56zi5hywazrhnam@yy-desk-7060>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720080912.g56zi5hywazrhnam@yy-desk-7060>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:09:12PM +0800,
Yuan Yao <yuan.yao@linux.intel.com> wrote:

> On Tue, Jul 18, 2023 at 04:44:51PM -0700, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> > In confidential computing usages, whether a page is private or shared is
> > necessary information for KVM to perform operations like page fault
> > handling, page zapping etc. There are other potential use cases for
> > per-page memory attributes, e.g. to make memory read-only (or no-exec,
> > or exec-only, etc.) without having to modify memslots.
> >
> > Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> > userspace to operate on the per-page memory attributes.
> >   - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
> >     a guest memory range.
> >   - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
> >     memory attributes.
> >
> > Use an xarray to store the per-page attributes internally, with a naive,
> > not fully optimized implementation, i.e. prioritize correctness over
> > performance for the initial implementation.
> >
> > Because setting memory attributes is roughly analogous to mprotect() on
> > memory that is mapped into the guest, zap existing mappings prior to
> > updating the memory attributes.  Opportunistically provide an arch hook
> > for the post-set path (needed to complete invalidation anyways) in
> > anticipation of x86 needing the hook to update metadata related to
> > determining whether or not a given gfn can be backed with various sizes
> > of hugepages.
> >
> > It's possible that future usages may not require an invalidation, e.g.
> > if KVM ends up supporting RWX protections and userspace grants _more_
> > protections, but again opt for simplicity and punt optimizations to
> > if/when they are needed.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
> > Cc: Fuad Tabba <tabba@google.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > Co-developed-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  Documentation/virt/kvm/api.rst |  60 ++++++++++++
> >  include/linux/kvm_host.h       |  14 +++
> >  include/uapi/linux/kvm.h       |  14 +++
> >  virt/kvm/Kconfig               |   4 +
> >  virt/kvm/kvm_main.c            | 170 +++++++++++++++++++++++++++++++++
> >  5 files changed, 262 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 34d4ce66e0c8..0ca8561775ac 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6068,6 +6068,56 @@ writes to the CNTVCT_EL0 and CNTPCT_EL0 registers using the SET_ONE_REG
> >  interface. No error will be returned, but the resulting offset will not be
> >  applied.
> >
> > +4.139 KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
> > +-----------------------------------------
> > +
> > +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> > +:Architectures: x86
> > +:Type: vm ioctl
> > +:Parameters: u64 memory attributes bitmask(out)
> > +:Returns: 0 on success, <0 on error
> > +
> > +Returns supported memory attributes bitmask. Supported memory attributes will
> > +have the corresponding bits set in u64 memory attributes bitmask.
> > +
> > +The following memory attributes are defined::
> > +
> > +  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > +
> > +4.140 KVM_SET_MEMORY_ATTRIBUTES
> > +-----------------------------------------
> > +
> > +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> > +:Architectures: x86
> > +:Type: vm ioctl
> > +:Parameters: struct kvm_memory_attributes(in/out)
> > +:Returns: 0 on success, <0 on error
> > +
> > +Sets memory attributes for pages in a guest memory range. Parameters are
> > +specified via the following structure::
> > +
> > +  struct kvm_memory_attributes {
> > +	__u64 address;
> > +	__u64 size;
> > +	__u64 attributes;
> > +	__u64 flags;
> > +  };
> > +
> > +The user sets the per-page memory attributes to a guest memory range indicated
> > +by address/size, and in return KVM adjusts address and size to reflect the
> > +actual pages of the memory range have been successfully set to the attributes.
> > +If the call returns 0, "address" is updated to the last successful address + 1
> > +and "size" is updated to the remaining address size that has not been set
> > +successfully. The user should check the return value as well as the size to
> > +decide if the operation succeeded for the whole range or not. The user may want
> > +to retry the operation with the returned address/size if the previous range was
> > +partially successful.
> > +
> > +Both address and size should be page aligned and the supported attributes can be
> > +retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
> > +
> > +The "flags" field may be used for future extensions and should be set to 0s.
> > +
> >  5. The kvm_run structure
> >  ========================
> >
> > @@ -8494,6 +8544,16 @@ block sizes is exposed in KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES as a
> >  64-bit bitmap (each bit describing a block size). The default value is
> >  0, to disable the eager page splitting.
> >
> > +8.41 KVM_CAP_MEMORY_ATTRIBUTES
> > +------------------------------
> > +
> > +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> > +:Architectures: x86
> > +:Type: vm
> > +
> > +This capability indicates KVM supports per-page memory attributes and ioctls
> > +KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES are available.
> > +
> >  9. Known KVM API problems
> >  =========================
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index e9ca49d451f3..97db63da6227 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -264,6 +264,7 @@ struct kvm_gfn_range {
> >  	gfn_t end;
> >  	union {
> >  		pte_t pte;
> > +		unsigned long attributes;
> >  		u64 raw;
> >  	} arg;
> >  	bool may_block;
> > @@ -809,6 +810,9 @@ struct kvm {
> >
> >  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
> >  	struct notifier_block pm_notifier;
> > +#endif
> > +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> > +	struct xarray mem_attr_array;
> >  #endif
> >  	char stats_id[KVM_STATS_NAME_SIZE];
> >  };
> > @@ -2301,4 +2305,14 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
> >  /* Max number of entries allowed for each kvm dirty ring */
> >  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
> >
> > +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> > +static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
> > +}
> > +
> > +bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> > +					 struct kvm_gfn_range *range);
> 
> Used but no definition in this patch, it's defined in next patch 09.
> How about add weak version in this patch and let ARCHs to overide it ?

It is guarded by CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
