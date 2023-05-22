Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8BC70CF11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjEWAYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjEVX4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 19:56:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650E2125;
        Mon, 22 May 2023 16:52:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNsVe001958;
        Mon, 22 May 2023 23:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=IKJkCOccVzLu6kohxV9I79caIQhey6LTKOR4b88i/IU=;
 b=3UJqX2XZ6j0UBhzLIZNQ9lmrVhrAYUAVXnHMxqkynXI9OasWnBEcNIjIC2/LbJXJqrt/
 FIR6hZIOA6KKiJQpdjI3LrSgoepG+7/eZ0L+iWy68LiP2J9J6h/4roh0c3KnZfJvi/T+
 H/v1dIluN2YehVetJU54XDaczryUpq8wNkWTgJkkUEn3uCgDlZyF38YvdOtfj0tFrz5i
 sfCykymZr0m98jM9b1u6u9wRG0ETKPaTPpCEqVC7sxvE2kqoEws4cHEEoAuYCOkpW7+e
 9hsYfh/z8rtRiw2LoDLmWWxOi3MbXHavtpKQbq2zDeqbYOY0+KTjYKf2dmcKEtJP8B/Z LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44kumq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLouQa013218;
        Mon, 22 May 2023 23:52:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7e43vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MNqqgv018982;
        Mon, 22 May 2023 23:52:52 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qqk7e43vc-1;
        Mon, 22 May 2023 23:52:52 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 0/3] NFSD: add support for NFSv4 write delegation
Date:   Mon, 22 May 2023 16:52:37 -0700
Message-Id: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=800 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220201
X-Proofpoint-GUID: mG3qQPbzzKhwgvq5ftf9mpVDGfzqfCEM
X-Proofpoint-ORIG-GUID: mG3qQPbzzKhwgvq5ftf9mpVDGfzqfCEM
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
  for futher clarification of the benefits of these patches

Changes since v3:

- recall write delegation when there is GETATTR from 2nd client
- add trace point to track when write delegation is granted 

Changes since v4:
- squash 4/4 into 2/4
- apply 1/4 last instead of first
- combine nfs4_wrdeleg_filelock and nfs4_handle_wrdeleg_conflict to
  nfsd4_deleg_getattr_conflict and move it to fs/nfsd/nfs4state.c
- check for lock belongs to delegation before proceed and do it
  under the fl_lock
- check and skip FL_LAYOUT file_locks
