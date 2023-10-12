Return-Path: <linux-fsdevel+bounces-209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 160387C7977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE76B207F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956313F4BA;
	Thu, 12 Oct 2023 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063603FB3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:29:24 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336FCA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:29:21 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLuDIc010305
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:29:20 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpjt7afn2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:29:20 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:29:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5A28539A3A089; Thu, 12 Oct 2023 15:28:10 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 00/18] BPF token and BPF FS-based delegation
Date: Thu, 12 Oct 2023 15:27:52 -0700
Message-ID: <20231012222810.4120312-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: L7skfVsgd3LBzuekMm46_FX7xGb2BdEP
X-Proofpoint-ORIG-GUID: L7skfVsgd3LBzuekMm46_FX7xGb2BdEP
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespa=
ced
or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely r=
ead
arbitrary memory, and it's impossible to ensure that they only read memory =
of
processes belonging to any given namespace. This means that it's impossible=
 to
have a mechanically verifiable namespace-aware CAP_BPF capability, and as s=
uch
another mechanism to allow safe usage of BPF functionality is necessary.BPF=
 FS
delegation mount options and BPF token derived from such BPF FS instance is
such a mechanism. Kernel makes no assumption about what "trusted" constitut=
es
in any particular case, and it's up to specific privileged applications and
their surrounding infrastructure to decide that. What kernel provides is a =
set
of APIs to setup and mount special BPF FS instanecs and derive BPF tokens f=
rom
it. BPF FS and BPF token are both bound to its owning userns and in such a =
way
are constrained inside intended container. Users can then pass BPF token FD=
 to
privileged bpf() syscall commands, like BPF map creation and BPF program
loading, to perform such operations without having init userns privileged.

This version incorporates feedback and suggestions ([3]) received on v3 of
this patch set, and instead of allowing to create BPF tokens directly assum=
ing
capable(CAP_SYS_ADMIN), we instead enhance BPF FS to accepts a few new
delegation mount options. If these options are used and BPF FS itself is
properly created, set up, and mounted inside the user namespaced container,
user application is able to derive a BPF token object from BPF FS instance,
and pass that token to bpf() syscall. As explained in patch #2, BPF token
itself doesn't grant access to BPF functionality, but instead allows kernel=
 to
do namespaced capabilities checks (ns_capable() vs capable()) for CAP_BPF,
CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, as applicable. So it forms o=
ne
half of a puzzle and allows container managers and sys admins to have safe =
and
flexible configuration options: determining which containers get delegation=
 of
BPF functionality through BPF FS, and then which applications within such
containers are allowed to perform bpf() commands, based on namespaces
capabilities.

Previous attempt at addressing this very same problem ([0]) attempted to
utilize authoritative LSM approach, but was conclusively rejected by upstre=
am
LSM maintainers. BPF token concept is not changing anything about LSM
approach, but can be combined with LSM hooks for very fine-grained security
policy. Some ideas about making BPF token more convenient to use with LSM (=
in
particular custom BPF LSM programs) was briefly described in recent LSF/MM/=
BPF
2023 presentation ([1]). E.g., an ability to specify user-provided data
(context), which in combination with BPF LSM would allow implementing a very
dynamic and fine-granular custom security policies on top of BPF token. In =
the
interest of minimizing API surface area and discussions this was relegated =
to
follow up patches, as it's not essential to the fundamental concept of
delegatable BPF token.

It should be noted that BPF token is conceptually quite similar to the idea=
 of
/dev/bpf device file, proposed by Song a while ago ([2]). The biggest
difference is the idea of using virtual anon_inode file to hold BPF token a=
nd
allowing multiple independent instances of them, each (potentially) with its
own set of restrictions. And also, crucially, BPF token approach is not usi=
ng
any special stateful task-scoped flags. Instead, bpf() syscall accepts
token_fd parameters explicitly for each relevant BPF command. This addresses
main concerns brought up during the /dev/bpf discussion, and fits better wi=
th
overall BPF subsystem design.

This patch set adds a basic minimum of functionality to make BPF token idea
useful and to discuss API and functionality. Currently only low-level libbpf
APIs support creating and passing BPF token around, allowing to test kernel
functionality, but for the most part is not sufficient for real-world
applications, which typically use high-level libbpf APIs based on `struct
bpf_object` type. This was done with the intent to limit the size of patch =
set
and concentrate on mostly kernel-side changes. All the necessary plumbing f=
or
libbpf will be sent as a separate follow up patch set kernel support makes =
it
upstream.

Another part that should happen once kernel-side BPF token is established, =
is
a set of conventions between applications (e.g., systemd), tools (e.g.,
bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
instance(s) at well-defined locations to allow applications take advantage =
of
this in automatic fashion without explicit code changes on BPF application's
side. But I'd like to postpone this discussion to after BPF token concept
lands.

  [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
  [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_=
LSFMM2023.pdf
  [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@f=
b.com/
  [3] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@=
brauner/

v6->v7:
  - separate patches to refactor bpf_prog_alloc/bpf_map_alloc LSM hooks, as
    discussed with Paul, and now they also accept struct bpf_token;
  - added bpf_token_create/bpf_token_free to allow LSMs (SELinux,
    specifically) to set up security LSM blob (Paul);
  - last patch also wires bpf_security_struct setup by SELinux, similar to =
how
    it's done for BPF map/prog, though I'm not sure if that's enough, so wo=
rst
    case it's easy to drop this patch if more full fledged SELinux
    implementation will be done separately;
  - small fixes for issues caught by code reviews (Jiri, Hou);
  - fix for test_maps test that doesn't use LIBBPF_OPTS() macro (CI);
v5->v6:
  - fix possible use of uninitialized variable in selftests (CI);
  - don't use anon_inode, instead create one from BPF FS instance (Christia=
n);
  - don't store bpf_token inside struct bpf_map, instead pass it explicitly=
 to
    map_check_btf(). We do store bpf_token inside prog->aux, because it's u=
sed
    during verification and even can be checked during attach time for some
    program types;
  - LSM hooks are left intact pending the conclusion of discussion with Paul
    Moore; I'd prefer to do LSM-related changes as a follow up patch set
    anyways;
v4->v5:
  - add pre-patch unifying CAP_NET_ADMIN handling inside kernel/bpf/syscall=
.c
    (Paul Moore);
  - fix build warnings and errors in selftests and kernel, detected by CI a=
nd
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

Andrii Nakryiko (18):
  bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
  bpf: add BPF token delegation mount options to BPF FS
  bpf: introduce BPF token object
  bpf: add BPF token support to BPF_MAP_CREATE command
  bpf: add BPF token support to BPF_BTF_LOAD command
  bpf: add BPF token support to BPF_PROG_LOAD command
  bpf: take into account BPF token when fetching helper protos
  bpf: consistenly use BPF token throughout BPF verifier logic
  bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
  bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
  bpf,lsm: add bpf_token_create and bpf_token_free LSM hooks
  libbpf: add bpf_token_create() API
  selftests/bpf: fix test_maps' use of bpf_map_create_opts
  libbpf: add BPF token support to bpf_map_create() API
  libbpf: add BPF token support to bpf_btf_load() API
  libbpf: add BPF token support to bpf_prog_load() API
  selftests/bpf: add BPF token-enabled tests
  bpf,selinux: allocate bpf_security_struct per BPF token

 drivers/media/rc/bpf-lirc.c                   |   2 +-
 include/linux/bpf.h                           |  83 ++-
 include/linux/filter.h                        |   2 +-
 include/linux/lsm_hook_defs.h                 |  13 +-
 include/linux/security.h                      |  29 +-
 include/uapi/linux/bpf.h                      |  44 ++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arraymap.c                         |   2 +-
 kernel/bpf/bpf_lsm.c                          |  13 +-
 kernel/bpf/cgroup.c                           |   6 +-
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/helpers.c                          |   6 +-
 kernel/bpf/inode.c                            |  98 ++-
 kernel/bpf/syscall.c                          | 215 ++++--
 kernel/bpf/token.c                            | 257 +++++++
 kernel/bpf/verifier.c                         |  13 +-
 kernel/trace/bpf_trace.c                      |   2 +-
 net/core/filter.c                             |  36 +-
 net/ipv4/bpf_tcp_ca.c                         |   2 +-
 net/netfilter/nf_bpf_link.c                   |   2 +-
 security/security.c                           |  69 +-
 security/selinux/hooks.c                      |  47 +-
 tools/include/uapi/linux/bpf.h                |  44 ++
 tools/lib/bpf/bpf.c                           |  30 +-
 tools/lib/bpf/bpf.h                           |  39 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/map_tests/map_percpu_stats.c          |  20 +-
 .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
 .../testing/selftests/bpf/prog_tests/token.c  | 629 ++++++++++++++++++
 30 files changed, 1537 insertions(+), 182 deletions(-)
 create mode 100644 kernel/bpf/token.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

--=20
2.34.1


