Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8B4EDE2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiCaQEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiCaQEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805E2162194;
        Thu, 31 Mar 2022 09:02:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEnEPU030446;
        Thu, 31 Mar 2022 16:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=5qhP6a5w/pe2jL6JHuQb8UsQANthSTakX+/4JdQZ6G8=;
 b=ZWsbxysmOpf1A7mN0zIcNfPuHaOPuhHpNsD2x3Nj8vH2ae5NHpXSI4j0EBVXWCvdLmvW
 yD5TgN9zypb82tPtJ/4EjIoBTtpMCObK00rT2RniRf+InLtEVgJs4nTd92jYJFK6s4H3
 kc28HDrdNoh5B4lUxIg+IlhP1huwTLt+9I1tZaWDD4FKoT4Q880u044aed8SHmi3Lio4
 OquUsNHho2lqgVuZ1GGDH2BLa8O2+NsHHbKpygBLjZdtYFBHtw9DHuNy63955fxLhGcp
 gIldTV2KpZJ+3TucNa3N+DQHyvlbaJc0bgXxVxjIjRsoMGmdn6RDhjSz95y1+ubBeF4n iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0mtm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFvMJV029475;
        Thu, 31 Mar 2022 16:02:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VG10K3003132;
        Thu, 31 Mar 2022 16:02:15 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxf8-5;
        Thu, 31 Mar 2022 16:02:15 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v19 04/11] NFSD: Update nfsd_breaker_owns_lease() to handle courtesy clients
Date:   Thu, 31 Mar 2022 09:02:02 -0700
Message-Id: <1648742529-28551-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: Y-4m6JXf3EcQQkGYz7D1NtaCVqNAG7SO
X-Proofpoint-GUID: Y-4m6JXf3EcQQkGYz7D1NtaCVqNAG7SO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update nfsd_breaker_owns_lease() to handle delegation conflict with
courtesy clients by calling nfsd4_expire_courtesy_clnt.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 80772662236b..f20c75890594 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4727,6 +4727,9 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	if (nfsd4_expire_courtesy_clnt(dl->dl_stid.sc_client))
+		return true;
+
 	if (!i_am_nfsd())
 		return false;
 	rqst = kthread_data(current);
-- 
2.9.5

