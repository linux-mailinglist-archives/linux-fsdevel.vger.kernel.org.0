Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44981FD5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfEPBq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:27 -0400
Received: from fieldses.org ([173.255.197.46]:33114 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfEPBWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7D32242A6; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 07/12] nfsd: copy client's address including port number to cl_addr
Date:   Wed, 15 May 2019 21:20:14 -0400
Message-Id: <1557969619-17157-10-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

rpc_copy_addr() copies only the IP address and misses any port numbers.
It seems potentially useful to keep the port number around too.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 928705fc8ff5..c665ce9af773 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2252,7 +2252,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	clp->cl_time = get_seconds();
 	clear_bit(0, &clp->cl_cb_slot_busy);
 	copy_verf(clp, verf);
-	rpc_copy_addr((struct sockaddr *) &clp->cl_addr, sa);
+	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
 	clp->cl_cb_session = NULL;
 	clp->net = net;
 	clp->cl_nfsd_dentry = nfsd_client_mkdir(nn, &clp->cl_nfsdfs,
-- 
2.21.0

