Return-Path: <linux-fsdevel+bounces-49488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D06ABD340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 11:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F13188E9EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC3B267720;
	Tue, 20 May 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B80EdFxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662F1E5701
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732996; cv=none; b=SnyFvzwNNQLUCg43CV+3eWUnOmXxFdmymkQB96q3GPI8UKqyf4Vv1ktWMdefBa4R0gne8ZT77+mkHIwwW/yIQpkDRr1vqGqjV0uPhbqo01yKnSNpVuOnzEBLtbvJIXV6Quwz9znLf/2LeTQRVVLL+MOjB0EiBzzAtg0FrJw8Wb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732996; c=relaxed/simple;
	bh=O0R+4hBrS+DWfxjMiLcCGNdUu4EaPTREGYA4X6FqPPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOCpTW0eo1qVxyHiz5G0u0kXIkAn4JWmRKV5Lee5dXcpGfcUjO1coWnYfYjfM7vYlH9KkfOX+5sj2WbIEo6EjoLTmoWEf/iQK+kRHDO35a+yxeBaTJdJVkVgNcD+EXdJzsfpsMdcQiKI1xFfqb78JKW8Ua6EqzDMwlmME7QtqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B80EdFxw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47666573242so961521cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747732992; x=1748337792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NgRslGgoPUIa9miQEs5PaTdBGnGmWi2fH+uqBrR2JTA=;
        b=B80EdFxwNCyjOcsQeRpObAlk0KcYZR5dQZGg1BXmghTCrBHW4N9uRy9mNPCL1KrDaE
         EPkqyuXpo4wNczeCS2s/iQvWlZSO+2L19s76DFuWcM3I5VONHOizR/dqmbzVEpRJNLRY
         Osmxo1pobMhkREEHt5ZsyZSGJqt/uSf3w01NqRtijF1NOo427z8a4MNYkzmN4LovckBY
         k9KlfVTsCSSVlG2fFFV4Ld+rA+EIb0nIkXBCt7waeqyID34DeA5GBV85o8yA26yqmZls
         pli1wn2bmbhJZSqozVqUij8mwgMf21CiFV+5YLl1IqvWyx42wD9NnrXrXuSi/pHOTzDR
         i2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732992; x=1748337792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgRslGgoPUIa9miQEs5PaTdBGnGmWi2fH+uqBrR2JTA=;
        b=vPVqJ9lHmrdKkuUNRpfrnPhxBhWmhcztRmwnXNpEpZTouXAs49i6PhJazJdYIqrv7P
         MIpXn/uqjJerUeOw1zvgkTIX8bdHUltROZ1wUhhtFRdMzlN7uNycxNanyW+9rydyDxIU
         Pon2g9oRNjKW1S7XL2uiaCe18hkP4A3OLuFYs4Y9HZfKoxvHu9RO6xGPKtTubuaUqMLL
         tlOdAtWC6MYu0J+La/8M2bBEHfrRJ2KuJfxh+kFbf9mlBIXwcb6cOOulbp0B+gkoPGB8
         gSJE0nWz/D9vkr++5uEGR0r9iuw2pA392MylPLw3BxgrlkBBD0n+N6wQ2JNTXzqhFpDX
         n3pw==
X-Forwarded-Encrypted: i=1; AJvYcCXlOX2UQqVNKGhFbvkGizw0XyO/cAgybrSUx1wQLGeMZg4Wjxts8vGB7RvBzkgfUG8SmYl7J9zqFg/dRjF+@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyhL3ZQwRMA3X7VgfqJPmQGnr9U2YV+mJCzqX361FI+CqyolB
	F19r11PCZyX3+0VkZQTofJsuAjUYoVytEj8Rb7sQwxTcTfQfzhn0ww0F+sfhDsjIwHfxFj4RtmG
	cIS5P/SC+baLnQZmpaa9pOPCLlzrOqhH2qQIenfrZ
X-Gm-Gg: ASbGncuVjn6l24yr49EvlkXCP3NeKM7+cOROuJvAGBIUMb8e9/yvLzLogwfIpysVjMW
	HbF9teOPjOVlXGQ+8br9HcfT/jCcGZvXkZXBtXhaLMf2akYP6Y623IuSXqdJSdb4rAUtwmdBtbY
	kNlu7/2P9pHWbk3UAgbGYDy/oe+ahyP26eJ3btgtRCNO6HiGQNl3TLYX6sYdvB/l+QbrSk9MXm
X-Google-Smtp-Source: AGHT+IHqSH0PeJIRquwgzahePpyVteyvanvz6fbvfbuDtvPX6fcluzAS0uk6PdWolQebE/NO+IFyJGyJiFbkj5kTeeE=
X-Received: by 2002:ac8:7f4c:0:b0:48a:5b89:473b with SMTP id
 d75a77b69052e-49600c85c06mr9620301cf.7.1747732991941; Tue, 20 May 2025
 02:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
In-Reply-To: <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 20 May 2025 10:22:35 +0100
X-Gm-Features: AX0GCFuad3k_eeLCPfcn12RMV3c4zm88hv51IV1yTlQEhgXZK63kv1Lb7vhRYsI
Message-ID: <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Ackerley,

On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google.com> wrote:
>
> The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
> KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges to shared
> and private respectively.

I have a high level question about this particular patch and this
approach for conversion: why do we need IOCTLs to manage conversion
between private and shared?

In the presentations I gave at LPC [1, 2], and in my latest patch
series that performs in-place conversion [3] and the associated (by
now outdated) state diagram [4], I didn't see the need to have a
userspace-facing interface to manage that. KVM has all the information
it needs to handle conversions, which are triggered by the guest. To
me this seems like it adds additional complexity, as well as a user
facing interface that we would need to maintain.

There are various ways we could handle conversion without explicit
interference from userspace. What I had in mind is the following (as
an example, details can vary according to VM type). I will use use the
case of conversion from shared to private because that is the more
complicated (interesting) case:

- Guest issues a hypercall to request that a shared folio become private.

- The hypervisor receives the call, and passes it to KVM.

- KVM unmaps the folio from the guest stage-2 (EPT I think in x86
parlance), and unmaps it from the host. The host however, could still
have references (e.g., GUP).

- KVM exits to the host (hypervisor call exit), with the information
that the folio has been unshared from it.

- A well behaving host would now get rid of all of its references
(e.g., release GUPs), perform a VCPU run, and the guest continues
running as normal. I expect this to be the common case.

But to handle the more interesting situation, let's say that the host
doesn't do it immediately, and for some reason it holds on to some
references to that folio.

- Even if that's the case, the guest can still run *. If the guest
tries to access the folio, KVM detects that access when it tries to
fault it into the guest, sees that the host still has references to
that folio, and exits back to the host with a memory fault exit. At
this point, the VCPU that has tried to fault in that particular folio
cannot continue running as long as it cannot fault in that folio.

- The host tries a VCPU run again, and the above repeats, i.e., KVM
checks the refcount, finds that the host still holds references,
doesn't fault the folio into the guest, and exits back to the host.

- Eventually a well-behaving host releases all its references, and the
following VCPU run is able to fault the page into the guest, and
proceed with running it.

In case the guest is destroyed before that happens, we have the whole
folio_put() callback scenario we had discussed earlier.

In other words, the interface that I had in mind where KVM run exists
(hyp call, memory fault), as well as VCPU run. Both which already
exist, and convey the same information. Is there a case where that
isn't enough or suboptimal?

Thanks,
/fuad

(*) An alternative suggestion was to block the VCPU from running
altogether, regardless of whether it wants to fault the unshared page
immediately, and continually exit to the host until references are
dropped and the conversion can happen.

[1] https://lpc.events/event/17/contributions/1487/
[2] https://lpc.events/event/18/contributions/1758/
[3] https://lore.kernel.org/all/20250328153133.3504118-1-tabba@google.com/
[4] https://lpc.events/event/18/contributions/1758/attachments/1457/3699/Guestmemfd%20folio%20state%20page_type.pdf


> A guest_memfd ioctl is used because shareability is a property of the
> memory, and this property should be modifiable independently of the
> attached struct kvm. This allows shareability to be modified even if
> the memory is not yet bound using memslots.
>
> For shared to private conversions, if refcounts on any of the folios
> within the range are elevated, fail the conversion with -EAGAIN.
>
> At the point of shared to private conversion, all folios in range are
> also unmapped. The filemap_invalidate_lock() is held, so no faulting
> can occur. Hence, from that point on, only transient refcounts can be
> taken on the folios associated with that guest_memfd.
>
> Hence, it is safe to do the conversion from shared to private.
>
> After conversion is complete, refcounts may become elevated, but that
> is fine since users of transient refcounts don't actually access
> memory.
>
> For private to shared conversions, there are no refcount checks. any
> transient refcounts are expected to drop their refcounts soon. The
> conversion process will spin waiting for these transient refcounts to
> go away.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> Change-Id: I3546aaf6c1b795de6dc9ba09e816b64934221918
> ---
>  include/uapi/linux/kvm.h |  11 ++
>  virt/kvm/guest_memfd.c   | 357 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 366 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index d7df312479aa..5b28e17f6f14 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1577,6 +1577,17 @@ struct kvm_create_guest_memfd {
>         __u64 reserved[6];
>  };
>
> +#define KVM_GMEM_IO 0xAF
> +#define KVM_GMEM_CONVERT_SHARED                _IOWR(KVM_GMEM_IO,  0x41, struct kvm_gmem_convert)
> +#define KVM_GMEM_CONVERT_PRIVATE       _IOWR(KVM_GMEM_IO,  0x42, struct kvm_gmem_convert)
> +
> +struct kvm_gmem_convert {
> +       __u64 offset;
> +       __u64 size;
> +       __u64 error_offset;
> +       __u64 reserved[5];
> +};
> +
>  #define KVM_PRE_FAULT_MEMORY   _IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
>
>  struct kvm_pre_fault_memory {
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 590932499eba..f802116290ce 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -30,6 +30,10 @@ enum shareability {
>  };
>
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
> +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> +                                     pgoff_t end);
> +static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
> +                                   pgoff_t end);
>
>  static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
>  {
> @@ -85,6 +89,306 @@ static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t inde
>         return kvm_gmem_get_folio(inode, index);
>  }
>
> +/**
> + * kvm_gmem_shareability_store() - Sets shareability to @value for range.
> + *
> + * @mt: the shareability maple tree.
> + * @index: the range begins at this index in the inode.
> + * @nr_pages: number of PAGE_SIZE pages in this range.
> + * @value: the shareability value to set for this range.
> + *
> + * Unlike mtree_store_range(), this function also merges adjacent ranges that
> + * have the same values as an optimization. Assumes that all stores to @mt go
> + * through this function, such that adjacent ranges are always merged.
> + *
> + * Return: 0 on success and negative error otherwise.
> + */
> +static int kvm_gmem_shareability_store(struct maple_tree *mt, pgoff_t index,
> +                                      size_t nr_pages, enum shareability value)
> +{
> +       MA_STATE(mas, mt, 0, 0);
> +       unsigned long start;
> +       unsigned long last;
> +       void *entry;
> +       int ret;
> +
> +       start = index;
> +       last = start + nr_pages - 1;
> +
> +       mas_lock(&mas);
> +
> +       /* Try extending range. entry is NULL on overflow/wrap-around. */
> +       mas_set_range(&mas, last + 1, last + 1);
> +       entry = mas_find(&mas, last + 1);
> +       if (entry && xa_to_value(entry) == value)
> +               last = mas.last;
> +
> +       mas_set_range(&mas, start - 1, start - 1);
> +       entry = mas_find(&mas, start - 1);
> +       if (entry && xa_to_value(entry) == value)
> +               start = mas.index;
> +
> +       mas_set_range(&mas, start, last);
> +       ret = mas_store_gfp(&mas, xa_mk_value(value), GFP_KERNEL);
> +
> +       mas_unlock(&mas);
> +
> +       return ret;
> +}
> +
> +struct conversion_work {
> +       struct list_head list;
> +       pgoff_t start;
> +       size_t nr_pages;
> +};
> +
> +static int add_to_work_list(struct list_head *list, pgoff_t start, pgoff_t last)
> +{
> +       struct conversion_work *work;
> +
> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
> +       if (!work)
> +               return -ENOMEM;
> +
> +       work->start = start;
> +       work->nr_pages = last + 1 - start;
> +
> +       list_add_tail(&work->list, list);
> +
> +       return 0;
> +}
> +
> +static bool kvm_gmem_has_safe_refcount(struct address_space *mapping, pgoff_t start,
> +                                      size_t nr_pages, pgoff_t *error_index)
> +{
> +       const int filemap_get_folios_refcount = 1;
> +       struct folio_batch fbatch;
> +       bool refcount_safe;
> +       pgoff_t last;
> +       int i;
> +
> +       last = start + nr_pages - 1;
> +       refcount_safe = true;
> +
> +       folio_batch_init(&fbatch);
> +       while (refcount_safe &&
> +              filemap_get_folios(mapping, &start, last, &fbatch)) {
> +
> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +                       int filemap_refcount;
> +                       int safe_refcount;
> +                       struct folio *f;
> +
> +                       f = fbatch.folios[i];
> +                       filemap_refcount = folio_nr_pages(f);
> +
> +                       safe_refcount = filemap_refcount + filemap_get_folios_refcount;
> +                       if (folio_ref_count(f) != safe_refcount) {
> +                               refcount_safe = false;
> +                               *error_index = f->index;
> +                               break;
> +                       }
> +               }
> +
> +               folio_batch_release(&fbatch);
> +       }
> +
> +       return refcount_safe;
> +}
> +
> +static int kvm_gmem_shareability_apply(struct inode *inode,
> +                                      struct conversion_work *work,
> +                                      enum shareability m)
> +{
> +       struct maple_tree *mt;
> +
> +       mt = &kvm_gmem_private(inode)->shareability;
> +       return kvm_gmem_shareability_store(mt, work->start, work->nr_pages, m);
> +}
> +
> +static int kvm_gmem_convert_compute_work(struct inode *inode, pgoff_t start,
> +                                        size_t nr_pages, enum shareability m,
> +                                        struct list_head *work_list)
> +{
> +       struct maple_tree *mt;
> +       struct ma_state mas;
> +       pgoff_t last;
> +       void *entry;
> +       int ret;
> +
> +       last = start + nr_pages - 1;
> +
> +       mt = &kvm_gmem_private(inode)->shareability;
> +       ret = 0;
> +
> +       mas_init(&mas, mt, start);
> +
> +       rcu_read_lock();
> +       mas_for_each(&mas, entry, last) {
> +               enum shareability current_m;
> +               pgoff_t m_range_index;
> +               pgoff_t m_range_last;
> +               int ret;
> +
> +               m_range_index = max(mas.index, start);
> +               m_range_last = min(mas.last, last);
> +
> +               current_m = xa_to_value(entry);
> +               if (m == current_m)
> +                       continue;
> +
> +               mas_pause(&mas);
> +               rcu_read_unlock();
> +               /* Caller will clean this up on error. */
> +               ret = add_to_work_list(work_list, m_range_index, m_range_last);
> +               rcu_read_lock();
> +               if (ret)
> +                       break;
> +       }
> +       rcu_read_unlock();
> +
> +       return ret;
> +}
> +
> +static void kvm_gmem_convert_invalidate_begin(struct inode *inode,
> +                                             struct conversion_work *work)
> +{
> +       struct list_head *gmem_list;
> +       struct kvm_gmem *gmem;
> +       pgoff_t end;
> +
> +       end = work->start + work->nr_pages;
> +
> +       gmem_list = &inode->i_mapping->i_private_list;
> +       list_for_each_entry(gmem, gmem_list, entry)
> +               kvm_gmem_invalidate_begin(gmem, work->start, end);
> +}
> +
> +static void kvm_gmem_convert_invalidate_end(struct inode *inode,
> +                                           struct conversion_work *work)
> +{
> +       struct list_head *gmem_list;
> +       struct kvm_gmem *gmem;
> +       pgoff_t end;
> +
> +       end = work->start + work->nr_pages;
> +
> +       gmem_list = &inode->i_mapping->i_private_list;
> +       list_for_each_entry(gmem, gmem_list, entry)
> +               kvm_gmem_invalidate_end(gmem, work->start, end);
> +}
> +
> +static int kvm_gmem_convert_should_proceed(struct inode *inode,
> +                                          struct conversion_work *work,
> +                                          bool to_shared, pgoff_t *error_index)
> +{
> +       if (!to_shared) {
> +               unmap_mapping_pages(inode->i_mapping, work->start,
> +                                   work->nr_pages, false);
> +
> +               if (!kvm_gmem_has_safe_refcount(inode->i_mapping, work->start,
> +                                               work->nr_pages, error_index)) {
> +                       return -EAGAIN;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
> +                                 size_t nr_pages, bool shared,
> +                                 pgoff_t *error_index)
> +{
> +       struct conversion_work *work, *tmp, *rollback_stop_item;
> +       LIST_HEAD(work_list);
> +       struct inode *inode;
> +       enum shareability m;
> +       int ret;
> +
> +       inode = file_inode(file);
> +
> +       filemap_invalidate_lock(inode->i_mapping);
> +
> +       m = shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
> +       ret = kvm_gmem_convert_compute_work(inode, start, nr_pages, m, &work_list);
> +       if (ret || list_empty(&work_list))
> +               goto out;
> +
> +       list_for_each_entry(work, &work_list, list)
> +               kvm_gmem_convert_invalidate_begin(inode, work);
> +
> +       list_for_each_entry(work, &work_list, list) {
> +               ret = kvm_gmem_convert_should_proceed(inode, work, shared,
> +                                                     error_index);
> +               if (ret)
> +                       goto invalidate_end;
> +       }
> +
> +       list_for_each_entry(work, &work_list, list) {
> +               rollback_stop_item = work;
> +               ret = kvm_gmem_shareability_apply(inode, work, m);
> +               if (ret)
> +                       break;
> +       }
> +
> +       if (ret) {
> +               m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
> +               list_for_each_entry(work, &work_list, list) {
> +                       if (work == rollback_stop_item)
> +                               break;
> +
> +                       WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
> +               }
> +       }
> +
> +invalidate_end:
> +       list_for_each_entry(work, &work_list, list)
> +               kvm_gmem_convert_invalidate_end(inode, work);
> +out:
> +       filemap_invalidate_unlock(inode->i_mapping);
> +
> +       list_for_each_entry_safe(work, tmp, &work_list, list) {
> +               list_del(&work->list);
> +               kfree(work);
> +       }
> +
> +       return ret;
> +}
> +
> +static int kvm_gmem_ioctl_convert_range(struct file *file,
> +                                       struct kvm_gmem_convert *param,
> +                                       bool shared)
> +{
> +       pgoff_t error_index;
> +       size_t nr_pages;
> +       pgoff_t start;
> +       int ret;
> +
> +       if (param->error_offset)
> +               return -EINVAL;
> +
> +       if (param->size == 0)
> +               return 0;
> +
> +       if (param->offset + param->size < param->offset ||
> +           param->offset > file_inode(file)->i_size ||
> +           param->offset + param->size > file_inode(file)->i_size)
> +               return -EINVAL;
> +
> +       if (!IS_ALIGNED(param->offset, PAGE_SIZE) ||
> +           !IS_ALIGNED(param->size, PAGE_SIZE))
> +               return -EINVAL;
> +
> +       start = param->offset >> PAGE_SHIFT;
> +       nr_pages = param->size >> PAGE_SHIFT;
> +
> +       ret = kvm_gmem_convert_range(file, start, nr_pages, shared, &error_index);
> +       if (ret)
> +               param->error_offset = error_index << PAGE_SHIFT;
> +
> +       return ret;
> +}
> +
>  #else
>
>  static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> @@ -186,15 +490,26 @@ static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>         unsigned long index;
>
>         xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> +               enum kvm_gfn_range_filter filter;
>                 pgoff_t pgoff = slot->gmem.pgoff;
>
> +               filter = KVM_FILTER_PRIVATE;
> +               if (kvm_gmem_memslot_supports_shared(slot)) {
> +                       /*
> +                        * Unmapping would also cause invalidation, but cannot
> +                        * rely on mmu_notifiers to do invalidation via
> +                        * unmapping, since memory may not be mapped to
> +                        * userspace.
> +                        */
> +                       filter |= KVM_FILTER_SHARED;
> +               }
> +
>                 struct kvm_gfn_range gfn_range = {
>                         .start = slot->base_gfn + max(pgoff, start) - pgoff,
>                         .end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
>                         .slot = slot,
>                         .may_block = true,
> -                       /* guest memfd is relevant to only private mappings. */
> -                       .attr_filter = KVM_FILTER_PRIVATE,
> +                       .attr_filter = filter,
>                 };
>
>                 if (!found_memslot) {
> @@ -484,11 +799,49 @@ EXPORT_SYMBOL_GPL(kvm_gmem_memslot_supports_shared);
>  #define kvm_gmem_mmap NULL
>  #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>
> +static long kvm_gmem_ioctl(struct file *file, unsigned int ioctl,
> +                          unsigned long arg)
> +{
> +       void __user *argp;
> +       int r;
> +
> +       argp = (void __user *)arg;
> +
> +       switch (ioctl) {
> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +       case KVM_GMEM_CONVERT_SHARED:
> +       case KVM_GMEM_CONVERT_PRIVATE: {
> +               struct kvm_gmem_convert param;
> +               bool to_shared;
> +
> +               r = -EFAULT;
> +               if (copy_from_user(&param, argp, sizeof(param)))
> +                       goto out;
> +
> +               to_shared = ioctl == KVM_GMEM_CONVERT_SHARED;
> +               r = kvm_gmem_ioctl_convert_range(file, &param, to_shared);
> +               if (r) {
> +                       if (copy_to_user(argp, &param, sizeof(param))) {
> +                               r = -EFAULT;
> +                               goto out;
> +                       }
> +               }
> +               break;
> +       }
> +#endif
> +       default:
> +               r = -ENOTTY;
> +       }
> +out:
> +       return r;
> +}
> +
>  static struct file_operations kvm_gmem_fops = {
>         .mmap           = kvm_gmem_mmap,
>         .open           = generic_file_open,
>         .release        = kvm_gmem_release,
>         .fallocate      = kvm_gmem_fallocate,
> +       .unlocked_ioctl = kvm_gmem_ioctl,
>  };
>
>  static void kvm_gmem_free_inode(struct inode *inode)
> --
> 2.49.0.1045.g170613ef41-goog
>

