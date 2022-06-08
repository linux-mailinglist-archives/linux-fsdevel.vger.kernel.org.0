Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E76543680
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbiFHPM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242380AbiFHPLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:11:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBEF49EC57;
        Wed,  8 Jun 2022 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HSa7nq0rTQKYu5xpTAyDBZo7J0xJSZeuZJeu4cA7+uA=; b=XSD4w/8aX3QS1Znxe52JqzddnO
        G9zfq44OTwfp/32xhuKCl4Mg3xGreiaH8tFKVxlHMfrnpwMvnnotxzX00VFXpd7wWur8s+M26k2GZ
        TQpr9hhPMjPkCnJl97tbAbojP8c+1md6RlRp3z4OZKvvHNQcMYaYXhG6f59qeoS5XCK+9LMrR/Vqy
        7jWwVyypvwXJOwCpTQ/MQ02ByUp560JzcQg/QOkW9PNNO8iLitSnyU5SCbqwFt1UDbTxYwkMPSxvC
        HTTY+AvLcnSoRVzYLZ+jJyulkCr1h/3yrbyCYfw5vgZgRyc2SZ5bDxz+fJGiuw/n/EZzcCRhFAyU0
        CKco2Cfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxCt-00CjFI-QD; Wed, 08 Jun 2022 15:02:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 02/19] mm: Convert all PageMovable users to movable_operations
Date:   Wed,  8 Jun 2022 16:02:32 +0100
Message-Id: <20220608150249.3033815-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220608150249.3033815-1-willy@infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These drivers are rather uncomfortably hammered into the
address_space_operations hole.  They aren't filesystems and don't behave
like filesystems.  They just need their own movable_operations structure,
which we can point to directly from page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/powerpc/platforms/pseries/cmm.c |  60 +---------------
 drivers/misc/vmw_balloon.c           |  61 +---------------
 drivers/virtio/virtio_balloon.c      |  47 +-----------
 include/linux/balloon_compaction.h   |   6 +-
 include/linux/fs.h                   |   2 -
 include/linux/migrate.h              |  26 +++++--
 include/linux/page-flags.h           |   2 +-
 include/uapi/linux/magic.h           |   4 --
 mm/balloon_compaction.c              |  10 ++-
 mm/compaction.c                      |  29 ++++----
 mm/migrate.c                         |  24 +++----
 mm/util.c                            |   4 +-
 mm/z3fold.c                          |  82 +++------------------
 mm/zsmalloc.c                        | 102 ++++++---------------------
 14 files changed, 94 insertions(+), 365 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 15ed8206c463..5f4037c1d7fe 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -19,9 +19,6 @@
 #include <linux/stringify.h>
 #include <linux/swap.h>
 #include <linux/device.h>
-#include <linux/mount.h>
-#include <linux/pseudo_fs.h>
-#include <linux/magic.h>
 #include <linux/balloon_compaction.h>
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
@@ -500,19 +497,6 @@ static struct notifier_block cmm_mem_nb = {
 };
 
 #ifdef CONFIG_BALLOON_COMPACTION
-static struct vfsmount *balloon_mnt;
-
-static int cmm_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, PPC_CMM_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type balloon_fs = {
-	.name = "ppc-cmm",
-	.init_fs_context = cmm_init_fs_context,
-	.kill_sb = kill_anon_super,
-};
-
 static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 			   struct page *newpage, struct page *page,
 			   enum migrate_mode mode)
@@ -564,47 +548,13 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 	return MIGRATEPAGE_SUCCESS;
 }
 
-static int cmm_balloon_compaction_init(void)
+static void cmm_balloon_compaction_init(void)
 {
-	int rc;
-
 	balloon_devinfo_init(&b_dev_info);
 	b_dev_info.migratepage = cmm_migratepage;
-
-	balloon_mnt = kern_mount(&balloon_fs);
-	if (IS_ERR(balloon_mnt)) {
-		rc = PTR_ERR(balloon_mnt);
-		balloon_mnt = NULL;
-		return rc;
-	}
-
-	b_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
-	if (IS_ERR(b_dev_info.inode)) {
-		rc = PTR_ERR(b_dev_info.inode);
-		b_dev_info.inode = NULL;
-		kern_unmount(balloon_mnt);
-		balloon_mnt = NULL;
-		return rc;
-	}
-
-	b_dev_info.inode->i_mapping->a_ops = &balloon_aops;
-	return 0;
-}
-static void cmm_balloon_compaction_deinit(void)
-{
-	if (b_dev_info.inode)
-		iput(b_dev_info.inode);
-	b_dev_info.inode = NULL;
-	kern_unmount(balloon_mnt);
-	balloon_mnt = NULL;
 }
 #else /* CONFIG_BALLOON_COMPACTION */
-static int cmm_balloon_compaction_init(void)
-{
-	return 0;
-}
-
-static void cmm_balloon_compaction_deinit(void)
+static void cmm_balloon_compaction_init(void)
 {
 }
 #endif /* CONFIG_BALLOON_COMPACTION */
@@ -622,9 +572,7 @@ static int cmm_init(void)
 	if (!firmware_has_feature(FW_FEATURE_CMO) && !simulate)
 		return -EOPNOTSUPP;
 
-	rc = cmm_balloon_compaction_init();
-	if (rc)
-		return rc;
+	cmm_balloon_compaction_init();
 
 	rc = register_oom_notifier(&cmm_oom_nb);
 	if (rc < 0)
@@ -658,7 +606,6 @@ static int cmm_init(void)
 out_oom_notifier:
 	unregister_oom_notifier(&cmm_oom_nb);
 out_balloon_compaction:
-	cmm_balloon_compaction_deinit();
 	return rc;
 }
 
@@ -677,7 +624,6 @@ static void cmm_exit(void)
 	unregister_memory_notifier(&cmm_mem_nb);
 	cmm_free_pages(atomic_long_read(&loaned_pages));
 	cmm_unregister_sysfs(&cmm_dev);
-	cmm_balloon_compaction_deinit();
 }
 
 /**
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 086ce77d9074..85dd6aa33df6 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -29,8 +29,6 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/mount.h>
-#include <linux/pseudo_fs.h>
 #include <linux/balloon_compaction.h>
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
@@ -1730,20 +1728,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 
 
 #ifdef CONFIG_BALLOON_COMPACTION
-
-static int vmballoon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type vmballoon_fs = {
-	.name           	= "balloon-vmware",
-	.init_fs_context	= vmballoon_init_fs_context,
-	.kill_sb        	= kill_anon_super,
-};
-
-static struct vfsmount *vmballoon_mnt;
-
 /**
  * vmballoon_migratepage() - migrates a balloon page.
  * @b_dev_info: balloon device information descriptor.
@@ -1862,21 +1846,6 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	return ret;
 }
 
-/**
- * vmballoon_compaction_deinit() - removes compaction related data.
- *
- * @b: pointer to the balloon.
- */
-static void vmballoon_compaction_deinit(struct vmballoon *b)
-{
-	if (!IS_ERR(b->b_dev_info.inode))
-		iput(b->b_dev_info.inode);
-
-	b->b_dev_info.inode = NULL;
-	kern_unmount(vmballoon_mnt);
-	vmballoon_mnt = NULL;
-}
-
 /**
  * vmballoon_compaction_init() - initialized compaction for the balloon.
  *
@@ -1888,33 +1857,15 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
  *
  * Return: zero on success or error code on failure.
  */
-static __init int vmballoon_compaction_init(struct vmballoon *b)
+static __init void vmballoon_compaction_init(struct vmballoon *b)
 {
-	vmballoon_mnt = kern_mount(&vmballoon_fs);
-	if (IS_ERR(vmballoon_mnt))
-		return PTR_ERR(vmballoon_mnt);
-
 	b->b_dev_info.migratepage = vmballoon_migratepage;
-	b->b_dev_info.inode = alloc_anon_inode(vmballoon_mnt->mnt_sb);
-
-	if (IS_ERR(b->b_dev_info.inode))
-		return PTR_ERR(b->b_dev_info.inode);
-
-	b->b_dev_info.inode->i_mapping->a_ops = &balloon_aops;
-	return 0;
 }
 
 #else /* CONFIG_BALLOON_COMPACTION */
-
-static void vmballoon_compaction_deinit(struct vmballoon *b)
-{
-}
-
-static int vmballoon_compaction_init(struct vmballoon *b)
+static inline void vmballoon_compaction_init(struct vmballoon *b)
 {
-	return 0;
 }
-
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 static int __init vmballoon_init(void)
@@ -1939,9 +1890,7 @@ static int __init vmballoon_init(void)
 	 * balloon_devinfo_init() .
 	 */
 	balloon_devinfo_init(&balloon.b_dev_info);
-	error = vmballoon_compaction_init(&balloon);
-	if (error)
-		goto fail;
+	vmballoon_compaction_init(&balloon);
 
 	INIT_LIST_HEAD(&balloon.huge_pages);
 	spin_lock_init(&balloon.comm_lock);
@@ -1958,7 +1907,6 @@ static int __init vmballoon_init(void)
 	return 0;
 fail:
 	vmballoon_unregister_shrinker(&balloon);
-	vmballoon_compaction_deinit(&balloon);
 	return error;
 }
 
@@ -1985,8 +1933,5 @@ static void __exit vmballoon_exit(void)
 	 */
 	vmballoon_send_start(&balloon, 0);
 	vmballoon_pop(&balloon);
-
-	/* Only once we popped the balloon, compaction can be deinit */
-	vmballoon_compaction_deinit(&balloon);
 }
 module_exit(vmballoon_exit);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b9737da6c4dd..bd360b91e9d3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -17,9 +17,6 @@
 #include <linux/oom.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
-#include <linux/mount.h>
-#include <linux/magic.h>
-#include <linux/pseudo_fs.h>
 #include <linux/page_reporting.h>
 
 /*
@@ -42,10 +39,6 @@
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
 #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
 
-#ifdef CONFIG_BALLOON_COMPACTION
-static struct vfsmount *balloon_mnt;
-#endif
-
 enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_INFLATE,
 	VIRTIO_BALLOON_VQ_DEFLATE,
@@ -805,18 +798,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 
 	return MIGRATEPAGE_SUCCESS;
 }
-
-static int balloon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, BALLOON_KVM_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type balloon_fs = {
-	.name           = "balloon-kvm",
-	.init_fs_context = balloon_init_fs_context,
-	.kill_sb        = kill_anon_super,
-};
-
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 static unsigned long shrink_free_pages(struct virtio_balloon *vb,
@@ -909,19 +890,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		goto out_free_vb;
 
 #ifdef CONFIG_BALLOON_COMPACTION
-	balloon_mnt = kern_mount(&balloon_fs);
-	if (IS_ERR(balloon_mnt)) {
-		err = PTR_ERR(balloon_mnt);
-		goto out_del_vqs;
-	}
-
 	vb->vb_dev_info.migratepage = virtballoon_migratepage;
-	vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
-	if (IS_ERR(vb->vb_dev_info.inode)) {
-		err = PTR_ERR(vb->vb_dev_info.inode);
-		goto out_kern_unmount;
-	}
-	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
 #endif
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		/*
@@ -930,13 +899,13 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		 */
 		if (virtqueue_get_vring_size(vb->free_page_vq) < 2) {
 			err = -ENOSPC;
-			goto out_iput;
+			goto out_del_vqs;
 		}
 		vb->balloon_wq = alloc_workqueue("balloon-wq",
 					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
 		if (!vb->balloon_wq) {
 			err = -ENOMEM;
-			goto out_iput;
+			goto out_del_vqs;
 		}
 		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
 		vb->cmd_id_received_cache = VIRTIO_BALLOON_CMD_ID_STOP;
@@ -1030,13 +999,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 out_del_balloon_wq:
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
-out_iput:
-#ifdef CONFIG_BALLOON_COMPACTION
-	iput(vb->vb_dev_info.inode);
-out_kern_unmount:
-	kern_unmount(balloon_mnt);
 out_del_vqs:
-#endif
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
@@ -1083,12 +1046,6 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	}
 
 	remove_common(vb);
-#ifdef CONFIG_BALLOON_COMPACTION
-	if (vb->vb_dev_info.inode)
-		iput(vb->vb_dev_info.inode);
-
-	kern_unmount(balloon_mnt);
-#endif
 	kfree(vb);
 }
 
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index edb7f6d41faa..5ca2d5699620 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -57,7 +57,6 @@ struct balloon_dev_info {
 	struct list_head pages;		/* Pages enqueued & handled to Host */
 	int (*migratepage)(struct balloon_dev_info *, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
-	struct inode *inode;
 };
 
 extern struct page *balloon_page_alloc(void);
@@ -75,11 +74,10 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 	spin_lock_init(&balloon->pages_lock);
 	INIT_LIST_HEAD(&balloon->pages);
 	balloon->migratepage = NULL;
-	balloon->inode = NULL;
 }
 
 #ifdef CONFIG_BALLOON_COMPACTION
-extern const struct address_space_operations balloon_aops;
+extern const struct movable_operations balloon_mops;
 
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
@@ -94,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page, balloon->inode->i_mapping);
+	__SetPageMovable(page, &balloon_mops);
 	set_page_private(page, (unsigned long)balloon);
 	list_add(&page->lru, &balloon->pages);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..5d8ee3155ca2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -367,8 +367,6 @@ struct address_space_operations {
 	 */
 	int (*migratepage) (struct address_space *,
 			struct page *, struct page *, enum migrate_mode);
-	bool (*isolate_page)(struct page *, isolate_mode_t);
-	void (*putback_page)(struct page *);
 	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 069a89e847f3..48aa4be04108 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -19,6 +19,13 @@ struct migration_target_control;
  */
 #define MIGRATEPAGE_SUCCESS		0
 
+struct movable_operations {
+	bool (*isolate_page)(struct page *, isolate_mode_t);
+	int (*migrate_page)(struct page *dst, struct page *src,
+			enum migrate_mode);
+	void (*putback_page)(struct page *);
+};
+
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
@@ -91,13 +98,13 @@ static inline int next_demotion_node(int node)
 #endif
 
 #ifdef CONFIG_COMPACTION
-extern int PageMovable(struct page *page);
-extern void __SetPageMovable(struct page *page, struct address_space *mapping);
-extern void __ClearPageMovable(struct page *page);
+bool PageMovable(struct page *page);
+void __SetPageMovable(struct page *page, const struct movable_operations *ops);
+void __ClearPageMovable(struct page *page);
 #else
-static inline int PageMovable(struct page *page) { return 0; }
+static inline bool PageMovable(struct page *page) { return false; }
 static inline void __SetPageMovable(struct page *page,
-				struct address_space *mapping)
+		const struct movable_operations *ops)
 {
 }
 static inline void __ClearPageMovable(struct page *page)
@@ -110,6 +117,15 @@ static inline bool folio_test_movable(struct folio *folio)
 	return PageMovable(&folio->page);
 }
 
+static inline
+const struct movable_operations *page_movable_ops(struct page *page)
+{
+	VM_BUG_ON(!__PageMovable(page));
+
+	return (const struct movable_operations *)
+		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 extern int migrate_misplaced_page(struct page *page,
 				  struct vm_area_struct *vma, int node);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e66f7aa3191d..3f5490f6f038 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -639,7 +639,7 @@ __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
  * structure which KSM associates with that merged page.  See ksm.h.
  *
  * PAGE_MAPPING_KSM without PAGE_MAPPING_ANON is used for non-lru movable
- * page and then page->mapping points a struct address_space.
+ * page and then page->mapping points to a struct movable_operations.
  *
  * Please note that, confusingly, "page_mapping" refers to the inode
  * address_space which maps the page from disk; whereas "page_mapped"
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f724129c0425..6325d1d0e90f 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -98,12 +98,8 @@
 
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
-#define BALLOON_KVM_MAGIC	0x13661366
-#define ZSMALLOC_MAGIC		0x58295829
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
-#define Z3FOLD_MAGIC		0x33
-#define PPC_CMM_MAGIC		0xc7571590
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 4b8eab4b3f45..22c96fed70b5 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -228,10 +228,8 @@ static void balloon_page_putback(struct page *page)
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 }
 
-
 /* move_to_new_page() counterpart for a ballooned page */
-static int balloon_page_migrate(struct address_space *mapping,
-		struct page *newpage, struct page *page,
+static int balloon_page_migrate(struct page *newpage, struct page *page,
 		enum migrate_mode mode)
 {
 	struct balloon_dev_info *balloon = balloon_page_device(page);
@@ -250,11 +248,11 @@ static int balloon_page_migrate(struct address_space *mapping,
 	return balloon->migratepage(balloon, newpage, page, mode);
 }
 
-const struct address_space_operations balloon_aops = {
-	.migratepage = balloon_page_migrate,
+const struct movable_operations balloon_mops = {
+	.migrate_page = balloon_page_migrate,
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
 };
-EXPORT_SYMBOL_GPL(balloon_aops);
+EXPORT_SYMBOL_GPL(balloon_mops);
 
 #endif /* CONFIG_BALLOON_COMPACTION */
diff --git a/mm/compaction.c b/mm/compaction.c
index 1f89b969c12b..f23efba1d118 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -110,28 +110,27 @@ static void split_map_pages(struct list_head *list)
 }
 
 #ifdef CONFIG_COMPACTION
-
-int PageMovable(struct page *page)
+bool PageMovable(struct page *page)
 {
-	struct address_space *mapping;
+	const struct movable_operations *mops;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	if (!__PageMovable(page))
-		return 0;
+		return false;
 
-	mapping = page_mapping(page);
-	if (mapping && mapping->a_ops && mapping->a_ops->isolate_page)
-		return 1;
+	mops = page_movable_ops(page);
+	if (mops)
+		return true;
 
-	return 0;
+	return false;
 }
 EXPORT_SYMBOL(PageMovable);
 
-void __SetPageMovable(struct page *page, struct address_space *mapping)
+void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 {
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE((unsigned long)mapping & PAGE_MAPPING_MOVABLE, page);
-	page->mapping = (void *)((unsigned long)mapping | PAGE_MAPPING_MOVABLE);
+	VM_BUG_ON_PAGE((unsigned long)mops & PAGE_MAPPING_MOVABLE, page);
+	page->mapping = (void *)((unsigned long)mops | PAGE_MAPPING_MOVABLE);
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
@@ -139,12 +138,10 @@ void __ClearPageMovable(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	/*
-	 * Clear registered address_space val with keeping PAGE_MAPPING_MOVABLE
-	 * flag so that VM can catch up released page by driver after isolation.
-	 * With it, VM migration doesn't try to put it back.
+	 * This page still has the type of a movable page, but it's
+	 * actually not movable any more.
 	 */
-	page->mapping = (void *)((unsigned long)page->mapping &
-				PAGE_MAPPING_MOVABLE);
+	page->mapping = (void *)PAGE_MAPPING_MOVABLE;
 }
 EXPORT_SYMBOL(__ClearPageMovable);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index e51588e95f57..3ce6fee87efa 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -59,7 +59,7 @@
 
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
-	struct address_space *mapping;
+	const struct movable_operations *mops;
 
 	/*
 	 * Avoid burning cycles with pages that are yet under __free_pages(),
@@ -97,10 +97,10 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	if (!PageMovable(page) || PageIsolated(page))
 		goto out_no_isolated;
 
-	mapping = page_mapping(page);
-	VM_BUG_ON_PAGE(!mapping, page);
+	mops = page_movable_ops(page);
+	VM_BUG_ON_PAGE(!mops, page);
 
-	if (!mapping->a_ops->isolate_page(page, mode))
+	if (!mops->isolate_page(page, mode))
 		goto out_no_isolated;
 
 	/* Driver shouldn't use PG_isolated bit of page->flags */
@@ -120,10 +120,9 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 
 static void putback_movable_page(struct page *page)
 {
-	struct address_space *mapping;
+	const struct movable_operations *mops = page_movable_ops(page);
 
-	mapping = page_mapping(page);
-	mapping->a_ops->putback_page(page);
+	mops->putback_page(page);
 	ClearPageIsolated(page);
 }
 
@@ -846,16 +845,15 @@ static int fallback_migrate_page(struct address_space *mapping,
 static int move_to_new_folio(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
-	struct address_space *mapping;
 	int rc = -EAGAIN;
 	bool is_lru = !__PageMovable(&src->page);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
 	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
 
-	mapping = folio_mapping(src);
-
 	if (likely(is_lru)) {
+		struct address_space *mapping = folio_mapping(src);
+
 		if (!mapping)
 			rc = migrate_page(mapping, &dst->page, &src->page, mode);
 		else if (mapping->a_ops->migratepage)
@@ -872,6 +870,8 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			rc = fallback_migrate_page(mapping, &dst->page,
 							&src->page, mode);
 	} else {
+		const struct movable_operations *mops;
+
 		/*
 		 * In case of non-lru page, it could be released after
 		 * isolation step. In that case, we shouldn't try migration.
@@ -883,8 +883,8 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			goto out;
 		}
 
-		rc = mapping->a_ops->migratepage(mapping, &dst->page,
-						&src->page, mode);
+		mops = page_movable_ops(&src->page);
+		rc = mops->migrate_page(&dst->page, &src->page, mode);
 		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
 				!folio_test_isolated(src));
 	}
diff --git a/mm/util.c b/mm/util.c
index 0837570c9225..53af0e79d3e4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -804,10 +804,10 @@ struct address_space *folio_mapping(struct folio *folio)
 		return swap_address_space(folio_swap_entry(folio));
 
 	mapping = folio->mapping;
-	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
+	if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
 		return NULL;
 
-	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
+	return mapping;
 }
 EXPORT_SYMBOL(folio_mapping);
 
diff --git a/mm/z3fold.c b/mm/z3fold.c
index f41f8b0d9e9a..13b1e9d15056 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -34,15 +34,11 @@
 #include <linux/node.h>
 #include <linux/compaction.h>
 #include <linux/percpu.h>
-#include <linux/mount.h>
-#include <linux/pseudo_fs.h>
-#include <linux/fs.h>
 #include <linux/preempt.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/zpool.h>
-#include <linux/magic.h>
 #include <linux/kmemleak.h>
 
 /*
@@ -149,7 +145,6 @@ struct z3fold_header {
  * @compact_wq:	workqueue for page layout background optimization
  * @release_wq:	workqueue for safe page release
  * @work:	work_struct for safe page release
- * @inode:	inode for z3fold pseudo filesystem
  *
  * This structure is allocated at pool creation time and maintains metadata
  * pertaining to a particular z3fold pool.
@@ -169,7 +164,6 @@ struct z3fold_pool {
 	struct workqueue_struct *compact_wq;
 	struct workqueue_struct *release_wq;
 	struct work_struct work;
-	struct inode *inode;
 };
 
 /*
@@ -334,54 +328,6 @@ static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 	}
 }
 
-static int z3fold_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, Z3FOLD_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type z3fold_fs = {
-	.name		= "z3fold",
-	.init_fs_context = z3fold_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
-static struct vfsmount *z3fold_mnt;
-static int __init z3fold_mount(void)
-{
-	int ret = 0;
-
-	z3fold_mnt = kern_mount(&z3fold_fs);
-	if (IS_ERR(z3fold_mnt))
-		ret = PTR_ERR(z3fold_mnt);
-
-	return ret;
-}
-
-static void z3fold_unmount(void)
-{
-	kern_unmount(z3fold_mnt);
-}
-
-static const struct address_space_operations z3fold_aops;
-static int z3fold_register_migration(struct z3fold_pool *pool)
-{
-	pool->inode = alloc_anon_inode(z3fold_mnt->mnt_sb);
-	if (IS_ERR(pool->inode)) {
-		pool->inode = NULL;
-		return 1;
-	}
-
-	pool->inode->i_mapping->private_data = pool;
-	pool->inode->i_mapping->a_ops = &z3fold_aops;
-	return 0;
-}
-
-static void z3fold_unregister_migration(struct z3fold_pool *pool)
-{
-	if (pool->inode)
-		iput(pool->inode);
-}
-
 /* Initializes the z3fold header of a newly allocated z3fold page */
 static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 					struct z3fold_pool *pool, gfp_t gfp)
@@ -1002,14 +948,10 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 	pool->release_wq = create_singlethread_workqueue(pool->name);
 	if (!pool->release_wq)
 		goto out_wq;
-	if (z3fold_register_migration(pool))
-		goto out_rwq;
 	INIT_WORK(&pool->work, free_pages_work);
 	pool->ops = ops;
 	return pool;
 
-out_rwq:
-	destroy_workqueue(pool->release_wq);
 out_wq:
 	destroy_workqueue(pool->compact_wq);
 out_unbuddied:
@@ -1043,11 +985,12 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
 
 	destroy_workqueue(pool->compact_wq);
 	destroy_workqueue(pool->release_wq);
-	z3fold_unregister_migration(pool);
 	free_percpu(pool->unbuddied);
 	kfree(pool);
 }
 
+static const struct movable_operations z3fold_mops;
+
 /**
  * z3fold_alloc() - allocates a region of a given size
  * @pool:	z3fold pool from which to allocate
@@ -1117,11 +1060,11 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 	}
 	if (can_sleep) {
 		lock_page(page);
-		__SetPageMovable(page, pool->inode->i_mapping);
+		__SetPageMovable(page, &z3fold_mops);
 		unlock_page(page);
 	} else {
 		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, pool->inode->i_mapping);
+		__SetPageMovable(page, &z3fold_mops);
 		unlock_page(page);
 	}
 	z3fold_page_lock(zhdr);
@@ -1554,8 +1497,8 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	return false;
 }
 
-static int z3fold_page_migrate(struct address_space *mapping, struct page *newpage,
-			       struct page *page, enum migrate_mode mode)
+static int z3fold_page_migrate(struct page *newpage, struct page *page,
+		enum migrate_mode mode)
 {
 	struct z3fold_header *zhdr, *new_zhdr;
 	struct z3fold_pool *pool;
@@ -1608,7 +1551,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	spin_lock(&pool->lock);
 	list_add(&newpage->lru, &pool->lru);
 	spin_unlock(&pool->lock);
-	__SetPageMovable(newpage, new_mapping);
+	__SetPageMovable(newpage, &z3fold_mops);
 	z3fold_page_unlock(new_zhdr);
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
@@ -1642,9 +1585,9 @@ static void z3fold_page_putback(struct page *page)
 	z3fold_page_unlock(zhdr);
 }
 
-static const struct address_space_operations z3fold_aops = {
+static const struct movable_operations z3fold_mops = {
 	.isolate_page = z3fold_page_isolate,
-	.migratepage = z3fold_page_migrate,
+	.migrate_page = z3fold_page_migrate,
 	.putback_page = z3fold_page_putback,
 };
 
@@ -1746,17 +1689,11 @@ MODULE_ALIAS("zpool-z3fold");
 
 static int __init init_z3fold(void)
 {
-	int ret;
-
 	/*
 	 * Make sure the z3fold header is not larger than the page size and
 	 * there has remaining spaces for its buddy.
 	 */
 	BUILD_BUG_ON(ZHDR_SIZE_ALIGNED > PAGE_SIZE - CHUNK_SIZE);
-	ret = z3fold_mount();
-	if (ret)
-		return ret;
-
 	zpool_register_driver(&z3fold_zpool_driver);
 
 	return 0;
@@ -1764,7 +1701,6 @@ static int __init init_z3fold(void)
 
 static void __exit exit_z3fold(void)
 {
-	z3fold_unmount();
 	zpool_unregister_driver(&z3fold_zpool_driver);
 }
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d5fc04385b8..71d6edcbea48 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -41,7 +41,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/magic.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/highmem.h>
@@ -59,8 +58,6 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/zpool.h>
-#include <linux/mount.h>
-#include <linux/pseudo_fs.h>
 #include <linux/migrate.h>
 #include <linux/wait.h>
 #include <linux/pagemap.h>
@@ -177,10 +174,6 @@ struct zs_size_stat {
 static struct dentry *zs_stat_root;
 #endif
 
-#ifdef CONFIG_COMPACTION
-static struct vfsmount *zsmalloc_mnt;
-#endif
-
 /*
  * We assign a page to ZS_ALMOST_EMPTY fullness group when:
  *	n <= N / f, where
@@ -252,7 +245,6 @@ struct zs_pool {
 	struct dentry *stat_dentry;
 #endif
 #ifdef CONFIG_COMPACTION
-	struct inode *inode;
 	struct work_struct free_work;
 #endif
 	/* protect page/zspage migration */
@@ -271,6 +263,7 @@ struct zspage {
 	unsigned int freeobj;
 	struct page *first_page;
 	struct list_head list; /* fullness list */
+	struct zs_pool *pool;
 #ifdef CONFIG_COMPACTION
 	rwlock_t lock;
 #endif
@@ -295,8 +288,6 @@ static bool ZsHugePage(struct zspage *zspage)
 }
 
 #ifdef CONFIG_COMPACTION
-static int zs_register_migration(struct zs_pool *pool);
-static void zs_unregister_migration(struct zs_pool *pool);
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
@@ -307,10 +298,6 @@ static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static int zsmalloc_mount(void) { return 0; }
-static void zsmalloc_unmount(void) {}
-static int zs_register_migration(struct zs_pool *pool) { return 0; }
-static void zs_unregister_migration(struct zs_pool *pool) {}
 static void migrate_lock_init(struct zspage *zspage) {}
 static void migrate_read_lock(struct zspage *zspage) {}
 static void migrate_read_unlock(struct zspage *zspage) {}
@@ -1083,6 +1070,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 
 	create_page_chain(class, zspage, pages);
 	init_zspage(class, zspage);
+	zspage->pool = pool;
 
 	return zspage;
 }
@@ -1754,33 +1742,6 @@ static void lock_zspage(struct zspage *zspage)
 	migrate_read_unlock(zspage);
 }
 
-static int zs_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, ZSMALLOC_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type zsmalloc_fs = {
-	.name		= "zsmalloc",
-	.init_fs_context = zs_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
-static int zsmalloc_mount(void)
-{
-	int ret = 0;
-
-	zsmalloc_mnt = kern_mount(&zsmalloc_fs);
-	if (IS_ERR(zsmalloc_mnt))
-		ret = PTR_ERR(zsmalloc_mnt);
-
-	return ret;
-}
-
-static void zsmalloc_unmount(void)
-{
-	kern_unmount(zsmalloc_mnt);
-}
-
 static void migrate_lock_init(struct zspage *zspage)
 {
 	rwlock_init(&zspage->lock);
@@ -1823,6 +1784,8 @@ static void dec_zspage_isolation(struct zspage *zspage)
 	zspage->isolated--;
 }
 
+static const struct movable_operations zsmalloc_mops;
+
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -1843,7 +1806,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	set_first_obj_offset(newpage, get_first_obj_offset(oldpage));
 	if (unlikely(ZsHugePage(zspage)))
 		newpage->index = oldpage->index;
-	__SetPageMovable(newpage, page_mapping(oldpage));
+	__SetPageMovable(newpage, &zsmalloc_mops);
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
@@ -1865,8 +1828,8 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
-		struct page *page, enum migrate_mode mode)
+static int zs_page_migrate(struct page *newpage, struct page *page,
+		enum migrate_mode mode)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
@@ -1889,14 +1852,15 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
-	pool = mapping->private_data;
+	/* The page is locked, so this pointer must remain valid */
+	zspage = get_zspage(page);
+	pool = zspage->pool;
 
 	/*
 	 * The pool migrate_lock protects the race between zpage migration
 	 * and zs_free.
 	 */
 	write_lock(&pool->migrate_lock);
-	zspage = get_zspage(page);
 	class = zspage_class(pool, zspage);
 
 	/*
@@ -1964,31 +1928,12 @@ static void zs_page_putback(struct page *page)
 	migrate_write_unlock(zspage);
 }
 
-static const struct address_space_operations zsmalloc_aops = {
+static const struct movable_operations zsmalloc_mops = {
 	.isolate_page = zs_page_isolate,
-	.migratepage = zs_page_migrate,
+	.migrate_page = zs_page_migrate,
 	.putback_page = zs_page_putback,
 };
 
-static int zs_register_migration(struct zs_pool *pool)
-{
-	pool->inode = alloc_anon_inode(zsmalloc_mnt->mnt_sb);
-	if (IS_ERR(pool->inode)) {
-		pool->inode = NULL;
-		return 1;
-	}
-
-	pool->inode->i_mapping->private_data = pool;
-	pool->inode->i_mapping->a_ops = &zsmalloc_aops;
-	return 0;
-}
-
-static void zs_unregister_migration(struct zs_pool *pool)
-{
-	flush_work(&pool->free_work);
-	iput(pool->inode);
-}
-
 /*
  * Caller should hold page_lock of all pages in the zspage
  * In here, we cannot use zspage meta data.
@@ -2032,6 +1977,11 @@ static void kick_deferred_free(struct zs_pool *pool)
 	schedule_work(&pool->free_work);
 }
 
+static void zs_flush_migration(struct zs_pool *pool)
+{
+	flush_work(&pool->free_work);
+}
+
 static void init_deferred_free(struct zs_pool *pool)
 {
 	INIT_WORK(&pool->free_work, async_free_zspage);
@@ -2043,10 +1993,12 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 
 	do {
 		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, pool->inode->i_mapping);
+		__SetPageMovable(page, &zsmalloc_mops);
 		unlock_page(page);
 	} while ((page = get_next_page(page)) != NULL);
 }
+#else
+static inline void zs_flush_migration(struct zs_pool *pool) { }
 #endif
 
 /*
@@ -2324,9 +2276,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	/* debug only, don't abort if it fails */
 	zs_pool_stat_create(pool, name);
 
-	if (zs_register_migration(pool))
-		goto err;
-
 	/*
 	 * Not critical since shrinker is only used to trigger internal
 	 * defragmentation of the pool which is pretty optional thing.  If
@@ -2348,7 +2297,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 	int i;
 
 	zs_unregister_shrinker(pool);
-	zs_unregister_migration(pool);
+	zs_flush_migration(pool);
 	zs_pool_stat_destroy(pool);
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
@@ -2380,14 +2329,10 @@ static int __init zs_init(void)
 {
 	int ret;
 
-	ret = zsmalloc_mount();
-	if (ret)
-		goto out;
-
 	ret = cpuhp_setup_state(CPUHP_MM_ZS_PREPARE, "mm/zsmalloc:prepare",
 				zs_cpu_prepare, zs_cpu_dead);
 	if (ret)
-		goto hp_setup_fail;
+		goto out;
 
 #ifdef CONFIG_ZPOOL
 	zpool_register_driver(&zs_zpool_driver);
@@ -2397,8 +2342,6 @@ static int __init zs_init(void)
 
 	return 0;
 
-hp_setup_fail:
-	zsmalloc_unmount();
 out:
 	return ret;
 }
@@ -2408,7 +2351,6 @@ static void __exit zs_exit(void)
 #ifdef CONFIG_ZPOOL
 	zpool_unregister_driver(&zs_zpool_driver);
 #endif
-	zsmalloc_unmount();
 	cpuhp_remove_state(CPUHP_MM_ZS_PREPARE);
 
 	zs_stat_exit();
-- 
2.35.1

