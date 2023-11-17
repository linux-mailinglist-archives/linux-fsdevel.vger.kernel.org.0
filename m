Return-Path: <linux-fsdevel+bounces-3043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E327EF6F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 18:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4ADB20C0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6003DBBA;
	Fri, 17 Nov 2023 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NHngODWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA83454C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 17:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F0C433C7;
	Fri, 17 Nov 2023 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700242114;
	bh=9GTttPvpLmxTe5osuXFN+EKu1R3OgSkqy8Tv2xm07Tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NHngODWbTtFclnznau5Z9PoISw7ECpkzVA9h/wXor3rYZGvpCUalajgqVpugGQ0NY
	 WDC/gvkCcTrHmEQWVYImd2w0J90/73K/ISSPHjaKDuoGZIfo8odG5p6c6V4DK5UMiV
	 K+Q70qqf2KpXVWcxMpNMsr7AfyfxcTJ/hGnh516U=
Date: Fri, 17 Nov 2023 09:28:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Paolo Bonzini
 <pbonzini@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 6/6] fs: Convert error_remove_page to error_remove_folio
Message-Id: <20231117092833.f143fa4bbf0abfbd2e58661d@linux-foundation.org>
In-Reply-To: <20231117161447.2461643-7-willy@infradead.org>
References: <20231117161447.2461643-1-willy@infradead.org>
	<20231117161447.2461643-7-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 16:14:47 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> There were already assertions that we were not passing a tail page
> to error_remove_page(), so make the compiler enforce that by converting
> everything to pass and use a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/locking.rst |  4 ++--
>  Documentation/filesystems/vfs.rst     |  6 +++---
>  block/fops.c                          |  2 +-
>  fs/afs/write.c                        |  2 +-
>  fs/bcachefs/fs.c                      |  2 +-
>  fs/btrfs/inode.c                      |  2 +-
>  fs/ceph/addr.c                        |  4 ++--
>  fs/ext2/inode.c                       |  2 +-
>  fs/ext4/inode.c                       |  6 +++---
>  fs/f2fs/compress.c                    |  2 +-
>  fs/f2fs/inode.c                       |  2 +-
>  fs/gfs2/aops.c                        |  4 ++--
>  fs/hugetlbfs/inode.c                  |  6 +++---
>  fs/nfs/file.c                         |  2 +-
>  fs/ntfs/aops.c                        |  6 +++---
>  fs/ocfs2/aops.c                       |  2 +-
>  fs/xfs/xfs_aops.c                     |  2 +-
>  fs/zonefs/file.c                      |  2 +-
>  include/linux/fs.h                    |  2 +-
>  include/linux/mm.h                    |  3 ++-
>  mm/memory-failure.c                   | 10 +++++-----
>  mm/shmem.c                            |  6 +++---
>  mm/truncate.c                         |  9 ++++-----
>  virt/kvm/guest_memfd.c                |  9 +++++----

virt/kvm/guest_memfd.c exists only in the KVM tree (and hence
linux-next).  So I assume Stephen will use the change from this patch
when doing his resolution.

This:

--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -267,7 +267,8 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
 	return -EINVAL;
 }
 
-static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
+static int kvm_gmem_error_folio(struct address_space *mapping,
+		struct folio *folio)
 {
 	struct list_head *gmem_list = &mapping->private_list;
 	struct kvm_gmem *gmem;
@@ -275,8 +276,8 @@ static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
 
 	filemap_invalidate_lock_shared(mapping);
 
-	start = page->index;
-	end = start + thp_nr_pages(page);
+	start = folio->index;
+	end = start + folio_nr_pages(folio);
 
 	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_begin(gmem, start, end);
@@ -303,7 +304,7 @@ static const struct address_space_operations kvm_gmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= kvm_gmem_migrate_folio,
 #endif
-	.error_remove_page = kvm_gmem_error_page,
+	.error_remove_folio = kvm_gmem_error_folio,
 };
 
 static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
-- 
2.42.0

