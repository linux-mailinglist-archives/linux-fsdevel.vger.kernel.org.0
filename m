Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36EB512C53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 09:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244870AbiD1HKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbiD1HKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:10:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83044996A4;
        Thu, 28 Apr 2022 00:06:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S65Fgo032176;
        Thu, 28 Apr 2022 07:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=jtBJGqf5xgvESLaeCwAvjDdsZDXODqkmqPSSCXdE62U=;
 b=dNumFeIctkzpdRFDGngX2Px2FHFZJGu0FhbVcPJiUWHYFa/vh+PyVcCwmkGR0SRAtA8T
 3EfFqJGzyKwBKHvLQ06g5Rnnde2meFlKcUX+XRdLK172ylcKA5xiH7iRVEzLGbOYRgOm
 zlTlyJtyV3pETPvkjjhGYLIEIEfiPK9AdqsX++J8hOPHX61Hu2Ki32468THi1MQScF+5
 e3zbJvTxCo4z6W+sTb8Dv3rjsIJVD2kcRkjvgGD1Gj16hf56SdlqOzLRnpPmoHoxCnzj
 QwUrYYPItOaZOdtPKwMTUEXArIp8XP7CKcI8x6BoJz//fIdLudwWkTaeNXT+r/lGNu55 GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb102nh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S70Bc3019500;
        Thu, 28 Apr 2022 07:06:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23S76cAo007862;
        Thu, 28 Apr 2022 07:06:46 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634qj-8;
        Thu, 28 Apr 2022 07:06:46 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v23 7/7] NFSD: Show state of courtesy client in client info
Date:   Thu, 28 Apr 2022 00:06:35 -0700
Message-Id: <1651129595-6904-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: V01lDeMOUBuEPTB832FyYBOpP4YSblld
X-Proofpoint-GUID: V01lDeMOUBuEPTB832FyYBOpP4YSblld
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index cf6d5ebea17a..9f4c0327415c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2471,7 +2471,8 @@ static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
 	struct nfs4_client *clp;
-	u64 clid;
+	u64 clid, hrs;
+	u32 mins, secs;
 
 	clp = get_nfsdfs_clp(inode);
 	if (!clp)
@@ -2479,10 +2480,19 @@ static int client_info_show(struct seq_file *m, void *v)
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

