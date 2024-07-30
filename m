Return-Path: <linux-fsdevel+bounces-24640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A734942341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 01:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E823FB251DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F41922DD;
	Tue, 30 Jul 2024 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA6b8ZGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97035191F72;
	Tue, 30 Jul 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380915; cv=none; b=hOLLWTX8lqTW7l383e960C+7CgVe/vVdnKMirMizQIiIWx+RMOD4YAhRdTPsIq40ZEuIcJz4dwJW0Mbjws18Kv33T4wxGUiF/xmQluVAdOGbJf2pbewsZtS2xgym2Xj2OJWO5T8oVGA3CntEMaoT5qh2KkiisefoE4zUcmWQE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380915; c=relaxed/simple;
	bh=+jM3S/DkTC2Mh0lhp+tvsPqAdZXA/Ps+Ju82iQ305dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzT5rTNjRN0atXublwv8Rk7v3/aqy87bEHRsYAU5CfT0hJ6rnKHQ4bOsODjnqz5bOXE1WKVnLqPyO7w9bnuvM+ZfyKcIt46uZwMOYRNMRFKJgnBI/7T/n1oiDiu8rY5gpEMhsNg6ekA4yE0j64GLOqBTczQwJSiY3JF5bxzGuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA6b8ZGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FDEC32782;
	Tue, 30 Jul 2024 23:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722380915;
	bh=+jM3S/DkTC2Mh0lhp+tvsPqAdZXA/Ps+Ju82iQ305dk=;
	h=From:To:Cc:Subject:Date:From;
	b=dA6b8ZGMvyJ72TIotXBE90QZUYkEtlhIPz/zVxuH3zSkz6rDx7TOWahbKOoNT7EKw
	 oNIN8jILTsUxx/1vWSmP5SqTjCiQqAy5kXZa4P9PIJuicGvCxCCgPFY6jlwBCW43e3
	 ASroxYlRPmhBxBFHUqTC4QQMhlV3+ETmJgb5Va5wnf6iIhatRkbRjouFzf9mmDjgyP
	 AfkDOLGXiOAf7tS5fuVONpJ/fJJ+IA4P0DMtB3BSKjB7uyy7FVILyAsglrHctHFXkw
	 pprKp2Z1pKXCfMny8OmwoxgzBu8OF0JeW0xMhHUZPHfnh8dL3+1/IvXWFhwpgtgocj
	 9JZGIZuYheHrQ==
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
	liamwisehart@meta.com,
	lltang@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/2] Add bpf_get_dentry_xattr
Date: Tue, 30 Jul 2024 16:08:03 -0700
Message-ID: <20240730230805.42205-1-song@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kfunc to read xattr from dentry. Also add selftest for the new
kfunc.


Changes v1 => v2:
1. Remove 3 kfuncs that are ready yet.

v1: https://lore.kernel.org/linux-fsdevel/20240725234706.655613-1-song@kernel.org/T/#u

Song Liu (2):
  bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
  selftests/bpf: Add tests for bpf_get_dentry_xattr

 kernel/trace/bpf_trace.c                      | 46 ++++++++++++++-----
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  9 +++-
 .../selftests/bpf/progs/test_get_xattr.c      | 37 +++++++++++++--
 3 files changed, 75 insertions(+), 17 deletions(-)

--
2.43.0

