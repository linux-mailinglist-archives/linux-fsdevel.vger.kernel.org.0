Return-Path: <linux-fsdevel+bounces-28120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D699673AF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA1A1C21070
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9041822F8;
	Sat, 31 Aug 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO8W8K6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83318890C;
	Sat, 31 Aug 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143890; cv=none; b=h0CgV9sTs5upEqWR6+LvegVATxUPr4jRCN24X6FaJXek1Jn/d30R/an/WdoBBw9RSt79SDxc7us2a+HByY9L9tCkwpeFK5z+VsAo6YZi+p+qnHaVvh9MWUNd57QZStvt6eYU5K5kTIK07YRGb6xkygNXZqoZz0Npr3JvL9jTcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143890; c=relaxed/simple;
	bh=ewPT2nHxQMEfBBIGXSHmcQYb4XBasbobywAtIkV10Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWC1gXlp+z5wAAxd3zutVOEuIeAIhFsxVoIm53CzC7cNvGQ72fdyoYNaAtYje6wUOEEheT53CKMxuvz+CTslgS5jjCXdcv9u7QUDxawXk/zfnvGShuA0cFN5sFL/1nSZfuHHDOi4A4Tswdo4JWIwEv3PN5mc+uB/IomdelCUdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO8W8K6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5106C4CEC4;
	Sat, 31 Aug 2024 22:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143890;
	bh=ewPT2nHxQMEfBBIGXSHmcQYb4XBasbobywAtIkV10Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XO8W8K6LNDoRHWLBXUB4Ldjquq4O+NTUu0unBEMQMxVVvAolKLoXp+t+n+qIKGd+k
	 LmeDnxR0gsPyxyAAtUie0ZNUQPbDRJqczwdjH6R91SVhCD5yPPf17reWBdfzeSD32Q
	 qRzswtURl8rgAp85R6XMG1DaEXJfsvXZtg+Dpq1zgjzOc26rwfr0b5HSjEJr7m5Tmi
	 6BEVs32UCl0u5Hx/u97xKACtaSeDqYPjs/pAGeJzkkxOPfgluNYKxCHE5/mArVXm1S
	 QB1bbhGA67/8Z7R9q05m4quYUFZXEVgqyAA4yuWD0d2pO7ou5c43hKMkUouHtO+aPr
	 ZVhnLf8q4dTmw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 10/26] nfsd: add nfsd_serv_try_get and nfsd_serv_put
Date: Sat, 31 Aug 2024 18:37:30 -0400
Message-ID: <20240831223755.8569-11-snitzer@kernel.org>
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

Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
caller of nfsd_serv_try_get releases their reference using nfsd_serv_put.

A percpu_ref is used to implement the interlock between
nfsd_destroy_serv and any caller of nfsd_serv_try_get.

This interlock is needed to properly wait for the completion of client
initiated localio calls to nfsd (that are _not_ in the context of nfsd).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/netns.h  |  8 +++++++-
 fs/nfsd/nfssvc.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 238fc4e56e53..e2d953f21dde 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/filelock.h>
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
 
@@ -139,7 +140,9 @@ struct nfsd_net {
 
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
-
+	struct percpu_ref nfsd_serv_ref;
+	struct completion nfsd_serv_confirm_done;
+	struct completion nfsd_serv_free_done;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -221,6 +224,9 @@ struct nfsd_net {
 extern bool nfsd_support_version(int vers);
 extern unsigned int nfsd_net_id;
 
+bool nfsd_serv_try_get(struct nfsd_net *nn);
+void nfsd_serv_put(struct nfsd_net *nn);
+
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
 void nfsd_reset_write_verifier(struct nfsd_net *nn);
 #endif /* __NFSD_NETNS_H__ */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index defc430f912f..e43d440f9f0a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -193,6 +193,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
+bool nfsd_serv_try_get(struct nfsd_net *nn)
+{
+	return percpu_ref_tryget_live(&nn->nfsd_serv_ref);
+}
+
+void nfsd_serv_put(struct nfsd_net *nn)
+{
+	percpu_ref_put(&nn->nfsd_serv_ref);
+}
+
+static void nfsd_serv_done(struct percpu_ref *ref)
+{
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+
+	complete(&nn->nfsd_serv_confirm_done);
+}
+
+static void nfsd_serv_free(struct percpu_ref *ref)
+{
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+
+	complete(&nn->nfsd_serv_free_done);
+}
+
 /*
  * Maximum number of nfsd processes
  */
@@ -392,6 +416,7 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+	percpu_ref_exit(&nn->nfsd_serv_ref);
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -471,6 +496,13 @@ void nfsd_destroy_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
+	lockdep_assert_held(&nfsd_mutex);
+
+	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
+	wait_for_completion(&nn->nfsd_serv_confirm_done);
+	wait_for_completion(&nn->nfsd_serv_free_done);
+	/* percpu_ref_exit is called in nfsd_shutdown_net */
+
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
 	spin_unlock(&nfsd_notifier_lock);
@@ -595,6 +627,13 @@ int nfsd_create_serv(struct net *net)
 	if (nn->nfsd_serv)
 		return 0;
 
+	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
+				0, GFP_KERNEL);
+	if (error)
+		return error;
+	init_completion(&nn->nfsd_serv_free_done);
+	init_completion(&nn->nfsd_serv_confirm_done);
+
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-- 
2.44.0


