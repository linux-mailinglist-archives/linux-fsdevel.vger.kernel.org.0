Return-Path: <linux-fsdevel+bounces-35355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7133A9D41F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308D3282113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E711C57A0;
	Wed, 20 Nov 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dC8dt5H+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F41BC097;
	Wed, 20 Nov 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126367; cv=none; b=kw6Lpx/6uoi+4GknPqb5orCUQsftgW52W7WhFkQxHMmRWXM5jcXEeXETvLGwoaEqjKJ+qzw55DSO+H+ors3D/NiJysz3joxIqYOczDzIB9wpZUDgMO2CqjP198OZI+2En7DqJwtyPB/eZPwkuUvge51KexTxUCNJHP9n1mCZxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126367; c=relaxed/simple;
	bh=kEKpxw3CotOQ7wils62B18/WUj4g9whxm2Eiu4thJiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W1aKo46WEqo3nUTmw6FtMqEUHQf68tYbLsAavbNekp+0XW+rCxR8A+1Lg4Cnc36OiFIK5N21SV/NxVD32394U+AESV+z9tWZ90OI8iqICxqBUb966R3A2pRwmqXnCjnS/sCXCZXfg46Puk4ywdL2poPWqVYleGqWSu/lIttPZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dC8dt5H+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FKSB027803;
	Wed, 20 Nov 2024 18:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dYnrEPxKLE6MQr5D9RuLPD8bN+zm4F0byAPTSCQkhxE=; b=dC8dt5H+cQHviopv
	RhJHEKycrBke9RtwRutNt+CJatrFvCW635dZrktM3ayWSuclMNy/Njyu16vyfX32
	XYyozQRbWwoOVidRJ2J+3fI/sfOn6bt6aWqCwT7WC3OlBqSRwwtEahmsd+1Syq+D
	0b+0h8fRSUSUOCrwVFEbU/KMRSeXVKx4n5iEk0HzZiEH12cy0mBP2MOxpZ0JsX1b
	GM9SzXNtGJhytrlQfDHpjSb9V1Tb8RDFJgc46v1Qv+mBdD+GoNVPQwIrWq6U7gnP
	Gx19NWqQR8J1N7oyIWGgXBcgyg0ceHpU44ayH1F10U0juXiGisfFAL28XlsskLjc
	komeAA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431bv79kf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 18:12:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKICEj0001256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 18:12:14 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 10:12:14 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Wed, 20 Nov 2024 10:12:07 -0800
Subject: [PATCH v4 1/2] filemap: Pass address_space mapping to
 ->free_folio()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241120-guestmem-library-v4-1-0c597f733909@quicinc.com>
References: <20241120-guestmem-library-v4-0-0c597f733909@quicinc.com>
In-Reply-To: <20241120-guestmem-library-v4-0-0c597f733909@quicinc.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        "Fuad
 Tabba" <tabba@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        "Mike
 Rapoport" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter
 Anvin" <hpa@zytor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
        "Anna
 Schumaker" <anna@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        "Martin
 Brandenburg" <martin@omnibond.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: James Gowans <jgowans@amazon.com>, Mike Day <michael.day@amd.com>,
        <linux-fsdevel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <devel@lists.orangefs.org>, <linux-arm-kernel@lists.infradead.org>,
        "Elliot
 Berman" <quic_eberman@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zmCUsCF2OCF2qjnIgQvaT7lUbSu7ZtJ7
X-Proofpoint-GUID: zmCUsCF2OCF2qjnIgQvaT7lUbSu7ZtJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200125

When guest_memfd becomes a library, a callback will need to be made to
the owner (KVM SEV) to update the RMP entry for the page back to shared
state. This is currently being done as part of .free_folio() operation,
but this callback shouldn't assume that folio->mapping is set/valid.

The mapping is well-known to callers of .free_folio(), so pass that
mapping so the callback can access the mapping's private data.

Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@redhat.com/
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/filesystems/locking.rst |  2 +-
 fs/nfs/dir.c                          | 11 ++++++-----
 fs/orangefs/inode.c                   |  3 ++-
 include/linux/fs.h                    |  2 +-
 mm/filemap.c                          |  9 +++++----
 mm/secretmem.c                        |  3 ++-
 mm/vmscan.c                           |  4 ++--
 virt/kvm/guest_memfd.c                |  3 ++-
 8 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index f5e3676db954b5bce4c23a0bf723a79d66181fcd..f1a20ad5edbee70c1a3c8d8a9bfc0f008a68985b 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -258,7 +258,7 @@ prototypes::
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
-	void (*free_folio)(struct folio *);
+	void (*free_folio)(struct address_space *, struct folio *);
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 492cffd9d3d845723b5f3d0eea3874b1f1773fe1..54e7069013ef2a63db24491fa65059e5ad68057a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -55,7 +55,7 @@ static int nfs_closedir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
-static void nfs_readdir_clear_array(struct folio *);
+static void nfs_readdir_clear_array(struct address_space *, struct folio *);
 static int nfs_do_create(struct inode *dir, struct dentry *dentry,
 			 umode_t mode, int open_flags);
 
@@ -218,7 +218,8 @@ static void nfs_readdir_folio_init_array(struct folio *folio, u64 last_cookie,
 /*
  * we are freeing strings created by nfs_add_to_readdir_array()
  */
-static void nfs_readdir_clear_array(struct folio *folio)
+static void nfs_readdir_clear_array(struct address_space *mapping,
+				    struct folio *folio)
 {
 	struct nfs_cache_array *array;
 	unsigned int i;
@@ -233,7 +234,7 @@ static void nfs_readdir_clear_array(struct folio *folio)
 static void nfs_readdir_folio_reinit_array(struct folio *folio, u64 last_cookie,
 					   u64 change_attr)
 {
-	nfs_readdir_clear_array(folio);
+	nfs_readdir_clear_array(folio->mapping, folio);
 	nfs_readdir_folio_init_array(folio, last_cookie, change_attr);
 }
 
@@ -249,7 +250,7 @@ nfs_readdir_folio_array_alloc(u64 last_cookie, gfp_t gfp_flags)
 static void nfs_readdir_folio_array_free(struct folio *folio)
 {
 	if (folio) {
-		nfs_readdir_clear_array(folio);
+		nfs_readdir_clear_array(folio->mapping, folio);
 		folio_put(folio);
 	}
 }
@@ -391,7 +392,7 @@ static void nfs_readdir_folio_init_and_validate(struct folio *folio, u64 cookie,
 	if (folio_test_uptodate(folio)) {
 		if (nfs_readdir_folio_validate(folio, cookie, change_attr))
 			return;
-		nfs_readdir_clear_array(folio);
+		nfs_readdir_clear_array(folio->mapping, folio);
 	}
 	nfs_readdir_folio_init_array(folio, cookie, change_attr);
 	folio_mark_uptodate(folio);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aae6d2b8767df04714647db5fe1e5ce54c092fce..2d554102ba9ac83acd2b637d4568090717e87f94 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -470,7 +470,8 @@ static bool orangefs_release_folio(struct folio *folio, gfp_t foo)
 	return !folio_test_private(folio);
 }
 
-static void orangefs_free_folio(struct folio *folio)
+static void orangefs_free_folio(struct address_space *mapping,
+				struct folio *folio)
 {
 	kfree(folio_detach_private(folio));
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337650d562405500013f5c4cfed8eb6..6e5b5cc99750a685b217cb8273c38e7f6bf5ae86 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -417,7 +417,7 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
-	void (*free_folio)(struct folio *folio);
+	void (*free_folio)(struct address_space *, struct folio *folio);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
 	 * migrate the contents of a folio to the specified target. If
diff --git a/mm/filemap.c b/mm/filemap.c
index 36d22968be9a1e10da42927dd627d3f22c3a747b..2c8d92dd9d5dd433acbf1b87156eb2e68337332d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -235,12 +235,12 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 
 void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
-	void (*free_folio)(struct folio *);
+	void (*free_folio)(struct address_space *, struct folio *);
 	int refs = 1;
 
 	free_folio = mapping->a_ops->free_folio;
 	if (free_folio)
-		free_folio(folio);
+		free_folio(mapping, folio);
 
 	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
@@ -814,7 +814,8 @@ EXPORT_SYMBOL(file_write_and_wait_range);
 void replace_page_cache_folio(struct folio *old, struct folio *new)
 {
 	struct address_space *mapping = old->mapping;
-	void (*free_folio)(struct folio *) = mapping->a_ops->free_folio;
+	void (*free_folio)(struct address_space *, struct folio *) =
+		mapping->a_ops->free_folio;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
 
@@ -843,7 +844,7 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 		__lruvec_stat_add_folio(new, NR_SHMEM);
 	xas_unlock_irq(&xas);
 	if (free_folio)
-		free_folio(old);
+		free_folio(mapping, old);
 	folio_put(old);
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_folio);
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3afb5ad701e14ad87b6e5173b2974f1309399b8e..8643d073b8f3554a18d419353fa604864de224c1 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -152,7 +152,8 @@ static int secretmem_migrate_folio(struct address_space *mapping,
 	return -EBUSY;
 }
 
-static void secretmem_free_folio(struct folio *folio)
+static void secretmem_free_folio(struct address_space *mapping,
+				 struct folio *folio)
 {
 	set_direct_map_default_noflush(&folio->page);
 	folio_zero_segment(folio, 0, folio_size(folio));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c745944cd455ae9c5a4c373f631341d..419dc63de05095be298fee724891f0665a397a7b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -765,7 +765,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_folio(folio, swap);
 	} else {
-		void (*free_folio)(struct folio *);
+		void (*free_folio)(struct address_space *, struct folio *);
 
 		free_folio = mapping->a_ops->free_folio;
 		/*
@@ -794,7 +794,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		spin_unlock(&mapping->host->i_lock);
 
 		if (free_folio)
-			free_folio(folio);
+			free_folio(mapping, folio);
 	}
 
 	return 1;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 47a9f68f7b247f4cba0c958b4c7cd9458e7c46b4..24dcbad0cb76e353509cf4718837a1999f093414 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -358,7 +358,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-static void kvm_gmem_free_folio(struct folio *folio)
+static void kvm_gmem_free_folio(struct address_space *mapping,
+				struct folio *folio)
 {
 	struct page *page = folio_page(folio, 0);
 	kvm_pfn_t pfn = page_to_pfn(page);

-- 
2.34.1


