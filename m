Return-Path: <linux-fsdevel+bounces-69327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF173C76876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CE76A29D86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82982368E12;
	Thu, 20 Nov 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9DmDs0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DF2FB09A
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678035; cv=none; b=dVfUmLDWtSHseV7/dl2ANNNuBoFhvl2H0wMElvnogbAF45YLfoE05aN82Q/XWeo/oJBVP1aMARDiS75MwEFAr5I0wqw3x3pBLMtu/kz+XOAVa1ubQevW6ZKsRWI0UDA88nPDNfKVe/wQzMwMKLG1AfH4A3s3t0rHsFYueQFqM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678035; c=relaxed/simple;
	bh=pnsN1eWNLvBaN626N+uhslNofKWgHfrtxabNK2ZIO0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsMyyUpaqff+zbEvUYIuwLq/0WfWl3zTDYjoCOw0I2+Pz52VqvoA3lt53RRJDeypBe5TPvU8NZOAYC/OsVqrLXjgEykWBhFw1TWxcN2y6mhoupwHYhw4PltgT2YFq3usItoGX6/V3dMFdzT+hLdDeSzWC9NL7iQd9sQWbm1Im9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9DmDs0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28840C4CEF1;
	Thu, 20 Nov 2025 22:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678034;
	bh=pnsN1eWNLvBaN626N+uhslNofKWgHfrtxabNK2ZIO0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A9DmDs0hKFLVZXTdFee1VZUG5iD1oTlmF3AH1dr33EOd+rxNtfm3rblAUaNqSp2TU
	 c6FppBPU+KC7SEPJiv/GaP4B7NzjWPNs5Vis/dj8pjY+gqDve7dAjd9La6C6R8Q2EB
	 pVP/nRYKVCuk+cYyporpaVWeHin92xL8wE0T/rtPHeE6EexcW9Aez6W1bzwaarSt4j
	 amiQau+5rFplTrkhpnY8Ypsr4s1jCtdQU6LGc8TUJmmYdLbEzqW+/LtmLAI8OjiKn/
	 Nc0cBuIzxaft78X+5a6vGcaDpJbdcpvBTjGhQY53Mm8qR3oCOKVEUH5ri78/ME6er/
	 7MdHB0TVQ/iWg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:44 +0100
Subject: [PATCH RFC v2 47/48] kvm: convert
 kvm_arch_supports_gmem_init_shared() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-47-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pnsN1eWNLvBaN626N+uhslNofKWgHfrtxabNK2ZIO0Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vfsG+n5BuT9k8/g7PNZOIsfp2UEMupWZmx9PdGH
 3dhIekzHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORnMrwP+iWbPDaD+7LTi3K
 elK1UHoep6rr/mdcd25Ol9Eqy2a0OsTI0Mlj02L1cQ//y1SWtx3Mx0PjjgS9nG+6bWF06GRBGbZ
 5XAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 virt/kvm/guest_memfd.c | 81 ++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fbca8c0972da..c536423424ef 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -493,56 +493,45 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	const char *anon_name = "[kvm-gmem]";
-	struct kvm_gmem *gmem;
+	struct kvm_gmem *gmem __free(kfree) = NULL;
 	struct inode *inode;
-	struct file *file;
-	int fd, err;
-
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
 
 	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
-	if (!gmem) {
-		err = -ENOMEM;
-		goto err_fd;
+	if (!gmem)
+		return -ENOMEM;
+
+	FD_PREPARE(fdf, 0, anon_inode_create_getfile(anon_name, &kvm_gmem_fops,
+						     gmem, O_RDWR, NULL)) {
+		struct file *file;
+
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
+
+		file = fd_prepare_file(fdf);
+		file->f_flags |= O_LARGEFILE;
+
+		inode = file->f_inode;
+		WARN_ON(file->f_mapping != inode->i_mapping);
+
+		inode->i_private = (void *)(unsigned long)flags;
+		inode->i_op = &kvm_gmem_iops;
+		inode->i_mapping->a_ops = &kvm_gmem_aops;
+		inode->i_mode |= S_IFREG;
+		inode->i_size = size;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+		mapping_set_inaccessible(inode->i_mapping);
+		/* Unmovable mappings are supposed to be marked unevictable as well. */
+		WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+		kvm_get_kvm(kvm);
+		gmem->kvm = kvm;
+		xa_init(&gmem->bindings);
+		list_add(&gmem->entry, &inode->i_mapping->i_private_list);
+
+		/* Ownership of gmem transferred to file */
+		retain_and_null_ptr(gmem);
+		return fd_publish(fdf);
 	}
-
-	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
-					 O_RDWR, NULL);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_gmem;
-	}
-
-	file->f_flags |= O_LARGEFILE;
-
-	inode = file->f_inode;
-	WARN_ON(file->f_mapping != inode->i_mapping);
-
-	inode->i_private = (void *)(unsigned long)flags;
-	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
-	inode->i_mode |= S_IFREG;
-	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
-
-	kvm_get_kvm(kvm);
-	gmem->kvm = kvm;
-	xa_init(&gmem->bindings);
-	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
-
-	fd_install(fd, file);
-	return fd;
-
-err_gmem:
-	kfree(gmem);
-err_fd:
-	put_unused_fd(fd);
-	return err;
 }
 
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)

-- 
2.47.3


