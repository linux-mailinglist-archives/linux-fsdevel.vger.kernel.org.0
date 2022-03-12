Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D4C4D6BEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 03:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiCLCPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 21:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiCLCPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:15:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2511C1AD942;
        Fri, 11 Mar 2022 18:13:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C1Vdwt023826;
        Sat, 12 Mar 2022 02:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=ancRsNJ/fXVbrikDCqx4d3U/VLdR68Xz3Mugzj1HFQA=;
 b=PEd6Ggss685mhgrQO6MA41G/TDzyKrwdsgPlkjaRPQKSo/HEMECMF5hKWK75eiBqNLX9
 x5iCemgqdO9ixnjaKHhO4KRpkhDjDKM2Y8x5/VHt5HWwoQjnszSmI5VbWB/zWSvd+xcS
 Cr9g0t+ZdQCgT7c7jM4enwHxUOrNQoCChXqn9F2T0gmF7wiLAl8pzZq73i5CstzVY5x5
 ux58yd99jEW9J4OwScjaWL0l1Gg/3c7axZzns887g+ij4HTK4pbDZKjPBTlCqyiaQcS0
 2GmI6RuLRSvkWSzrMYMCWZ8bIJ29siE1U4B9JqtkAojeVZ4jrHcaHUs0i+tbzLo/VQpb rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erhxcg0vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C2CA0V084327;
        Sat, 12 Mar 2022 02:13:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3erhj88qgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22C2DgMl086332;
        Sat, 12 Mar 2022 02:13:49 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfe-12;
        Sat, 12 Mar 2022 02:13:49 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v16 11/11] NFSD: Show state of courtesy clients in client info
Date:   Fri, 11 Mar 2022 18:13:35 -0800
Message-Id: <1647051215-2873-12-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: Q9B1b3rdXbWYzd5YvWpUdYtKF2Sr41zB
X-Proofpoint-ORIG-GUID: Q9B1b3rdXbWYzd5YvWpUdYtKF2Sr41zB
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
 fs/nfsd/nfs4state.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 17b5d5b202c1..79f60bb7be76 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2438,7 +2438,8 @@ static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
 	struct nfs4_client *clp;
-	u64 clid;
+	u64 clid, hrs;
+	u32 mins, secs;
 
 	clp = get_nfsdfs_clp(inode);
 	if (!clp)
@@ -2446,10 +2447,16 @@ static int client_info_show(struct seq_file *m, void *v)
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: 0x%llx\n", clid);
 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
-	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
+	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
+		seq_puts(m, "status: courtesy\n");
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

