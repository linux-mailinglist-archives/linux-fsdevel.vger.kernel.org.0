Return-Path: <linux-fsdevel+bounces-61060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D447B54C07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ACE586C99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E5311959;
	Fri, 12 Sep 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryGPXQK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0C305047;
	Fri, 12 Sep 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678067; cv=none; b=D6TXsFyg6oFiwv1s6Lt5RP/hoXdbMQ/UePDELcN4kvEJJnjWoW96kGeLNtHjmY6Y7VcMDpQWnudrg4JnjeUHZmA4uZpp4IUh0tzLucKRJuXDdRHIJMhQsvFKEsiBqxbF0kr/DzNdgjDDpAgVI4xHIxgim4SXyW98S2c6fb0fT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678067; c=relaxed/simple;
	bh=Z6OZ5fLqp8itBaP4KETMc+Rrap1MAMb9skiLO6rW064=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsuaE4LSHGZRkhnibcZq3B531ujpzDXcdNcM16f1jY8UPu4SadBzAZIyFUZ4YNOBSa7O97ydIehL5JHRykl9ox6VSP229HAkmuJTTDYerCRf0+b5Tp1Ab3/ze5FYvFK6j/VSaUHkW/5ClFlRrKuZrII19Q9oBEsYgz8wP3iWvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryGPXQK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C70C4CEF4;
	Fri, 12 Sep 2025 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678067;
	bh=Z6OZ5fLqp8itBaP4KETMc+Rrap1MAMb9skiLO6rW064=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ryGPXQK856dFhMQT3L2mdYKLpGxMtrklfvNHp+TNWhR7xPB88xHd6vEVJty5GBAdp
	 VMAoPutwebFVo0Pm4EnWFAvnhyvC+KlZHmne7jsNzShjQW6y0nr7CNSDWI0GVbrVPc
	 f490R22TMzGyG9ldIkQcpMh2kDH8GfxjynAGjs4nWtC1nYSMMaIsGzK6sAMs0rHpc2
	 bU36dNrWUvYmyW/QPAjdEOev4WPjCwmAe+tGzLz7D/9//pZUywp5A80bFt4JHfqi4E
	 YkiQEYiqdocI5BZpz6hJOf9+OJ2tJ8ebpEcBGLaxmi3Rp82me76JDEDjw/RZOVkcgk
	 grySkCEnzEZaQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:38 +0200
Subject: [PATCH v2 15/33] uts: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-15-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Z6OZ5fLqp8itBaP4KETMc+Rrap1MAMb9skiLO6rW064=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZwiPil9Lq+MhVf/hHyuDcf26deYdlo5eFfMfBWz+
 WL2D+7AjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkwszD84a26m55/70adSerW
 p4/4prXdTLC+IPw65Vr35KAK5V9/vjL806xesbPo0qRJ7VkrGYP23tq73j3Q0PnLL4svaWLa+yw
 fsgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/utsname.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f2..02037010b378 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -27,16 +27,6 @@ static void dec_uts_namespaces(struct ucounts *ucounts)
 	dec_ucount(ucounts, UCOUNT_UTS_NAMESPACES);
 }
 
-static struct uts_namespace *create_uts_ns(void)
-{
-	struct uts_namespace *uts_ns;
-
-	uts_ns = kmem_cache_alloc(uts_ns_cache, GFP_KERNEL);
-	if (uts_ns)
-		refcount_set(&uts_ns->ns.count, 1);
-	return uts_ns;
-}
-
 /*
  * Clone a new ns copying an original utsname, setting refcount to 1
  * @old_ns: namespace to clone
@@ -55,17 +45,15 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = create_uts_ns();
+	ns = kmem_cache_zalloc(uts_ns_cache, GFP_KERNEL);
 	if (!ns)
 		goto fail_dec;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = ns_common_init(&ns->ns, &utsns_operations, true);
 	if (err)
 		goto fail_free;
 
 	ns->ucounts = ucounts;
-	ns->ns.ops = &utsns_operations;
-
 	down_read(&uts_sem);
 	memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
 	ns->user_ns = get_user_ns(user_ns);

-- 
2.47.3


