Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B95166BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353565AbiEARmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 May 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353507AbiEARlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 May 2022 13:41:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0076ADB6;
        Sun,  1 May 2022 10:38:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241BHwRE018680;
        Sun, 1 May 2022 17:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=E/GTxQk2KNnq1EwYz6qUlI+kamrJj4MhgIkEoNk7mb4=;
 b=qvMhXoo1AG7PSu/NDfTwPDdN5wlzbF29M2Nsm0JS7HyYcV8a7Ol6cSBACwB4qKAk4CY0
 M1dIuUHRe2BSw12JdmSNyS31V2RaOXbu5ZBYC0/lhvMVPuLoEB6v87tGb4BG2RYqNil/
 oPBPUpJeupgvkBLAVbd7QM39Bw/dBRYjoaKXflEOLednt2XcskAAnMnHMTYP1bS4e9jA
 sNojPFwp86eubnRD8I4ET8h1PAXh18Il6boEUuKz1/8cTouUFlx6lpY+sQ2VSeAdoR7W
 VNVc7GN8crniIJK7JUnIqDWaSnSvZrNOBZvqQUmYtGh8SufXcWBkwLVXbpBQ/8H2l0XC mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt1sre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 241HZCjF033348;
        Sun, 1 May 2022 17:38:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 241HauVn034841;
        Sun, 1 May 2022 17:38:23 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w5x-8;
        Sun, 01 May 2022 17:38:23 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v24 7/7] NFSD: Show state of courtesy client in client info
Date:   Sun,  1 May 2022 10:38:16 -0700
Message-Id: <1651426696-15509-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: qhK_C0TCoxJd4TEk2dr9hmKw7QA9d5Ms
X-Proofpoint-GUID: qhK_C0TCoxJd4TEk2dr9hmKw7QA9d5Ms
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update client_info_show to show state of courtesy client
and time since last renew.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4ab7dda44f38..9cff06fc3600 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2473,7 +2473,8 @@ static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
 	struct nfs4_client *clp;
-	u64 clid;
+	u64 clid, hrs;
+	u32 mins, secs;
 
 	clp = get_nfsdfs_clp(inode);
 	if (!clp)
@@ -2481,10 +2482,19 @@ static int client_info_show(struct seq_file *m, void *v)
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: 0x%llx\n", clid);
 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
-	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
+
+	if (clp->cl_state == NFSD4_COURTESY)
+		seq_puts(m, "status: courtesy\n");
+	else if (clp->cl_state == NFSD4_EXPIRABLE)
+		seq_puts(m, "status: expirable\n");
+	else if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
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

