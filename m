Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CDD47E722
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhLWRfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 12:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLWRfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:35:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63611C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 09:35:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id mj19so5594863pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yIw9Fjpgijj44IXOUKUCZEBlyaVdzzfrrZ8Lojvg1lY=;
        b=KchQe9EBbruIMjeYeJXQs0w3O4kx4AL6Hoo8jlZapI4ZOjlRLvTUKO57VG05cszkq/
         cxCx8ttS1wS+jESFzGiuNO8JRwklcfN6a0abl+aSLXx0ykUiCxgRj6UJb3XfwontSdT+
         Pal7HtLokeKseV78BPG+ZFrr1TzNamA/WdL3i2cCdSkQYrTK4lMRF81oZHgXWIm42LQ+
         AyZCyLTVbMX3OiICY5MitKDc2envJnLaX51xjFXqoiwUNMWIBKJlQ/5crWWzop9kAcgc
         e8RvOe5wFMZOhSy5s3N6DCPw0YeMa8o2m2iUEczeKV/8cBVE5bg1YbhZwv4BBhZiVzP6
         Y3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yIw9Fjpgijj44IXOUKUCZEBlyaVdzzfrrZ8Lojvg1lY=;
        b=Gw8o3YrHLHqVNKO7ZAOhzbSqNUEWbNwUrXzmTOY0HjXt6ikqvEldZJ5LpaozXRb0FQ
         7MnT+d5QiK9QBboWzqSoi3mvTCFwD0KcOehNkrgOjwxTCtMBXmmsqISBnLJhSLYT8pn8
         +Pl5Oq+Wq/dGLYYsjsGWiJN06oBBbklfyGP84lSZTZH/c9kYmQB9AEIqJveFZchGARGF
         nhxYVttc3BW24iq/VhRsUtMOBaBXGIUpThlYfM+sdQLlgyApX5ZiZ275zOwMRRLDjYXa
         0IWB/U+OYaismgbnfZvXBLxJUXD45WlnR5GCCoV/4tM+SkNrNWKKjuWYhx9dE7C0BUcL
         Y6pg==
X-Gm-Message-State: AOAM533G99MfGYSgbme2pQSmyAaQJ6J2PfttDNR5/48K97b14OZswUia
        glfWyMLEBr9goDoqGuA4xE0jfFO9A6mIVw==
X-Google-Smtp-Source: ABdhPJwwfNHbtzXtFf76NGe6MOSECepzIn2qqq6XNXeecRXGPz/CfFnejBjUga6fpLtCWNPFFSHAWA==
X-Received: by 2002:a17:90a:d792:: with SMTP id z18mr3774755pju.182.1640280941694;
        Thu, 23 Dec 2021 09:35:41 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t3sm6683459pfj.207.2021.12.23.09.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 09:35:41 -0800 (PST)
Date:   Thu, 23 Dec 2021 17:35:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 04/16] KVM: Extend the memslot to support
 fd-based private memory
Message-ID: <YcSzafzpjMy6m28B@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-5-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123011.41044-5-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021, Chao Peng wrote:
> Extend the memslot definition to provide fd-based private memory support
> by adding two new fields(fd/ofs). The memslot then can maintain memory
> for both shared and private pages in a single memslot. Shared pages are
> provided in the existing way by using userspace_addr(hva) field and
> get_user_pages() while private pages are provided through the new
> fields(fd/ofs). Since there is no 'hva' concept anymore for private
> memory we cannot call get_user_pages() to get a pfn, instead we rely on
> the newly introduced MEMFD_OPS callbacks to do the same job.
> 
> This new extension is indicated by a new flag KVM_MEM_PRIVATE.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h | 10 ++++++++++
>  include/uapi/linux/kvm.h | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f8ed799e8674..2cd35560c44b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -460,8 +460,18 @@ struct kvm_memory_slot {
>  	u32 flags;
>  	short id;
>  	u16 as_id;
> +	u32 fd;

There should be no need to store the fd in the memslot, the fd should be unneeded
outside of __kvm_set_memory_region(), e.g.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1caebded52c4..4e43262887a3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2029,10 +2029,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
        new->npages = npages;
        new->flags = mem->flags;
        new->userspace_addr = mem->userspace_addr;
-       new->fd = mem->fd;
-       new->file = NULL;
-       new->ofs = mem->ofs;
-
+       if (mem->flags & KVM_MEM_PRIVATE) {
+               new->private_file = fget(mem->private_fd);
+               new->private_offset = mem->private_offset;
+       }
        r = kvm_set_memslot(kvm, old, new, change);
        if (r)
                kfree(new);

> +	struct file *file;

Please use more descriptive names, shaving characters is not at all priority.

> +	u64 ofs;

I believe this should be loff_t.

	struct file *private_file;
	struct loff_t private_offset;

>  };
>  
> +static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> +{
> +	if (slot && (slot->flags & KVM_MEM_PRIVATE))
> +		return true;
> +	return false;

	return slot && (slot->flags & KVM_MEM_PRIVATE);

> +}
> +
>  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
>  {
>  	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1daa45268de2..41434322fa23 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -103,6 +103,17 @@ struct kvm_userspace_memory_region {
>  	__u64 userspace_addr; /* start of the userspace allocated memory */
>  };
>  
> +struct kvm_userspace_memory_region_ext {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size; /* bytes */
> +	__u64 userspace_addr; /* hva */

Would it make sense to embed "struct kvm_userspace_memory_region"?

> +	__u64 ofs; /* offset into fd */
> +	__u32 fd;

Again, use descriptive names, then comments like "offset into fd" are unnecessary.

	__u64 private_offset;
	__u32 private_fd;

> +	__u32 padding[5];
> +};
> +
>  /*
>   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
>   * other bits are reserved for kvm internal use which are defined in
> @@ -110,6 +121,7 @@ struct kvm_userspace_memory_region {
>   */
>  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
>  #define KVM_MEM_READONLY	(1UL << 1)
> +#define KVM_MEM_PRIVATE		(1UL << 2)
>  
>  /* for KVM_IRQ_LINE */
>  struct kvm_irq_level {
> -- 
> 2.17.1
> 
