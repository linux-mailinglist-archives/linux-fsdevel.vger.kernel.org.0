Return-Path: <linux-fsdevel+bounces-37148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8289EE616
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76F5188929E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4721516C;
	Thu, 12 Dec 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plsGg2KJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E405214A92
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004580; cv=none; b=ogwnTxAHkwDs/Euc874d/lsl/qzzjhP2xnJ5h8Qszw/SR8rzfmelurzaba6Q6Npv+wlgk0fuPXflYA35u00HXrIsxQChvPz84eyascuYFcZxehm4FijQDCFZ4wcPeLQMzVw55ZVW1hRQL62D6hFcHXVJtmosqGQp8tTa9d4Cj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004580; c=relaxed/simple;
	bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jP2OrBr2gC8BvSoskCkuYYejIx5m0YD0PhGNPY7r820m7c9VBNUJHHXI5RKgvhhJ1szJbaJtwS5hY9uKcx20yQep0l0bzqmDMuhPhr3HMAmaYCDEEGQ2dE6x3Po10GpTILYJCz/RBUqh/c54GMZJcHeXb+DIF27OOBRLRTBVeJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plsGg2KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5FBC4CED7;
	Thu, 12 Dec 2024 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004578;
	bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=plsGg2KJn0FgNeyWFJBFMBsTJjyaEJzczZkA5MTV+nV7UL63HYSVygNUUpx3L7Mko
	 M63fSK3PlmzXij8mVE7eZtL0k7MavY4wFoBmBzo87WRfih7hAnQSJLQwwy7t6TKd6A
	 Iih7dzHBnV3AlfNvwSLTfyryEWaXoOOoyFO9mJFpqbA03gnHCY8OBCsb8ePO24caXM
	 vRnbKC7Q1/4WvEtR0lTC9TnCSpjcXyWrtzGYi/4StUwVzPN9v/+p125FlfzQ1pBuWp
	 LjieTgHV4xUhmewuC70IfyajHI4ITeJdL/QRwO7zwypnKuIynELX8TGCjomKoc9UYp
	 +tDFVjP+//sWw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:01 +0100
Subject: [PATCH v2 2/8] fs: add mount namespace to rbtree late
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-2-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY/ZJ+KzmHHpXuMlNq/Dz7QcTY5Wm+SVwim1ck5M5
 czHJxZadJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE6jXDX/Hueb+Y1gpfr8ia
 ZcJ+J8H92aG+7IR/7G+rOERCVnmwKTL84ZcSPCD+653Fcge5Ixrn4+KLJr/7dFPR51pI6N+WRZd
 OMQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no point doing that under the namespace semaphore it just gives
the false impression that it protects the mount namespace rbtree and it
simply doesn't.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c3dbe6a7ab6b1c77c2693cc75941da89fa921048..10fa18dd66018fadfdc9d18c59a851eed7bd55ad 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3983,7 +3983,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
-	mnt_ns_tree_add(new_ns);
 	namespace_unlock();
 
 	if (rootmnt)
@@ -3991,6 +3990,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (pwdmnt)
 		mntput(pwdmnt);
 
+	mnt_ns_tree_add(new_ns);
 	return new_ns;
 }
 

-- 
2.45.2


