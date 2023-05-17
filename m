Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15B707687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjEQXjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEQXjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 19:39:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00146BF;
        Wed, 17 May 2023 16:39:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGupC021073;
        Wed, 17 May 2023 23:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=Tpp1J48e4AmmjSYL6utEn8Ps6uSUBOgkJhYinUpqL+o=;
 b=hpnClH0xwmSWKA82dHJLe8kl7Dr/8Z+1N37jaah+4xKOEGeJRz4GUorFdeWDcZZNS87K
 jyedg8+R+jJMmmntYF1OxkhEiMxZZEBEKeFFX6N2taE8btny4mAF4spGVTBKOuHdhJqR
 o4SBUXfI4oWJg9mj22uO0NBw5Kq4wfaOshTdaN3ChSuEu+kyKzCdbUuI5TqMjumDHq+k
 3MDUHmXtK6mlm4Q9VuDz4N5u3PJJKmCmlzy/8slekiCIlJhIwwWJub20Tddl0tFsknWG
 bFE8WsN8dU1fW1kjR5kkt255V3RWmigqAW5Bps/gD/kBBU+KieUZ2uc3stsNrvRTLd4f sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uxr5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:39:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HMFhGx032130;
        Wed, 17 May 2023 23:39:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10c3ukd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:39:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HNdABh015880;
        Wed, 17 May 2023 23:39:10 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10c3u5n-1;
        Wed, 17 May 2023 23:39:10 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/2] NFSD: add support for NFSv4 write delegation
Date:   Wed, 17 May 2023 16:38:08 -0700
Message-Id: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=630 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170194
X-Proofpoint-GUID: tHcDuRihIJGVvsBPRiCF7nkcSQSPyEK0
X-Proofpoint-ORIG-GUID: tHcDuRihIJGVvsBPRiCF7nkcSQSPyEK0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFSD: add support for NFSv4 write delegation

The NFSv4 server currently supports read delegation using VFS lease
which is implemented using file_lock. 

This patch series add write delegation support for NFSv4 server by:

    . remove the check for F_WRLCK in generic_add_lease to allow
      file_lock to be used for write delegation.  

    . grant write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
      if there is no conflict with other OPENs.

Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
are handled the same as read delegation using notify_change, try_break_deleg.

Changes since v1:

[PATCH 3/4] NFSD: add supports for CB_GETATTR callback
- remove WARN_ON_ONCE from encode_bitmap4
- replace decode_bitmap4 with xdr_stream_decode_uint32_array
- replace xdr_inline_decode and xdr_decode_hyper in decode_cb_getattr
   with xdr_stream_decode_u64. Also remove the un-needed likely().
- modify signature of encode_cb_getattr4args to take pointer to
   nfs4_cb_fattr
- replace decode_attr_length with xdr_stream_decode_u32
- rename decode_cb_getattr to decode_cb_fattr4
- fold the initialization of cb_cinfo and cb_fsize into decode_cb_fattr4
- rename ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
  in fs/nfsd/nfs4xdr.c
- correct NFS4_dec_cb_getattr_sz and update size description

[PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
- change nfs4_handle_wrdeleg_conflict returns __be32 to fix test robot
- change ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
  in fs/nfsd/nfs4xdr.c

Changes since v2:

[PATCH 2/4] NFSD: enable support for write delegation
- rename 'deleg' to 'dl_type' in nfs4_set_delegation
- remove 'wdeleg' in nfs4_open_delegation

- drop [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
  and [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
  for futher clarification of the benefits of using CB_GETATTR
  for handling GETATTR from the 2nd client

