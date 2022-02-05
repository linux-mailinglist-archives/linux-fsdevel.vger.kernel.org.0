Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72874AAA5C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380531AbiBEREi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:04:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40006 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380520AbiBEREi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:04:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE1E60F35;
        Sat,  5 Feb 2022 17:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588BFC340E8;
        Sat,  5 Feb 2022 17:04:37 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/7] NFSD: Clamp WRITE offsets
Date:   Sat,  5 Feb 2022 12:04:36 -0500
Message-Id:  <164408067623.3707.13921614193946451246.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
References:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; h=from:subject:message-id; bh=B0duDWfPZ7mlJ6eFB+7wW3BAunsL5CqPdWmsMKiIVa0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh/q4krTl/Po8hZI9mZ/n3SphGph+V9J1tsCF5f1rv lNrU8PaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYf6uJAAKCRAzarMzb2Z/l+MLEA CdMqWFBPODjbXr2JvjM0iakT/mpXP+46gZ62/ZQxiGDUK2qzyTfi6vHNZVsqXJDK4k+FlGUIsGREuI T1XVJuekHyLjjvQmdJD8B+PXQw2U9t6cCnrbog6nVYKMA/vfQUs2Hk9qd8QWp6S7j7eEPqAMyYphW9 CPzjyJkuznWujYZqInc2CqoPZzTEw9sJOdyLczKFNrsn9FRVLRo5jVewOhtr0DM+nbMH9+AXJJyhS9 CMGfwSOKpJ3fNbf+gNWuoUA+qxMkikluDAqKEC6K9hXKPeKg150AOnBGTXTbWEvsxY5KzBJdSZnm+V wlb4csSkrTF/jhIri7pY6yr8Yt6V0orfieapj85QGwyZmzh6E8pSAVFr51qrM8+/xFGqLlpIZaNvdh LjxuQgIJnknAHKdvpf8q/L1N7mXs115wlVhZezANZT4wtTe2pr+LjAT3E3DWzOpK0IptyVdfcgjor8 5arxQTiMXs/klzZ9TDT+BHs4py4i/dWsEkGWbbVOtujOc0y3hojqdtqh851loe9sxZ9N/9olP9BK78 sNaCsmOttZjjRuO8Z5vZHuXQlGATX29eNMN4G6ZU4KnLWFbf8VXt9Vc/DciDVC7S/srFUigX6KMQPJ GC4oJSAfkN8KbHIDy1YrSMFXMyi7/URWeJ6qQ++Rf8ICnrSmUfFWSsCNvjHA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that a client cannot specify a WRITE range that falls in a
byte range outside what the kernel's internal types (such as loff_t,
which is signed) can represent. The kiocb iterators, invoked in
nfsd_vfs_write(), should properly limit write operations to within
the underlying file system's s_maxbytes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    5 +++++
 fs/nfsd/nfs4proc.c |    5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b5a52528f19f..aca38ed1526e 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -203,6 +203,11 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 				(unsigned long long) argp->offset,
 				argp->stable? " stable" : "");
 
+	resp->status = nfserr_fbig;
+	if (argp->offset > (u64)OFFSET_MAX ||
+	    argp->offset + argp->len > (u64)OFFSET_MAX)
+		return rpc_success;
+
 	fh_copy(&resp->fh, &argp->fh);
 	resp->committed = argp->stable;
 	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71d735b125a0..b207c76a873f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1022,8 +1022,9 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	unsigned long cnt;
 	int nvecs;
 
-	if (write->wr_offset >= OFFSET_MAX)
-		return nfserr_inval;
+	if (write->wr_offset > (u64)OFFSET_MAX ||
+	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
+		return nfserr_fbig;
 
 	cnt = write->wr_buflen;
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,

