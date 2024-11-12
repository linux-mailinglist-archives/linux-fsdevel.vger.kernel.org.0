Return-Path: <linux-fsdevel+bounces-34407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDCE9C50E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08293B27AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71DF20DD58;
	Tue, 12 Nov 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNrb4OhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81B20B808;
	Tue, 12 Nov 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400632; cv=none; b=bfr3eh+YOfdTqd374Omi+uLUvI58uOonluiU7djbi6KhQ08HnybkDj7/W1w9YQL1pgNSeVAYmIrWiILGgWv0u4wyfoaFdAjPhAhTrTa9PYjwfJw5u+3K+lMBiQUIOGY44SDdMk2AgVIDEZhNrvJkGGGUjQUaHmP4bzUitL1r4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400632; c=relaxed/simple;
	bh=fKhoaCdIeovts+6PvFMNY2TwhszCTEY6Pyhcf3zYB4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6T2sCkXSAt4S0hCYSAXTsukiixzmeqzDjV7BfY0znzB+SFTt1aGpBgX6DJoY93JvO0f7GnPnEtedpHZ2c7KRQ1Ni5j9a2guF8XCqT1JpF8iGMLSC/6/dXiJLWDNRVHspK4IrGVtvZOu5g672Ibj4ivvIi88Vg9932jXJuMapeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNrb4OhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A2C4CECD;
	Tue, 12 Nov 2024 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731400631;
	bh=fKhoaCdIeovts+6PvFMNY2TwhszCTEY6Pyhcf3zYB4o=;
	h=From:To:Cc:Subject:Date:From;
	b=JNrb4OhZBdoqBcs75S38CeT0u9Qwugn/mw/ip9XnH+/nqQ8nPDsDETv43RgRZu8K7
	 mSOTlylYqxjNl2y6VrhiZ9JChBY3rbzKOeWXDLXxCupAwgF0U0yUcUc/sx8HtDWr+i
	 4eZpYcu/Q8DmrxEYI8p/6e1mlHf1nbFvchkurtOBxmKwWx5aAeQugZHyGTryAEedgs
	 olfzthVCRcArh9yGZwoFKdqNgslC1uJiHEIOrA6o1MchMwmtky+t6KlHUfv9uUuDbZ
	 wiOncgBTeHS5ddEYYThUIH66aBAdyYEcj/1KscEg+hG0FxzNe8K5NcEgd8IMapmPC+
	 YSOTpQwszjAPQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/4] Make inode storage available to tracing prog
Date: Tue, 12 Nov 2024 00:36:56 -0800
Message-ID: <20241112083700.356299-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf inode local storage can be useful beyond LSM programs. For example,
bcc/libbpf-tools file* can use inode local storage to simplify the logic.
This set makes inode local storage available to tracing program.

1/4 is missing change for bpf task local storage. 2/4 move inode local
storage from security blob to inode.

Similar to task local storage in tracing program, it is necessary to add
recursion prevention logic for inode local storage. Patch 3/4 adds such
logic, and 4/4 add a test for the recursion prevention logic.

Changes v1 => v2:
1. Rebase.
2. Fix send-email mistake.

Song Liu (4):
  bpf: lsm: Remove hook to bpf_task_storage_free
  bpf: Make bpf inode storage available to tracing program
  bpf: Add recursion prevention logic for inode storage
  selftest/bpf: Test inode local storage recursion prevention

 fs/inode.c                                    |   1 +
 include/linux/bpf.h                           |   9 +
 include/linux/bpf_lsm.h                       |  29 ---
 include/linux/fs.h                            |   4 +
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/bpf_inode_storage.c                | 185 +++++++++++++-----
 kernel/bpf/bpf_lsm.c                          |   4 -
 kernel/trace/bpf_trace.c                      |   8 +
 security/bpf/hooks.c                          |   7 -
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../bpf/prog_tests/inode_local_storage.c      |  72 +++++++
 .../bpf/progs/inode_storage_recursion.c       |  90 +++++++++
 12 files changed, 320 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inode_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/inode_storage_recursion.c

--
2.43.5

