Return-Path: <linux-fsdevel+bounces-57369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283AB20C61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFD423358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0C32DEA94;
	Mon, 11 Aug 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwgUFcdV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663E2561A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923203; cv=none; b=ZQ2yPE0Lgr5DwKZwm+WmfHfpcPvQDCoy3g0HhCdxG8fAPV1PPouAuMUn7RzSTWw/H3uU/6adGckIMn9dTkQiQt0f9UqetCAS4f6RAO4L8AlQf9fKOZQTa7yVgeVJaop3d7XFKmk2kViDFgmaYN4e/VLSV0SaGjybPR0zNU2eqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923203; c=relaxed/simple;
	bh=8WrMXaATum1+Vfy/MIWeS3UGke6MZg9bbi0gb3hBSoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3f/f7ycCWMq/QZVdrzSnYzEZPELXawfQS1ker3H+4YUU2GavTetXRKm3sF/G/7pd81N2mC7DzAt/10tH3tAUGYA8ZNsgrMOLfqQ2nb0pf9BE+adCuNyM+xoVk+AipfkcE0TTCz7UQOPKEqIQQSDp7isQ3pU7+QWYT3d7+9/U58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwgUFcdV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9pQ6cfOAd6CYMjiXktr++2RllUSiQ1vZU8nA2VfkG0=;
	b=BwgUFcdVKYsFvunt+j9LnKFkospVeU1/ngiurJTDW+2AEXN+Qvzv9/VhlFxWLYtospohIL
	XZWasxQZFDhjMfCfFx2PoBAlwi/zflz0lWub+TEENeMPD8mjmJ9Wfzw8I41I3eCuMh7TaX
	3YM8kP9iB0iGI6+DCXMWrSMX35NRFxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4jSg_XCPOL2iqsSqRXNV0g-1; Mon, 11 Aug 2025 10:39:58 -0400
X-MC-Unique: 4jSg_XCPOL2iqsSqRXNV0g-1
X-Mimecast-MFC-AGG-ID: 4jSg_XCPOL2iqsSqRXNV0g_1754923198
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so23342215e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 07:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923197; x=1755527997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9pQ6cfOAd6CYMjiXktr++2RllUSiQ1vZU8nA2VfkG0=;
        b=uq/C8Hrv0QNY+R+xdgDhaPwejffEpYpB02+Ke8m3qMkCJ3KvI+Wx7I+l6P0D8T3CG3
         46xl11KPdtNX+t0y+JWI6IJyWDwjz5qZll6A/uw7ocliFo5zjv+dRpXCiJUlG/Schnn0
         qtrF8VDpOlQzy58y67kl522Nfth3ecD+sX/mOwfd3aLLkOIG3a7kB7Wmxamoe1RQjhVS
         49ypeP88EG0Ngck3w0XcFRKEFFUPmiqHpzHX5rZLEm79Yk4x3EqVQTT7YL0dSjiConD2
         kMLTM0QC4gMzjG9h181Vns61TtiCtmEOVLIL9RYN7QJjo+Ph1dEfvOF6L+5uFv8O6MI7
         laEg==
X-Forwarded-Encrypted: i=1; AJvYcCU02IgsVOlp52PfdoKwalb76lr87/46NmHDrXCOoqfldd8EoU8pKiFjHDGIBn/2xIatCGAvSp+1Q0RiDxFB@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvmRSv0caVnDliKP4uiH0SaUNVvz0tHsQdjAaJExvAxOsKDF4
	txudZm5gsyB3uMCmX4PXFA/OzyGrxY1j4Kte31TBRbgRM7sT9f0rDc9rVsuABQxWIt7sgf2DZG4
	3HXd5DT2FNyDn/uSujmohDr/P1CVQuvj2i0aLGtkfAqT0OqFs2tKqGDjgIE143XRhVEM=
X-Gm-Gg: ASbGncuUmRzjYC18i6wLIyiRFxV6dDctynlvLaEdlohsfpJY3shGQ3KEWXKduaTLXEa
	36yywsPWlALAdNdgGBluOSt5OzhTtIzQTWrIsCVFSu2HodIlw05J6H47XzYAZx12c5dNca83Ms5
	TkHLkcPXhBhy+byLdPLLzcLbFHltsrAU3d82MSQkiSC92EHNAZC1D4CEZy+T9dI/pI2yoWCg8S/
	EMINjZiYZKcW5zoncB1HaLyhQ8R/6iORYOEbt5teUARjJaAuZQTTUSDf9W4fUBvZSh5Fah0h35c
	96YFpikiTzZL1AYMkLK8OaMhDbOjbnvPbBOafypwrwxZC3R15pId/ti0X8sVTbaqbVrvki1XRy5
	R18KTTf0W1rKO7wQlaknImWSy
X-Received: by 2002:a05:600c:190c:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-459f4f5292fmr128225485e9.10.1754923197498;
        Mon, 11 Aug 2025 07:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeJPd1Ge6IawGRqjGvoUIijF7grEq/r+WrWgIGNnqFvFWWeyhF+SV2vqhPS2/Wm5uHjhsRGA==
X-Received: by 2002:a05:600c:190c:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-459f4f5292fmr128224855e9.10.1754923196896;
        Mon, 11 Aug 2025 07:39:56 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e5868fd7sm275562255e9.18.2025.08.11.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:39:56 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Kleikamp <shaggy@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Date: Mon, 11 Aug 2025 16:39:48 +0200
Message-ID: <20250811143949.1117439-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811143949.1117439-1-david@redhat.com>
References: <20250811143949.1117439-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
return value that the code uses and expects.

Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
for success.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c |  2 +-
 drivers/misc/vmw_balloon.c           |  4 +--
 drivers/virtio/virtio_balloon.c      |  2 +-
 fs/aio.c                             |  2 +-
 fs/btrfs/inode.c                     |  4 +--
 fs/hugetlbfs/inode.c                 |  4 +--
 fs/jfs/jfs_metapage.c                |  8 +++---
 include/linux/migrate.h              | 10 +------
 mm/migrate.c                         | 40 +++++++++++++---------------
 mm/migrate_device.c                  |  2 +-
 mm/zsmalloc.c                        |  4 +--
 11 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 5e0a718d1be7b..0823fa2da1516 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -545,7 +545,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 	/* balloon page list reference */
 	put_page(page);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 static void cmm_balloon_compaction_init(void)
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 6653fc53c951c..6df51ee8db621 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1806,7 +1806,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		 * the list after acquiring the lock.
 		 */
 		get_page(newpage);
-		ret = MIGRATEPAGE_SUCCESS;
+		ret = 0;
 	}
 
 	/* Update the balloon list under the @pages_lock */
@@ -1817,7 +1817,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	 * If we succeed just insert it to the list and update the statistics
 	 * under the lock.
 	 */
-	if (ret == MIGRATEPAGE_SUCCESS) {
+	if (!ret) {
 		balloon_page_insert(&b->b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
 	}
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e299e18346a30..eae65136cdfb5 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -875,7 +875,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	balloon_page_finalize(page);
 	put_page(page); /* balloon reference */
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #endif /* CONFIG_BALLOON_COMPACTION */
 
diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312c..059e03cfa088c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -445,7 +445,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	folio_get(dst);
 
 	rc = folio_migrate_mapping(mapping, dst, src, 1);
-	if (rc != MIGRATEPAGE_SUCCESS) {
+	if (rc) {
 		folio_put(dst);
 		goto out_unlock;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b77dd22b8cdbe..1d64fee6f59e6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7411,7 +7411,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
 {
 	int ret = filemap_migrate_folio(mapping, dst, src, mode);
 
-	if (ret != MIGRATEPAGE_SUCCESS)
+	if (ret)
 		return ret;
 
 	if (folio_test_ordered(src)) {
@@ -7419,7 +7419,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
 		folio_set_ordered(dst);
 	}
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #else
 #define btrfs_migrate_folio NULL
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 09d4baef29cf9..34d496a2b7de6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1052,7 +1052,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 	int rc;
 
 	rc = migrate_huge_page_move_mapping(mapping, dst, src);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	if (hugetlb_folio_subpool(src)) {
@@ -1063,7 +1063,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 
 	folio_migrate_flags(dst, src);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #else
 #define hugetlbfs_migrate_folio NULL
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index b98cf3bb6c1fe..871cf4fb36366 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -169,7 +169,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 	}
 
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	for (i = 0; i < MPS_PER_PAGE; i++) {
@@ -199,7 +199,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 		}
 	}
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #endif	/* CONFIG_MIGRATION */
 
@@ -242,7 +242,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 		return -EAGAIN;
 
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	if (unlikely(insert_metapage(dst, mp)))
@@ -253,7 +253,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 	mp->folio = dst;
 	remove_metapage(src, mp);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #endif	/* CONFIG_MIGRATION */
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 40f2b5a37efbb..02f11704fb686 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -12,13 +12,6 @@ typedef void free_folio_t(struct folio *folio, unsigned long private);
 
 struct migration_target_control;
 
-/*
- * Return values from addresss_space_operations.migratepage():
- * - negative errno on page migration failure;
- * - zero on page migration success;
- */
-#define MIGRATEPAGE_SUCCESS		0
-
 /**
  * struct movable_operations - Driver page migration
  * @isolate_page:
@@ -34,8 +27,7 @@ struct migration_target_control;
  * @src page.  The driver should copy the contents of the
  * @src page to the @dst page and set up the fields of @dst page.
  * Both pages are locked.
- * If page migration is successful, the driver should
- * return MIGRATEPAGE_SUCCESS.
+ * If page migration is successful, the driver should return 0.
  * If the driver cannot migrate the page at the moment, it can return
  * -EAGAIN.  The VM interprets this as a temporary migration failure and
  * will retry it later.  Any other error value is a permanent migration
diff --git a/mm/migrate.c b/mm/migrate.c
index e9dacf1028dc7..2db4974178e6a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -209,18 +209,17 @@ static void putback_movable_ops_page(struct page *page)
  * src and dst are also released by migration core. These pages will not be
  * folios in the future, so that must be reworked.
  *
- * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
- * code.
+ * Returns 0 on success, otherwise a negative error code.
  */
 static int migrate_movable_ops_page(struct page *dst, struct page *src,
 		enum migrate_mode mode)
 {
-	int rc = MIGRATEPAGE_SUCCESS;
+	int rc;
 
 	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
 	VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(src), src);
 	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
-	if (rc == MIGRATEPAGE_SUCCESS)
+	if (!rc)
 		ClearPageMovableOpsIsolated(src);
 	return rc;
 }
@@ -565,7 +564,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
 
-		return MIGRATEPAGE_SUCCESS;
+		return 0;
 	}
 
 	oldzone = folio_zone(folio);
@@ -666,7 +665,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	}
 	local_irq_enable();
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 int folio_migrate_mapping(struct address_space *mapping,
@@ -715,7 +714,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 	xas_unlock_irq(&xas);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 /*
@@ -831,14 +830,14 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 		return rc;
 
 	rc = __folio_migrate_mapping(mapping, dst, src, expected_count);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	if (src_private)
 		folio_attach_private(dst, folio_detach_private(src));
 
 	folio_migrate_flags(dst, src);
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 /**
@@ -945,7 +944,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	}
 
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		goto unlock_buffers;
 
 	bh = head;
@@ -1049,7 +1048,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
  *
  * Return value:
  *   < 0 - error code
- *  MIGRATEPAGE_SUCCESS - success
+ *     0 - success
  */
 static int move_to_new_folio(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
@@ -1077,7 +1076,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 	else
 		rc = fallback_migrate_folio(mapping, dst, src, mode);
 
-	if (rc == MIGRATEPAGE_SUCCESS) {
+	if (!rc) {
 		/*
 		 * For pagecache folios, src->mapping must be cleared before src
 		 * is freed. Anonymous folios must stay anonymous until freed.
@@ -1427,7 +1426,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
 		folio_putback_hugetlb(src);
-		return MIGRATEPAGE_SUCCESS;
+		return 0;
 	}
 
 	dst = get_new_folio(src, private);
@@ -1490,8 +1489,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 		rc = move_to_new_folio(dst, src, mode);
 
 	if (page_was_mapped)
-		remove_migration_ptes(src,
-			rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
+		remove_migration_ptes(src, !rc ? dst : src, 0);
 
 unlock_put_anon:
 	folio_unlock(dst);
@@ -1500,7 +1498,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 
-	if (rc == MIGRATEPAGE_SUCCESS) {
+	if (!rc) {
 		move_hugetlb_state(src, dst, reason);
 		put_new_folio = NULL;
 	}
@@ -1508,7 +1506,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 out_unlock:
 	folio_unlock(src);
 out:
-	if (rc == MIGRATEPAGE_SUCCESS)
+	if (!rc)
 		folio_putback_hugetlb(src);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
@@ -1618,7 +1616,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 						      reason, ret_folios);
 			/*
 			 * The rules are:
-			 *	Success: hugetlb folio will be put back
+			 *	0: hugetlb folio will be put back
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	Other errno: put on ret_folios list
@@ -1635,7 +1633,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 				retry++;
 				nr_retry_pages += nr_pages;
 				break;
-			case MIGRATEPAGE_SUCCESS:
+			case 0:
 				stats->nr_succeeded += nr_pages;
 				break;
 			default:
@@ -1689,7 +1687,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 				reason, ret_folios);
 		/*
 		 * The rules are:
-		 *	Success: folio will be freed
+		 *	0: folio will be freed
 		 *	-EAGAIN: stay on the unmap_folios list
 		 *	Other errno: put on ret_folios list
 		 */
@@ -1699,7 +1697,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 			*thp_retry += is_thp;
 			*nr_retry_pages += nr_pages;
 			break;
-		case MIGRATEPAGE_SUCCESS:
+		case 0:
 			stats->nr_succeeded += nr_pages;
 			stats->nr_thp_succeeded += is_thp;
 			break;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index e05e14d6eacdb..abd9f6850db65 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -778,7 +778,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		if (migrate && migrate->fault_page == page)
 			extra_cnt = 1;
 		r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
-		if (r != MIGRATEPAGE_SUCCESS)
+		if (r)
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 		else
 			folio_migrate_flags(newfolio, folio);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2c5e56a653544..84eb91d47a226 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1746,7 +1746,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * instead.
 	 */
 	if (!zpdesc->zspage)
-		return MIGRATEPAGE_SUCCESS;
+		return 0;
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
@@ -1813,7 +1813,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	reset_zpdesc(zpdesc);
 	zpdesc_put(zpdesc);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 static void zs_page_putback(struct page *page)
-- 
2.50.1


