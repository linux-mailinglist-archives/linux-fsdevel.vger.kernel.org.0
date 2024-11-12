Return-Path: <linux-fsdevel+bounces-34399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E794B9C5080
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA203282CDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46E20B80D;
	Tue, 12 Nov 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgvFWbqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591F1AB535;
	Tue, 12 Nov 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399977; cv=none; b=AisxllpP33DG1CFgOsrkMWJjlqDCdqNYbwMiOchZ2K+bFXzUz1yPHmHICvkhNImC04Aq56cxIplAZX7ra2WiwlOkzZrgO4igkGUAb7DluFpbs1oYFOd/gKWjio+rbyIa7tZu6ZUUsA/sYVVTYua6/CV7q/svVv1z6C7yAwPodHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399977; c=relaxed/simple;
	bh=Y7htZnOFEVmRmOqBgRScScBjdMikNneCM17OkUCYvXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qa2CiW7vZFgzuWrE5cEbIvCWpmXR39Ad1CxCbG3yHay5kzOWe8lhUt03FnJC4C+go8uyuXqSxjYRRbTba+1peu/P+z8jXh2dAcrzeP1+j5V9UB0GpkLTFDk/ngXrA/xmmLaa/BtgpPVcPUuZFF2x+9upKS3KFU2tv6209A6x2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgvFWbqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95CBC4CED4;
	Tue, 12 Nov 2024 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731399976;
	bh=Y7htZnOFEVmRmOqBgRScScBjdMikNneCM17OkUCYvXk=;
	h=From:To:Cc:Subject:Date:From;
	b=AgvFWbqfY8us0MnqJPE7B1tbrr1lscwKh/m9bOW5I3r+CEh9/YqsPQfEvC0mSbolz
	 9UQgfOQzeBYaObuCl6jTj1HscYwnvkjMTwwgh7ZA5dfr6k0CHk3Cv4PgRi55fZr5y1
	 KYkzc6gxBtwzZL1ORmXVQW9rUGVh5PTzJy1/WhTWjV+HO2M6ft7Q+aW4JTIe7PjSaA
	 KyUhS8vAd+ETeA0wy6+toQylGsKTSXdbrVNdMOSVbzP6g4aryyLbHEHbH96z6FcUaV
	 Q8i92C1a8OhoAgNuZvjBW9c4sAvL1OQX1xJ8a8pgxol9YVuxyvoX9F8iRwCq1QIbJY
	 pG6WX1vFRvtNg==
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
Subject: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Date: Tue, 12 Nov 2024 00:25:54 -0800
Message-ID: <20241112082600.298035-1-song@kernel.org>
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

