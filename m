Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353C44CE1A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiCEAi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiCEAiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973DF37BF4;
        Fri,  4 Mar 2022 16:37:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224JYXRw011979;
        Sat, 5 Mar 2022 00:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=g7GYPKeDgF6ToIEX/lLAGfQoddnKQ1eXjQW4JkmLpR0=;
 b=jfBQq1RrLUfwHk+YDonAncDeVdgdcoKTEkDEKPuMa6pzslfCplupjx2p0StV9sDHNpzL
 WiO+u+5DPR0rvx6mpS2/j6ehRAC8YUUL5R2AqGLRZ4kYE/gh3kQip6tS0OJh13cS7gsg
 RaDS1KC0OwwUTVi8Rhv3Ko0zS3hXZsya/hIiJN+7BDZU2Qkzcw5yFMFl2Sfjsjn2G46P
 Mr67uSIdWSILlXpGmTKw/fsTmma1nHCxb3BSOmFZbl4+7qEQUWWb8LYDEa2bobjylZJy
 FthhftBwFP310P3dDeuyE/EKOP4QdhxsXiBlM5ZCxXHVYI+5zvQFClS26AMrVMjWLGJB jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvk5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250Pieb146437;
        Sat, 5 Mar 2022 00:37:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:27 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaZ161402;
        Sat, 5 Mar 2022 00:37:26 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-12;
        Sat, 05 Mar 2022 00:37:26 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in client info
Date:   Fri,  4 Mar 2022 16:37:13 -0800
Message-Id: <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: YqHFYic9JW5krl0IQyL6nvttYw0N_tr4
X-Proofpoint-GUID: YqHFYic9JW5krl0IQyL6nvttYw0N_tr4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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
 fs/nfsd/nfs4state.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bced09014e6b..ed14e0b54537 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2439,7 +2439,8 @@ static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
 	struct nfs4_client *clp;
-	u64 clid;
+	u64 clid, hrs;
+	u32 mins, secs;
 
 	clp = get_nfsdfs_clp(inode);
 	if (!clp)
@@ -2451,6 +2452,12 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_puts(m, "status: confirmed\n");
 	else
 		seq_puts(m, "status: unconfirmed\n");
+	seq_printf(m, "courtesy client: %s\n",
+		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
+	hrs = div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
+				3600, &secs);
+	mins = div_u64_rem((u64)secs, 60, &secs);
+	seq_printf(m, "time since last renew: %02ld:%02d:%02d\n", hrs, mins, secs);
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
-- 
2.9.5

