Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADED11BC5DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 18:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgD1QzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 12:55:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34421 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728327AbgD1QzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ebXyDv/i8jtA4VSfqIkOWbEh11RYKbfmfy2Rk5FO8Vk=;
        b=QoSRAvZNs0bSvGnUPSdCl8Uo3pXQuQK7UWX+GdQuNwaEqY9qHPBadiLG9TRJIMWxt2DodB
        IURd7pnEzqk66QGNsKN8lKE/lBF75DCACKTwr07zUIlQKKAZeKchZ2TV2G7mcIiA+6Oq8m
        sOL4taqai2i0NgrvvFjdkWmWc+xXjlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-1w1_27iUPpKirbacfPJCIQ-1; Tue, 28 Apr 2020 12:55:01 -0400
X-MC-Unique: 1w1_27iUPpKirbacfPJCIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDFED1005510;
        Tue, 28 Apr 2020 16:54:57 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 009E510013BD;
        Tue, 28 Apr 2020 16:54:55 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:54:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [regression?] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200428105455.30343fb4@w520.home>
In-Reply-To: <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
        <20200211001536.1027652-7-jhubbard@nvidia.com>
        <20200424121846.5ee2685f@w520.home>
        <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
        <20200424141548.5afdd2bb@w520.home>
        <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/BQ=NWFsJNN2mugeC9JYOndi"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--MP_/BQ=NWFsJNN2mugeC9JYOndi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 24 Apr 2020 15:58:29 -0700
John Hubbard <jhubbard@nvidia.com> wrote:

> On 2020-04-24 13:15, Alex Williamson wrote:
> > On Fri, 24 Apr 2020 12:20:03 -0700
> > John Hubbard <jhubbard@nvidia.com> wrote:
> >   
> >> On 2020-04-24 11:18, Alex Williamson wrote:
> >> ...  
> >>> Hi John,
> >>>
> >>> I'm seeing a regression bisected back to this commit (3faa52c03f44
> >>> mm/gup: track FOLL_PIN pages).  I've attached some vfio-pci test code
> >>> that reproduces this by mmap'ing a page of MMIO space of a device and
> >>> then tries to map that through the IOMMU, so this should be attempting
> >>> a gup/pin of a PFNMAP page.  Previously this failed gracefully (-EFAULT),
> >>> but now results in:  
> >>
> >>
> >> Hi Alex,
> >>
> >> Thanks for this report, and especially for source code to test it,
> >> seeing as how I can't immediately spot the problem just from the crash
> >> data so far.  I'll get set up and attempt a repro.
> >>
> >> Actually this looks like it should be relatively easier than the usual
> >> sort of "oops, we leaked a pin_user_pages() or unpin_user_pages() call,
> >> good luck finding which one" report that I fear the most. :) This one
> >> looks more like a crash that happens directly, when calling into the
> >> pin_user_pages_remote() code. Which should be a lot easier to solve...
> >>
> >> btw, if you are set up for it, it would be nice to know what source file
> >> and line number corresponds to the RIP (get_pfnblock_flags_mask+0x22)
> >> below. But if not, no problem, because I've likely got to do the repro
> >> in any case.  
> > 
> > Hey John,
> > 
> > TBH I'm feeling a lot less confident about this bisect.  This was
> > readily reproducible to me on a clean tree a bit ago, but now it
> > eludes me.  Let me go back and figure out what's going on before you
> > spend any more time on it.  Thanks,
> >   
> 
> OK. But I'm keeping the repro program! :)  It made it quick and easy to
> set up a vfio test, so it was worth doing in any case.

Great, because I've traced my steps, re-bisected and came back to the
same upstream commit with the same test program.  The major difference
is that I thought I was seeing this on pure upstream, but some vfio
code that I'm trying to prepare for upstream snuck in, so this isn't a
pure upstream regression, but the changes I was making worked on v5.6
and does not work with this commit.  Maybe still a latent regression,
maybe a bug in my changes.

> Anyway, I wanted to double check this just out of paranoia, and so
> now I have a data point for you: your test program runs and passes for
> me using today's linux.git kernel, with an NVIDIA GPU as the vfio
> device, and the kernel log is clean. No hint of any problems.

Yep, I agree.  The vfio change I'm experimenting with is to move the
remap_pfn_range() from vfio_pci_mmap() to a vm_ops.fault handler.  This
is why I have the test program creating an mmap of the device mmio
space and then immediately mapping it through the iommu without
touching it.  If the vma gets faulted in the dma mapping path via
pin_user_pages_remote(), I see the crash I reported initially.  If the
test program is modified to access the mmap before doing the dma
mapping, everything works normally.  In either case, the fault handler
is called and satisfies the fault with remap_pfn_range() and returns
VM_FAULT_NOPAGE (vfio patch attached).

Here's the crash I'm seeing with some further debugging:

BUG: unable to handle page fault for address: ffffa5b8bfe14f38
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] SMP NOPTI
CPU: 70 PID: 3343 Comm: vfio-pci-dma-ma Not tainted 5.6.0-3faa52c03f44+ #20
Hardware name: AMD Corporation Diesel/Diesel, BIOS TDL100CB 03/17/2020
RIP: 0010:get_pfnblock_flags_mask+0x22/0x70
Code: c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48 8b 05 bc e1 d9 01 48 89 f7 49 89 c8 48 c1 ef 0f 48 85 c0 74 48 48 89 f1 48 c1 e9 17 <48> 8b 04 c8 48 85 c0 74 0b 40 0f b6 ff 48 c1 e7 04 48 01 f8 48 c1
RSP: 0018:ffffb2e3c910fcc8 EFLAGS: 00010216
RAX: ffff95b8bff50000 RBX: 0000000000000001 RCX: 000001fffffd89e7
RDX: 0000000000000002 RSI: fffffec4f3a899ba RDI: 0001fffffd89e751
RBP: ffffb2e3c910fd88 R08: 0000000000000007 R09: ffff95a4aa79fce8
R10: 0000000000000000 R11: ffffb2e3c910f840 R12: 0000000100000000
R13: 0000000000000000 R14: 0000000000000001 R15: ffff959caa266e80
FS:  00007f1a95023740(0000) GS:ffff959caf180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffa5b8bfe14f38 CR3: 0000000462a1e000 CR4: 00000000003406e0
Call Trace:
 __gup_longterm_locked+0x274/0x620
 vaddr_get_pfn+0x74/0x110 [vfio_iommu_type1]
 vfio_pin_pages_remote+0x6e/0x370 [vfio_iommu_type1]
 vfio_iommu_type1_ioctl+0x8e5/0xaac [vfio_iommu_type1]

get_pfnblock_flags_mask+0x22/0x70 is here:

include/linux/mmzone.h:1254
static inline struct mem_section *__nr_to_section(unsigned long nr)
{
#ifdef CONFIG_SPARSEMEM_EXTREME
        if (!mem_section)
                return NULL;
#endif
====>   if (!mem_section[SECTION_NR_TO_ROOT(nr)])
                return NULL;
        return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
}

The call trace is:

__gup_longterm_locked
  check_and_migrate_cma_pages
    is_migrate_cma_page
      get_pageblock_migratetype
        get_pfnblock_flags_mask
          __get_pfnblock_flags_mask
            get_pageblock_bitmap
              __pfn_to_section
                __nr_to_section

Any ideas why we see this difference between the vma being faulted in
outside of the page pinning path versus faulted by it?

FWIW, here's the stack dump for getting to the fault handler in the
latter case:

 vfio_pci_mmap_fault+0x22/0x130 [vfio_pci]
 __do_fault+0x38/0xd0
 __handle_mm_fault+0xd4b/0x1380
 handle_mm_fault+0xe2/0x1f0
 __get_user_pages+0x188/0x820
 __gup_longterm_locked+0xc8/0x620

Thanks!
Alex

--MP_/BQ=NWFsJNN2mugeC9JYOndi
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=vfio-fault.diff

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 379a02c36e37..3b8db2ef6247 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1195,6 +1195,76 @@ static ssize_t vfio_pci_write(void *device_data, const char __user *buf,
 	return vfio_pci_rw(device_data, (char __user *)buf, count, ppos, true);
 }
 
+static int vfio_pci_add_vma(struct vfio_pci_device *vdev,
+			    struct vm_area_struct *vma)
+{
+	struct vfio_pci_mmap_vma *mmap_vma;
+
+	mmap_vma = kzalloc(sizeof(*mmap_vma), GFP_KERNEL);
+	if (!mmap_vma)
+		return -ENOMEM;
+
+	mmap_vma->vma = vma;
+
+	mutex_lock(&vdev->vma_lock);
+	list_add(&mmap_vma->vma_next, &vdev->vma_list);
+	mutex_unlock(&vdev->vma_lock);
+
+	return 0;
+}
+
+/*
+ * Zap mmaps on open so that we can fault them in on access and therefore
+ * our vma_list only tracks mappings accessed since last zap.
+ */
+static void vfio_pci_mmap_open(struct vm_area_struct *vma)
+{
+	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+}
+
+static void vfio_pci_mmap_close(struct vm_area_struct *vma)
+{
+	struct vfio_pci_device *vdev = vma->vm_private_data;
+	struct vfio_pci_mmap_vma *mmap_vma;
+
+	mutex_lock(&vdev->vma_lock);
+	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
+		if (mmap_vma->vma == vma) {
+			list_del(&mmap_vma->vma_next);
+			kfree(mmap_vma);
+			break;
+		}
+	}
+	mutex_unlock(&vdev->vma_lock);
+}
+
+static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct vfio_pci_device *vdev = vma->vm_private_data;
+
+	printk("Fault: %p\n", vma);
+	if (vfio_pci_add_vma(vdev, vma)) {
+		printk("SIGOOM\n");
+		return VM_FAULT_OOM;
+	}
+
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			    vma->vm_end - vma->vm_start, vma->vm_page_prot)) {
+		printk("SIGBUS\n");
+		return VM_FAULT_SIGBUS;
+	}
+
+	printk("OK\n");
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct vfio_pci_mmap_ops = {
+	.open = vfio_pci_mmap_open,
+	.close = vfio_pci_mmap_close,
+	.fault = vfio_pci_mmap_fault,
+};
+
 static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 {
 	struct vfio_pci_device *vdev = device_data;
@@ -1253,8 +1323,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
 
+	vma->vm_ops = &vfio_pci_mmap_ops;
+
+#if 1
+	return 0;
+#else
 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       req_len, vma->vm_page_prot);
+			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+#endif
 }
 
 static void vfio_pci_request(void *device_data, unsigned int count)
@@ -1330,6 +1406,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&vdev->irqlock);
 	mutex_init(&vdev->ioeventfds_lock);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
+	mutex_init(&vdev->vma_lock);
+	INIT_LIST_HEAD(&vdev->vma_list);
 
 	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
 	if (ret) {
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 8a2c7607d513..7faed79fe033 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -84,6 +84,11 @@ struct vfio_pci_reflck {
 	struct mutex		lock;
 };
 
+struct vfio_pci_mmap_vma {
+	struct vm_area_struct	*vma;
+	struct list_head	vma_next;
+};
+
 struct vfio_pci_device {
 	struct pci_dev		*pdev;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
@@ -122,6 +127,8 @@ struct vfio_pci_device {
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
 	struct list_head	ioeventfds_list;
+	struct mutex		vma_lock;
+	struct list_head	vma_list;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)

--MP_/BQ=NWFsJNN2mugeC9JYOndi--

