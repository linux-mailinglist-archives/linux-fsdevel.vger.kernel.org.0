Return-Path: <linux-fsdevel+bounces-26294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702E9572D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43363285255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA0189F2F;
	Mon, 19 Aug 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grB86qAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D8189BAF;
	Mon, 19 Aug 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091483; cv=none; b=R5dxMMDKVRmT/enlCyiOe8JybckBWL9wqq35CSCa9eEOpkga1aTq8c1Op9p3I+i0WTKeg9KkpMfe8IO4GGx6Okfg4A/g+xoeuBjbLkamXFjrZyvzRNC6+1Gz4bP1qEGZsOwQ9UMPBHzjaxrnqszTRd0Q09wzZrCNAX3c5/aH4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091483; c=relaxed/simple;
	bh=eKSyo4M/PwL7v/TFiclRIphm4rgipy9E/7hryKERvTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGk/zJUu5TyPKp1vH91LQnlOUjLdCJkaGU/X1EJRvgVuuvXO0X51U6WgYnPj0jR6qYoE7Z8pirbFIR+PIdFePJ9XcjnuB6UKjjyh1ezuD5dGSV/0IgKHaqYk0jTDKIEQc0CkfVDbpUpA1rIocrC1jlFSFnmWB+4pN1aWKIlT9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grB86qAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA4C4AF0C;
	Mon, 19 Aug 2024 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091483;
	bh=eKSyo4M/PwL7v/TFiclRIphm4rgipy9E/7hryKERvTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grB86qArsvXye1TvUsFsxOSJerPr4NqyGMXSeXt1hcd7aAjxVK8KLI+RFWSi2Fkxj
	 h/JEz1V6uj43CmhHx0kQyaCvQ7v161RvOwUAgOxpjnrvp+I0EogcNt6LDd/rbEZOJn
	 0nScu9dKiF7IVhg2V1tFQjQ/wVW73QImgZp5E7Mw6wyZ2xsstVf/vA3qvg6BaejR8R
	 pmAE7oQzjRptd1GRD+K/BOSWKasK3JGZ1z9MiVOmvSbp8073kkE5wsvf/A+GbN9hfD
	 VHyBMsWrlW/8KmEpK6bpmd9GC0ZzIwL6iCH3wBNelEl/lPV1B9YrW6vtzMHU3ei7Cj
	 nLup4ml8sEYZQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 08/24] SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
Date: Mon, 19 Aug 2024 14:17:13 -0400
Message-ID: <20240819181750.70570-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Add new funtion rpcauth_map_clnt_to_svc_cred_local which maps a
generic cred to a svc_cred suitable for use in nfsd.

This is needed by the localio code to map nfs client creds to nfs
server credentials.

Following from net/sunrpc/auth_unix.c:unx_marshal() it is clear that
->fsuid and ->fsgid must be used (rather than ->uid and ->gid).  In
addition, these uid and gid must be translated with from_kuid_munged()
so local client uses correct uid and gid when acting as local server.

Suggested-by: NeilBrown <neilb@suse.de> # to approximate unx_marshal()
Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/sunrpc/auth.h |  4 ++++
 net/sunrpc/auth.c           | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 61e58327b1aa..4cfb68f511db 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -11,6 +11,7 @@
 #define _LINUX_SUNRPC_AUTH_H
 
 #include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/xdr.h>
 
@@ -184,6 +185,9 @@ int			rpcauth_uptodatecred(struct rpc_task *);
 int			rpcauth_init_credcache(struct rpc_auth *);
 void			rpcauth_destroy_credcache(struct rpc_auth *);
 void			rpcauth_clear_credcache(struct rpc_cred_cache *);
+void			rpcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
+							   const struct cred *,
+							   struct svc_cred *);
 char *			rpcauth_stringify_acceptor(struct rpc_cred *);
 
 static inline
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 04534ea537c8..3b6d91b36589 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -17,6 +17,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/spinlock.h>
+#include <linux/user_namespace.h>
 
 #include <trace/events/sunrpc.h>
 
@@ -308,6 +309,27 @@ rpcauth_init_credcache(struct rpc_auth *auth)
 }
 EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
 
+void
+rpcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
+				   const struct cred *cred,
+				   struct svc_cred *svc)
+{
+	struct user_namespace *userns = clnt->cl_cred ?
+		clnt->cl_cred->user_ns : &init_user_ns;
+
+	memset(svc, 0, sizeof(struct svc_cred));
+
+	svc->cr_uid = KUIDT_INIT(from_kuid_munged(userns, cred->fsuid));
+	svc->cr_gid = KGIDT_INIT(from_kgid_munged(userns, cred->fsgid));
+	svc->cr_flavor = clnt->cl_auth->au_flavor;
+	if (cred->group_info)
+		svc->cr_group_info = get_group_info(cred->group_info);
+	/* These aren't relevant for local (network is bypassed) */
+	svc->cr_principal = NULL;
+	svc->cr_gss_mech = NULL;
+}
+EXPORT_SYMBOL_GPL(rpcauth_map_clnt_to_svc_cred_local);
+
 char *
 rpcauth_stringify_acceptor(struct rpc_cred *cred)
 {
-- 
2.44.0


