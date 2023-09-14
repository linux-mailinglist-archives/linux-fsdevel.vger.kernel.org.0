Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0FF79F705
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjINB6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjINB6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:58:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DDA30C8
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d814a1f7378so2790828276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656566; x=1695261366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tmZ4Pf+Lkz5wRFy1K0dmYcmTbZlsWWC8lS02Q/mSk0M=;
        b=pcVnX91ks2Ul7rg+s7dS8UJjyMksnDHMKMgwFQKQl91juTTlN6JfeOMU8uVlIs61vQ
         YtvnZTtIdImrZhSmRjPBWKXWQnMaFZxWS3CMoy6hBtHjM4hgqPhupZdEDxv3XJAQrKD+
         gxhewgxQB3nDVYqqGdnL+Uo5d7o7AJK8ExFKlCy6I0E+2frB4qACVgV+gtJ60B1xb6+s
         DEkjdwoPD0tDnKCkMf2oJiAeWsWJ/40mXpPAAb6FRyFes3ZG7dGOzijoNj2fcxQ30TeP
         IuJBuGOg7EHWMZeWONaEqmmN25fNF/5RQs3rcQ+zSfmiQ7+7cZP+Et5Y66+vncGHqNQ8
         TmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656566; x=1695261366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmZ4Pf+Lkz5wRFy1K0dmYcmTbZlsWWC8lS02Q/mSk0M=;
        b=pviDNOPQQxTj1hC+OCMATzBP72nLtZgfiCsZ8oYkjzkZf960fdONDb3iQzpS5ctqaY
         hr5Pv3TAbG+uag8mBf3dbrK7lfQ01jWuntCnA+OuymxtmP0xlmlRZqxUgpcCMTCkuqMw
         4jLPS/nV6cgR/6c28wZVy0F0umqXTr08DGgwg7tvFzcwTyrKmXxomkRcYSZlmxPjwazm
         hnPhdsNFMSdzujjCm/fM+fYYiVRmVI564Or++bxB/5lV8W+z4uH+A+ixfiMq46g6VTUp
         A7jNhTsSSqksRw2xji82wwwUC8TVnHX33v4bpPl4PPQDGXq9P/zdqQBj1dcr2CXwLtgP
         W1lw==
X-Gm-Message-State: AOJu0YxZ/G/eyRci4OOrIXw8vlLfRpxg4uRTCGMgnIZf9NlPlYPBIxzb
        VY9Ce3ydbWyY0hpb/EhwaAiI7MYlRoo=
X-Google-Smtp-Source: AGHT+IEewm62VrPkwfcYWKCbnDgTMcslgQzN36+Ag8qFabvQ71jteqZnAdWKs/X98zA5hLrpiwS+nbPNXc8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab47:0:b0:d7e:78db:d264 with SMTP id
 u65-20020a25ab47000000b00d7e78dbd264mr13061ybi.5.1694656566137; Wed, 13 Sep
 2023 18:56:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:13 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-16-seanjc@google.com>
Subject: [RFC PATCH v12 15/33] KVM: Add transparent hugepage support for
 dedicated guest memory
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TODO: writeme

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/uapi/linux/kvm.h |  2 ++
 virt/kvm/guest_mem.c     | 54 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6f90a273e2e..2df18796fd8e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -2314,6 +2314,8 @@ struct kvm_memory_attributes {
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 
+#define KVM_GUEST_MEMFD_ALLOW_HUGEPAGE		(1ULL << 0)
+
 struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 0dd3f836cf9c..a819367434e9 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -17,15 +17,48 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
-static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
+static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index)
 {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	unsigned long huge_index = round_down(index, HPAGE_PMD_NR);
+	unsigned long flags = (unsigned long)inode->i_private;
+	struct address_space *mapping  = inode->i_mapping;
+	gfp_t gfp = mapping_gfp_mask(mapping);
 	struct folio *folio;
 
-	/* TODO: Support huge pages. */
-	folio = filemap_grab_folio(file->f_mapping, index);
-	if (IS_ERR_OR_NULL(folio))
+	if (!(flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE))
 		return NULL;
 
+	if (filemap_range_has_page(mapping, huge_index << PAGE_SHIFT,
+				   (huge_index + HPAGE_PMD_NR - 1) << PAGE_SHIFT))
+		return NULL;
+
+	folio = filemap_alloc_folio(gfp, HPAGE_PMD_ORDER);
+	if (!folio)
+		return NULL;
+
+	if (filemap_add_folio(mapping, folio, huge_index, gfp)) {
+		folio_put(folio);
+		return NULL;
+	}
+
+	return folio;
+#else
+	return NULL;
+#endif
+}
+
+static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
+{
+	struct folio *folio;
+
+	folio = kvm_gmem_get_huge_folio(inode, index);
+	if (!folio) {
+		folio = filemap_grab_folio(inode->i_mapping, index);
+		if (IS_ERR_OR_NULL(folio))
+			return NULL;
+	}
+
 	/*
 	 * Use the up-to-date flag to track whether or not the memory has been
 	 * zeroed before being handed off to the guest.  There is no backing
@@ -323,7 +356,8 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, struct vfsmount *mnt)
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
+			     struct vfsmount *mnt)
 {
 	const char *anon_name = "[kvm-gmem]";
 	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
@@ -346,6 +380,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, struct vfsmount *mnt)
 	inode->i_mode |= S_IFREG;
 	inode->i_size = size;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_large_folios(inode->i_mapping);
 	mapping_set_unmovable(inode->i_mapping);
 	/* Unmovable mappings are supposed to be marked unevictable as well. */
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
@@ -396,6 +431,12 @@ static bool kvm_gmem_is_valid_size(loff_t size, u64 flags)
 	if (size < 0 || !PAGE_ALIGNED(size))
 		return false;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if ((flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE) &&
+	    !IS_ALIGNED(size, HPAGE_PMD_SIZE))
+		return false;
+#endif
+
 	return true;
 }
 
@@ -405,6 +446,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	u64 flags = args->flags;
 	u64 valid_flags = 0;
 
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		valid_flags |= KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+
 	if (flags & ~valid_flags)
 		return -EINVAL;
 
-- 
2.42.0.283.g2d96d420d3-goog

