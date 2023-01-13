Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D9B66A57B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 22:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjAMVy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 16:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjAMVys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:54:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED498A20A
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 13:54:46 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b17so17252929pld.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 13:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhpii7kCapxhB0DJlYGUjw51omeyUMoY3UIeTjTnFe8=;
        b=ZS8LNlcnnRbTeDNfK2GnjCI2FQe2seYywb27tQYC3rATL6nUcWgzHk9l/X49WuLcR7
         MxufLxr4v5JyxI8Fk1Rsy+L0v3HCs2Ec8RosxfNd68idcjN8NrAd5lDB2yRN59zB7jGz
         6llde0y8FGi0l0gklzTrCW0fHKCLbzGY3eEZyTr4IC7nOy4rj8dmCUa/Wmt4RvJB6d00
         xnrtlDsZLljAn2dP16/btJGNbyLLNxO0CqLkw/NAE7vznaQRmtr0IXKeX+0obFYouInv
         MbvsZmtjBoLbl3xae92pVeR0xrb1+kiQFuFIG6fid2t+s7JP6kK3JdHZJblcxSDNzPmx
         SOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hhpii7kCapxhB0DJlYGUjw51omeyUMoY3UIeTjTnFe8=;
        b=UbLUe6cwugImoozrPxvHReceFHSjWEtL/eUEc9jOsmC5PWNjmqsSQn2nFebarQRwhq
         X7Fszf+cc8YYQxIoCQbBL10I18IlqwlKIpRpAenvgfJG8q1wNevSKS6WY/TAEnoglGEA
         aAIwgvvlpLgGIz8cR9Aug8e3Li8sx7TA5aa9Y8XcbXPiTsO0Fh2I4lIKMrsNmxqobzMu
         sp56fBm7k6PLI27zFMNWnhOUVb+byIoBRPB2Vpt1CxoOu/UpA6arPwj2Cad0JQu/m4Xm
         6c8Z39ZNjZexTXMAgVOxbeWZxmkKADTe5HXtL07eQwqAAqroDVtqo35k34IxcNSl1frC
         dy8A==
X-Gm-Message-State: AFqh2krWvutRYTSIZKgzUnTeNlZvNA6tEN3kkC43fuFYD+KHdB4SVcib
        HiJ86Vtl24TS+w8T6QNOcXZ+0A==
X-Google-Smtp-Source: AMrXdXsrn0ksTbbdabw7JkYj7sG3I4DjLXmCZyLSNxH83QGpSuMFYShcdh0M4wmFmbDmEREMamklwA==
X-Received: by 2002:a17:90b:274b:b0:219:f970:5119 with SMTP id qi11-20020a17090b274b00b00219f9705119mr1438871pjb.1.1673646885581;
        Fri, 13 Jan 2023 13:54:45 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090a0ac200b002139459e121sm10013579pje.27.2023.01.13.13.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:54:45 -0800 (PST)
Date:   Fri, 13 Jan 2023 21:54:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <Y8HTITl1+Oe0H7Gd@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022, Chao Peng wrote:
> The system call is currently wired up for x86 arch.

Building on other architectures (except for arm64 for some reason) yields:

  CALL    /.../scripts/checksyscalls.sh
  <stdin>:1565:2: warning: #warning syscall memfd_restricted not implemented [-Wcpp]

Do we care?  It's the only such warning, which makes me think we either need to
wire this up for all architectures, or explicitly document that it's unsupported.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---

...

> diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
> new file mode 100644
> index 000000000000..c2700c5daa43
> --- /dev/null
> +++ b/include/linux/restrictedmem.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _LINUX_RESTRICTEDMEM_H

Missing

 #define _LINUX_RESTRICTEDMEM_H

which causes fireworks if restrictedmem.h is included more than once.

> +#include <linux/file.h>
> +#include <linux/magic.h>
> +#include <linux/pfn_t.h>

...

> +static inline int restrictedmem_get_page(struct file *file, pgoff_t offset,
> +					 struct page **pagep, int *order)
> +{
> +	return -1;

This should be a proper -errno, though in the current incarnation of things it's
a moot point because no stub is needed.  KVM can (and should) easily provide its
own stub for this one.

> +}
> +
> +static inline bool file_is_restrictedmem(struct file *file)
> +{
> +	return false;
> +}
> +
> +static inline void restrictedmem_error_page(struct page *page,
> +					    struct address_space *mapping)
> +{
> +}
> +
> +#endif /* CONFIG_RESTRICTEDMEM */
> +
> +#endif /* _LINUX_RESTRICTEDMEM_H */

...

> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> new file mode 100644
> index 000000000000..56953c204e5c
> --- /dev/null
> +++ b/mm/restrictedmem.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/sbitmap.h"
> +#include <linux/pagemap.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/syscalls.h>
> +#include <uapi/linux/falloc.h>
> +#include <uapi/linux/magic.h>
> +#include <linux/restrictedmem.h>
> +
> +struct restrictedmem_data {

Any objection to simply calling this "restrictedmem"?  And then using either "rm"
or "rmem" for local variable names?  I kept reading "data" as the underyling data
being written to the page, as opposed to the metadata describing the restrictedmem
instance.

> +	struct mutex lock;
> +	struct file *memfd;
> +	struct list_head notifiers;
> +};
> +
> +static void restrictedmem_invalidate_start(struct restrictedmem_data *data,
> +					   pgoff_t start, pgoff_t end)
> +{
> +	struct restrictedmem_notifier *notifier;
> +
> +	mutex_lock(&data->lock);

This can be a r/w semaphore instead of a mutex, that way punching holes at multiple
points in the file can at least run the notifiers in parallel.  The actual allocation
by shmem will still be serialized, but I think it's worth the simple optimization
since zapping and flushing in KVM may be somewhat slow.

> +	list_for_each_entry(notifier, &data->notifiers, list) {
> +		notifier->ops->invalidate_start(notifier, start, end);

Two major design issues that we overlooked long ago:

  1. Blindly invoking notifiers will not scale.  E.g. if userspace configures a
     VM with a large number of convertible memslots that are all backed by a
     single large restrictedmem instance, then converting a single page will
     result in a linear walk through all memslots.  I don't expect anyone to
     actually do something silly like that, but I also never expected there to be
     a legitimate usecase for thousands of memslots.

  2. This approach fails to provide the ability for KVM to ensure a guest has
     exclusive access to a page.  As discussed in the past, the kernel can rely
     on hardware (and maybe ARM's pKVM implementation?) for those guarantees, but
     only for SNP and TDX VMs.  For VMs where userspace is trusted to some extent,
     e.g. SEV, there is value in ensuring a 1:1 association.

     And probably more importantly, relying on hardware for SNP and TDX yields a
     poor ABI and complicates KVM's internals.  If the kernel doesn't guarantee a
     page is exclusive to a guest, i.e. if userspace can hand out the same page
     from a restrictedmem instance to multiple VMs, then failure will occur only
     when KVM tries to assign the page to the second VM.  That will happen deep
     in KVM, which means KVM needs to gracefully handle such errors, and it means
     that KVM's ABI effectively allows plumbing garbage into its memslots.

Rather than use a simple list of notifiers, this appears to be yet another
opportunity to use an xarray.  Supporting sharing of restrictedmem will be
non-trivial, but IMO we should punt that to the future since it's still unclear
exactly how sharing will work.

An xarray will solve #1 by notifying only the consumers (memslots) that are bound
to the affected range.

And for #2, it's relatively straightforward (knock wood) to detect existing
entries, i.e. if the user wants exclusive access to memory, then the bind operation
can be reject if there's an existing entry.

VERY lightly tested code snippet at the bottom (will provide link to fully worked
code in cover letter).


> +static long restrictedmem_punch_hole(struct restrictedmem_data *data, int mode,
> +				     loff_t offset, loff_t len)
> +{
> +	int ret;
> +	pgoff_t start, end;
> +	struct file *memfd = data->memfd;
> +
> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> +		return -EINVAL;
> +
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len) >> PAGE_SHIFT;
> +
> +	restrictedmem_invalidate_start(data, start, end);
> +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> +	restrictedmem_invalidate_end(data, start, end);

The lock needs to be end for the entire duration of the hole punch, i.e. needs to
be taken before invalidate_start() and released after invalidate_end().  If a user
(un)binds/(un)registers after invalidate_state(), it will see an unpaired notification,
e.g. could leave KVM with incorrect notifier counts.

> +
> +	return ret;
> +}

What I ended up with for an xarray-based implementation.  I'm very flexible on
names and whatnot, these are just what made sense to me.

static long restrictedmem_punch_hole(struct restrictedmem *rm, int mode,
				     loff_t offset, loff_t len)
{
	struct restrictedmem_notifier *notifier;
	struct file *memfd = rm->memfd;
	unsigned long index;
	pgoff_t start, end;
	int ret;

	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
		return -EINVAL;

	start = offset >> PAGE_SHIFT;
	end = (offset + len) >> PAGE_SHIFT;

	/*
	 * Bindings must stable across invalidation to ensure the start+end
	 * are balanced.
	 */
	down_read(&rm->lock);

	xa_for_each_range(&rm->bindings, index, notifier, start, end)
		notifier->ops->invalidate_start(notifier, start, end);

	ret = memfd->f_op->fallocate(memfd, mode, offset, len);

	xa_for_each_range(&rm->bindings, index, notifier, start, end)
		notifier->ops->invalidate_end(notifier, start, end);

	up_read(&rm->lock);

	return ret;
}

int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
		       struct restrictedmem_notifier *notifier, bool exclusive)
{
	struct restrictedmem *rm = file->f_mapping->private_data;
	int ret = -EINVAL;

	down_write(&rm->lock);

	/* Non-exclusive mappings are not yet implemented. */
	if (!exclusive)
		goto out_unlock;

	if (!xa_empty(&rm->bindings)) {
		if (exclusive != rm->exclusive)
			goto out_unlock;

		if (exclusive && xa_find(&rm->bindings, &start, end, XA_PRESENT))
			goto out_unlock;
	}

	xa_store_range(&rm->bindings, start, end, notifier, GFP_KERNEL);
	rm->exclusive = exclusive;
	ret = 0;
out_unlock:
	up_write(&rm->lock);
	return ret;
}
EXPORT_SYMBOL_GPL(restrictedmem_bind);

void restrictedmem_unbind(struct file *file, pgoff_t start, pgoff_t end,
			  struct restrictedmem_notifier *notifier)
{
	struct restrictedmem *rm = file->f_mapping->private_data;

	down_write(&rm->lock);
	xa_store_range(&rm->bindings, start, end, NULL, GFP_KERNEL);
	synchronize_rcu();
	up_write(&rm->lock);
}
EXPORT_SYMBOL_GPL(restrictedmem_unbind);
