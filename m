Return-Path: <linux-fsdevel+bounces-25129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849394952C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D782D1F26043
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67E37703;
	Tue,  6 Aug 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U43s6sub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A94CB5B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960164; cv=none; b=az5273tU5BP4zKl36IWT4FAorcsjg3JvcdXBcAdIPpwCU5PgbMKB8fkFilSNslM3TVOWvwvn5Pd/D/Ln+k970c6sTavDNDtemfn9k/BvSf3uwkUYxiCuLeZrPMEZQj3inzS4LNSyX6voOzRCQ4Q45q6zilVscv8v+2OXzeJc7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960164; c=relaxed/simple;
	bh=VHvhBLO4JEFn16lq6IhxF5u65kdur9fh5dxgwtDLXBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULUU/bzVSyXtrMfZU3JbNexqxQRtwezDOjm0Ec2ErMfzfr0KYNUxw0dN0RRXFH52nCBBmYznuLVMR51CijHcJSpCplRtc5zFICqLsnLgNwy5mOYvBC83xt/oK3l+c6TuTD45yV+cIvC9Nv/XXglE05/hua8suSSS8QQXm/9L1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U43s6sub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E98FC4AF0C;
	Tue,  6 Aug 2024 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960163;
	bh=VHvhBLO4JEFn16lq6IhxF5u65kdur9fh5dxgwtDLXBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U43s6subiJRrT+q/RDMa9h/p2blVEfI0m8riGwAolkJu92pfPeSpJhEDvVJaETgCZ
	 k0Y6omDYlcg8mTCz0wWVwy2pBbRUGItHeH4Xdy6p3uefiFGUx3hArNtnHB+Y+PejmK
	 /Up5ux9XSWr11WVZsgpShUSp0LyTG6DlrDei0D2io9eD5uZYoNCS8ewE85UWfAYTx3
	 kEIm0f9xB0p8fGYNAqqNXF5Jgclb8Q8p84+yhV34eDHv9DVRF7yN50YnPc7JzklKuw
	 2wQJ5WNIwTaUy9evGcwOQfjryvi0tvt1Ts8eyWj3NMlinBhzGxjBrneg1S+/wn+i9H
	 4zL4GbRI+S/1w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 06 Aug 2024 18:02:29 +0200
Subject: [PATCH RFC 3/6] proc: add proc_splice_unmountable()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-work-procfs-v1-3-fb04e1d09f0c@kernel.org>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VHvhBLO4JEFn16lq6IhxF5u65kdur9fh5dxgwtDLXBo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt8pQ+9jb+qorERyu/a4xTdJWfnW/vNRRpc/+xsIXrb
 5PMrL+lHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRM2NkeH8iYUk5D9/umMSu
 zZsua29P3VEhEM+k/fRhy4uQzYdMdjL8d4xPU7ZReO24PiHpmdiVnm/bmW7nnXps2VI/seMDt0k
 uAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a tiny procfs helper to splice a dentry that cannot be mounted upon.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/proc/internal.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a8a8576d8592..9e3f25e4c188 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -349,3 +349,16 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
 	pde->proc_dops = &proc_net_dentry_ops;
 }
+
+/*
+ * Add a new procfs dentry that can't serve as a mountpoint. That should
+ * encompass anything that is ephemeral and can just disappear while the
+ * process is still around.
+ */
+static inline struct dentry *proc_splice_unmountable(struct inode *inode,
+		struct dentry *dentry, const struct dentry_operations *d_ops)
+{
+	d_set_d_op(dentry, d_ops);
+	dont_mount(dentry);
+	return d_splice_alias(inode, dentry);
+}

-- 
2.43.0


