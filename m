Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8230970AB1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjETVg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 17:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETVgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 17:36:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC887E9;
        Sat, 20 May 2023 14:36:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34KLT6XB003661;
        Sat, 20 May 2023 21:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=hJktwOQD8qiPaL0vYb0rvx9KgaO7AKXSi96F3Z/FlLE=;
 b=S/FA+qG9vCfyHMD3Q61naMxeaYe92eJGAwrvwRaBPAaxoumxdgk8/G/kkBajM4N6dWC1
 NDJ2ZZ+Voyi+IiJ3R9Lvi7L+umFLCkQoXCIFWZK62YiBUjNYuAZnVkNHBjlA/4dQIF0I
 9L/nZJsD3ksB8yCIPbv8nnC0Hv0lPu16WITOBSpg4y0sGThWtmC7vSdZ10bHWnjwTBjK
 1tXkGuDNvQqGPRrlyni1w3d4fpe6PZ7kpPNXt6rvtYqEubsx9vb/F9EfFJ3PUpXs5N5+
 xV3wxl0YCBIHAeHK9llfM/ljrK9wXIbhpg0Q+Y4OHNhgMSpWG5Nv7lJgYT7xXgINvWuA RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtgmwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 May 2023 21:36:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34KG50B8011202;
        Sat, 20 May 2023 21:36:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qpmn82h4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 May 2023 21:36:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34KLajTl030297;
        Sat, 20 May 2023 21:36:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qpmn82h46-1;
        Sat, 20 May 2023 21:36:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 0/4] NFSD: add support for NFSv4 write delegation
Date:   Sat, 20 May 2023 14:36:31 -0700
Message-Id: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-20_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=724
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305200192
X-Proofpoint-GUID: bNqaRff1LtRMmCWmkNQDzf6YtbZpc0YW
X-Proofpoint-ORIG-GUID: bNqaRff1LtRMmCWmkNQDzf6YtbZpc0YW
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

