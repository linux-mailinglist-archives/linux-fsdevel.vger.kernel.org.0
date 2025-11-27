Return-Path: <linux-fsdevel+bounces-69947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F7C8C7AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6BC3B69D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E99F2641E7;
	Thu, 27 Nov 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM7pkOmq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6925F78F;
	Thu, 27 Nov 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204643; cv=none; b=kUHb31hiiiqsaxLyx4EaBCOr2m+qChe8El9IBP6PiKuX8WM2ugB6o8yAIOtGfxq+dwEGyVZaw42WroxvZMRnrufhHymGz+POZHguOZQU4ArGZXcUwX5o6dCy7ERAjukHXOAmXsbzKOC+ytjWg5GuLCIRZf7dchLUhBPe7V1aO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204643; c=relaxed/simple;
	bh=DHNoe28s2mWzphn+U+HggYHkEaMFi8tpUIzDb2hR+C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpMoFrgRdMtHXN1lyMM7bz3uhe8GQBVAgtGgJV/jankFEWfo8XH1xSPxk+rp9JTCS+6xALmwOGh+594mtPi+6suhBHG/DhsJTC+Idaa5HVQN5rmL5L9hLj4JRAHURt+N8q8HPt4QpJW/7wp0mRB2NGDWZ6IEj3ky1wCT+jaFt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM7pkOmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D102AC4CEF7;
	Thu, 27 Nov 2025 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764204642;
	bh=DHNoe28s2mWzphn+U+HggYHkEaMFi8tpUIzDb2hR+C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fM7pkOmqWHE7gT4Jfpr38aFODmWhkaxbqX8xD+e8Q7HQjKQaWwaPXVIoMSR33ff6L
	 70STvpBFEQPOu91sMryQEjj7GTfS4jYPaNlj8i4985RACR3TBvGjHj4+tYQfpWPZYO
	 80b8HckACVrkTuQwqgMzt/PW6kGIODm7J/62YFfzzyEURGuX8fEROobE72zrMAoR/R
	 3RhFSHyXlgfJI96b+frnAk4+jEttX6Yu6BQugDwMzlz98iQang0qxIkHot0A2ufy+2
	 8AERE525++keYxovxZZXO3jKgW9lkNfBllhSG8lsWZry4F0x/aWJ/vOMt2bP+8tiDm
	 rTqAcv8S58uHA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel-team@meta.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/3] Introduce bpf_kern_path and bpf_path_put
Date: Wed, 26 Nov 2025 16:50:08 -0800
Message-ID: <20251127005011.1872209-5-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127005011.1872209-1-song@kernel.org>
References: <20251127005011.1872209-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Security solutions use LSM hook security_sb_mount to monitor mount
operations. security_sb_mount takes dev_name as a string. To get a struct
path from dev_name, in-tree LSMs use kern_path. Introduce kfuncs
bpf_kern_path so that bpf LSM can do similar operations. bpf_kern_path
takes a reference on the return value path. Also add kfunc bpf_path_put to
release path returned by bpf_kern_path. Note that, bpf_kern_path only holds
reference on the path during the duration of this bpf program. The verifier
enforces the bpf program release this reference.

Patch 1/3 prepares bpf verifier to handle const char * passed in as hook
argument. Before this change, bpf helpers and kfuncs only consider value
from read only map as const string.

Patch 2/3 adds the two kfuncs.

Patch 3/3 add tests for the new kfuncs.

Song Liu (3):
  bpf: Allow const char * from LSM hooks as kfunc const string arguments
  bpf: Add bpf_kern_path and bpf_path_put kfuncs
  selftests/bpf: Add tests for bpf_kern_path kfunc

 fs/bpf_fs_kfuncs.c                            | 58 +++++++++++
 include/linux/btf.h                           |  1 +
 kernel/bpf/btf.c                              | 33 +++++++
 kernel/bpf/verifier.c                         | 51 +++++++---
 .../testing/selftests/bpf/bpf_experimental.h  |  4 +
 .../selftests/bpf/prog_tests/kern_path.c      | 82 ++++++++++++++++
 .../selftests/bpf/progs/test_kern_path.c      | 56 +++++++++++
 .../selftests/bpf/progs/verifier_kern_path.c  | 52 ++++++++++
 .../bpf/progs/verifier_kern_path_fail.c       | 97 +++++++++++++++++++
 9 files changed, 422 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kern_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kern_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kern_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kern_path_fail.c

--
2.47.3

