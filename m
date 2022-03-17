Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8104DC05D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiCQHpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiCQHpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:45:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC4C12F9;
        Thu, 17 Mar 2022 00:43:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3aUjX006894;
        Thu, 17 Mar 2022 07:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=5qhP6a5w/pe2jL6JHuQb8UsQANthSTakX+/4JdQZ6G8=;
 b=yV7FcInDcxAJQYAmMsNa44TODa99sTl5YSwfTkPr1cVlh+wOrZrW/H3jG+m1aZWTsL1E
 0S/WIb1RB5WgbDy2kfj5sgZlsnF3uIElW1GGe5LR71+xAAinEWbSbtlRgPY3jPCGI1Qm
 XJiWo8a3FqpYZWzQg+3wFQAgqeFEZ6yyzW1o7VCNaxkUuuU4hNbuFnNqfUNLwN+5fhD0
 bFjCprLtKoAvB9BzY1kvktQXhSvUKak2SM9Fh+Z2fnIP19CLajYzsSral5DFfvYbsgzz
 20z8kzKYf7rMZPwcssvLD+42jRwf3+f7Ww0rpfij/oMcFSdLU3utveiaBdjLTYRfjGML pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52q0exg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:43:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22H7foiL035025;
        Thu, 17 Mar 2022 07:43:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3erhy2wqwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:43:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22H7hoGj038783;
        Thu, 17 Mar 2022 07:43:54 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3erhy2wqv5-5;
        Thu, 17 Mar 2022 07:43:54 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v17 04/11] NFSD: Update nfsd_breaker_owns_lease() to handle courtesy clients
Date:   Thu, 17 Mar 2022 00:43:41 -0700
Message-Id: <1647503028-11966-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: cV_uhHT_JmILY8xU9Hk0OxBCTvHBsku6
X-Proofpoint-ORIG-GUID: cV_uhHT_JmILY8xU9Hk0OxBCTvHBsku6
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

