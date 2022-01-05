Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBCD485B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 23:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiAEWSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 17:18:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3634 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244590AbiAEWSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:18:40 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 205KW1Pj009766
        for <linux-fsdevel@vger.kernel.org>; Wed, 5 Jan 2022 14:18:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=kQ53G9pEbJoCOb/10sQJ7TcTg2620WYm0v54afw1tzk=;
 b=RgXFmhbvom+uIQjiSTCT2cuZc4+gaAm4ZdGZ9ZDTveh4C1kXtzfX6X22GYj44zWeWqbH
 bzRmreRo5Hw5bmhl5PK1KTj8zgeAlu3Sf5VOAMYPlBST5RJcP3j3uaT6VVAq4T+ti6Qp
 F+5SrD0j1Zb5yu90yMG5+LAcoUu9FAClFl4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dcwfmqgfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 14:18:39 -0800
Received: from twshared21922.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 14:18:38 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 600CD90D2DA3; Wed,  5 Jan 2022 14:18:32 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <torvalds@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <shr@fb.com>
Subject: [PATCH v12 0/4] io_uring: add xattr support
Date:   Wed, 5 Jan 2022 14:18:26 -0800
Message-ID: <20220105221830.2668297-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5fyV_EU0qjVXavFinkOICJxZUb2P-2HM
X-Proofpoint-ORIG-GUID: 5fyV_EU0qjVXavFinkOICJxZUb2P-2HM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_07,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=951
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the xattr support to io_uring. The intent is to have a more
complete support for file operations in io_uring.

This change adds support for the following functions to io_uring:
- fgetxattr
- fsetxattr
- getxattr
- setxattr

Patch 1: fs: split off setxattr_copy and do_setxattr function from setxat=
tr
  Split off the setup part of the setxattr function in the setxattr_copy
  function. Split off the processing part in do_setxattr.

Patch 2: fs: split off do_getxattr from getxattr
  Split of the do_getxattr part from getxattr. This will
  allow it to be invoked it from io_uring.

Patch 3: io_uring: add fsetxattr and setxattr support
  This adds new functions to support the fsetxattr and setxattr
  functions.

Patch 4: io_uring: add fgetxattr and getxattr support
  This adds new functions to support the fgetxattr and getxattr
  functions.


There are two additional patches:
  liburing: Add support for xattr api's.
            This also includes the tests for the new code.
  xfstests: Add support for io_uring xattr support.


V12: - add union to xattr_ctx structure. The getxattr api requires
       a pointer to value and the setxattr requires a const pointer
       to value (with a union this can be unified).
     - use xattr_ctx structure in do_getxattr call.
V11: - removed the do_user_path_at_empty function and directly
       call filename_lookup
     - introduce __io_xattr_finish and io_xattr_finish functions
       to unify the cleanup code
     - remove the older __io_setxattr_finish function
V10: - move do_user_path_at_empty definition to fs/internal.h
     - introduce __io_setxattr_finish function
     - introduce __io_getxattr_finish function
V9 : - keep kvalue in struct xattr_ctx
V8 : - introduce xattr_name struct as advised by Linus
     - remove kname_sz field in xattr_ctx
V7 : - split off setxattr in two functions as recommeneded by
       Christian.
V6 : - reverted addition of kname array to xattr_ctx structure
       Adding the kname array increases the io_kiocb beyond 64 bytes
       (increases it to 224 bytes). We try hard to limit it to 64 bytes.
       Keeping the original interface also is a bit more efficient.
     - addressed Pavel's reordering comment
     - addressed Pavel's putname comment
     - addressed Pavel's kvfree comment
     - rebased on for-5.17/io_uring-getdents64
V5 : - add kname array to xattr_ctx structure
V4 : - rebased patch series
V3 : - remove req->file checks in prep functions
     - change size parameter in do_xattr
V2 : - split off function do_user_path_empty instead of changing
       the function signature of user_path_at
     - Fix datatype size problem in do_getxattr


Stefan Roesch (4):
  fs: split off setxattr_copy and do_setxattr function from setxattr
  fs: split off do_getxattr from getxattr
  io_uring: add fsetxattr and setxattr support
  io_uring: add fgetxattr and getxattr support

 fs/internal.h                 |  29 ++++
 fs/io_uring.c                 | 294 ++++++++++++++++++++++++++++++++++
 fs/xattr.c                    | 141 ++++++++++------
 include/uapi/linux/io_uring.h |   8 +-
 4 files changed, 426 insertions(+), 46 deletions(-)


base-commit: c0235652ee5194fc75926daa580817e63ceb37ab
--=20
2.30.2

