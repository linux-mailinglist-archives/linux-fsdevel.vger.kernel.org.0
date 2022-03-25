Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F14E6D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 05:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358232AbiCYEgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 00:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiCYEge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:36:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76490C681C;
        Thu, 24 Mar 2022 21:35:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P0gsD3007614;
        Fri, 25 Mar 2022 04:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=5qhP6a5w/pe2jL6JHuQb8UsQANthSTakX+/4JdQZ6G8=;
 b=nga0eCia3AP+EnoAm2bJHimyPacfRGe6xaYlKFoCoj1R3yWX+IMjVB8vISj+oINGiPNv
 G3ExH8clFHQh5WN1dyCHeUa8FHOt92w0pQP/8gf9TTmBwO1Z4p7cMKUwu2UTp0Ewrp6m
 EcaJ5Bq036K6XwwQ3Ajhj0+ZCKcEDDNYSUd3HMej6xQqDa1gaFrCte28w3CJug9rtxLS
 sVACH7O9VeT9q3DhaPQ1VTxyKhW2x/8EeuGbaN//nKxT8tJAaESOG+bsixnBCZqaYpCq
 2x2myTqh7gC9yo900S+KF0ostBt1/5nRaxv1tO8B/umsitand0+ROdhdbiEos9rTZ+bZ Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcwx62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:34:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22P4WDET020751;
        Fri, 25 Mar 2022 04:34:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:34:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22P4YsCa040479;
        Fri, 25 Mar 2022 04:34:58 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bmt-5;
        Fri, 25 Mar 2022 04:34:58 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v18 04/11] NFSD: Update nfsd_breaker_owns_lease() to handle courtesy clients
Date:   Thu, 24 Mar 2022 21:34:44 -0700
Message-Id: <1648182891-32599-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: pIMIcEjgVnzPEPUJPvggI0HwYDe-l1Eq
X-Proofpoint-ORIG-GUID: pIMIcEjgVnzPEPUJPvggI0HwYDe-l1Eq
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

