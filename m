Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB270E321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 19:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjEWRAd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjEWRAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 13:00:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE4119
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:00:30 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDbfpx005062
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:00:29 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qrds401wd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:00:29 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 10:00:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AB1D13136532D; Tue, 23 May 2023 10:00:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <cyphar@cyphar.com>, <brauner@kernel.org>,
        <lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 0/4] Add O_PATH-based BPF_OBJ_PIN and BPF_OBJ_GET support
Date:   Tue, 23 May 2023 10:00:09 -0700
Message-ID: <20230523170013.728457-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QihJa4AesFRhlnklSdCkEtS8qEc0yG9C
X-Proofpoint-GUID: QihJa4AesFRhlnklSdCkEtS8qEc0yG9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add ability to specify pinning location within BPF FS using O_PATH-based FDs,
similar to openat() family of APIs. Patch #2 adds necessary kernel-side
changes. Patch #3 exposes this through libbpf APIs. Patch #4 uses new mount
APIs (fsopen, fsconfig, fsmount) to demonstrated how now it's possible to work
with detach-mounted BPF FS using new BPF_OBJ_PIN and BPF_OBJ_GET
functionality. We also add few more tests using various combinations of
path_fd and pathname to validate proper argument propagation in kernel code.

This feature is inspired as a result of recent conversations during
LSF/MM/BPF 2023 conference about shortcomings of being able to perform BPF
objects pinning only using lookup-based paths.

v3->v4:
  - libbpf v1.3 bump (Daniel);
v2->v3:
  - __s32 for path_fd in union bpf_attr (Christian);
  - added subtest for absolute/relative paths during pinning/getting;
  - added pre-patch moving LSM hook (security_path_mknod) around (Christian);
v1->v2:
  - add BPF_F_PATH_FD flag that should go along with path FD (Christian).

Andrii Nakryiko (4):
  bpf: Validate BPF object in BPF_OBJ_PIN before calling LSM
  libbpf: start v1.3 development cycle
  bpf: support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
  selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests

 include/linux/bpf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/inode.c                            |  27 +-
 kernel/bpf/syscall.c                          |  25 +-
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |  17 +-
 tools/lib/bpf/bpf.h                           |  18 +-
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../bpf/prog_tests/bpf_obj_pinning.c          | 268 ++++++++++++++++++
 10 files changed, 359 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c

-- 
2.34.1

