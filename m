Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9549E719
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiA0QJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiA0QJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:09:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C7C061714;
        Thu, 27 Jan 2022 08:09:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F3C618A8;
        Thu, 27 Jan 2022 16:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8FDC340E8;
        Thu, 27 Jan 2022 16:09:04 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 6/6] NFSD: Clamp WRITE offsets
Date:   Thu, 27 Jan 2022 11:09:04 -0500
Message-Id:  <164329974386.5879.9570306264604837233.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
References:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; h=from:subject:message-id; bh=GTLq72CbZ2YKLEMKSvDESFVcQNdG1hLyX3YuhtlMYXY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8sOfOwpoBVkKovhUsUkE5Ib8gOUmIEsFzKgqxNDI CAtJCRyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfLDnwAKCRAzarMzb2Z/l/bAD/ 4wStVMzb4aek3np1pM4E9ybdY8naM+MLh7qcDp2Cm2xLa5LEu245UYoDIGbxNwRPQpRq45zQuinDeu 5wCCGrRkzLr0FAoMCBB2/knrHIVbqmEjvzHnky5rOneCoIrMDUlmbo1ZKF0EE+cSXLjR2X/n+4cWlj P4d9XFDq3dCThRx3t7EBbVIkuFpoD6T5iWYZZIIdvLODw/qFXB3LgElSCcNzmt+Na5MfnbcSNr2Rr8 0oiEheFTxYQroTAWRBFHq/AYxUlSCPLn5oBnjDQmMj1Z1j2DbIGxsI3BFBayeoaK3ITWB8BSGvb27e HZMGkiww1DCeBp57UGbnLE5mYnazIIfxZ9+admV5KhD+vqu1jLFWVPlZC1mHpjxWT6tM7gjO4ezvyf rPtyEn8ZGyDKkaEZNZ3IFQgLGKpxKUvfSjYaeeC0G77+VVp2Ruux7/liKpBdxe7lGH5e5UfKBVsdwg ZwZNYCd7Ox6JdpL+kXn85i3FfuX2w6ZlwyFR7aTg8YdU90FyYMQsDRwxUXScp4tvyS3dc3TYfjbMBa vwTlW5tlkUrw7r9413jLyqDHCaFyRJaIPUuRUW83rzCdExaRSNxjiwnGUFp2DoT8P6M/fWr5qsujxR 1RZ0XmmX9ruWw0v8tD7ern3Ws2HkbJWN01mTu6oKnoEBMSPBnztUBvdrPIhw==
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
 fs/nfsd/nfs3proc.c |    7 +++++++
 fs/nfsd/nfs4proc.c |    4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 7bca219a8146..ba72bbff53a5 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -216,6 +216,12 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 				(unsigned long long) argp->offset,
 				argp->stable? " stable" : "");
 
+	resp->status = nfserr_fbig;
+	if (argp->offset >= OFFSET_MAX)
+		goto out;
+	if (argp->offset + argp->len >= OFFSET_MAX)
+		goto out;
+
 	fh_copy(&resp->fh, &argp->fh);
 	resp->committed = argp->stable;
 	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
@@ -224,6 +230,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 				  rqstp->rq_vec, nvecs, &cnt,
 				  resp->committed, resp->verf);
 	resp->count = cnt;
+out:
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b8ac2b9bce74..2baf547b344f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1022,7 +1022,9 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int nvecs;
 
 	if (write->wr_offset >= OFFSET_MAX)
-		return nfserr_inval;
+		return nfserr_fbig;
+	if (write->wr_offset + write->wr_buflen >= OFFSET_MAX)
+		return nfserr_fbig;
 
 	cnt = write->wr_buflen;
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,

