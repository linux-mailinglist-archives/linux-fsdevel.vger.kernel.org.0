Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135C47A8FF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 01:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjITXo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITXoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:44:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C926D7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 16:44:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c448ba292dso2769705ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 16:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695253489; x=1695858289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMbatuEIGrWsTlMlK7Tk6yapZGH8kwO0Z4+wG56Y3PQ=;
        b=hz/qLqNkPaJwrFs4Bfl+b+D2DMfp7nppSPU1y3a9M5mOOqTEaCTcY1Qb/tbs/vZJ3I
         0pCFwsgOoCU/5SKXWlWY4gG1/VF9tXAoJ9NyLvdFYKn3YpubFq7yoaFJfPa5G0hxuVIj
         1wjHcqK/1f1di1Of2NbZnD6XaaYIY9+sfkiVl7uRYef/Ob3p0P2MRcGj16uQSiu+F8co
         2e/NVdI9W30clWI2J7aTfD8OqTUEQtplGpPRBuMluYGTt+Rd/Kjx/qxgtQJEZdxGSIeT
         Z9lCU8YVH7CjyVp2P3ZuerKl4vl0jJajuspHr5RdWeLVpD/8UQhic6ZUVt2cLw23Ge28
         nsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695253489; x=1695858289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMbatuEIGrWsTlMlK7Tk6yapZGH8kwO0Z4+wG56Y3PQ=;
        b=W2eBUpzpbf8ef3hf+WZRNERoBAEJWDBsNtrNCZrxFsny/4tW1Fd3QjjLFYmGtorxAI
         YP+h4DsMM0HmiAiyfi0n/+bweQQejRe3QqXyhvlaG2LfEG0ghZdIzMd3tMu02KCz80/K
         KmDm0S86A40GuhQWaUJvWasOpE40tGWnaRBYurIA5fKZgVl+o9Br6ithpQNA9T5pX8kt
         mxwiBUjJWzKaIV83O4mYOvT8SXMROWdjBpmrQyskS5MWZ9fCJog3TL92WgAI39wigCTC
         E3ia6A6DpnzJ0KYRhX57AI+KawJPMOyj+uNgEVUKTzTJKoMJb2BRwA4kt3J7eGRKbksf
         rIMw==
X-Gm-Message-State: AOJu0Yx4dvEIP54Qqdhnqlc1ROQ7LDxcVlFBtjzX66BkeJsvuUYg2al5
        KQB1VFUQYjHAAXY09ym58uh5YFtGzgc=
X-Google-Smtp-Source: AGHT+IHQbG7yFE9jJPEUI1XKEjcd5Hn7eouqEyZetIlWhAmmYx1Ip3XqohOdLN8YNlfaQrxQ5DSfhNksAYI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:22d0:b0:1ae:6895:cb96 with SMTP id
 y16-20020a17090322d000b001ae6895cb96mr56298plg.5.1695253488829; Wed, 20 Sep
 2023 16:44:48 -0700 (PDT)
Date:   Wed, 20 Sep 2023 16:44:47 -0700
In-Reply-To: <20230918163647.m6bjgwusc7ww5tyu@amd.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-15-seanjc@google.com>
 <20230918163647.m6bjgwusc7ww5tyu@amd.com>
Message-ID: <ZQuD77vlBiSU/PE4@google.com>
Subject: Re: [RFC PATCH v12 14/33] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
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
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023, Michael Roth wrote:
> > +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > +{
> > +	struct list_head *gmem_list = &inode->i_mapping->private_list;
> > +	pgoff_t start = offset >> PAGE_SHIFT;
> > +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> > +	struct kvm_gmem *gmem;
> > +
> > +	/*
> > +	 * Bindings must stable across invalidation to ensure the start+end
> > +	 * are balanced.
> > +	 */
> > +	filemap_invalidate_lock(inode->i_mapping);
> > +
> > +	list_for_each_entry(gmem, gmem_list, entry) {
> > +		kvm_gmem_invalidate_begin(gmem, start, end);
> 
> In v11 we used to call truncate_inode_pages_range() here to drop filemap's
> reference on the folio. AFAICT the folios are only getting free'd upon
> guest shutdown without this. Was this on purpose?

Nope, I just spotted this too.  And then after scratching my head for a few minutes,
wondering if I was having an -ENOCOFFEE moment, I finally read your mail.  *sigh*

Looking at my reflog history, I'm pretty sure I deleted the wrong line when
removing the truncation from kvm_gmem_error_page().

> > +		kvm_gmem_invalidate_end(gmem, start, end);
> > +	}
> > +
> > +	filemap_invalidate_unlock(inode->i_mapping);
> > +
> > +	return 0;
> > +}
> > +
> > +static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
> > +{
> > +	struct address_space *mapping = inode->i_mapping;
> > +	pgoff_t start, index, end;
> > +	int r;
> > +
> > +	/* Dedicated guest is immutable by default. */
> > +	if (offset + len > i_size_read(inode))
> > +		return -EINVAL;
> > +
> > +	filemap_invalidate_lock_shared(mapping);
> 
> We take the filemap lock here, but not for
> kvm_gmem_get_pfn()->kvm_gmem_get_folio(). Is it needed there as well?

No, we specifically do not want to take a rwsem when faulting in guest memory.
Callers of kvm_gmem_get_pfn() *must* guard against concurrent invalidations via
mmu_invalidate_seq and friends.

> > +	/*
> > +	 * For simplicity, require the offset into the file and the size of the
> > +	 * memslot to be aligned to the largest possible page size used to back
> > +	 * the file (same as the size of the file itself).
> > +	 */
> > +	if (!kvm_gmem_is_valid_size(offset, flags) ||
> > +	    !kvm_gmem_is_valid_size(size, flags))
> > +		goto err;
> 
> I needed to relax this check for SNP. KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
> applies to entire gmem inode, so it makes sense for userspace to enable
> hugepages if start/end are hugepage-aligned, but QEMU will do things
> like map overlapping regions for ROMs and other things on top of the
> GPA range that the gmem inode was originally allocated for. For
> instance:
> 
>   692500@1689108688.696338:kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x4 gpa=0x0 size=0x80000000 ua=0x7fbf5be00000 ret=0 restricted_fd=19 restricted_offset=0x0
>   692500@1689108688.699802:kvm_set_user_memory AddrSpace#0 Slot#1 flags=0x4 gpa=0x100000000 size=0x380000000 ua=0x7fbfdbe00000 ret=0 restricted_fd=19 restricted_offset=0x80000000
>   692500@1689108688.795412:kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x0 gpa=0x0 size=0x0 ua=0x7fbf5be00000 ret=0 restricted_fd=19 restricted_offset=0x0
>   692500@1689108688.795550:kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x4 gpa=0x0 size=0xc0000 ua=0x7fbf5be00000 ret=0 restricted_fd=19 restricted_offset=0x0
>   692500@1689108688.796227:kvm_set_user_memory AddrSpace#0 Slot#6 flags=0x4 gpa=0x100000 size=0x7ff00000 ua=0x7fbf5bf00000 ret=0 restricted_fd=19 restricted_offset=0x100000
> 
> Because of that the KVM_SET_USER_MEMORY_REGIONs for non-THP-aligned GPAs
> will fail. Maybe instead it should be allowed, and kvm_gmem_get_folio()
> should handle the alignment checks on a case-by-case and simply force 4k
> for offsets corresponding to unaligned bindings?

Yeah, I wanted to keep the code simple, but disallowing small bindings/memslots
is probably going to be a deal-breaker.  Even though I'm skeptical that QEMU
_needs_ to play these games for SNP guests, not playing nice will make it all
but impossible to use guest_memfd for regular VMs.

And the code isn't really any more complex, so long as we punt on allowing
hugepages on interior sub-ranges.

Compile-tested only, but this?

---
 virt/kvm/guest_mem.c | 54 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index a819367434e9..dc12e38211df 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -426,20 +426,6 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
 	return err;
 }
 
-static bool kvm_gmem_is_valid_size(loff_t size, u64 flags)
-{
-	if (size < 0 || !PAGE_ALIGNED(size))
-		return false;
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if ((flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE) &&
-	    !IS_ALIGNED(size, HPAGE_PMD_SIZE))
-		return false;
-#endif
-
-	return true;
-}
-
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
 	loff_t size = args->size;
@@ -452,9 +438,15 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (flags & ~valid_flags)
 		return -EINVAL;
 
-	if (!kvm_gmem_is_valid_size(size, flags))
+	if (size < 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if ((flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE) &&
+	    !IS_ALIGNED(size, HPAGE_PMD_SIZE))
+		return false;
+#endif
+
 	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
 }
 
@@ -462,7 +454,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset)
 {
 	loff_t size = slot->npages << PAGE_SHIFT;
-	unsigned long start, end, flags;
+	unsigned long start, end;
 	struct kvm_gmem *gmem;
 	struct inode *inode;
 	struct file *file;
@@ -481,16 +473,9 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		goto err;
 
 	inode = file_inode(file);
-	flags = (unsigned long)inode->i_private;
 
-	/*
-	 * For simplicity, require the offset into the file and the size of the
-	 * memslot to be aligned to the largest possible page size used to back
-	 * the file (same as the size of the file itself).
-	 */
-	if (!kvm_gmem_is_valid_size(offset, flags) ||
-	    !kvm_gmem_is_valid_size(size, flags))
-		goto err;
+	if (offset < 0 || !PAGE_ALIGNED(offset))
+		return -EINVAL;
 
 	if (offset + size > i_size_read(inode))
 		goto err;
@@ -591,8 +576,23 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	page = folio_file_page(folio, index);
 
 	*pfn = page_to_pfn(page);
-	if (max_order)
-		*max_order = compound_order(compound_head(page));
+	if (!max_order)
+		goto success;
+
+	*max_order = compound_order(compound_head(page));
+	if (!*max_order)
+		goto success;
+
+	/*
+	 * For simplicity, allow mapping a hugepage if and only if the entire
+	 * binding is compatible, i.e. don't bother supporting mapping interior
+	 * sub-ranges with hugepages (unless userspace comes up with a *really*
+	 * strong use case for needing hugepages within unaligned bindings).
+	 */
+	if (!IS_ALIGNED(slot->gmem.pgoff, 1ull << *max_order) ||
+	    !IS_ALIGNED(slot->npages, 1ull << *max_order))
+		*max_order = 0;
+success:
 	r = 0;
 
 out_unlock:

base-commit: bc1a54ee393e0574ea422525cf0b2f1e768e38c5
-- 

