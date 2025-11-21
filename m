Return-Path: <linux-fsdevel+bounces-69445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25617C7B367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980074EC904
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD99B354AD1;
	Fri, 21 Nov 2025 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAZqqUgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B5352938
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748151; cv=none; b=aaccPxk2gFx39uij/Tp1tDsJ7hpDvCFhbxJIyKnuyecocPFfQ0J5+1JHm0SLCzGT5akdfy+g3Js4MFisv9HJ5p0OmvtHRLFyplee/A4o5z2HAi7m/0GW1Lcy551ozFyEQGZ2DH6jX6f80FEJqNNGPiy4WL56yu+oQ56Yn76I7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748151; c=relaxed/simple;
	bh=Z0g4K/8D7TAvbHpW9jpdHTZO/ZfLBuWFu9MXauderuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GndbilZ6IlgjgqnlGmnw4JXd9e0+2wIhEF0/jmhjKmMA4oI/cX1BWl5LsglFNfrUo9E2H5mUU1LgU15O62TlUoDwAfRZQ0GNMMifS7cZ5aXjm5OAFcYT5JSOckpbAvlN5Rc7uoXKQfMBq/KeWAzoSfWOhKbo6Q55lsSxT+V+f0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAZqqUgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D57C4CEF1;
	Fri, 21 Nov 2025 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748150;
	bh=Z0g4K/8D7TAvbHpW9jpdHTZO/ZfLBuWFu9MXauderuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JAZqqUgZOFJt7LctslVTYSEJksLFZCPL8ZhpLYp7JMovcM9C3WLzdQSDvK8wOP60/
	 w+j6K1xIK6Obpq+rFukCPoabvZBZTA160QDMZDq5KDq7HBTeM8u8qIDq61L9xj8+8a
	 fMZgg3R7nrIOJiqdiLbKkVukRfDYgnl16AfYtbvjAiydkvkX9u3NGLZjiLSFpFgfPE
	 B3Mh8Mdfbejoi5jBdeoQsXwPLJ1ZG05gR0x/0QaTbSm6XIBEbvrBvMc00mnGhTc4UK
	 oSI2gUJTVqpel/0jljCi5Hfq/sEU3bP6A6xPmuZsFiXviHlYoGb/XUDQX5fbz5xsrU
	 BsGSKCY5UkEkw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:26 +0100
Subject: [PATCH RFC v3 47/47] kvm: convert kvm_vcpu_ioctl_get_stats_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-47-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Z0g4K/8D7TAvbHpW9jpdHTZO/ZfLBuWFu9MXauderuU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLg4W/Zm+DbDU8de9u3UcAq08tjdkCAvOLVkxv1cU
 aPrth/edZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk1QtGhn1Xmg4JPK+ucDFO
 17UXkOLz7NdeeMv431Vh7SXXE2czFDD895p4TvNhlZfqafd2HZMshW/fj02Y4NH93p/dzfd0RsN
 xdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 virt/kvm/kvm_main.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7a0ae2a7b20..f8c5ed12d42d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4313,27 +4313,21 @@ static const struct file_operations kvm_vcpu_stats_fops = {
 
 static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 {
-	int fd;
-	struct file *file;
+	int ret;
 	char name[15 + ITOA_MAX_LEN + 1];
 
 	snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
-					O_RDONLY, FMODE_PREAD);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, O_CLOEXEC, anon_inode_getfile_fmode(name,
+							     &kvm_vcpu_stats_fops,
+							     vcpu, O_RDONLY,
+							     FMODE_PREAD));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
 
 	kvm_get_kvm(vcpu->kvm);
-	fd_install(fd, file);
-
-	return fd;
+	return fd_publish(fdf);
 }
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY

-- 
2.47.3


