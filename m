Return-Path: <linux-fsdevel+bounces-33534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91E9B9D2D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F88B1F241F8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38C1ABED8;
	Sat,  2 Nov 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ciK6J3wP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AB156677;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524116; cv=none; b=fp3Eka3XcjmRdV2bObapk4xHL7Mu+4tbY9r90XEGCkq9jUSoGz6+/NiAi2x/3ZLkoYZjacEoweFJuBZmE4IXlhWoWwi5um4ziOSIRuEG/ym7a34le9vPPJnsQfkx7844Wla960UEwNSYcgdxE3fcLha4/b2iIWOvkx6VNooGnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524116; c=relaxed/simple;
	bh=vWNJWiojtyftbzVFc97pG2AiLM1BY1aPuFgpta6i410=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4niztxHEIt1MphRbTtpqo840WNxW4e1eO7KkOTLNHjf7nRbMuDMcwM765uRbt93rWUYNge7Zhpfn70L9qh5UXKMNyXlz+XqyrJFq5LFo4VrKndldo/jiHiA0pBqys58wzXNPqy+HPFGXXe85qWaCXYDXgJCJwR9z38nkOABJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ciK6J3wP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9xwP8b5XYu0N16WwsP078Fg/o2eYPBzzou+rLvxxP9U=; b=ciK6J3wPy7VUON8CWKA8GJtnen
	KeTjOHHuXF34P7AqJNWyInPiRsozKIng79dA3hhB7YVJFPcPFpmfvNbyTiaknW8bBNbzfKJL9aezp
	o93p86zZtbog7rZ9wKWsyuN/zCEm3Cnbda2R9LIHmEC/kmoMPN945P+oATWd+2uxV6MkvCE9kAYu1
	lS6gOfPylTSK/nHAi1xUn3jJxAGcbNHL0Vd7Napet5hKzVd6D9R7ncR5t5sU7N4kvfRtxfdJnqNDk
	dKs69/zstOhWZWlTyvKdsx2W2CcGk4iOoScnw2Q3L7Jcyrh7ctT/VPHJcJhNy4qYnY0+3dyihG8Xj
	1rRdoxog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NC-0000000AHoL-2yDu;
	Sat, 02 Nov 2024 05:08:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 25/28] assorted variants of irqfd setup: convert to CLASS(fd)
Date: Sat,  2 Nov 2024 05:08:23 +0000
Message-ID: <20241102050827.2451599-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

in all of those failure exits prior to fdget() are plain returns and
the only thing done after fdput() is (on failure exits) a kfree(),
which can be done before fdput() just fine.

NOTE: in acrn_irqfd_assign() 'fail:' failure exit is wrong for
eventfd_ctx_fileget() failure (we only want fdput() there) and once
we stop doing that, it doesn't need to check if eventfd is NULL or
ERR_PTR(...) there.

NOTE: in privcmd we move fdget() up before the allocation - more
to the point, before the copy_from_user() attempt.

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
index 79070494070d..0ca532614343 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -967,10 +967,11 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
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
@@ -986,8 +987,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	kirqfd->dom = irqfd->dom;
 	INIT_WORK(&kirqfd->shutdown, irqfd_shutdown);
 
-	f = fdget(irqfd->fd);
-	if (!fd_file(f)) {
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto error_kfree;
 	}
@@ -995,7 +995,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	kirqfd->eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(kirqfd->eventfd)) {
 		ret = PTR_ERR(kirqfd->eventfd);
-		goto error_fd_put;
+		goto error_kfree;
 	}
 
 	/*
@@ -1028,20 +1028,11 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
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
index 6b390b622b72..249ba5b72e9b 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -304,7 +304,6 @@ static int
 kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 {
 	struct kvm_kernel_irqfd *irqfd, *tmp;
-	struct fd f;
 	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
 	int ret;
 	__poll_t events;
@@ -327,8 +326,8 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
 	seqcount_spinlock_init(&irqfd->irq_entry_sc, &kvm->irqfds.lock);
 
-	f = fdget(args->fd);
-	if (!fd_file(f)) {
+	CLASS(fd, f)(args->fd);
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto out;
 	}
@@ -336,7 +335,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(eventfd)) {
 		ret = PTR_ERR(eventfd);
-		goto fail;
+		goto out;
 	}
 
 	irqfd->eventfd = eventfd;
@@ -440,12 +439,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
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
@@ -458,8 +451,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	if (eventfd && !IS_ERR(eventfd))
 		eventfd_ctx_put(eventfd);
 
-	fdput(f);
-
 out:
 	kfree(irqfd);
 	return ret;
-- 
2.39.5


