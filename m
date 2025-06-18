Return-Path: <linux-fsdevel+bounces-52137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB140ADF9CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 01:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6130319E0138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758822E06EE;
	Wed, 18 Jun 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES9mJ4rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF21C2324;
	Wed, 18 Jun 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289874; cv=none; b=h/u1JJUw1Zetro+C+U7HUZ6B/NtO3+LtWxF69cra3/vxSua1g3KMrLYpC0fuKSSxb+2yt8hutqYAbk4WmAt7lhLctYgWOjd7jvRPFwTC64tWAbDw456YIrNxNaqwToy/u12oAZAFrc/Wlys+PbooklbBbNGkMj5DdiEjCLnFiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289874; c=relaxed/simple;
	bh=jT/WFn/kSkE09z8k3BXM/m+RCnGxFogqiqP15XNsKRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2lelxa1iLv6SK3xPTzCxEiz8Bh8MyFhcg3HerZlcc7dxx+oUC/alXHQlV0XozBI8ecPMQ0809tG5kyRFszihNMb+Y1rxJ0Vy7KroMTQaiLhBXCk3gRSm9T2L7p8eF65GCXXZ1o2duPKH/HbAbdHD9dLbj2eGonpN6Dpy3ueZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES9mJ4rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE26C4CEE7;
	Wed, 18 Jun 2025 23:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750289874;
	bh=jT/WFn/kSkE09z8k3BXM/m+RCnGxFogqiqP15XNsKRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ES9mJ4rwtG5/ZtGfVWFHtsmiTMBcFpcSaEXTvPgHZlS76WjXMVBCA3uIHEamugSao
	 cBv5QIFkh8+ELXvq4LxmIPNMi+KC7h6/D2c/mnNE2tEz6UFjJSzZa7w+HSwlD9N45K
	 lA3KJm4Vr5YtYDtHoo61eF8Byf+IDsVG0veALgNNiuDo3wJQA6BlebIvparThMFrH1
	 PHVAmijUN9t5udkm9xgWCaABgT8v1pkvH1YGdjK0LZwkJ+t/eNubn/nrIiPbjT6ikb
	 HtaBqnCvDt727blfXodxoyoKsiNWNceDo1U/XrrLtY6An0b9s4ai90cKw14e074lAV
	 Gggod2EFldkag==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	daan.j.demeyer@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU protected access
Date: Wed, 18 Jun 2025 16:37:36 -0700
Message-ID: <20250618233739.189106-2-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618233739.189106-1-song@kernel.org>
References: <20250618233739.189106-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing kernfs_xattr_get() locks iattr_mutex, so it cannot be used in
RCU critical sections. Introduce __kernfs_xattr_get(), which reads xattr
under RCU read lock. This can be used by BPF programs to access cgroupfs
xattrs.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/kernfs/inode.c      | 14 ++++++++++++++
 include/linux/kernfs.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b83054da68b3..0ca231d2012c 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -302,6 +302,20 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
 	return simple_xattr_get(&attrs->xattrs, name, value, size);
 }
 
+int __kernfs_xattr_get(struct kernfs_node *kn, const char *name,
+		       void *value, size_t size)
+{
+	struct kernfs_iattrs *attrs;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	attrs = rcu_dereference(kn->iattr);
+	if (!attrs)
+		return -ENODATA;
+
+	return simple_xattr_get(&attrs->xattrs, name, value, size);
+}
+
 int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 		     const void *value, size_t size, int flags)
 {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b5a5f32fdfd1..8536ffc5c9f1 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -456,6 +456,8 @@ void kernfs_notify(struct kernfs_node *kn);
 
 int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
 		     void *value, size_t size);
+int __kernfs_xattr_get(struct kernfs_node *kn, const char *name,
+		       void *value, size_t size);
 int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 		     const void *value, size_t size, int flags);
 
-- 
2.47.1


