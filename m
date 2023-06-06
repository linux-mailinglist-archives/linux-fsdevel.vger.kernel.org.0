Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A485724C68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbjFFTHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbjFFTFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:05:44 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4C1FC1
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b011901b03so24400065ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078279; x=1688670279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXM9JnRppggpXADZsSU7oZSsG9y4s1gBipK1U/D+HWI=;
        b=VWeSODpWaBqW4mQpMFylMZsGjqz9x2cJWtAJkF8pA6jBSLPJ/ks6MKmLjF0le7g30t
         JnmedBVXzjwth3hzxEtFKbLpgTPpii8AIYI3pjk/s5jbK19NEFa6oqTQ13vB92hVQiL8
         ViOM5skTjTy0akJXm7D62mzzCwjuX5DC11svxqniq47zqTKpG8FGJ6kwksqVcEgjbsdr
         Q2K/qR6ANqCdLydEwlvpleG5wsmCc5RNcdR6s83XxomLHgCDxLDz6X0Nkjd7UZ2zKFsM
         UtKOTh+fe/f2a9gAwgpw1N4/+Q8OfnwiS90nL6ITis3W2ib2nbVxkWVf59u885V77XDE
         HbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078279; x=1688670279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXM9JnRppggpXADZsSU7oZSsG9y4s1gBipK1U/D+HWI=;
        b=d9i2aif4CFd/5uAQYXGd210IpZ1+COLetkc2bM1w43jvU0WlNKNvlLUWufXu4LxlT5
         v/NWEWaQHDhy6edYqkfr1P7+fz413Tay0RriND74CRoZmUT2Aoz/2CvIKUgj5zr97ZM+
         Ms6kLciXzas57uWspThrryxtzpyS89iuRVNeCW+eahXb7gGyjd4QP/+nLn3RAef+dVz/
         gDANB/NY4HZFcUicAuHLJbBJHADpWWD7twIeOtzIsM4mM49UvNCmaRoNUKFpr5MJoaKh
         hXF/t3LCOdCDgj5vIxFebXSiYslWPXpSSGc1YPDOwLRS0tKmT/ToK1KfhsJjsvn9emXq
         TXmA==
X-Gm-Message-State: AC+VfDwcJzmLw6sWiOWJXHLx32WgdWlRKRKtgc6DOT0++QKRf1K3pN9t
        7pknVm6YJZhIS6ZjdEXwzeNKcDiqXqkE7IFSGA==
X-Google-Smtp-Source: ACHHUZ7ZdtfDieT/Oervi6LGRC4PY5HZ9dIjkRC61ZAb5O1fokMpY3zuDqGBxtoVMfmrEF+ZlDZD/kzUef5/lnoKEw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:7c03:b0:1b2:690:23ff with SMTP
 id x3-20020a1709027c0300b001b2069023ffmr991531pll.11.1686078279112; Tue, 06
 Jun 2023 12:04:39 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:59 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <44ac051fab6315161905949caefed78381b6c5fe.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 14/19] KVM: guest_mem: Refactor cleanup to separate inode
 and file cleanup
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cleanup in kvm_gmem_release() should be the reverse of
kvm_gmem_create_file().

Cleanup in kvm_gmem_evict_inode() should be the reverse of
kvm_gmem_create_inode().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_mem.c | 105 +++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 34 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 2f69ef666871..13253af40be6 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -247,42 +247,13 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 static int kvm_gmem_release(struct inode *inode, struct file *file)
 {
-	struct kvm_gmem *gmem = inode->i_mapping->private_data;
-	struct kvm_memory_slot *slot;
-	struct kvm *kvm = gmem->kvm;
-	unsigned long index;
-
 	/*
-	 * Prevent concurrent attempts to *unbind* a memslot.  This is the last
-	 * reference to the file and thus no new bindings can be created, but
-	 * deferencing the slot for existing bindings needs to be protected
-	 * against memslot updates, specifically so that unbind doesn't race
-	 * and free the memslot (kvm_gmem_get_file() will return NULL).
+	 * This is called when the last reference to the file is released. Only
+	 * clean up file-related stuff. struct kvm_gmem is also referred to in
+	 * the inode, so clean that up in kvm_gmem_evict_inode().
 	 */
-	mutex_lock(&kvm->slots_lock);
-
-	xa_for_each(&gmem->bindings, index, slot)
-		rcu_assign_pointer(slot->gmem.file, NULL);
-
-	synchronize_rcu();
-
-	/*
-	 * All in-flight operations are gone and new bindings can be created.
-	 * Free the backing memory, and more importantly, zap all SPTEs that
-	 * pointed at this file.
-	 */
-	kvm_gmem_invalidate_begin(kvm, gmem, 0, -1ul);
-	truncate_inode_pages_final(file->f_mapping);
-	kvm_gmem_invalidate_end(kvm, gmem, 0, -1ul);
-
-	mutex_unlock(&kvm->slots_lock);
-
-	WARN_ON_ONCE(!(mapping_empty(file->f_mapping)));
-
-	xa_destroy(&gmem->bindings);
-	kfree(gmem);
-
-	kvm_put_kvm(kvm);
+	file->f_mapping = NULL;
+	file->private_data = NULL;
 
 	return 0;
 }
@@ -603,11 +574,77 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
 
+static void kvm_gmem_evict_inode(struct inode *inode)
+{
+	struct kvm_gmem *gmem = inode->i_mapping->private_data;
+	struct kvm_memory_slot *slot;
+	struct kvm *kvm;
+	unsigned long index;
+
+	/*
+	 * If iput() was called before inode is completely set up due to some
+	 * error in kvm_gmem_create_inode(), gmem will be NULL.
+	 */
+	if (!gmem)
+		goto basic_cleanup;
+
+	kvm = gmem->kvm;
+
+	/*
+	 * Prevent concurrent attempts to *unbind* a memslot.  This is the last
+	 * reference to the file and thus no new bindings can be created, but
+	 * deferencing the slot for existing bindings needs to be protected
+	 * against memslot updates, specifically so that unbind doesn't race
+	 * and free the memslot (kvm_gmem_get_file() will return NULL).
+	 */
+	mutex_lock(&kvm->slots_lock);
+
+	xa_for_each(&gmem->bindings, index, slot)
+		rcu_assign_pointer(slot->gmem.file, NULL);
+
+	synchronize_rcu();
+
+	/*
+	 * All in-flight operations are gone and new bindings can be created.
+	 * Free the backing memory, and more importantly, zap all SPTEs that
+	 * pointed at this file.
+	 */
+	kvm_gmem_invalidate_begin(kvm, gmem, 0, -1ul);
+	truncate_inode_pages_final(inode->i_mapping);
+	kvm_gmem_invalidate_end(kvm, gmem, 0, -1ul);
+
+	mutex_unlock(&kvm->slots_lock);
+
+	WARN_ON_ONCE(!(mapping_empty(inode->i_mapping)));
+
+	xa_destroy(&gmem->bindings);
+	kfree(gmem);
+
+	kvm_put_kvm(kvm);
+
+basic_cleanup:
+	clear_inode(inode);
+}
+
+static const struct super_operations kvm_gmem_super_operations = {
+	/*
+	 * TODO update statfs handler for kvm_gmem. What should the statfs
+	 * handler return?
+	 */
+	.statfs		= simple_statfs,
+	.evict_inode	= kvm_gmem_evict_inode,
+};
+
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
 {
+	struct pseudo_fs_context *ctx;
+
 	if (!init_pseudo(fc, GUEST_MEMORY_MAGIC))
 		return -ENOMEM;
 
+	ctx = fc->fs_private;
+	ctx->ops = &kvm_gmem_super_operations;
+
 	return 0;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

