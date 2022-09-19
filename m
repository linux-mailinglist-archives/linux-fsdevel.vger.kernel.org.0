Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E235BD511
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiISTK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiISTKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:10:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382C24BD8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 12:10:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so8368320pjm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uHDCmC+fkGgZQ7BzMPp6c7XrTAwkaI5bKq16AmgDePo=;
        b=FzLZKvxtooNg2nIQsy5+eM5f7fy1lAzBB2VA1wO/c/z5x+mIvht2HeQTpz0+O2GNON
         qYfCZIIQd7vVS1ydcSUk98uZRncHJ8NJqsBYal/77hLUDVgkbWXOBd+hz5VEBE58svml
         7veNt7a5mrys0Ba0zXNGukgmilRYcWUK1G5Ld55DCw1aaAWGjuHTYvwOXM55fy1GZCq2
         /HIYNCCaMOBCvVP4bTRqEX/0Cg2d5v66Gen6iUYVbeQoaRoKlz+CSMn6594FqKI3OBOx
         CgWqKCHmKyJawz7IbqlOUC2g8zhLuRqDNc0zsCq7DTjXNqPS5WtBOOhuXN/fLqvu7Nx+
         YhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uHDCmC+fkGgZQ7BzMPp6c7XrTAwkaI5bKq16AmgDePo=;
        b=W/UT3NegajyeFzPzdcOzk8srKzY2pKr3PL9tX7O9At4c0MYopW8rNrk93wa950EXpe
         0V4jjAE+mJeiQzlZl522ICwqhBK93WZwjyURLLH0U6rJ3wN1D21GSnGYZlGpfe/rQp6X
         Q/lZdLkep6B7SFdGem1ONLAdNWodC4eeXtm81/oPHMpO13pZrlwI2DRR/AARXB51rRis
         o/bunTv94hRHQ1JlAquUEdsNGndWNLzX6LcaAjfNP2sLEM0HcJT7KL+kaII4Fhdcz/h4
         M+RFmdSu4xE0X7CtHl8D0xUkEYoQv8lcaxJSMMY+2RQxMg7wawzs7AdyLgqsdjwRexKb
         pB2A==
X-Gm-Message-State: ACrzQf33h+8tqbysdhs4Rvo9V4+xkmPLB+3fogB6Kz39rYBrK+dAIF9k
        9t8rndVCtK8rHcbFpYArjy3Oew==
X-Google-Smtp-Source: AMsMyM68H82eEsZf9j6+Lgi2bA7LULrsBpCz2pkVmtzhsIZbm7nIKWn17NC3OpQf7t6rW+ZP9MqtOQ==
X-Received: by 2002:a17:90a:b00b:b0:203:a6de:5b0f with SMTP id x11-20020a17090ab00b00b00203a6de5b0fmr1533338pjq.134.1663614619499;
        Mon, 19 Sep 2022 12:10:19 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p187-20020a6229c4000000b00540c24ba181sm20357398pfp.120.2022.09.19.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:10:18 -0700 (PDT)
Date:   Mon, 19 Sep 2022 19:10:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <Yyi+l3+p9lbBAC4M@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Will, Marc and Fuad (apologies if I missed other pKVM folks)

On Mon, Sep 19, 2022, David Hildenbrand wrote:
> On 15.09.22 16:29, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > KVM can use memfd-provided memory for guest memory. For normal userspace
> > accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
> > virtual address space and then tells KVM to use the virtual address to
> > setup the mapping in the secondary page table (e.g. EPT).
> > 
> > With confidential computing technologies like Intel TDX, the
> > memfd-provided memory may be encrypted with special key for special
> > software domain (e.g. KVM guest) and is not expected to be directly
> > accessed by userspace. Precisely, userspace access to such encrypted
> > memory may lead to host crash so it should be prevented.
> 
> Initially my thaught was that this whole inaccessible thing is TDX specific
> and there is no need to force that on other mechanisms. That's why I
> suggested to not expose this to user space but handle the notifier
> requirements internally.
> 
> IIUC now, protected KVM has similar demands. Either access (read/write) of
> guest RAM would result in a fault and possibly crash the hypervisor (at
> least not the whole machine IIUC).

Yep.  The missing piece for pKVM is the ability to convert from shared to private
while preserving the contents, e.g. to hand off a large buffer (hundreds of MiB)
for processing in the protected VM.  Thoughts on this at the bottom.

> > This patch introduces userspace inaccessible memfd (created with
> > MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
> > ordinary MMU access (e.g. read/write/mmap) but can be accessed via
> > in-kernel interface so KVM can directly interact with core-mm without
> > the need to map the memory into KVM userspace.
> 
> With secretmem we decided to not add such "concept switch" flags and instead
> use a dedicated syscall.
>

I have no personal preference whatsoever between a flag and a dedicated syscall,
but a dedicated syscall does seem like it would give the kernel a bit more
flexibility.

> What about memfd_inaccessible()? Especially, sealing and hugetlb are not
> even supported and it might take a while to support either.

Don't know about sealing, but hugetlb support for "inaccessible" memory needs to
come sooner than later.  "inaccessible" in quotes because we might want to choose
a less binary name, e.g. "restricted"?.

Regarding pKVM's use case, with the shim approach I believe this can be done by
allowing userspace mmap() the "hidden" memfd, but with a ton of restrictions
piled on top.

My first thought was to make the uAPI a set of KVM ioctls so that KVM could tightly
tightly control usage without taking on too much complexity in the kernel, but
working through things, routing the behavior through the shim itself might not be
all that horrific.

IIRC, we discarded the idea of allowing userspace to map the "private" fd because
things got too complex, but with the shim it doesn't seem _that_ bad.

E.g. on the memfd side:

  1. The entire memfd must be mapped, and at most one mapping is allowed, i.e.
     mapping is all or nothing.

  2. Acquiring a reference via get_pfn() is disallowed if there's a mapping for
     the restricted memfd.

  3. Add notifier hooks to allow downstream users to further restrict things.

  4. Disallow splitting VMAs, e.g. to force userspace to munmap() everything in
     one shot.

  5. Require that there are no outstanding references at munmap().  Or if this
     can't be guaranteed by userspace, maybe add some way for userspace to wait
     until it's ok to convert to private?  E.g. so that get_pfn() doesn't need
     to do an expensive check every time.
     
  static int memfd_restricted_mmap(struct file *file, struct vm_area_struct *vma)
  {
	if (vma->vm_pgoff)
		return -EINVAL;

	if ((vma->vm_end - vma->vm_start) != <file size>)
		return -EINVAL;

	mutex_lock(&data->lock);

	if (data->has_mapping) {
		r = -EINVAL;
		goto err;
	}
	list_for_each_entry(notifier, &data->notifiers, list) {
		r = notifier->ops->mmap_start(notifier, ...);
		if (r)
			goto abort;
	}

	notifier->ops->mmap_end(notifier, ...);
	mutex_unlock(&data->lock);
	return 0;

  abort:
	list_for_each_entry_continue_reverse(notifier &data->notifiers, list)
		notifier->ops->mmap_abort(notifier, ...);
  err:
	mutex_unlock(&data->lock);
	return r;
  }

  static void memfd_restricted_close(struct vm_area_struct *vma)
  {
	mutex_lock(...);

	/*
	 * Destroy the memfd and disable all future accesses if there are
	 * outstanding refcounts (or other unsatisfied restrictions?).
	 */
	if (<outstanding references> || ???)
		memfd_restricted_destroy(...);
	else
		data->has_mapping = false;

	mutex_unlock(...);
  }

  static int memfd_restricted_may_split(struct vm_area_struct *area, unsigned long addr)
  {
	return -EINVAL;
  }

  static int memfd_restricted_mapping_mremap(struct vm_area_struct *new_vma)
  {
	return -EINVAL;
  }

Then on the KVM side, its mmap_start() + mmap_end() sequence would:

  1. Not be supported for TDX or SEV-SNP because they don't allow adding non-zero
     memory into the guest (after pre-boot phase).

  2. Be mutually exclusive with shared<=>private conversions, and is allowed if
     and only if the entire gfn range of the associated memslot is shared.
