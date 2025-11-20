Return-Path: <linux-fsdevel+bounces-69328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06628C76882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 046F64E40F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7B368E1C;
	Thu, 20 Nov 2025 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7emM4+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB35348468
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678037; cv=none; b=Wjee1jfSkpoeH2ffWOFhl6NouZ/i1bw4h7NPbmD7Bgy1PFA4VrksfWzIfSrhrP5ZLlz67A5tNy0MHmd5fL/dUhtKb1jv6CpnFsuL2l7OqayyTDjJo+fiYE6GcaWtQea9MeqLGpVNuIB7BNZSVLIVAVsVDjHP5I1eyYc/Ip3aRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678037; c=relaxed/simple;
	bh=zjPzbxaMcZdc8dpfe1mwu3CKubuc2EAyRK9L1CPFS98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJ/+jAGZ/QxmnT2mgUI/5kemPzpjuG5nZRBIpt//KwDpwNzi3YqaXs106/1dEeD7RktXHAwaqsbOLR+jEVHndqhnOPi++3PPlMkyzgSPgd9JJeNMK8wWwpal+2sSFbwzog8/uS9KOvVrf9g3gLznzbGZDVPsQl8zB9IE/lfu480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7emM4+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A88C4CEF1;
	Thu, 20 Nov 2025 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678037;
	bh=zjPzbxaMcZdc8dpfe1mwu3CKubuc2EAyRK9L1CPFS98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X7emM4+LyldSbLZwrKK44r+3MKZMgtk6b91YaR0dszn9aEVOJbuVKmKDylch1HQLy
	 V7XkXIW7hvBn6+mu13kN3Nd8r+weaPLRe2oib0RqGSK/vuJQY7nEqFAJUEjaA4+L7J
	 p6m2NvSGcs7PlsV66zCMc3d96+hgOQN2BlXDIU3kIdTYAhuUe2BXzg66vwAgbX1Lp2
	 haIGv1bSYVVlV/UQLTSRLuA0v+SfDM13VrTUyM0MB+4KkrQL+bkvvYWVOl1CiOdt7W
	 rovLFdL8C8UVHaO7AvJ8W7ouYp3mmhLlu/UKtiuFGaCoJ4H4puAhaz21Z34Vfn4hwL
	 lCcIGX6PpFWiQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:45 +0100
Subject: [PATCH RFC v2 48/48] kvm: convert kvm_vcpu_ioctl_get_stats_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-48-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zjPzbxaMcZdc8dpfe1mwu3CKubuc2EAyRK9L1CPFS98=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vfrhp1b41v5Cm/7LvXUw5/miT3effy1VdkVy5pP
 3T0HHfT5o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJTLRgZLhjkRp9Yo1YQNyJ
 JMcLVfcXP7py9ZrC5SDJzdv37L+4q82D4Z/SMjnfj1s4jlvaGf7j3ly3JrZZq+j+hG83Xjl1FVy
 OEWYGAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 virt/kvm/kvm_main.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7a0ae2a7b20..9bb51da668dd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4313,27 +4313,20 @@ static const struct file_operations kvm_vcpu_stats_fops = {
 
 static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 {
-	int fd;
-	struct file *file;
 	char name[15 + ITOA_MAX_LEN + 1];
 
 	snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	FD_PREPARE(fdf, O_CLOEXEC, anon_inode_getfile_fmode(name,
+							     &kvm_vcpu_stats_fops,
+							     vcpu, O_RDONLY,
+							     FMODE_PREAD)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	file = anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
-					O_RDONLY, FMODE_PREAD);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
+		kvm_get_kvm(vcpu->kvm);
+		return fd_publish(fdf);
 	}
-
-	kvm_get_kvm(vcpu->kvm);
-	fd_install(fd, file);
-
-	return fd;
 }
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY

-- 
2.47.3


