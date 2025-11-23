Return-Path: <linux-fsdevel+bounces-69569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C56EBC7E42F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DB72349B74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2CB28D8CC;
	Sun, 23 Nov 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TerJCRx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E462192EA
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915717; cv=none; b=Df3YXAiDJqWO2ZD7V2vJ/KByA0bXToyI7ZEtB78oUtl5OBeqUKy+tMRc8ODh9Y/7+uo9I4fTPRmkBYPc+rdrFj3OFmwaOsDoe2UZpTOWEUXZXujAnQUMfdjbkUUGbxO2jdq8cfvLZZOwdRE5Ab+q9AzT+MZNYOjzZacNnz59IwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915717; c=relaxed/simple;
	bh=tElJinOQT1EqdSI6xs6yIYsdLeebt0cldIhPQ5nHX+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oHRsQRBvuUiGVWrYt6sPmDM0Tn5+Ni//dIEhfpfzr1xq+nIxAwRwUhO3UScrUUzO3bLGfIZ8S3UrWfqEp6OIUNwagqnVijUe61QdANHEHVKRbYhCfeu1uJHyGPyXWV79Zpl1qNEijf5bUl2v3qTLrrWr4YLAKV8c/hGo1MoIKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TerJCRx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DEAC113D0;
	Sun, 23 Nov 2025 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915717;
	bh=tElJinOQT1EqdSI6xs6yIYsdLeebt0cldIhPQ5nHX+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TerJCRx9GZDNogHM0iOqtEidxHka/QWa9tp48aItzJBJUazl0b3usmaNwaHHInfFJ
	 PcDex742lh4Ef6Y3cnMwn8W/k2GLxFPXx/VVtFmTWqf373kfbYFH65qnJe/0Nb6aBX
	 domZfH1/81sZtyaLcxUGIxCM+1R49wd3bXaCSKBEv8MxokCQ0QNyZC1ydaCJaaV2py
	 +EoksH6emwrWuAMp035tviZXNslWhMhDtiLO3wfS7aoLDU2DwOZgR7mz9P5OdghX/J
	 3hE1Q9eZw45XKlrgfiZ+pGdXuOgH8T/YdLdUiYLLF2AMOEfePGIuimnGKzRUy42gO6
	 lvtCpuGQH5GxA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:34:05 +0100
Subject: [PATCH v4 47/47] kvm: convert kvm_vcpu_ioctl_get_stats_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-47-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tElJinOQT1EqdSI6xs6yIYsdLeebt0cldIhPQ5nHX+Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0fHfX8Vfdtzv/8FzWthRbdyPK1bzrHH3+hdnvV9z
 RoBfclLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxOc3w3+vARqPfbGblfml3
 b/bc+G+87oNm6uR8HcszPh2erYetlzL8z69IXVSkF9ttM0vkwJMj710v56yz1nq77vM7Z1sp5y0
 m7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 virt/kvm/kvm_main.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7a0ae2a7b20..aecc3b4aa472 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4314,25 +4314,15 @@ static const struct file_operations kvm_vcpu_stats_fops = {
 static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 {
 	int fd;
-	struct file *file;
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
-
-	kvm_get_kvm(vcpu->kvm);
-	fd_install(fd, file);
-
+	fd = FD_ADD(O_CLOEXEC,
+		    anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
+					     O_RDONLY, FMODE_PREAD));
+	if (fd >= 0)
+		kvm_get_kvm(vcpu->kvm);
 	return fd;
 }
 

-- 
2.47.3


