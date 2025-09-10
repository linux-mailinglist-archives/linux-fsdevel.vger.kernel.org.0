Return-Path: <linux-fsdevel+bounces-60780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75E3B519C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32D15655FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9EA338F54;
	Wed, 10 Sep 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYrDm3fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAA32CF6C;
	Wed, 10 Sep 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515061; cv=none; b=pfUs2egxBWD0XJzYWkIQyYTF0941vDcIUej3+iTq7yusreHecfGttchy6N1O6vwpIcQPG2fB130EwtzKbqAS1YX/8U33gRNZHWP78dhQBOR2XGh6vJ4lqpV5VmKnihPqbkRTwHcnCmdfOAsc9kOW+Myii5OUJUQRGyuvvWa4FfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515061; c=relaxed/simple;
	bh=B7r5xME705JZrGrmvpUjQFvU/5IFdDDiURc8AUJwiiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uR/uzzhyag90UAHhK1dCn7ITTDEh2E75qCQe6B14trHVrfOK77pT0KkSaFnSleNnHEbZRzbdfkc6TslEWur/Dy59nUw+EgzH8dnS9VqyVwSI8fBe6HD7t7BNiSXG8sC6tYsw0MVDY6sYqEbOgcIy50G3YjSacp5IFkiMPw/c7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYrDm3fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1F1C4CEF0;
	Wed, 10 Sep 2025 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515061;
	bh=B7r5xME705JZrGrmvpUjQFvU/5IFdDDiURc8AUJwiiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYrDm3foVgRyetarOPPjGBoKL2jTXbEF663pJ31nlzq+EkFi4aicPOLyWGk0pSsVg
	 7cEYzyu+yorQ401tF4RAPXrix8y4scRYTaAYzme7koY7wTXU9cNFmEernTGng4pyq8
	 pF08kk1+/JWQhNa8O1tlLB9KMhu28Umklv2TsL1Vd+9QL7bVaef5L3haS2UasPdwFy
	 82b56iaBwX0cxZq+q6Lb87l/ZJnW/JZizBfcY9ce04Z+bZfXMiK7lMTndKW6AjO6Fc
	 uR9zu8Q7mR4ASbQFJUeIfWp4MAJmsfbS9pOp01yrjqiR8o3wPOjdVokw7Sv3i8hVF5
	 t0Sp1JCGUUp2g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:51 +0200
Subject: [PATCH 06/32] ns: uniformly initialize ns_common
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-6-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B7r5xME705JZrGrmvpUjQFvU/5IFdDDiURc8AUJwiiQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OWYG3gylSNZ7e36oD8rmc/dLJxQHzZ5Qgz/jTK/C
 bcihT5O7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIueMMfziTxU4wauybahl0
 I6f+QpvjMqPdW+zW1jnPE6tPb/LdsJmR4cksdlvXEGMRHvadktu3yLnx+tSr++TZn57q2GWn/Uu
 QHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No point in cargo-culting the same code across all the different types.
Use one common initializer.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/proc_ns.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 5e1a4b378b79..dbb119bda097 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -72,6 +72,22 @@ static inline int ns_alloc_inum(struct ns_common *ns)
 	return proc_alloc_inum(&ns->inum);
 }
 
+static inline int ns_common_init(struct ns_common *ns,
+				 const struct proc_ns_operations *ops,
+				 bool alloc_inum)
+{
+	if (alloc_inum) {
+		int ret;
+		ret = proc_alloc_inum(&ns->inum);
+		if (ret)
+			return ret;
+	}
+	refcount_set(&ns->count, 1);
+	ns->stashed = NULL;
+	ns->ops = ops;
+	return 0;
+}
+
 #define ns_free_inum(ns) proc_free_inum((ns)->inum)
 
 #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)

-- 
2.47.3


