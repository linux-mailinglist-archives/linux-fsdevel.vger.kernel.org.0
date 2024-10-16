Return-Path: <linux-fsdevel+bounces-32067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC89A022B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1C31F24A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56211B6D0C;
	Wed, 16 Oct 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAsGay7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C5433CE;
	Wed, 16 Oct 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062605; cv=none; b=CxwwNE7vJa+hV6Q4urIf++vPefjOeYeEg/e29pGRFDxQMdsHNzQE2ImZqqefKVr+YjHxXZdDl5reTLfuAIjJB//0ClXpC0NGq/NlHeKZzYE7WrnJtTwARQeqmFR9dGk7d83nhOaTN/+2CwQDDpib8v9Gz5B3/w4sytll2PE8nN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062605; c=relaxed/simple;
	bh=Wnu9kNlRHvr/q70LNQ3w/Hk2P35T91JQjHS3wd1Tdi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWMC3IviQNXjezpmVewLZHCWO2qFx/66gpHCkgF+4vMlz7VVAGOI5mGUFmYmLOaelAlHqWFrYOT9fGCgfEniOn6lunbRVgjzisDVyNV3+/LYXKDaUro2XKGy7i+9CF1u8J+GukMkFMJtj4xB61F1XgP9EWRra3ukkRQihEdcCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAsGay7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E27BC4CEC5;
	Wed, 16 Oct 2024 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729062604;
	bh=Wnu9kNlRHvr/q70LNQ3w/Hk2P35T91JQjHS3wd1Tdi4=;
	h=From:To:Cc:Subject:Date:From;
	b=tAsGay7PjSssyc3Z05CrOV9TLk7fPicnuLwSe1HKJVSoPwLawDw8e4sxjlwFZOdxO
	 tjOsxuOJRDGB4b2HALFqvjoWK13dVkpuH1MO258wpk/GF79vR1z1LR5CJiezDf5XY8
	 ugkSc1K9TbjFO0ZlI5Y0W9NsQilk/P7AHEmP8/suLFMyJy8IrfbTgvlHC8L86CRLqv
	 s+2AkYa3kS0LDBgqvNxdGBE8tq9Sl4zSER/ryH6UGrS7v3TMMtOHulxIVUAXWJ94+1
	 fr0e897A3yM5XbnuMXTctPYZ35B86yhgS8G8n0N+a6SYyv9baCQkCPV+rtfXWbKLe7
	 7vjZ1s7ld+12g==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/2] security.bpf xattr name prefix
Date: Wed, 16 Oct 2024 00:09:53 -0700
Message-ID: <20241016070955.375923-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow up discussion in LPC 2024 [1], that we need security.bpf xattr
prefix. This set adds "security.bpf" xattr name prefix, and allows
bpf kfuncs bpf_get_[file|dentry]_xattr() to read these xattrs.

[1] https://lpc.events/event/18/contributions/1940/

Changes v1 => v2
1. Update comment of bpf_get_[file|dentry]_xattr. (Jiri Olsa)
2. Fix comment for return value of bpf_get_[file|dentry]_xattr.

v1: https://lore.kernel.org/bpf/20241002214637.3625277-1-song@kernel.org/

Song Liu (2):
  fs/xattr: bpf: Introduce security.bpf xattr name prefix
  selftests/bpf: Extend test fs_kfuncs to cover security.bpf xattr names

 fs/bpf_fs_kfuncs.c                            | 22 +++++++++-
 include/uapi/linux/xattr.h                    |  4 ++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 40 ++++++++++++++-----
 .../selftests/bpf/progs/test_get_xattr.c      | 30 ++++++++++++--
 4 files changed, 80 insertions(+), 16 deletions(-)

--
2.43.5

