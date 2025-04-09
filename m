Return-Path: <linux-fsdevel+bounces-46039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F04A81B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 05:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289C34A5F08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 03:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A21C1F22;
	Wed,  9 Apr 2025 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JU3QQPb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljlxsW4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D3524F;
	Wed,  9 Apr 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169680; cv=none; b=j82csWbpyI1whYxBWj7fbbfLd4zMstPvK4BR/HopSOmE89HxjXzOYb6HfHObftuHbD4uCkVs7xX8r+kutx9vtkA3nVfV2pRSOa4g98DswH+C0rDLWfDedOXisfg/LIDJnck+OZ3mdL+CYl3TdqF6rfkZBcEjbGeQIi5achLC73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169680; c=relaxed/simple;
	bh=b6zV8GOspPN/yp1UaoSQi7HmMP0SFPNWk+enfaKC0e0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q0SLfrQ8gbpJxAyEGrIfsOibMnZgmEevN9Exgpqvf87lSYUuXdCOZpoTledwP/Ml7LqNU0OkuZvBXou8gTX0Ax8K92BkI3CZRN7woMOpv5whaj3RKeVq1JgGbmMXDHapOAldVqwCmvAfyPv1f8KkXYSUx3ey6Q2sf8jYLfpO8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JU3QQPb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljlxsW4z; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DAFF11401EC;
	Tue,  8 Apr 2025 23:34:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 08 Apr 2025 23:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1744169675; x=1744256075; bh=KgpeIAFHyGKVpKQfj8mF9
	93N7YtyGNtKnt7Z58kWdLQ=; b=JU3QQPb/wN6HqjxOlGWZqrnhmlvF1faE0Zgdz
	3CFe2Q+Cxm2IZn2E0vXdVcJ8wNhu75Au/Y/ExoZt6tTDJNbPNzrfOnL/yDC9v4nc
	i1hCDGfw50sOnp+RmV8ALPhXNCwT/lnV+vfbxk/70Sgbu8vv4Ci1/sWUnB1iLg3y
	4Fv7FjQQ+7Awl9PaumIjQ+qwEBedBaaBnVrFiSzbEc9Z4MqSzyEhwHiDdV9xRTHJ
	+CF1Ab/I30CNq1BeNUpI6fQzI1bbs/66SPDg28hs/VpurNEZ/9a5LQ3RkdLRnlLH
	6IHCz1FUX6b9MuQhPj5IEGYmMpgdDQvOJE8PLw98EAGuKTDQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744169675; x=1744256075; bh=KgpeIAFHyGKVpKQfj8mF993N7YtyGNtKnt7
	Z58kWdLQ=; b=ljlxsW4zn2160lMrJTz+xXf8n8+EGpRB6HnSg9hVs8sJYIkOu+1
	O3BKQ9A9XLS1dnYfxo42SMGSCc3vtmXj9EtsrifKGvtB1CfYJoG21Vm871O9M2/h
	0DYuVp42/N8s9160n7BKZ7DYtykNDFrd3jWE7brW/yIcZldr/Pslqy0yO4GeEHwO
	4crMURsOxvbJvQ5d1qj1pV+CWyGv2W7NIc0AvCwF2F4tGjSy9f4I9upViBcvvA8O
	jLu2w7HYJx6lBGPgrKJnFGwyjdJVDCI9E0pO4lscn5CztpS5i0/jOT0LT5bAKwSk
	a/DQFKrHFgM+hPBePNFwTmWfzdgwcTrev9A==
X-ME-Sender: <xms:yur1ZyVdybc6G347olxo2AXEEYyK0_KETXUNYG2f5jQITFj_ay3d2g>
    <xme:yur1Z-kCfmbzJvGo2hWJSkeeOusu31alVtVjEuNus85ayo6fpJ-ewTyNl_hIVPLKp
    1ao1l08jXbxli8AXQ>
X-ME-Received: <xmr:yur1Z2brcI4yuxbQCzXIsr1I-TajeI1pvOQuexI-BfLE2dWY3PSJ_F6z2b97RjwnrTWXOaeIdEQD4EIzVINPeY9Wwx5oOqd-AZ1Z_BxD85d8uVa7Z2cm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dlvdefmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffo
    ggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguh
    huuhdrgiihiieqnecuggftrfgrthhtvghrnhephfeijeelueeuveekjeejteeitdegieff
    gfeguefhjeeljedtiefgvdejkedtfeelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepuddtpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    phgvrhhfqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvghtfhhilhhtvghrqdguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    ohhrvghtvggrmhesnhgvthhfihhlthgvrhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhmvgguihgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yur1Z5VKfdRnYV8i1TP-pNPD1hrrL4sDGE-uCU85kLjBqhXmeSGR-w>
    <xmx:yur1Z8lj-j2S7pjQSdGbsOrX6betNOzEBXMmmyt-g_NluETEaFR74w>
    <xmx:yur1Z-eudSUkuoxHlgCxyQm1envt8p4mI6Yf092RXw0eSvzGFAJePQ>
    <xmx:yur1Z-GT0K-nfjfwuCknjUdWg-t1nGIg7jv9sjwnTEI957PzSviVNw>
    <xmx:y-r1Z414n0pfTsw7uFuGS0gmgPBVKLECLJf69UAINXf9nxfcOeJSIIAA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:33 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC bpf-next 00/13] bpf: Introduce modular verifier
Date: Tue,  8 Apr 2025 21:33:55 -0600
Message-ID: <cover.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the base infrastructure for modular BPF verifier.
The motivation remains unchanged from the LSFMMBPF25 proposal [0].

However, the design has diverged. Rather than immediately going for the
facade described in [0], we instead make a stop first at the continously
exported copies of the verifier in an out-of-tree repository, with a
separate copy for each kernel release. Each copy will receive as many
verifier backports as possible within the "boundary" of the modular
portions.

For example, a patch that changes the verifier at the same time as one
of the kernel symbols it depends on cannot be applied, as at runtime
only the verifier portion can be updated. However, a patch that only
changes verifier.c can be applied, as it's within the boundary.  Rough
analysis of past data shows that most verifier changes fall within the
latter category. The jupyter notebook for this can be found here [1].

From here, we'll gradually enlarge the "boundary" to enable backports of
more and more patches, with the north star being the facade as described
in the proposal. Ideally, completion of the facade will render the
out-of-tree repository useless.

[0]: https://lore.kernel.org/bpf/nahst74z46ov7ii3vmriyhk25zo6tkf2f3hsulzjzselvobbbu@pqn6wfdibwqb/
[1]: https://github.com/danobi/verifier-analysis/blob/master/analysis.ipynb

Daniel Xu (13):
  bpf: Move bpf_prog_ctx_arg_info_init() body into header
  bpf: Move BTF related globals out of verifier.c
  bpf: Move percpu memory allocator definition into core
  bpf: Move bpf_check_attach_target() to core
  bpf: Remove map_set_for_each_callback_args callback for maps
  bpf: Move kfunc definitions out of verifier.c
  bpf: Make bpf_free_kfunc_btf_tab() static in core
  selftests: bpf: Avoid attaching to bpf_check()
  perf: Export perf_snapshot_branch_stack static key
  bpf: verifier: Add indirection to kallsyms_lookup_name()
  treewide: bpf: Export symbols used by verifier
  bpf: verifier: Make verifier loadable
  bpf: Supporting building verifier.ko out-of-tree

 arch/x86/net/bpf_jit_comp.c                   |   2 +
 drivers/media/rc/bpf-lirc.c                   |   1 +
 fs/bpf_fs_kfuncs.c                            |   4 +
 include/linux/bpf.h                           |  82 ++-
 include/linux/bpf_verifier.h                  |   7 -
 include/linux/btf.h                           |   4 +
 kernel/bpf/Kbuild                             |   8 +
 kernel/bpf/Kconfig                            |  12 +
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/arraymap.c                         |   2 -
 kernel/bpf/bpf_iter.c                         |   1 +
 kernel/bpf/bpf_lsm.c                          |   5 +
 kernel/bpf/bpf_struct_ops.c                   |   2 +
 kernel/bpf/btf.c                              |  61 +-
 kernel/bpf/cgroup.c                           |   4 +
 kernel/bpf/core.c                             | 463 ++++++++++++++++
 kernel/bpf/disasm.c                           |   4 +
 kernel/bpf/hashtab.c                          |   4 -
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/local_storage.c                    |   2 +
 kernel/bpf/log.c                              |  12 +
 kernel/bpf/map_iter.c                         |   1 +
 kernel/bpf/memalloc.c                         |   3 +
 kernel/bpf/offload.c                          |  10 +
 kernel/bpf/syscall.c                          |  52 +-
 kernel/bpf/tnum.c                             |  20 +
 kernel/bpf/token.c                            |   1 +
 kernel/bpf/trampoline.c                       |   5 +
 kernel/bpf/verifier.c                         | 521 ++----------------
 kernel/events/callchain.c                     |   3 +
 kernel/events/core.c                          |   1 +
 kernel/trace/bpf_trace.c                      |   9 +
 lib/error-inject.c                            |   2 +
 net/core/filter.c                             |  26 +
 net/core/xdp.c                                |   2 +
 net/netfilter/nf_bpf_link.c                   |   1 +
 .../selftests/bpf/progs/exceptions_assert.c   |   2 +-
 .../selftests/bpf/progs/exceptions_fail.c     |   4 +-
 38 files changed, 834 insertions(+), 514 deletions(-)
 create mode 100644 kernel/bpf/Kbuild

-- 
2.47.1


