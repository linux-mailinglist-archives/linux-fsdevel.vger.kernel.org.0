Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E824D6BE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 03:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiCLCPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 21:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiCLCPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:15:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F61ACA2B;
        Fri, 11 Mar 2022 18:13:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C1uV1q026138;
        Sat, 12 Mar 2022 02:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=tyRLBCh3NbKIArnmzfrYITUVnwOeaTnA8mjbcXadmmM=;
 b=J8QT4vUSrDZDBxTvKBeBGl3bgXOjMaGVLBiklpAcozVWZPYJQGE1hEdG6fbWDyOkrRz/
 k+SiAH2+4RnIA5a4fsSCnQcgGP7K4ROY4kJiNTcBC8gtzwmNO0RiwK3f/yh4XWoqH1Nw
 +MDgZ6vjWnmbG4RSJDuAfjRgGkSc5tQ1ntEzJBkP0XMGA80rUSu6TLcs1GkFR9zffXxJ
 Eq+3pszhZVXPTshB/GPHPOM9jIIF1iEnGcBAd9ijnPMOx6Enmi8BYUYWxdYlXwIqGBsn
 uS89/LejBVk4cYdr+9soAIfflzXvZ/rKGI39t89fu1nh5+NafnBWC1PeENzkwyZwh9PA qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erja280c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C2C0wo084285;
        Sat, 12 Mar 2022 02:13:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:45 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22C2DgMX086332;
        Sat, 12 Mar 2022 02:13:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfe-5;
        Sat, 12 Mar 2022 02:13:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v16 04/11] NFSD: Update nfsd_breaker_owns_lease() to handle courtesy clients
Date:   Fri, 11 Mar 2022 18:13:28 -0800
Message-Id: <1647051215-2873-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: A0hD2s2qHgBXIMEeLuHSu7nOg3b0pRWu
X-Proofpoint-GUID: A0hD2s2qHgBXIMEeLuHSu7nOg3b0pRWu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update nfsd_breaker_owns_lease() to handle delegation conflict
with courtesy clients. If conflict was caused by courtesy client
then discard the courtesy client by setting CLIENT_EXPIRED and
return conflict resolved. Client with CLIENT_EXPIRED is expired
by the laundromat.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 583ac807e98d..2beb0972de88 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4713,6 +4713,28 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	return ret;
 }
 
+static bool
+nfs4_check_and_expire_courtesy_client(struct nfs4_client *clp)
+{
+	/*
+	 * need to sync with courtesy client trying to reconnect using
+	 * the cl_cs_lock, nn->client_lock can not be used since this
+	 * function is called with the fl_lck held.
+	 */
+	spin_lock(&clp->cl_cs_lock);
+	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+	return false;
+}
+
 /**
  * nfsd_breaker_owns_lease - Check if lease conflict was resolved
  * @fl: Lock state to check
@@ -4727,6 +4749,10 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	clp = dl->dl_stid.sc_client;
+	if (nfs4_check_and_expire_courtesy_client(clp))
+		return true;
+
 	if (!i_am_nfsd())
 		return false;
 	rqst = kthread_data(current);
-- 
2.9.5

