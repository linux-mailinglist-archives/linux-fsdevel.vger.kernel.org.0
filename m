Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED57517909
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387631AbiEBVXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387619AbiEBVXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 17:23:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80E4DFE4;
        Mon,  2 May 2022 14:19:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242KZ9QF019152;
        Mon, 2 May 2022 21:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=KyofMBGNJ4j7aZopkCauDi6CFwk+o48vBfXNbHsnrvM=;
 b=WHHfLBi51SPoLkWGRbXbgVPcv4qf2awLLKhlYL+z8JxbLkt2rbXRLWbA2RuDzKIEsxM6
 KActK8rvBAJ7lRqfi/TjeI8RiKhcyIQW6rHpH+sRk5B0TceirfYhzZd8IlYsFejQ/Z48
 JRc7VBAdEEYbSvUhTVQrotEtsCRKUa1mk6ucLA6Ql11tgO3P1ELgsjemSdVsY0a/whXL
 GS0jmPSw3R8m52MpHEse0kCZBl1ewoI368x+Du6B9pIsRRVIZN0zGlgBb6dqzKNRceYj
 qqjufbIRbPaFYZGXhT/y42dTBQqFTZQdEP8P2RZ0MT/X0TyXYkjR2+NlkVEOodzdd026 dA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0am9df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:19:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242LAk6X029207;
        Mon, 2 May 2022 21:19:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj1v8qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:19:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 242LJXSU003941;
        Mon, 2 May 2022 21:19:36 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj1v8ph-8;
        Mon, 02 May 2022 21:19:36 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v25 7/7] NFSD: Show state of courtesy client in client info
Date:   Mon,  2 May 2022 14:19:27 -0700
Message-Id: <1651526367-1522-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: NjVpRVUZ5etq10rEJvLk6ky2p6bGAiWY
X-Proofpoint-ORIG-GUID: NjVpRVUZ5etq10rEJvLk6ky2p6bGAiWY
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
and seconds since last renew.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2bcdc6e4ad91..231e5c19cdb7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2481,10 +2481,17 @@ static int client_info_show(struct seq_file *m, void *v)
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
+	seq_printf(m, "seconds from last renew: %lld\n",
+		ktime_get_boottime_seconds() - clp->cl_time);
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
-- 
2.9.5

