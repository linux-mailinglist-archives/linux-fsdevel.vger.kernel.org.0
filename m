Return-Path: <linux-fsdevel+bounces-69444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAD3C7B370
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32CE834F71B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F321354AC1;
	Fri, 21 Nov 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMpoZ20x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE46354709
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748148; cv=none; b=rRD2tml3REY1ZH3xO02rrq+9K0qt+mdvBb3Wen+4x4CoMI2x7ns9xqQbCcgnGtfRkv1OGE2d/z0WIyt3OuCBYQQ20NZsdu38ls6uIC2JsazOXlEgbTJzfiUktgN3EqPqL/XjhW6E386V6Hn3ZzYX8hsEfjRakHReEZKlkXYSBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748148; c=relaxed/simple;
	bh=GmiLr3N+CJdr5Qn7A4fet58hpnadWgf6ua6m1wrmVRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1PUj6n583G1vwl0+/v1nAk8wZQqmjTUOc31OW5nYKSeM6dok8JJwour7ixfAOKUJ5cHd7D0dVhPS/nyH1J50Judbba4uC+KcWN45lTSKvCWZAOn88vaoorQxS++QZho1cjHpDeE3MxT67lJWNIb1bXDDHQyPOjVBWlGb6cso/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMpoZ20x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22733C4CEF1;
	Fri, 21 Nov 2025 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748148;
	bh=GmiLr3N+CJdr5Qn7A4fet58hpnadWgf6ua6m1wrmVRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cMpoZ20xzHfLhLKxYouawRRfd+PYDN2i0znelUMhIwU2MoSYzUPeYvgI3uytWnnXQ
	 IQNPxdnb9lAlEsv0hPTi5qFPDuJF1XiickNwFkU4eGN+dDIxWypOGVpLJ223MHsCrv
	 VKsDZ7PIClpnjGtiGpQ04+8duDrglvSctP6v9NquMQ4tvpyIC9EuPiCQ1zEV4i1uWB
	 UKAv86NH8OHljiv9Qql09VGmWB8Y8AuzMFB6WiIk4dGFcHSSM53Y8F8saDIQTkZsay
	 Etn7RieJaSfwm1DVDZeS733vJ2kbLbwyQXjuud+GJJFSZv5cH0BQhSPRu80D8Kmi1b
	 4MctjPRgv8LOg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:25 +0100
Subject: [PATCH RFC v3 46/47] kvm: convert
 kvm_arch_supports_gmem_init_shared() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-46-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GmiLr3N+CJdr5Qn7A4fet58hpnadWgf6ua6m1wrmVRI=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkgqNGj1N4nlgoM4n581EvMLEaQ0/Ke46+xWCWnbvqNHwNda
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkgqNEACgkQkcYbwGV43KKHqwEAzaEI
 yKQk7MG0wNXPvi3vaUfy6e84sA51BAagLVdAvd8BAN0Th0NHH7vz9AS5jNwJVczCQAh3riZq2zh
 QKuhyy4IE
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 virt/kvm/guest_memfd.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fbca8c0972da..ca0135dbefa8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -493,28 +493,22 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
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
+	int ret;
 
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
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
 
+	file = fd_prepare_file(fdf);
 	file->f_flags |= O_LARGEFILE;
 
 	inode = file->f_inode;
@@ -535,14 +529,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
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


