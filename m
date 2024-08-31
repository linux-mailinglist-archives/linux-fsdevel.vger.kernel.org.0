Return-Path: <linux-fsdevel+bounces-28122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC49673B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9FE280A0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF2188CBC;
	Sat, 31 Aug 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzHiH/0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180F183063;
	Sat, 31 Aug 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143893; cv=none; b=FLfdSiZpQl3qhg3N6wgnl7FyjqkaaAE3j0S9x/9G8Fr/QOkQZZPX8Wr5vzxG/jkGhgnCypRn0QzhnEvJuMsOfT3U8jollJlZAjEtrlMf9kJKFb1kxJBuJ/f+GK7dVRdo82vOk64wMnoxa/p23yL+PyaVwpK4PDXpn5F1z+udxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143893; c=relaxed/simple;
	bh=m1Gv88aEcs5MzUqmo/jehkur/kUbUDiHgZzp+gG4//k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nH1RQHtwJEdi/RLl2lmnzinprmkv8sQ3Yx42WuLZJzBvt8JR7/RzKhVpo4DQQKW9kr/zl59x2xmIGfcsrhlK/7Eic3cKJcHynYn7NW8vsAZRAlBGKniMFJx19gDlt1rZNgPKmSr6pfLkMc1JVKVGQj9VN0yFyLAlL3O0V3/H1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzHiH/0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ED1C4CEC4;
	Sat, 31 Aug 2024 22:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143892;
	bh=m1Gv88aEcs5MzUqmo/jehkur/kUbUDiHgZzp+gG4//k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzHiH/0kZBgIzkQl56ruDJIj8qysWmMi8Y64lMG4g3jpPB9hmEb9paamWcenSReii
	 dPTWH2RHJhbpj7/2sjfYOdKe4+u43o7c77rxg3MIdSzIfG70LdV56Zr/0ugRW919wE
	 USJJIaeOuK3TKsOeMklPvjOczXw0zdfGtGBYLj4kFbhGAN7FDN5vJkb25cckT3bfqW
	 7I//6nKuldVhhWx6QLQArRrt2B6OmoKwE/UgBETAYIkUcpFkjguVGHgfJOrDAzXsUH
	 4i7K/KLIrMRxyuIjJSk2Auj7nIdEXktOPNFxYmAcShqAY8q1y9NXoQBjb3wJpclwyZ
	 hM4M0H7oG0L8Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 12/26] SUNRPC: add svcauth_map_clnt_to_svc_cred_local
Date: Sat, 31 Aug 2024 18:37:32 -0400
Message-ID: <20240831223755.8569-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Add new funtion svcauth_map_clnt_to_svc_cred_local which maps a
generic cred to a svc_cred suitable for use in nfsd.

This is needed by the localio code to map nfs client creds to nfs
server credentials.

Following from net/sunrpc/auth_unix.c:unx_marshal() it is clear that
->fsuid and ->fsgid must be used (rather than ->uid and ->gid).  In
addition, these uid and gid must be translated with from_kuid_munged()
so local client uses correct uid and gid when acting as local server.

Jeff Layton noted:
  This is where the magic happens. Since we're working in
  kuid_t/kgid_t, we don't need to worry about further idmapping.

Suggested-by: NeilBrown <neilb@suse.de> # to approximate unx_marshal()
Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svcauth.h |  5 +++++
 net/sunrpc/svcauth.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 63cf6fb26dcc..2e111153f7cd 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -14,6 +14,7 @@
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/gss_api.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/hash.h>
 #include <linux/stringhash.h>
 #include <linux/cred.h>
@@ -157,6 +158,10 @@ extern enum svc_auth_status svc_set_client(struct svc_rqst *rqstp);
 extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
 extern void	svc_auth_unregister(rpc_authflavor_t flavor);
 
+extern void	svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
+						   const struct cred *,
+						   struct svc_cred *);
+
 extern struct auth_domain *unix_domain_find(char *name);
 extern void auth_domain_put(struct auth_domain *item);
 extern struct auth_domain *auth_domain_lookup(char *name, struct auth_domain *new);
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 93d9e949e265..55b4d2874188 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -18,6 +18,7 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/err.h>
 #include <linux/hash.h>
+#include <linux/user_namespace.h>
 
 #include <trace/events/sunrpc.h>
 
@@ -175,6 +176,33 @@ rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_auth_flavor);
 
+/**
+ * svcauth_map_clnt_to_svc_cred_local - maps a generic cred
+ * to a svc_cred suitable for use in nfsd.
+ * @clnt: rpc_clnt associated with nfs client
+ * @cred: generic cred associated with nfs client
+ * @svc: returned svc_cred that is suitable for use in nfsd
+ */
+void svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
+					const struct cred *cred,
+					struct svc_cred *svc)
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
+EXPORT_SYMBOL_GPL(svcauth_map_clnt_to_svc_cred_local);
+
 /**************************************************
  * 'auth_domains' are stored in a hash table indexed by name.
  * When the last reference to an 'auth_domain' is dropped,
-- 
2.44.0


