Return-Path: <linux-fsdevel+bounces-8638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A1B839EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C070E1F2A2CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E62109;
	Wed, 24 Jan 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoR1NVzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336441860;
	Wed, 24 Jan 2024 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062892; cv=none; b=bfGpdZRaoe/qSyxw3tkhxnqpKCj9//Tdde5HYswESmxXQNrvnVnQEYUrNhoAaiQ/jOK2z5HEZtSCsJNMtYunisZcAI9k0ecCYx9/T6MfQLJeVzTxFELPS5WV0AM97h+Ol/J6vL9kdxvEx65mUFeSOGYuDUNwWpQclukhbqWU47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062892; c=relaxed/simple;
	bh=1omuZQzDaJwOJVGdPtdVSXr7A629MpT74ikqpFOLNco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hySF3v3/nF5cFOGk4MFTs6/AbV0XpD1jg21KTTkpHQJyq0fappLSnbeUV7lPGbitxRU96pzy6iXfnhpLDaXuj7EedfxwDgQaMQWPcLIU7yUi9b7BMrpGog4ozRWECg6V447/6mx6hDwByJgKYHf8rKUQLyHjLrIWsNqaMHqBDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoR1NVzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E032C433C7;
	Wed, 24 Jan 2024 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062891;
	bh=1omuZQzDaJwOJVGdPtdVSXr7A629MpT74ikqpFOLNco=;
	h=From:To:Cc:Subject:Date:From;
	b=HoR1NVzyNBcrsN+6kdEWup87tw6xacnut2WnylBcdLGgwnpGVzmIO6Mro6V+nyqet
	 aU/uG/j5BhYZcZ49q+LlB+eEtvy7apGmWQKy8JEcpcS8wpuhJ0kcKKrCmpMe31wBNL
	 7Z83uapUhJzT2LseZhKKLIbMIHetcgf74MSukHj7kub8VKxtqhInsAlY0oE8PfeiZl
	 dUAicrh/poAH6gWzf+wmT3b0d/f1L7qyrkGrp3c2gZfVF8fT9ogm/6pWmL0UlXg1xG
	 iWAvQNjPFN8/LWEsduz4Tqdm31mCze0Qkz2/eiGudSkIexn0ODU4AvbdkNI7u6z+8G
	 yg/ip5uL1YJ6A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 00/30] BPF token
Date: Tue, 23 Jan 2024 18:20:57 -0800
Message-Id: <20240124022127.2379740-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set is a combination of three BPF token-related patch sets ([0],
[1], [2]) with fixes ([3]) to kernel-side token_fd passing APIs incorporated
into relevant patches, bpf_token_capable() changes requested by
Christian Brauner, and necessary libbpf and BPF selftests side adjustments.

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
another mechanism to allow safe usage of BPF functionality is necessary.

BPF FS delegation mount options and BPF token derived from such BPF FS instance
is such a mechanism. Kernel makes no assumption about what "trusted"
constitutes in any particular case, and it's up to specific privileged
applications and their surrounding infrastructure to decide that. What kernel
provides is a set of APIs to setup and mount special BPF FS instance and
derive BPF tokens from it. BPF FS and BPF token are both bound to its owning
userns and in such a way are constrained inside intended container. Users can
then pass BPF token FD to privileged bpf() syscall commands, like BPF map
creation and BPF program loading, to perform such operations without having
init userns privileges.

This version incorporates feedback and suggestions ([4]) received on earlier
iterations of BPF token approach, and instead of allowing to create BPF tokens
directly assuming capable(CAP_SYS_ADMIN), we instead enhance BPF FS to accept
a few new delegation mount options. If these options are used and BPF FS itself
is properly created, set up, and mounted inside the user namespaced container,
user application is able to derive a BPF token object from BPF FS instance, and
pass that token to bpf() syscall. As explained in patch #3, BPF token itself
doesn't grant access to BPF functionality, but instead allows kernel to do
namespaced capabilities checks (ns_capable() vs capable()) for CAP_BPF,
CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, as applicable. So it forms one
half of a puzzle and allows container managers and sys admins to have safe and
flexible configuration options: determining which containers get delegation of
BPF functionality through BPF FS, and then which applications within such
containers are allowed to perform bpf() commands, based on namespaces
capabilities.

Previous attempt at addressing this very same problem ([5]) attempted to
utilize authoritative LSM approach, but was conclusively rejected by upstream
LSM maintainers. BPF token concept is not changing anything about LSM
approach, but can be combined with LSM hooks for very fine-grained security
policy. Some ideas about making BPF token more convenient to use with LSM (in
particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
2023 presentation ([6]). E.g., an ability to specify user-provided data
(context), which in combination with BPF LSM would allow implementing a very
dynamic and fine-granular custom security policies on top of BPF token. In the
interest of minimizing API surface area and discussions this was relegated to
follow up patches, as it's not essential to the fundamental concept of
delegatable BPF token.

It should be noted that BPF token is conceptually quite similar to the idea of
/dev/bpf device file, proposed by Song a while ago ([7]). The biggest
difference is the idea of using virtual anon_inode file to hold BPF token and
allowing multiple independent instances of them, each (potentially) with its
own set of restrictions. And also, crucially, BPF token approach is not using
any special stateful task-scoped flags. Instead, bpf() syscall accepts
token_fd parameters explicitly for each relevant BPF command. This addresses
main concerns brought up during the /dev/bpf discussion, and fits better with
overall BPF subsystem design.

Second part of this patch set adds full support for BPF token in libbpf's BPF
object high-level API. Good chunk of the changes rework libbpf feature
detection internals, which are the most affected by BPF token presence.

Besides internal refactorings, libbpf allows to pass location of BPF FS from
which BPF token should be created by libbpf. This can be done explicitly though
a new bpf_object_open_opts.bpf_token_path field. But we also add implicit BPF
token creation logic to BPF object load step, even without any explicit
involvement of the user. If the environment is setup properly, BPF token will
be created transparently and used implicitly. This allows for all existing
application to gain BPF token support by just linking with latest version of
libbpf library. No source code modifications are required.  All that under
assumption that privileged container management agent properly set up default
BPF FS instance at /sys/bpf/fs to allow BPF token creation.

libbpf adds support to override default BPF FS location for BPF token creation
through LIBBPF_BPF_TOKEN_PATH envvar knowledge. This allows admins or container
managers to mount BPF token-enabled BPF FS at non-standard location without the
need to coordinate with applications.  LIBBPF_BPF_TOKEN_PATH can also be used
to disable BPF token implicit creation by setting it to an empty value.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=805707&state=*
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=810260&state=*
  [2] https://patchwork.kernel.org/project/netdevbpf/list/?series=809800&state=*
  [3] https://patchwork.kernel.org/project/netdevbpf/patch/20231219053150.336991-1-andrii@kernel.org/
  [4] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/
  [5] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
  [6] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
  [7] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/

v1->v2:
  - disable BPF token creation in init userns, and simplify
    bpf_token_capable() logic (Christian);
  - use kzalloc/kfree instead of kvzalloc/kvfree (Linus);
  - few more selftest cases to validate LSM and BPF token interations.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Andrii Nakryiko (30):
  bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
  bpf: add BPF token delegation mount options to BPF FS
  bpf: introduce BPF token object
  bpf: add BPF token support to BPF_MAP_CREATE command
  bpf: add BPF token support to BPF_BTF_LOAD command
  bpf: add BPF token support to BPF_PROG_LOAD command
  bpf: take into account BPF token when fetching helper protos
  bpf: consistently use BPF token throughout BPF verifier logic
  bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
  bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
  bpf,lsm: add BPF token LSM hooks
  libbpf: add bpf_token_create() API
  libbpf: add BPF token support to bpf_map_create() API
  libbpf: add BPF token support to bpf_btf_load() API
  libbpf: add BPF token support to bpf_prog_load() API
  selftests/bpf: add BPF token-enabled tests
  bpf,selinux: allocate bpf_security_struct per BPF token
  bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
  bpf: support symbolic BPF FS delegation mount options
  selftests/bpf: utilize string values for delegate_xxx mount options
  libbpf: split feature detectors definitions from cached results
  libbpf: further decouple feature checking logic from bpf_object
  libbpf: move feature detection code into its own file
  libbpf: wire up token_fd into feature probing logic
  libbpf: wire up BPF token support at BPF object level
  selftests/bpf: add BPF object loading tests with explicit token
    passing
  selftests/bpf: add tests for BPF object load with implicit token
  libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH
    envvar
  selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
  selftests/bpf: incorporate LSM policy to token-based tests

 drivers/media/rc/bpf-lirc.c                   |    2 +-
 include/linux/bpf.h                           |   85 +-
 include/linux/filter.h                        |    2 +-
 include/linux/lsm_hook_defs.h                 |   15 +-
 include/linux/security.h                      |   43 +-
 include/uapi/linux/bpf.h                      |   54 +
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/arraymap.c                         |    2 +-
 kernel/bpf/bpf_lsm.c                          |   15 +-
 kernel/bpf/cgroup.c                           |    6 +-
 kernel/bpf/core.c                             |    3 +-
 kernel/bpf/helpers.c                          |    6 +-
 kernel/bpf/inode.c                            |  276 ++++-
 kernel/bpf/syscall.c                          |  228 +++-
 kernel/bpf/token.c                            |  278 +++++
 kernel/bpf/verifier.c                         |   13 +-
 kernel/trace/bpf_trace.c                      |    2 +-
 net/core/filter.c                             |   36 +-
 net/ipv4/bpf_tcp_ca.c                         |    2 +-
 net/netfilter/nf_bpf_link.c                   |    2 +-
 security/security.c                           |  101 +-
 security/selinux/hooks.c                      |   47 +-
 tools/include/uapi/linux/bpf.h                |   54 +
 tools/lib/bpf/Build                           |    2 +-
 tools/lib/bpf/bpf.c                           |   41 +-
 tools/lib/bpf/bpf.h                           |   37 +-
 tools/lib/bpf/btf.c                           |   10 +-
 tools/lib/bpf/elf.c                           |    2 -
 tools/lib/bpf/features.c                      |  503 ++++++++
 tools/lib/bpf/libbpf.c                        |  559 ++-------
 tools/lib/bpf/libbpf.h                        |   21 +-
 tools/lib/bpf/libbpf.map                      |    1 +
 tools/lib/bpf/libbpf_internal.h               |   38 +-
 tools/lib/bpf/libbpf_probes.c                 |   11 +-
 tools/lib/bpf/str_error.h                     |    3 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |    4 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |    6 +
 .../testing/selftests/bpf/prog_tests/token.c  | 1052 +++++++++++++++++
 tools/testing/selftests/bpf/progs/priv_map.c  |   13 +
 tools/testing/selftests/bpf/progs/priv_prog.c |   13 +
 tools/testing/selftests/bpf/progs/token_lsm.c |   32 +
 41 files changed, 2980 insertions(+), 642 deletions(-)
 create mode 100644 kernel/bpf/token.c
 create mode 100644 tools/lib/bpf/features.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/token_lsm.c

-- 
2.34.1


