Return-Path: <linux-fsdevel+bounces-69568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62AAC7E41D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639683A6A32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627E2D7DE2;
	Sun, 23 Nov 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chXKTSqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64677231A41
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915715; cv=none; b=X5Qgmbyn3q1M6q3UtKOSB0QaWZpZe469a2cyiP3yBgAeBEtLzprF1tU9BTzQ6a3EUz9KeWCKoRx/WOrR7EOc/9K1dTsPnU9FD0Zzz3ekea5HWvKQ8X3zCUIXAtiyVHJsNljRwB7/EZoeSsDJKC1HV/1NuLPtK1NwM6CloMnsuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915715; c=relaxed/simple;
	bh=mzzhInXE4R/aY7jNPLsb1kQP1oX/eXDHQE/UmmaTaj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtRFKXTy8YZw7Vrhz1JYVxyu/UjC2ro8BTNqfv/NTk4IVUtJEF/XmuMAtuXBKIRwXlRGhazLEbWEmcqmPIPZ2Y5tsTP9mWkuXrQydvmBX52dWUjBgpNFN1HwaV7OKt5S1dn8vEWQTKNNnlYxGfqvG6XBZTVvE4Lqh8rq/xukYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chXKTSqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1ADC116D0;
	Sun, 23 Nov 2025 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915715;
	bh=mzzhInXE4R/aY7jNPLsb1kQP1oX/eXDHQE/UmmaTaj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=chXKTSqRfwyg/asSh64XtqT6McyR1PmoyJKR2wb/xKOGbe+F3okWKhnZFAn4jVJh9
	 7UWADIuRRUDmn1I6igGFyb3rkgOQ5p7HC/YxlDqHhdwE+0jAkfpkvzgsHcGIm6lJ1X
	 Vz9aDKqhOZ6v1Ld5o66vmGv4FusDO5p5whZXSReoni+qPet4BOTAZDzQoGruIXbBsn
	 jJmbup0WVIhY6HXBQakMeCgNxRdjI0y9m0VJFqbnVUp7THXwcnKmkA6W1rFWzMZ8gR
	 tC/L4rGb1cdXsZzxRyWLan3ldxngnO4pcxDVznXZX5GAlJfcbgPCb1E6n2IJ07tByt
	 Uy+URdo6nVN1A==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:34:04 +0100
Subject: [PATCH v4 46/47] kvm: convert kvm_arch_supports_gmem_init_shared()
 to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-46-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mzzhInXE4R/aY7jNPLsb1kQP1oX/eXDHQE/UmmaTaj0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0dncf6SCRHatvHdHGlV66uSm4u2nTn8dtm0B3Hb3
 Ar2Xs5901HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRm2sY/ic41647VVXFtcb3
 75TPFkUPwyN1zbx7W/ZW/mkNUXVeyMnwV4olf+42kYi+32smqXw4lP3YZHbDm51BiaqP/mxbGRw
 XxwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 virt/kvm/guest_memfd.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fbca8c0972da..1d583d0cf6b9 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -493,28 +493,20 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	const char *anon_name = "[kvm-gmem]";
-	struct kvm_gmem *gmem;
+	struct kvm_gmem *gmem __free(kfree) = NULL;
 	struct inode *inode;
 	struct file *file;
-	int fd, err;
-
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
 
 	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
-	if (!gmem) {
-		err = -ENOMEM;
-		goto err_fd;
-	}
+	if (!gmem)
+		return -ENOMEM;
 
-	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
-					 O_RDWR, NULL);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_gmem;
-	}
+	FD_PREPARE(fdf, 0, anon_inode_create_getfile(anon_name, &kvm_gmem_fops,
+						     gmem, O_RDWR, NULL));
+	if (fdf.err)
+		return fdf.err;
 
+	file = fd_prepare_file(fdf);
 	file->f_flags |= O_LARGEFILE;
 
 	inode = file->f_inode;
@@ -535,14 +527,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&gmem->bindings);
 	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
 
-	fd_install(fd, file);
-	return fd;
-
-err_gmem:
-	kfree(gmem);
-err_fd:
-	put_unused_fd(fd);
-	return err;
+	/* Ownership of gmem transferred to file */
+	retain_and_null_ptr(gmem);
+	return fd_publish(fdf);
 }
 
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)

-- 
2.47.3


