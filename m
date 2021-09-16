Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD6940E9C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 20:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbhIPSYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 14:24:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48656 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349880AbhIPSXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:23:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GHq2FB009079;
        Thu, 16 Sep 2021 18:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=swLR0qNEGbIEpSHZ/x+h+qERXkkDO6AQWVuih/HqNwU=;
 b=UC8J6OFfDv3qKNuLQYP9i7x4vW9UQhX99aYvoP0rgUOyCVv93t+/Wk/t8dYRWlQF/Dly
 KcxltdcoGNQp3exXG2W4NGdXQuKVETvO1gn5+NVqRpUCWPZ2nTLIjxQLgH3XpAL2lrdL
 0NMclwXzmZXm0fOwqLPYw2Me+JARAEYT71VlnobxGziPkCo87YKZCMD7jaiLbgt0u/uW
 X73s0Y1IL4FdDqBiaT7E8gKp6VW5itSmmfXvbjUsfS5XQ8P07uyq+ij60da9gMOel2Om
 /Ydfd/+1M+M/jDzwUBMZc9miZFDe/PQCveZfR7JHbUtGGZjKXnCCplD4v/YFgWdTJA/t +Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=swLR0qNEGbIEpSHZ/x+h+qERXkkDO6AQWVuih/HqNwU=;
 b=ptX4PDk0kSAumJPRdJgdg+/eE4uYynPDJ7IkrRW4/cAu5VyXDxnU9hhDwfgfqgEjACGO
 Xrf4XUVStdaCeHPfW/FseD1IqMRHCNtFNV3t2sq0NAFdD0yI+KkmKx4Xmqr0/6YA2Su7
 ahYMVqjRwOAEq4QO+dmGF8LUlJ//DSFhUtwjuD1aYe9ZNM89U7KvnsOJ7f4Wt0OLWTIO
 lh+qc4pRQApudOsKGrtAXQVuWelfkwC/Qqgc9ye9h/esXBDCU7X0Exg5lV5c25PqBr5Y
 Gllf/VcLhBFPg06gKOyzvCGMHoTGR8PsOmhxW5VLP2NHxMJyYscBUejXtNEoRZTGUm8r nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3s74kmuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:22:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GIAV8h149748;
        Thu, 16 Sep 2021 18:22:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3b0m99rpg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:22:21 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 18GIK46g182960;
        Thu, 16 Sep 2021 18:22:20 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3b0m99rpeg-4;
        Thu, 16 Sep 2021 18:22:20 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/3] nfsd: back channel stuck in SEQ4_STATUS_CB_PATH_DOWN
Date:   Thu, 16 Sep 2021 14:22:12 -0400
Message-Id: <20210916182212.81608-4-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210916182212.81608-1-dai.ngo@oracle.com>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RzmrLqrSK54RxiH_XbUYugmRerdIW01C
X-Proofpoint-GUID: RzmrLqrSK54RxiH_XbUYugmRerdIW01C
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the back channel enters SEQ4_STATUS_CB_PATH_DOWN state, the client
recovers by sending BIND_CONN_TO_SESSION but the server fails to recover
the back channel and leaves it as NFSD4_CB_DOWN.

Fix by enhancing nfsd4_bind_conn_to_session to probe the back channel
by calling nfsd4_probe_callback.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 54e5317f00f1..63b4d0e6fc29 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3580,7 +3580,7 @@ static struct nfsd4_conn *__nfsd4_find_conn(struct svc_xprt *xpt, struct nfsd4_s
 }
 
 static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
-				struct nfsd4_session *session, u32 req)
+		struct nfsd4_session *session, u32 req, struct nfsd4_conn **conn)
 {
 	struct nfs4_client *clp = session->se_client;
 	struct svc_xprt *xpt = rqst->rq_xprt;
@@ -3603,6 +3603,8 @@ static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
 	else
 		status = nfserr_inval;
 	spin_unlock(&clp->cl_lock);
+	if (status == nfs_ok && conn)
+		*conn = c;
 	return status;
 }
 
@@ -3627,8 +3629,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(session->se_client, rqstp))
 		goto out;
-	status = nfsd4_match_existing_connection(rqstp, session, bcts->dir);
-	if (status == nfs_ok || status == nfserr_inval)
+	status = nfsd4_match_existing_connection(rqstp, session,
+			bcts->dir, &conn);
+	if (status == nfs_ok) {
+		if (bcts->dir == NFS4_CDFC4_FORE_OR_BOTH ||
+				bcts->dir == NFS4_CDFC4_BACK)
+			conn->cn_flags |= NFS4_CDFC4_BACK;
+		nfsd4_probe_callback(session->se_client);
+		goto out;
+	}
+	if (status == nfserr_inval)
 		goto out;
 	status = nfsd4_map_bcts_dir(&bcts->dir);
 	if (status)
-- 
2.9.5

