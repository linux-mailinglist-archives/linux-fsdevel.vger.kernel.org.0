Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E57020C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 02:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjEOAVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 20:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjEOAVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 20:21:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777810EA;
        Sun, 14 May 2023 17:21:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34EM8s8m019522;
        Mon, 15 May 2023 00:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=nuOWrHiyAXW7/vpIpeHu9L5cU1vtcIwKTikenFS2wKU=;
 b=s/32eCHjsIfTY3ZwLFS7MByJVCxt3M/fcJND4MXISCJ/gVjiMbKpoIKi7Z3dFMhN/56r
 K6aB3tw4jIskjOhv/G1Bfluzbw/flbQ13o04S6fst3ymtDIVFExWqFRw09RpcCPsa6fq
 rcwWzAU9IKp4OeBseWQfcYmV/EAHqNWu5D7HZ+QMvgO00kjePasAinLWhVpyzpsSEuz3
 /5biDM8Y1B/W0bFwpvno2V4WFkUYgpoZ7PkO1VX9yvPpTohd8tQiOzjQvi8MlaDx4Nij
 IWNlcF/Z99kJAv3N6kIDr688b2rt7bFhxBfU/bqYTJUNJ0XWbA8mTTm6eU3Jtu7q+mra yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25tx0we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 00:20:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34EJUF4e033095;
        Mon, 15 May 2023 00:20:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107ymsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 00:20:51 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34F0KoeK004448;
        Mon, 15 May 2023 00:20:50 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj107yms7-1;
        Mon, 15 May 2023 00:20:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] NFSD: add support for NFSv4 write delegation
Date:   Sun, 14 May 2023 17:20:34 -0700
Message-Id: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=710 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150000
X-Proofpoint-ORIG-GUID: QLsd4qkw5VRi5TlcYvCihbxROujSE-Qn
X-Proofpoint-GUID: QLsd4qkw5VRi5TlcYvCihbxROujSE-Qn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

    . add XDR support for sending and receiving CB_GETATTR.

    . handle GETATTR from another client on a file that has outstanding
      write delegation by using CB_GETATTR to get the latest change_info
      and size for the GETATTR reply.

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
