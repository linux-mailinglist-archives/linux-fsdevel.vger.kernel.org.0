Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AC1FD63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfEPBq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:28 -0400
Received: from fieldses.org ([173.255.197.46]:33110 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfEPBWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 74ED340CA; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 05/12] nfsd: make client/ directory names small ints
Date:   Wed, 15 May 2019 21:20:12 -0400
Message-Id: <1557969619-17157-8-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We want clientid's on the wire to be randomized for reasons explained in
ebd7c72c63ac "nfsd: randomize SETCLIENTID reply to help distinguish
servers".  But I'd rather have mostly small integers for the clients/
directory.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/netns.h     | 1 +
 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/nfsctl.c    | 5 +++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 46d956676480..888b2891960e 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -121,6 +121,7 @@ struct nfsd_net {
 	 */
 	unsigned int max_connections;
 
+	u32 clientid_base;
 	u32 clientid_counter;
 	u32 clverifier_counter;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dfcb90743861..de99bfe3e6e2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2221,7 +2221,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	clp->cl_cb_session = NULL;
 	clp->net = net;
 	clp->cl_nfsd_dentry = nfsd_client_mkdir(nn, &clp->cl_nfsdfs,
-						clp->cl_clientid.cl_id);
+			clp->cl_clientid.cl_id - nn->clientid_base);
 	if (!clp->cl_nfsd_dentry) {
 		free_client(clp);
 		return NULL;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8a2261cdefee..edf4dada42bf 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1212,7 +1212,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn, struct nfsdfs_client *ncl,
 {
 	char name[11];
 
-	sprintf(name, "%d", id++);
+	sprintf(name, "%u", id);
 
 	return nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
 }
@@ -1350,7 +1350,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->nfsd4_grace = 90;
 	nn->somebody_reclaimed = false;
 	nn->clverifier_counter = prandom_u32();
-	nn->clientid_counter = prandom_u32();
+	nn->clientid_base = prandom_u32();
+	nn->clientid_counter = nn->clientid_base + 1;
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
 
 	atomic_set(&nn->ntf_refcnt, 0);
-- 
2.21.0

