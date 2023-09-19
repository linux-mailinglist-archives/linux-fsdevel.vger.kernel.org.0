Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309CF7A6D23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjISVsQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjISVsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:48:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8671AC0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:09 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JL4wcQ017463
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:09 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t74caemh7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:09 -0700
Received: from twshared22837.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 14:48:06 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E178D385A5EF6; Tue, 19 Sep 2023 14:48:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v5 bpf-next 00/13] BPF token and BPF FS-based delegation
Date:   Tue, 19 Sep 2023 14:47:47 -0700
Message-ID: <20230919214800.3803828-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pizN3l1fzvwU4ZgxjeR5JW4s3ORU4xbG
X-Proofpoint-GUID: pizN3l1fzvwU4ZgxjeR5JW4s3ORU4xbG
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set introduces an ability to delegate a subset of BPF subsystem
functionality from privileged system-wide daemon (e.g., systemd or any other
container manager) through special mount options for userns-bound BPF FS to
a *trusted* unprivileged application. Trust is the key here. This
functionality is not about allowing unconditional unprivileged BPF usage.
Establishing trust, though, is completely up to the discretion of respective
privileged application that would create and mount a BPF FS instance with
delegation enabled, as different production setups can and do achieve it
through a combination of different means (signing, LSM, code reviews, etc),
and it's undesirable and infeasible for kernel to enforce any particular way
of validating trustworthiness of particular process.

The main motivation for this work is a desire to enable containerized BPF
applications to be used together with user namespaces. This is currently
impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
arbitrary memory, and it's impossible to ensure that they only read memory of
processes belonging to any given namespace. This means that it's impossible to
have a mechanically verifiable namespace-aware CAP_BPF capability, and as such
another mechanism to allow safe usage of BPF functionality is necessary.BPF FS
delegation mount options and BPF token derived from such BPF FS instance is
such a mechanism. Kernel makes no assumption about what "trusted" constitutes
in any particular case, and it's up to specific privileged applications and
their surrounding infrastructure to decide that. What kernel provides is a set
of APIs to setup and mount special BPF FS instanecs and derive BPF tokens from
it. BPF FS and BPF token are both bound to its owning userns and in such a way
are constrained inside intended container. Users can then pass BPF token FD to
privileged bpf() syscall commands, like BPF map creation and BPF program
loading, to perform such operations without having init userns privileged.

This v4 incorporates feedback and suggestions ([3]) received on v3 of this
patch set, and instead of allowing to create BPF tokens directly assuming
capable(CAP_SYS_ADMIN), we instead enhance BPF FS to accepts a few new
delegation mount options. If these options are used and BPF FS itself is
properly created, set up, and mounted inside the user namespaced container,
user application is able to derive a BPF token object from BPF FS instance,
and pass that token to bpf() syscall. As explained in patch #2, BPF token
itself doesn't grant access to BPF functionality, but instead allows kernel to
do namespaced capabilities checks (ns_capable() vs capable()) for CAP_BPF,
CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, as applicable. So it forms one
half of a puzzle and allows container managers and sys admins to have safe and
flexible configuration options: determining which containers get delegation of
BPF functionality through BPF FS, and then which applications within such
containers are allowed to perform bpf() commands, based on namespaces
capabilities.

Previous attempt at addressing this very same problem ([0]) attempted to
utilize authoritative LSM approach, but was conclusively rejected by upstream
LSM maintainers. BPF token concept is not changing anything about LSM
approach, but can be combined with LSM hooks for very fine-grained security
policy. Some ideas about making BPF token more convenient to use with LSM (in
particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
2023 presentation ([1]). E.g., an ability to specify user-provided data
(context), which in combination with BPF LSM would allow implementing a very
dynamic and fine-granular custom security policies on top of BPF token. In the
interest of minimizing API surface area and discussions this was relegated to
follow up patches, as it's not essential to the fundamental concept of
delegatable BPF token.

It should be noted that BPF token is conceptually quite similar to the idea of
/dev/bpf device file, proposed by Song a while ago ([2]). The biggest
difference is the idea of using virtual anon_inode file to hold BPF token and
allowing multiple independent instances of them, each (potentially) with its
own set of restrictions. And also, crucially, BPF token approach is not using
any special stateful task-scoped flags. Instead, bpf() syscall accepts
token_fd parameters explicitly for each relevant BPF command. This addresses
main concerns brought up during the /dev/bpf discussion, and fits better with
overall BPF subsystem design.

This patch set adds a basic minimum of functionality to make BPF token idea
useful and to discuss API and functionality. Currently only low-level libbpf
APIs support creating and passing BPF token around, allowing to test kernel
functionality, but for the most part is not sufficient for real-world
applications, which typically use high-level libbpf APIs based on `struct
bpf_object` type. This was done with the intent to limit the size of patch set
and concentrate on mostly kernel-side changes. All the necessary plumbing for
libbpf will be sent as a separate follow up patch set kernel support makes it
upstream.

Another part that should happen once kernel-side BPF token is established, is
a set of conventions between applications (e.g., systemd), tools (e.g.,
bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
instance(s) at well-defined locations to allow applications take advantage of
this in automatic fashion without explicit code changes on BPF application's
side. But I'd like to postpone this discussion to after BPF token concept
lands.

  [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
  [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
  [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/
  [3] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/

v4->v5:
  - add pre-patch unifying CAP_NET_ADMIN handling inside kernel/bpf/syscall.c
    (Paul Moore);
  - fix build warnings and errors in selftests and kernel, detected by CI and
    kernel test robot;
v3->v4:
  - add delegation mount options to BPF FS;
  - BPF token is derived from the instance of BPF FS and associates itself
    with BPF FS' owning userns;
  - BPF token doesn't grant BPF functionality directly, it just turns
    capable() checks into ns_capable() checks within BPF FS' owning user;
  - BPF token cannot be pinned;
v2->v3:
  - make BPF_TOKEN_CREATE pin created BPF token in BPF FS, and disallow
    BPF_OBJ_PIN for BPF token;
v1->v2:
  - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
  - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).


Andrii Nakryiko (13):
  bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
  bpf: add BPF token delegation mount options to BPF FS
  bpf: introduce BPF token object
  bpf: add BPF token support to BPF_MAP_CREATE command
  bpf: add BPF token support to BPF_BTF_LOAD command
  bpf: add BPF token support to BPF_PROG_LOAD command
  bpf: take into account BPF token when fetching helper protos
  bpf: consistenly use BPF token throughout BPF verifier logic
  libbpf: add bpf_token_create() API
  libbpf: add BPF token support to bpf_map_create() API
  libbpf: add BPF token support to bpf_btf_load() API
  libbpf: add BPF token support to bpf_prog_load() API
  selftests/bpf: add BPF token-enabled tests

 drivers/media/rc/bpf-lirc.c                   |   2 +-
 include/linux/bpf.h                           |  82 ++-
 include/linux/filter.h                        |   2 +-
 include/uapi/linux/bpf.h                      |  44 ++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arraymap.c                         |   2 +-
 kernel/bpf/cgroup.c                           |   6 +-
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/helpers.c                          |   6 +-
 kernel/bpf/inode.c                            |  93 ++-
 kernel/bpf/syscall.c                          | 190 ++++--
 kernel/bpf/token.c                            | 229 +++++++
 kernel/bpf/verifier.c                         |  13 +-
 kernel/trace/bpf_trace.c                      |   2 +-
 net/core/filter.c                             |  36 +-
 net/ipv4/bpf_tcp_ca.c                         |   2 +-
 net/netfilter/nf_bpf_link.c                   |   2 +-
 tools/include/uapi/linux/bpf.h                |  44 ++
 tools/lib/bpf/bpf.c                           |  30 +-
 tools/lib/bpf/bpf.h                           |  38 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
 .../testing/selftests/bpf/prog_tests/token.c  | 627 ++++++++++++++++++
 24 files changed, 1361 insertions(+), 105 deletions(-)
 create mode 100644 kernel/bpf/token.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

-- 
2.34.1

