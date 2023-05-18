Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C2708AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjERVzI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjERVzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 17:55:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6463810CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 14:55:03 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34IGeUfF007840
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 14:55:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qnqr8j33a-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 14:55:02 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 14:54:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CCFC430EEE484; Thu, 18 May 2023 14:54:45 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <cyphar@cyphar.com>, <brauner@kernel.org>,
        <lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 0/3] Add O_PATH-based BPF_OBJ_PIN and BPF_OBJ_GET support
Date:   Thu, 18 May 2023 14:54:41 -0700
Message-ID: <20230518215444.1418789-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0SWgGRH4g9RUdo789ubhVtwRwsPN8tf3
X-Proofpoint-GUID: 0SWgGRH4g9RUdo789ubhVtwRwsPN8tf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add ability to specify pinning location within BPF FS using O_PATH-based FDs,
similar to openat() family of APIs. Patch #1 adds necessary kernel-side
changes. Patch #2 exposes this through libbpf APIs. Patch #3 uses new mount
APIs (fsopen, fsconfig, fsmount) to demonstrated how now it's possible to work
with detach-mounted BPF FS using new BPF_OBJ_PIN and BPF_OBJ_GET
functionality.

This feature is inspired as a result of recent conversations during
LSF/MM/BPF 2023 conference about shortcomings of being able to perform BPF
objects pinning only using lookup-based paths.

v1->v2:
  - add BPF_F_PATH_FD flag that should go along with path FD (Christian).

Andrii Nakryiko (3):
  bpf: support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
  libbpf: add opts-based bpf_obj_pin() API and add support for path_fd
  selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests

 include/linux/bpf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |  10 ++
 kernel/bpf/inode.c                            |  16 +--
 kernel/bpf/syscall.c                          |  25 +++-
 tools/include/uapi/linux/bpf.h                |  10 ++
 tools/lib/bpf/bpf.c                           |  17 ++-
 tools/lib/bpf/bpf.h                           |  18 ++-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/bpf_obj_pinning.c          | 112 ++++++++++++++++++
 9 files changed, 193 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c

-- 
2.34.1

