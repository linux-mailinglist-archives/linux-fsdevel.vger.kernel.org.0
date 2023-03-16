Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969046BD8E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 20:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCPTVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCPTVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6424BFA
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678994408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7DGVGdsLr2YbV3HWdxuX51W92mO0vTUc8qtZ0E4eCDA=;
        b=DEgYsqunvBYU2UDm20L9BTtBZI+Or2GBFNAqNqsQkcjL5p1GzrWt/jOqDsTBjyw/mOt6yt
        RsWEs7vuvHsydig/8eCyVJVduK4F/Zio1SIY54BRwLXsvviZmo2/oGIne3iMjagcNl+UZ5
        14ozEGAj24wb+wD7aezYahYVKa/NIWc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-eIwOpzLSM8m0KsMUVh4jNQ-1; Thu, 16 Mar 2023 15:20:06 -0400
X-MC-Unique: eIwOpzLSM8m0KsMUVh4jNQ-1
Received: by mail-qt1-f199.google.com with SMTP id ga17-20020a05622a591100b003bfdf586476so1401025qtb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 12:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994405; x=1681586405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DGVGdsLr2YbV3HWdxuX51W92mO0vTUc8qtZ0E4eCDA=;
        b=eOfNljnG09Z2k8qa/PW19+x6Bns9W0rtnj4b/PzitdpnUFU6xNBMKkQM3sgtBWeCJ8
         pDwgRJgpClQktWrujJ7llX1jryAMrYdq0DtWSsYyvOlYaBu1MxS1u8dvMHCZ/M8S+SGr
         g83x+4ZP+ktRmEt2071zyleata54oxuzxE1lP6d+42xbz8+6GFsWBhoql/MiJaUaQohp
         d0hC0noAslADR0TZwprHh8UcYpO8sh7n7BdhxI1RIqJjcljPevo16RXvTTGfsfCZM3kU
         Hkx5BFj4UC0+/VkEDk2IgdP/1SmxFsyIbYwMAQSdPMAvPscI8SLkYqsN3CMcAAAzAgjc
         pUQw==
X-Gm-Message-State: AO0yUKVt+/XpTBEnZCKoMB170dMnTiMrj7eRLOO+bYTSRlNSXySHYyQY
        LnSg+S+l+QwKD2FcvtNAJFrYblxWcDBSkSD0bXz6wwevXwypP8Yz0JHnIn9cM0bmjoy5ZbjoolD
        r7OX07lwemA3tp+2fj/vwiAIx1g==
X-Received: by 2002:ac8:5e0a:0:b0:3bd:1c0f:74f3 with SMTP id h10-20020ac85e0a000000b003bd1c0f74f3mr5989399qtx.2.1678994405538;
        Thu, 16 Mar 2023 12:20:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set/3yEJNplZkS+WTlmJt0QQT1iVZQPI9CC4z2P1JD6GrZheJ85kezxUtyHC00fVRRMwrGNMu+w==
X-Received: by 2002:ac8:5e0a:0:b0:3bd:1c0f:74f3 with SMTP id h10-20020ac85e0a000000b003bd1c0f74f3mr5989356qtx.2.1678994405109;
        Thu, 16 Mar 2023 12:20:05 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b0074235386738sm144323qkb.37.2023.03.16.12.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:20:04 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:20:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 1/7] userfaultfd: Add UFFD WP Async support
Message-ID: <ZBNr4nohj/Tw4Zhw@x1n>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wmm/kV5Ei1/X4v9u"
Content-Disposition: inline
In-Reply-To: <20230309135718.1490461-2-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wmm/kV5Ei1/X4v9u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, Muhammad,

On Thu, Mar 09, 2023 at 06:57:12PM +0500, Muhammad Usama Anjum wrote:
> Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
> faults on its own. It can be used to track that which pages have been
> written-to from the time the pages were write-protected. It is very
> efficient way to track the changes as uffd is by nature pte/pmd based.
> 
> UFFD synchronous WP sends the page faults to the userspace where the
> pages which have been written-to can be tracked. But it is not efficient.
> This is why this asynchronous version is being added. After setting the
> WP Async, the pages which have been written to can be found in the pagemap
> file or information can be obtained from the PAGEMAP_IOCTL.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Here's the patch that can enable WP_ASYNC for all kinds of memories (as I
promised..).  Currently I only tested btrfs (besides the common three)
which is the major fs I use locally, but I guess it'll also enable the rest
no matter what's underneath, just like soft-dirty.

As I mentioned, I just feel it very unfortunate to have a lot of suffixes
for the UFFD_FEATURE_* on types of memory, and I hope we get rid of it for
this WP_ASYNC from the start because the workflow should really be similar
to anon/shmem handling for most of the rest, just a few tweaks here and
there.

I had a feeling that some type of special VMA will work weirdly, but let's
see.. so far I don't come up with any.

If the patch looks fine to you, please consider replace this patch with
patch 1 of mine where I attached.  Then patch 1 can be reviewed alongside
with your series.

Logically patch 1 can be reviewed separately too, because it works
perfectly afaiu without the atomic version of pagemap already.  But on my
side I don't think it justifies anything really matters, so unless someone
thinks it a good idea to post / review / merge it separately, you can keep
that with your new pagemap ioctl.

Patch 2 is only for your reference.  It's not for merging quality so please
don't put it into your series.  I do plan to cleanup the userfaultfd
selftests in the near future first (when I wrote this I am more eager to do
so..).  I also think your final pagemap test cases can cover quite a bit.

Thanks,

-- 
Peter Xu

--wmm/kV5Ei1/X4v9u
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-userfaultfd-UFFD_FEATURE_WP_ASYNC.patch"

From 69640a7df80c147f43b2926ec0b189343acc3362 Mon Sep 17 00:00:00 2001
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date: Thu, 9 Mar 2023 18:57:12 +0500
Subject: [PATCH 1/2] userfaultfd: UFFD_FEATURE_WP_ASYNC

This patch adds a new userfaultfd-wp feature UFFD_FEATURE_WP_ASYNC, that
allows userfaultfd wr-protect faults to be resolved by the kernel directly.

It can be used like a high accuracy version of soft-dirty, without vma
modifications during tracking, and also with ranged support by default
rather than for a whole mm when reset the protections due to existance of
ioctl(UFFDIO_WRITEPROTECT).

Several goals of such a dirty tracking interface:

1. All types of memory should be supported and tracable.  This is nature
   for soft-dirty but should mention when the context is userfaultfd,
   because it used to only support anon/shmem/hugetlb.  The problem is for
   a dirty tracking purpose these three types may not be enough, and it's
   legal to track anything e.g. any page cache writes from mmap.

2. Protections can be applied to partial of a memory range, without vma
   split / merge fuss.  The hope is that the tracking itself should not
   affect any vma layout change.  It also helps when reset happens because
   the reset will not need mmap write lock which can block the tracee.

3. Accuracy needs to be maintained.  This means we need pte markers to work
   on any type of VMA.

One could question that, the whole concept of async dirty tracking is not
really close to fundamentally what userfaultfd used to be: it's not "a
fault to be serviced by userspace" anymore.  However, using userfaultfd-wp
here as a framework is convenient for us in at least:

1. VM_UFFD_WP vma flag, which has a very good name to suite something like
   this, so we don't need VM_YET_ANOTHER_SOFT_DIRTY.  Just use a new
   feature bit to identify from a sync version of uffd-wp registration.

2. PTE markers logic can be leveraged across the whole kernel to maintain
   the uffd-wp bit as long as an arch supports, this also applies to this
   case where uffd-wp bit will be a hint to dirty information and it will
   not go lost easily (e.g. when some page cache ptes got zapped).

3. Reuse ioctl(UFFDIO_WRITEPROTECT) interface for either starting or
   resetting a range of memory, while there's no counterpart in the old
   soft-dirty world, hence if this is wanted in a new design we'll need a
   new interface otherwise.

We can somehow understand that commonality because uffd-wp was
fundamentally a similar idea of write-protecting pages just like
soft-dirty.

This implementation allows WP_ASYNC to imply WP_UNPOPULATED, because so far
WP_ASYNC seems to not usable if without WP_UNPOPULATE.  This also gives us
chance to modify impl of WP_ASYNC just in case it could be not depending on
WP_UNPOPULATED anymore in the future kernels.  It's also fine to imply that
because both features will rely on PTE_MARKER_UFFD_WP config option, so
they'll show up together (or both missing) in an UFFDIO_API probe.

vma_can_userfault() now allows any VMA if the userfaultfd registration is
only about async uffd-wp.  So we can track dirty for all kinds of memory
including generic file systems (like XFS, EXT4 or BTRFS).

One trick worth mention in do_wp_page() is that we need to manually update
vmf->orig_pte here because it can be used later with a pte_same() check -
this path always has FAULT_FLAG_ORIG_PTE_VALID set in the flags.

The major defect of this approach of dirty tracking is we need to populate
the pgtables when tracking starts.  Soft-dirty doesn't do it like that.
It's unwanted in the case where the range of memory to track is huge and
unpopulated (e.g., tracking updates on a 10G file with mmap() on top,
without having any page cache installed yet).  One way to improve this is
to allow pte markers exist for larger than PTE level for PMD+.  That will
not change the interface if to implemented, so we can leave that for later.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 35 ++++++++++++++++++++
 fs/userfaultfd.c                             | 26 ++++++++++++---
 include/linux/userfaultfd_k.h                | 21 +++++++++++-
 include/uapi/linux/userfaultfd.h             |  9 ++++-
 mm/hugetlb.c                                 | 32 ++++++++++--------
 mm/memory.c                                  | 27 +++++++++++++--
 6 files changed, 128 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 16843d5a4f65..2f924a33beff 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -244,6 +244,41 @@ write-protected (so future writes will also result in a WP fault). These ioctls
 support a mode flag (``UFFDIO_COPY_MODE_WP`` or ``UFFDIO_CONTINUE_MODE_WP``
 respectively) to configure the mapping this way.
 
+If the userfaultfd context has ``UFFD_FEATURE_WP_ASYNC`` feature bit set,
+any vma registered with write-protection will work in async mode rather
+than the default sync mode.
+
+In async mode, there will be no message generated when a write operation
+happens, meanwhile the write-protection will be resolved automatically by
+the kernel.  It can be seen as a more accurate version of soft-dirty
+tracking and it can be different in a few ways:
+
+  - The dirty result will not be affected by vma changes (e.g. vma
+    merging) because the dirty is only tracked by the pte.
+
+  - It supports range operations by default, so one can enable tracking on
+    any range of memory as long as page aligned.
+
+  - Dirty information will not get lost if the pte was zapped due to
+    various reasons (e.g. during split of a shmem transparent huge page).
+
+  - Due to a reverted meaning of soft-dirty (page clean when uffd-wp bit
+    set; dirty when uffd-wp bit cleared), it has different semantics on
+    some of the memory operations.  For example: ``MADV_DONTNEED`` on
+    anonymous (or ``MADV_REMOVE`` on a file mapping) will be treated as
+    dirtying of memory by dropping uffd-wp bit during the procedure.
+
+The user app can collect the "written/dirty" status by looking up the
+uffd-wp bit for the pages being interested in /proc/pagemap.
+
+The page will not be under track of uffd-wp async mode until the page is
+explicitly write-protected by ``ioctl(UFFDIO_WRITEPROTECT)`` with the mode
+flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
+that was tracked by async mode userfaultfd-wp is invalid.
+
+When userfaultfd-wp async mode is used alone, it can be applied to all
+kinds of memory.
+
 QEMU/KVM
 ========
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 8395605790f6..a3cb05cfbd9b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -108,6 +108,11 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
 	return ctx->features & UFFD_FEATURE_INITIALIZED;
 }
 
+static bool userfaultfd_wp_async_ctx(struct userfaultfd_ctx *ctx)
+{
+	return ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC);
+}
+
 /*
  * Whether WP_UNPOPULATED is enabled on the uffd context.  It is only
  * meaningful when userfaultfd_wp()==true on the vma and when it's
@@ -1317,6 +1322,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
+	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1390,7 +1396,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
-		if (!vma_can_userfault(cur, vm_flags))
+		if (!vma_can_userfault(cur, vm_flags, wp_async))
 			goto out_unlock;
 
 		/*
@@ -1449,7 +1455,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vm_flags));
+		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
 		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
 		       vma->vm_userfaultfd_ctx.ctx != ctx);
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
@@ -1548,6 +1554,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
+	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1601,7 +1608,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * provides for more strict behavior to notice
 		 * unregistration errors.
 		 */
-		if (!vma_can_userfault(cur, cur->vm_flags))
+		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
 
 		found = true;
@@ -1614,7 +1621,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
+		BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1951,6 +1958,11 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	return ret;
 }
 
+bool userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return userfaultfd_wp_async_ctx(vma->vm_userfaultfd_ctx.ctx);
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -1982,6 +1994,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
 		goto err_out;
+
+	/* WP_ASYNC relies on WP_UNPOPULATED, choose it unconditionally */
+	if (features & UFFD_FEATURE_WP_ASYNC)
+		features |= UFFD_FEATURE_WP_UNPOPULATED;
+
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
@@ -1994,6 +2011,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
 	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
+	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a2c53e98dfd6..19e81df921a5 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -159,11 +159,22 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 }
 
 static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags)
+				     unsigned long vm_flags,
+				     bool wp_async)
 {
+	vm_flags &= __VM_UFFD_FLAGS;
+
 	if ((vm_flags & VM_UFFD_MINOR) &&
 	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
 		return false;
+
+	/*
+	 * If wp async enabled, and WP is the only mode enabled, allow any
+	 * memory type.
+	 */
+	if (wp_async && (vm_flags == VM_UFFD_WP))
+		return true;
+
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
@@ -173,6 +184,8 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
 		return false;
 #endif
+
+	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
 	    vma_is_shmem(vma);
 }
@@ -195,6 +208,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
+extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -295,6 +309,11 @@ static inline bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 66dd4cd277bd..cfb87a112a9f 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -39,7 +39,8 @@
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
-			   UFFD_FEATURE_WP_UNPOPULATED)
+			   UFFD_FEATURE_WP_UNPOPULATED |	\
+			   UFFD_FEATURE_WP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -210,6 +211,11 @@ struct uffdio_api {
 	 * (i.e. empty ptes).  This will be the default behavior for shmem
 	 * & hugetlbfs, so this flag only affects anonymous memory behavior
 	 * when userfault write-protection mode is registered.
+	 *
+	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
+	 * asynchronous mode is supported in which the write fault is
+	 * automatically resolved and write-protection is un-set.
+	 * It implies UFFD_FEATURE_WP_UNPOPULATED.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -225,6 +231,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#define UFFD_FEATURE_WP_ASYNC			(1<<14)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8bfd07f4c143..88ab9fc56856 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6084,21 +6084,27 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	/* Handle userfault-wp first, before trying to lock more pages */
 	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = haddr,
-			.real_address = address,
-			.flags = flags,
-		};
+		if (!userfaultfd_wp_async(vma)) {
+			struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.real_address = address,
+				.flags = flags,
+			};
 
-		spin_unlock(ptl);
-		if (pagecache_folio) {
-			folio_unlock(pagecache_folio);
-			folio_put(pagecache_folio);
+			spin_unlock(ptl);
+			if (pagecache_folio) {
+				folio_unlock(pagecache_folio);
+				folio_put(pagecache_folio);
+			}
+			hugetlb_vma_unlock_read(vma);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
-		hugetlb_vma_unlock_read(vma);
-		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		return handle_userfault(&vmf, VM_UFFD_WP);
+
+		entry = huge_pte_clear_uffd_wp(entry);
+		set_huge_pte_at(mm, haddr, ptep, entry);
+		/* Fallthrough to CoW */
 	}
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index c5f1bf906d0c..da639438af2b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3327,11 +3327,28 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
+	pte_t pte;
 
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_WP);
+			if (!userfaultfd_wp_async(vma)) {
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				return handle_userfault(vmf, VM_UFFD_WP);
+			}
+
+			/*
+			 * Nothing needed (cache flush, TLB invalidations,
+			 * etc.) because we're only removing the uffd-wp bit,
+			 * which is completely invisible to the user.
+			 */
+			pte = pte_clear_uffd_wp(*vmf->pte);
+
+			set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
+			/*
+			 * Update this to be prepared for following up CoW
+			 * handling
+			 */
+			vmf->orig_pte = pte;
 		}
 
 		/*
@@ -4803,8 +4820,11 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 
 	if (vma_is_anonymous(vmf->vma)) {
 		if (likely(!unshare) &&
-		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
+		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
+			if (userfaultfd_wp_async(vmf->vma))
+				goto split;
 			return handle_userfault(vmf, VM_UFFD_WP);
+		}
 		return do_huge_pmd_wp_page(vmf);
 	}
 
@@ -4816,6 +4836,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 		}
 	}
 
+split:
 	/* COW or write-notify handled on pte level: split pmd. */
 	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
 
-- 
2.39.1


--wmm/kV5Ei1/X4v9u
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0002-selftests-mm-Add-userfaultfd-unit-test.patch"

From b948ecb4d42560e263a27e5be6cb361b444035fc Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Mar 2023 12:23:08 -0400
Subject: [PATCH 2/2] selftests/mm: Add userfaultfd unit test

Add a new test for userfaultfd unit test.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   2 +
 .../selftests/mm/userfaultfd-unit-test.c      | 407 ++++++++++++++++++
 3 files changed, 410 insertions(+)
 create mode 100644 tools/testing/selftests/mm/userfaultfd-unit-test.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 1f8c36a9fa10..7404f27cba8d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -22,6 +22,7 @@ protection_keys_32
 protection_keys_64
 madv_populate
 userfaultfd
+userfaultfd-unit-test
 mlock-intersect-test
 mlock-random-test
 virtual_address_range
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index fbf5646b1072..a540ab7c84ec 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -56,6 +56,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_FILES += userfaultfd-unit-test
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
@@ -111,6 +112,7 @@ $(OUTPUT)/madv_populate: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 $(OUTPUT)/userfaultfd: vm_util.c
+$(OUTPUT)/userfaultfd-unit-test: vm_util.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/mm/userfaultfd-unit-test.c b/tools/testing/selftests/mm/userfaultfd-unit-test.c
new file mode 100644
index 000000000000..cd7b4f564f3b
--- /dev/null
+++ b/tools/testing/selftests/mm/userfaultfd-unit-test.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Userfaultfd unit tests.
+ *
+ *  Copyright (C) 2023  Red Hat, Inc.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <time.h>
+#include <signal.h>
+#include <poll.h>
+#include <string.h>
+#include <linux/mman.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <sys/wait.h>
+#include <pthread.h>
+#include <linux/userfaultfd.h>
+#include <setjmp.h>
+#include <stdbool.h>
+#include <assert.h>
+#include <inttypes.h>
+#include <stdint.h>
+#include <sys/random.h>
+#include <semaphore.h>
+
+#include "../kselftest.h"
+#include "vm_util.h"
+
+/* 128MB */
+#define  ASYNC_MEM_SIZE  (128UL << 20)
+
+#define ALIGN_DOWN(x,a) ((x) & ~((a) - 1))
+#define PAGE_SIZE 4096
+
+int pagemap_fd;
+/* TODO: detect this */
+int thp_size = 2UL << 20;
+
+typedef unsigned char *(*mem_map_fn)(size_t size);
+
+unsigned char *anon_mem_map(size_t size);
+unsigned char *shmem_mem_map(size_t size);
+unsigned char *hugetlb_mem_map(size_t size);
+unsigned char *localfs_mem_map(size_t size);
+
+typedef enum {
+	TEST_ASYNC_ANON = 0,
+	TEST_ASYNC_SHMEM,
+	TEST_ASYNC_HUGETLB,
+	/* Direct test on `pwd`, with the hope that it's a local file system. */
+	TEST_ASYNC_LOCAL_FS,
+	TEST_ASYNC_NUM,
+} test_async_type;
+
+typedef struct {
+	const char *name;
+	/* madvise() used to zap a pte (only, but keep the data) */
+	int zap_madvise;
+	int page_size;
+	mem_map_fn mem_map;
+} async_ops_t;
+
+async_ops_t async_ops[TEST_ASYNC_NUM] = {
+	{
+		.name = "anonymous",
+		.zap_madvise = MADV_PAGEOUT,
+		.mem_map = anon_mem_map,
+		.page_size = PAGE_SIZE,
+	},
+	{
+		.name = "shmem",
+		.zap_madvise = MADV_DONTNEED,
+		.mem_map = shmem_mem_map,
+		.page_size = PAGE_SIZE,
+	},
+	{
+		.name = "hugetlb",
+		.zap_madvise = MADV_DONTNEED,
+		.mem_map = hugetlb_mem_map,
+		.page_size = (2UL << 20),
+	},
+	{
+		.name = "local-fs",
+		.zap_madvise = MADV_DONTNEED,
+		.mem_map = localfs_mem_map,
+		.page_size = PAGE_SIZE,
+	},
+};
+
+//#define debug(...) printf(__VA_ARGS__)
+#define debug(...)
+
+#define _err(fmt, ...)						\
+	do {							\
+		int ret = errno;				\
+		fprintf(stderr, "ERROR: " fmt, ##__VA_ARGS__);	\
+		fprintf(stderr, " (errno=%d, line=%d)\n",	\
+			ret, __LINE__);				\
+	} while (0)
+
+#define errexit(exitcode, fmt, ...)		\
+	do {					\
+		_err(fmt, ##__VA_ARGS__);	\
+		exit(exitcode);			\
+	} while (0)
+
+#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
+
+#define PM_UFFD_WP                    (1UL << 57)
+
+#define  pagemap_check_wp(addr, wp) do {				\
+		if (!!(pagemap_get_entry(pagemap_fd, \
+					 (char *)addr) & PM_UFFD_WP) != wp) \
+			err("pagemap uffd-wp bit error: addr=0x%lx", \
+			    (unsigned long)addr);		     \
+	} while (0)
+
+static uint64_t random_uint64(void)
+{
+	uint64_t value;
+	int ret;
+
+	ret = getrandom(&value, sizeof(value), 0);
+	assert(ret == sizeof(value));
+
+	return value;
+}
+
+static int __userfaultfd_open_dev(void)
+{
+	int fd, _uffd;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		perror("open(/dev/userfaultfd)");
+		return -1;
+	}
+
+	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, O_CLOEXEC);
+	if (_uffd < 0) {
+		perror("USERFAULTFD_IOC_NEW");
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	return _uffd;
+}
+
+static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
+{
+	struct uffdio_writeprotect prms;
+
+	/* Write protection page faults */
+	prms.range.start = start;
+	prms.range.len = len;
+	/* Undo write-protect, do wakeup after that */
+	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
+
+	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
+		err("clear WP failed: address=0x%"PRIx64, (uint64_t)start);
+}
+
+unsigned char *anon_mem_map(size_t size)
+{
+	unsigned char *buffer;
+
+	buffer = mmap(NULL, size, PROT_READ|PROT_WRITE,
+		      MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+
+	if (buffer == MAP_FAILED)
+		err("mmap(MAP_HUGETLB)");
+
+	return buffer;
+}
+
+unsigned char *shmem_mem_map(size_t size)
+{
+	unsigned char *buffer;
+
+	buffer = mmap(NULL, size, PROT_READ|PROT_WRITE,
+		      MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+
+	if (buffer == MAP_FAILED)
+		err("mmap(MAP_HUGETLB)");
+
+	return buffer;
+}
+
+unsigned char *hugetlb_mem_map(size_t size)
+{
+	unsigned char *buffer;
+
+	buffer = mmap(NULL, size, PROT_READ|PROT_WRITE,
+		      MAP_SHARED|MAP_ANONYMOUS|MAP_HUGETLB|MAP_HUGE_2MB,
+		      -1, 0);
+
+	if (buffer == MAP_FAILED)
+		err("mmap(MAP_HUGETLB)");
+
+	return buffer;
+}
+
+unsigned char *localfs_mem_map(size_t size)
+{
+#define  TMP_LOCAL_PATH  "./test-async"
+	int ret, fd = open(TMP_LOCAL_PATH, O_RDWR | O_CREAT, 0644);
+	unsigned char *buffer = NULL;
+
+	if (fd < 0) {
+		perror("open()");
+		return NULL;
+	}
+
+	ret = ftruncate(fd, size);
+	if (ret) {
+		perror("ftruncate()");
+		close(fd);
+		return NULL;
+	}
+
+	buffer = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (buffer == MAP_FAILED) {
+		perror("mmap()");
+		close(fd);
+		return NULL;
+	}
+	close(fd);
+	unlink(TMP_LOCAL_PATH);
+
+	return buffer;
+}
+
+typedef struct {
+	async_ops_t *ops;
+	unsigned char *buffer;
+	size_t size;
+	volatile bool quit;
+} async_args_t;
+
+static void *uffd_zap_thread(void *data)
+{
+	async_args_t *args = data;
+	unsigned char *start = args->buffer;
+	size_t size = args->size;
+	async_ops_t *ops = args->ops;
+	unsigned int psize = ops->page_size;
+	int zap_madvise = ops->zap_madvise;
+	uint64_t offset;
+
+	debug("zap thread started\n");
+
+	while (!args->quit) {
+		offset = ALIGN_DOWN(random_uint64() % size, psize);
+		madvise(start + offset, psize, zap_madvise);
+		usleep(100);
+	}
+
+	debug("zap thread ended\n");
+
+	return NULL;
+}
+
+static bool bitmap_test(unsigned long *bitmap, unsigned long bit)
+{
+	unsigned long nbits = sizeof(unsigned long) * 8;
+
+	return bitmap[bit / nbits] & (1UL << (bit % nbits));
+}
+
+static bool test_async(async_ops_t *ops, int uffd,
+		       unsigned char *buffer, size_t size)
+{
+#define  LOOP_N  5
+	unsigned long *bitmap, npages, i;
+	pthread_t zap_tid;
+	async_args_t args = {
+		.buffer = buffer,
+		.size = size,
+		.ops = ops,
+		.quit = false,
+	};
+	int loops;
+
+	npages = size / ops->page_size;
+	bitmap = calloc(1, npages / 8);
+	assert(bitmap);
+
+	/* Random prefaults */
+	getrandom(bitmap, npages / 8, 0);
+	for (i = 0; i < npages; i++) {
+		if (bitmap_test(bitmap, i)) {
+			debug("prefault page %ld as write\n", i);
+			*(buffer + i * ops->page_size) = 1;
+		}
+	}
+
+	/* Create zapper to randomly zap pgtables */
+	pthread_create(&zap_tid, NULL, uffd_zap_thread, &args);
+
+	for (loops = 0; loops < LOOP_N; loops++) {
+		/* Start tracking, or reset, on all pages */
+		wp_range(uffd, (uintptr_t)buffer, size, true);
+
+		/* Random writes */
+		getrandom(bitmap, npages / 8, 0);
+		for (i = 0; i < npages; i++) {
+			if (bitmap_test(bitmap, i)) {
+				debug("update page %ld\n", i);
+				*(buffer + i * ops->page_size) = 2;
+			}
+		}
+
+		/* Verify pagemap tracked all the writes */
+		for (i = 0; i < npages; i++) {
+			debug("check page %ld\n", i);
+			pagemap_check_wp(buffer + i * ops->page_size,
+					 !bitmap_test(bitmap, i));
+		}
+	}
+
+	free(bitmap);
+	args.quit = true;
+	pthread_join(zap_tid, NULL);
+
+	return true;
+}
+
+static void test_uffd_wp_async_one(async_ops_t *ops)
+{
+	struct uffdio_register uffdio_register = {0};
+	struct uffdio_api uffdio_api;
+	unsigned char *buffer = NULL;
+	bool succeed = false;
+	int uffd = -1;
+
+	if (!ops->mem_map) {
+		ksft_test_result_skip("Userfaultfd-wp async (%s)\n",
+				      ops->name);
+		return;
+	}
+
+	buffer = ops->mem_map(ASYNC_MEM_SIZE);
+	if (!buffer)
+		goto out;
+
+	uffd = __userfaultfd_open_dev();
+	if (uffd < 0)
+		goto out;
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_WP_ASYNC;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
+		perror("UFFDIO_API");
+		goto out;
+	}
+
+	uffdio_register.range.start = (unsigned long) buffer;
+	uffdio_register.range.len = ASYNC_MEM_SIZE;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
+		perror("UFFDIO_REGISTER");
+		goto out;
+	}
+
+	succeed = test_async(ops, uffd, buffer, ASYNC_MEM_SIZE);
+
+	if (ioctl(uffd, UFFDIO_UNREGISTER, &uffdio_register.range)) {
+		perror("UFFDIO_UNREGISTER");
+		goto out;
+	}
+out:
+	if (uffd > 0)
+		close(uffd);
+	if (buffer)
+		munmap(buffer, ASYNC_MEM_SIZE);
+
+	if (succeed)
+		ksft_test_result_pass("Userfaultfd-wp async (%s)\n", ops->name);
+	else
+		ksft_test_result_fail("Userfaultfd-wp async (%s)\n", ops->name);
+}
+
+static void test_uffd_wp_async_all(void)
+{
+	test_async_type type;
+
+	for (type = 0; type < TEST_ASYNC_NUM; type++)
+		test_uffd_wp_async_one(&async_ops[type]);
+}
+
+int main(void)
+{
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+
+	ksft_print_header();
+	ksft_set_plan(TEST_ASYNC_NUM);
+	test_uffd_wp_async_all();
+	return ksft_exit_pass();
+}
-- 
2.39.1


--wmm/kV5Ei1/X4v9u--

