Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6584D4E6D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 05:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346980AbiCYEgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 00:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358241AbiCYEgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:36:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5EC682F;
        Thu, 24 Mar 2022 21:35:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ONb2Si031192;
        Fri, 25 Mar 2022 04:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=gyQqK7dCX48o4jiHAdmiq+u3QAEhj/882VQxChuwKY8=;
 b=bsKZRtCF9qALUGagT2sfHUo+rdiKz0Rf+q+CFHt4AoLualj8aOHJjZ0a7ToxuKtm0L/j
 WsJUz4okzi9GqlTrq2ALNbD/acBScDx+eUOs8DUpxxtS35XDSh0BLoSu7zZak8iaJMGb
 NunTQoAYbUvM+H4jVSo8Oh9p061h1HulnBgCMsnTLHJICLmCwbuRa7NfcStrgWutO3hJ
 nLrUTImYmIwikjbOMGsY+7WYfim9Mx0VWTxd3LVUntaT8hY2maBYDt09rHBdxO07eg/w
 24B4964E6ptGg6QCyEqc6TxJleF67K5+nxDSyOCIkBbdk+HNEU0dt68whPgmCpjtnaPX 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0x9x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:35:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22P4WDEW020751;
        Fri, 25 Mar 2022 04:35:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:35:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22P4YsCo040479;
        Fri, 25 Mar 2022 04:35:05 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bmt-12;
        Fri, 25 Mar 2022 04:35:05 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v18 11/11] NFSD: Show state of courtesy clients in client info
Date:   Thu, 24 Mar 2022 21:34:51 -0700
Message-Id: <1648182891-32599-12-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: WR0hTULfwCEo-EM0UYDz2r2x8Bx2NM--
X-Proofpoint-ORIG-GUID: WR0hTULfwCEo-EM0UYDz2r2x8Bx2NM--
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update client_info_show to show state of courtesy client
and time since last renew.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6169cbb74d31..5f003271004c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2470,7 +2470,8 @@ static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
 	struct nfs4_client *clp;
-	u64 clid;
+	u64 clid, hrs;
+	u32 mins, secs;
 
 	clp = get_nfsdfs_clp(inode);
 	if (!clp)
@@ -2478,10 +2479,17 @@ static int client_info_show(struct seq_file *m, void *v)
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: 0x%llx\n", clid);
 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
-	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
+
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY)
+		seq_puts(m, "status: courtesy\n");
+	else if (clp->cl_cs_client_state == NFSD4_CLIENT_CONFIRMED)
 		seq_puts(m, "status: confirmed\n");
 	else
 		seq_puts(m, "status: unconfirmed\n");
+	hrs = div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
+				3600, &secs);
+	mins = div_u64_rem((u64)secs, 60, &secs);
+	seq_printf(m, "time since last renew: %llu:%02u:%02u\n", hrs, mins, secs);
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
-- 
2.9.5

