Return-Path: <linux-fsdevel+bounces-30800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89F98E577
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BB51C241FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8249219A2BD;
	Wed,  2 Oct 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slFH6A3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7C19993B;
	Wed,  2 Oct 2024 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905622; cv=none; b=P0ltso2oxZNsJMC2aU7uv2T1xLPUZ5MVEYXE8IAkXEXmT/50e0SkQL4IGqgHK0YOW6m4e32e5c+fX4jea0KRLhN8QzL09I/ovrtzCD3XyB1v/KHYHdThW/0VOgfzOpBV5o3JUS2kFAfNVjVSHcwyfgDY1K3o+580b7lNXXRUzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905622; c=relaxed/simple;
	bh=B/A9XDcq31vO4j7nqLZbgqF863TkV6jzW1tMihg32WU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzIx3r0FPHoRX2oI2JgvdqPDiFDiUDozPuMye5fbbFmggRofQUjuI3SFvxbJpXiWSVd9DfxUl46GWkdqcLSJBMs5uXx9Rr19ImoGIkqESae29BilwMSCpWpBZQNGouU9RPt+00sPOYJo4Ml8HO79TjSi/JP0viL8KwxxEmZcM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slFH6A3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE42C4CEC5;
	Wed,  2 Oct 2024 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727905621;
	bh=B/A9XDcq31vO4j7nqLZbgqF863TkV6jzW1tMihg32WU=;
	h=From:To:Cc:Subject:Date:From;
	b=slFH6A3nyyQSkChZIgM3VDv8AdWsqq1Ui/u36Akg6YBo5c3F4sJMBZItUAum/Vyfv
	 4ayfXMlc9WFDrQn2TmFxJsmOXn2kDDZ35kmPX25BobOxWzR6hfHFNFgSXIhgZADGXU
	 F4lxy2exTM26x6PbHInwfzYfNZVXTmS94Wo7KG7VyLAgfBX9D3XKvPqrlTUbGEEZLZ
	 eFabNadxaGdP+v1SjXddbdrocNJ4S9vUKvJC+k9dyEj2JauHVzcl+9RNnXODEYqH0c
	 AUIskD0APIeE4TLamimsQjb5aiw7dfwwrJDEovjXiDU7ZJNjN9pCJM9pHHND5QgF8F
	 tSBNf/JwYlL0A==
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
Subject: [PATCH bpf-next 0/2] security.bpf xattr name prefix
Date: Wed,  2 Oct 2024 14:46:35 -0700
Message-ID: <20241002214637.3625277-1-song@kernel.org>
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

Song Liu (2):
  fs/xattr: bpf: Introduce security.bpf xattr name prefix
  selftests/bpf: Extend test fs_kfuncs to cover security.bpf xattr names

 fs/bpf_fs_kfuncs.c                            | 19 ++++++++-
 include/uapi/linux/xattr.h                    |  4 ++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 40 ++++++++++++++-----
 .../selftests/bpf/progs/test_get_xattr.c      | 30 ++++++++++++--
 4 files changed, 78 insertions(+), 15 deletions(-)

--
2.43.5

