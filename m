Return-Path: <linux-fsdevel+bounces-26966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875295D4FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2731C2269F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A36192B8C;
	Fri, 23 Aug 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtQfT5iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D169191F80;
	Fri, 23 Aug 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436875; cv=none; b=TsZuRtaEsDoLX+q7bXX5XIOTuVKZ0jV+RIaVDSpObla8jkosX1aX+0mx9GkW8kviLNZRixP0GBeX0CPBV2wyj5yzffCxfTP81uYd/JS9HbI70EYcEu7p/kHE7qEcl50/xGqgERWB3y7AzXnKeRrXwv9ba8SLwRHEm1o6k0yXnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436875; c=relaxed/simple;
	bh=eKSyo4M/PwL7v/TFiclRIphm4rgipy9E/7hryKERvTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0l3karmhiXQb4QioWmS0S2SwdRTm9gfTsbM9Eumk4C0Kv3qj0qWNL3l/PfxF/4lBMZsmnX786olSYMflC88PB0pXSURlqIfcbSVNyswTw2evZoKyGCu7YJpeG+lyhcrrMYc2mELPG3CHS0k9DWUOHvHco7QLJaHPpSaDmA3o30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtQfT5iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700D6C4AF09;
	Fri, 23 Aug 2024 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436874;
	bh=eKSyo4M/PwL7v/TFiclRIphm4rgipy9E/7hryKERvTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtQfT5iCxXE7SsJffXvpdDiZUDJE1UCHgkxXDFTUbJtWi5JyDtXPWOZXcU2c+AjiZ
	 dIrfL0dvZbPfux/kL7FX9vBUlBOedFm5V3GHEX+POgKu/3DwS2kRA8zZwQ+NIN+3ch
	 Yb+ffuRK3vgeGqCavR4TdF5m0AazRzuxpi3SOptQ8F/8fu9XBshzVE6AgIJT2GU/T9
	 8+ZpKw8RZ5cLvRxtQ4mMU5H5vileQ7Ym63QhRd2rCdyYjKzGs9k1yiBjouG0K5yR8z
	 e91rxf5iUKKbHsxQEPz4sUykX6xfF8n9KG0DJ21EqWmJ5gAWoFzVopcG1u67L6Hblk
	 w3S+94U4ogBwg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 07/19] SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
Date: Fri, 23 Aug 2024 14:14:05 -0400
Message-ID: <20240823181423.20458-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
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


