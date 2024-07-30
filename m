Return-Path: <linux-fsdevel+bounces-24568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D258894077C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7261F23805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712BC1A00FC;
	Tue, 30 Jul 2024 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkghWRQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BD1A00C2;
	Tue, 30 Jul 2024 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316520; cv=none; b=snYp3+2FrAf/TqDRKBb3wDAAnPwJ0+wNiX8wmiIvLq4O/Pb8gBL9VsJDQvIdZz6LXidBFlzHxOd0DUA2Falp/CT4ET1sTo9i4JHb7VvNPpRa7FT/atDwhCCM9I4CygJisLn1P31Y6QMDeVCHB2nrdRKigMc5mGrSqYoxz1plNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316520; c=relaxed/simple;
	bh=ionwxzIbc2LdJlUSlA7ltKLq42W/4KKLlFBvI2Fnzv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMpM5rEp9VbCQn1Gixeu5s3JZ4mPQ9k8XntZLm/Tc6drnNwGEy8jei4boUNAT9TTsbTC8gPqu//bcorQ+uzsgixsx2IJNTNsfc01QjJuiPTM0CKYH/ZvgA78/4rm1cpPal3U176GJRnbrsVpB97crH9f/5Zujnbe0ROtOi3zVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkghWRQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C8BC4AF0E;
	Tue, 30 Jul 2024 05:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316520;
	bh=ionwxzIbc2LdJlUSlA7ltKLq42W/4KKLlFBvI2Fnzv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkghWRQ6SZ7xfVG53U0yGNwi++kH3SV1fcP215BUiyDra4dsJb8tzcB2k2HYdbT0h
	 nPuZvlTr0Ysf8NXy7mXQ6cTGRghCCOdI0E5/ZeNM+0fl8kr3Cz12OhdqyPaZk5SORF
	 hnPzCC6W7QOlHm4u8gVW9CuNDqTmKQQQ0HsoSJ6bJuMUuTWOrq5y4OJ++KVZin531N
	 N1euhp2w6hxBxqZldEMxh1PwbxlHlJYYVWul7Q9bCKO1l1tZI8fM+igM9m//3VvUx6
	 +JPIkgjXbTeP69pSAbQveSBoBxXFFnLZK8SSNmjpRfvNnhpwKwJsLpnNRWLObWMBGm
	 fJTDltwn0HRZA==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 36/39] assorted variants of irqfd setup: convert to CLASS(fd)
Date: Tue, 30 Jul 2024 01:16:22 -0400
Message-Id: <20240730051625.14349-36-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

in all of those failure exits prior to fdget() are plain returns and
the only thing done after fdput() is (on failure exits) a kfree(),
which can be done before fdput() just fine.

NOTE: in acrn_irqfd_assign() 'fail:' failure exit is wrong for
eventfd_ctx_fileget() failure (we only want fdput() there) and once
we stop doing that, it doesn't need to check if eventfd is NULL or
ERR_PTR(...) there.

NOTE: in privcmd we move fdget() up before the allocation - more
to the point, before the copy_from_user() attempt.

[trivial conflict in privcmd]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/vfio/virqfd.c     | 16 +++-------------
 drivers/virt/acrn/irqfd.c | 13 ++++---------
 drivers/xen/privcmd.c     | 17 ++++-------------
 virt/kvm/eventfd.c        | 15 +++------------
 4 files changed, 14 insertions(+), 47 deletions(-)

diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index d22881245e89..aa2891f97508 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -113,7 +113,6 @@ int vfio_virqfd_enable(void *opaque,
 		       void (*thread)(void *, void *),
 		       void *data, struct virqfd **pvirqfd, int fd)
 {
-	struct fd irqfd;
 	struct eventfd_ctx *ctx;
 	struct virqfd *virqfd;
 	int ret = 0;
@@ -133,8 +132,8 @@ int vfio_virqfd_enable(void *opaque,
 	INIT_WORK(&virqfd->inject, virqfd_inject);
 	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
 
-	irqfd = fdget(fd);
-	if (!fd_file(irqfd)) {
+	CLASS(fd, irqfd)(fd);
+	if (fd_empty(irqfd)) {
 		ret = -EBADF;
 		goto err_fd;
 	}
@@ -142,7 +141,7 @@ int vfio_virqfd_enable(void *opaque,
 	ctx = eventfd_ctx_fileget(fd_file(irqfd));
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
-		goto err_ctx;
+		goto err_fd;
 	}
 
 	virqfd->eventfd = ctx;
@@ -181,18 +180,9 @@ int vfio_virqfd_enable(void *opaque,
 		if ((!handler || handler(opaque, data)) && thread)
 			schedule_work(&virqfd->inject);
 	}
-
-	/*
-	 * Do not drop the file until the irqfd is fully initialized,
-	 * otherwise we might race against the EPOLLHUP.
-	 */
-	fdput(irqfd);
-
 	return 0;
 err_busy:
 	eventfd_ctx_put(ctx);
-err_ctx:
-	fdput(irqfd);
 err_fd:
 	kfree(virqfd);
 
diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index 9994d818bb7e..b7da24ca1475 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -112,7 +112,6 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	struct eventfd_ctx *eventfd = NULL;
 	struct hsm_irqfd *irqfd, *tmp;
 	__poll_t events;
-	struct fd f;
 	int ret = 0;
 
 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
@@ -124,8 +123,8 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	INIT_LIST_HEAD(&irqfd->list);
 	INIT_WORK(&irqfd->shutdown, hsm_irqfd_shutdown_work);
 
-	f = fdget(args->fd);
-	if (!fd_file(f)) {
+	CLASS(fd, f)(args->fd);
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto out;
 	}
@@ -133,7 +132,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(eventfd)) {
 		ret = PTR_ERR(eventfd);
-		goto fail;
+		goto out;
 	}
 
 	irqfd->eventfd = eventfd;
@@ -162,13 +161,9 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	if (events & EPOLLIN)
 		acrn_irqfd_inject(irqfd);
 
-	fdput(f);
 	return 0;
 fail:
-	if (eventfd && !IS_ERR(eventfd))
-		eventfd_ctx_put(eventfd);
-
-	fdput(f);
+	eventfd_ctx_put(eventfd);
 out:
 	kfree(irqfd);
 	return ret;
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index ba02b732fa49..8a5bdf1f3050 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -939,10 +939,11 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	struct privcmd_kernel_irqfd *kirqfd, *tmp;
 	unsigned long flags;
 	__poll_t events;
-	struct fd f;
 	void *dm_op;
 	int ret, idx;
 
+	CLASS(fd, f)(irqfd->fd);
+
 	kirqfd = kzalloc(sizeof(*kirqfd) + irqfd->size, GFP_KERNEL);
 	if (!kirqfd)
 		return -ENOMEM;
@@ -958,8 +959,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	kirqfd->dom = irqfd->dom;
 	INIT_WORK(&kirqfd->shutdown, irqfd_shutdown);
 
-	f = fdget(irqfd->fd);
-	if (!fd_file(f)) {
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto error_kfree;
 	}
@@ -967,7 +967,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	kirqfd->eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(kirqfd->eventfd)) {
 		ret = PTR_ERR(kirqfd->eventfd);
-		goto error_fd_put;
+		goto error_kfree;
 	}
 
 	/*
@@ -1000,20 +1000,11 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 		irqfd_inject(kirqfd);
 
 	srcu_read_unlock(&irqfds_srcu, idx);
-
-	/*
-	 * Do not drop the file until the kirqfd is fully initialized, otherwise
-	 * we might race against the EPOLLHUP.
-	 */
-	fdput(f);
 	return 0;
 
 error_eventfd:
 	eventfd_ctx_put(kirqfd->eventfd);
 
-error_fd_put:
-	fdput(f);
-
 error_kfree:
 	kfree(kirqfd);
 	return ret;
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 65efb3735e79..70bc0d1f5f6a 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -303,7 +303,6 @@ static int
 kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 {
 	struct kvm_kernel_irqfd *irqfd, *tmp;
-	struct fd f;
 	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
 	int ret;
 	__poll_t events;
@@ -326,8 +325,8 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
 	seqcount_spinlock_init(&irqfd->irq_entry_sc, &kvm->irqfds.lock);
 
-	f = fdget(args->fd);
-	if (!fd_file(f)) {
+	CLASS(fd, f)(args->fd);
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto out;
 	}
@@ -335,7 +334,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(eventfd)) {
 		ret = PTR_ERR(eventfd);
-		goto fail;
+		goto out;
 	}
 
 	irqfd->eventfd = eventfd;
@@ -439,12 +438,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 #endif
 
 	srcu_read_unlock(&kvm->irq_srcu, idx);
-
-	/*
-	 * do not drop the file until the irqfd is fully initialized, otherwise
-	 * we might race against the EPOLLHUP
-	 */
-	fdput(f);
 	return 0;
 
 fail:
@@ -457,8 +450,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	if (eventfd && !IS_ERR(eventfd))
 		eventfd_ctx_put(eventfd);
 
-	fdput(f);
-
 out:
 	kfree(irqfd);
 	return ret;
-- 
2.39.2


