Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59A36FFC05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 23:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjEKVnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbjEKVnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 17:43:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2071BF;
        Thu, 11 May 2023 14:43:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BKgcNt028618;
        Thu, 11 May 2023 21:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=2f5ktVGLV3Bmx7XgrM8kwuICF66tSE6b2JDrZ37H6eI=;
 b=o0VtqhscBqnuoHzkLxfdpsTD75ArGjIOjhfeh64SgibOwXd+UnCM1Y6+MCWT0AJA46F3
 /7ncogJR0TRb4F4tXIWmychzDXSfEyqqac4S1QNz5gjnsQgxTETIb7nmRNLurh+Yy0m+
 QcNLYC/YODP9eb4LPitCqEKXh/z+ovzMolVYc09lOCPMzA79zxfD3vHirO/hDYZUy46p
 mbS45TK1i0K5IVcWAoDFjznwhZHflzPIGUBXSGNXaEZ25IkVDKgTi3UMTyCImgmzl8Ff
 ozx2hOOxMDyyWMmuHL3q/YFzLZE/IRhWUncwKfVGtnq/4sImEBg1g7CQTlChQ7BTfWJY Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7778acy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BJubTv018147;
        Thu, 11 May 2023 21:43:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77kcm75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BLhX1W028893;
        Thu, 11 May 2023 21:43:33 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf77kcm6r-1;
        Thu, 11 May 2023 21:43:33 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] NFSD: add support for NFSv4 write delegation
Date:   Thu, 11 May 2023 14:42:59 -0700
Message-Id: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=758 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110184
X-Proofpoint-GUID: xNj2ikAaN2AyfX3WG-PGGRr96ItFK6pt
X-Proofpoint-ORIG-GUID: xNj2ikAaN2AyfX3WG-PGGRr96ItFK6pt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The NFSv4 server currently supports read delegation using VFS lease
which is implemented using file_lock. 

This patch series add write delegation support for NFSv4 server by:

    . remove the check for F_WRLCK in generic_add_lease to allow
      file_lock to be used for write delegation.  

    . grant write delegation for  OPEN with NFS4_SHARE_ACCESS_WRITE
      if there is no conflict with other OPENs.

    . add XDR support for sending and receiving CB_GETATTR.

    . handle GETATTR from another client on a file that has outstanding
      write delegation by using CB_GETATTR to get the latest change_info
      and size for the GETATTR reply.

Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
are handled the same as read delegation using notify_change, try_break_deleg.


