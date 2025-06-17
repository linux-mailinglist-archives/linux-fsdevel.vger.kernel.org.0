Return-Path: <linux-fsdevel+bounces-51933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BCADD31A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC39C188A0D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9902ED857;
	Tue, 17 Jun 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXbs1E54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF22ECE8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175124; cv=none; b=Yf85jOOBFlX3gnyYCKu1N3gEsgvIHnTrLxr8YRfXmfXyzGOb1jtqb0bok1/XqK02AwHpLwmTFZiFjiTeaAg+1rfExmPtcOSeddqqiZWbQ7OZUo0X7DShyySYgjIp7RlhsTx1c2ifOnwirnJbyw7KjKTgpud/gIj1hPVXf2D4b18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175124; c=relaxed/simple;
	bh=G2ADcao7gr5wLevoR02sqtL5kkc1MgcUmNkBeBWy05Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jepoFukw5UaErzkRT5JAir/YjYYyk+8HnyRP5JbGw7ToE1kTw2RiGca6NxC8CySpGwJ4J1/pm0Z0tkTvHgUiyQGmr0VUzF89TTiyfs81LLXHjrTOna/cXmOmwmcBNlbXCxss0nk842F8N6eyG6Em7aW0LWND2pajDY29xQ+IO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXbs1E54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8354C4CEE7;
	Tue, 17 Jun 2025 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750175123;
	bh=G2ADcao7gr5wLevoR02sqtL5kkc1MgcUmNkBeBWy05Q=;
	h=From:Subject:Date:To:Cc:From;
	b=AXbs1E54m6oHd6vLN/nRXv5Pv8Z0GC9mWkrnMnCD+9JmtsSHN7bHuJl196IdyWLhm
	 dQz/RWD8DOYPg+5GMoeVM0lwyU684SJtmS0G0yOR/9XpdHy9EoiwV3w9lEUjzGdcxi
	 jR84aCneBpDmjH+AiUqnBERmY8szzlrkpgJ6/Sl2M4IlwFtxXmMeDqtaQenq5MkuEz
	 SPGVyWoa2Poe3iVCUGbnIS7khh4aZ6wtEacsImNl+rRR2pM/hF4XXmAb+3a936RpyQ
	 vzd2e47logMrg32VDjIq4CfpdMbVgOAZ/soWUBf26E8ijZD101Me+CweC6wS+GG1Jb
	 d8qniUOuKQCTA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/7] pidfs: support extended attributes
Date: Tue, 17 Jun 2025 17:45:10 +0200
Message-Id: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIaNUWgC/x2MwQrCQAxEf6XkbEp30YpeBT/Aq3jYbbM2CNuSF
 C2U/rvZzu3NMG8FJWFSuFYrCH1ZecwG7lBBN4T8JuTeGHzjT03rzvgb5YMT90lxCfMs6Cz+2Ca
 6RA92m4QSL7vyCY/7DV5WxqCEUULuhmIrknqX1GWBbfsDNrtQ5okAAAA=
X-Change-ID: 20250617-work-pidfs-xattr-1111246fe9b2
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G2ADcao7gr5wLevoR02sqtL5kkc1MgcUmNkBeBWy05Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9k6o+cdvsKnn8Rbt69/Ztr1sN7mjHensnPLQ89D0N
 YyWv0TaO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiO5Hhf3CHQ1OPjuEnlRnz
 i24yHVHjWSByxWl6FbduxRdhwZi9jxgZDnwo2aCnYCFfflH6c/tpH+5bJ6adXqey/el8qYqAtl8
 TOQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

With the incoming support for permanent pidfs dentries we can start
supporting extended attributes on pidfds. This will allow to attach meta
information to tasks. This currently adds support for trusted extended
attributes which is a first natural target.

One natural extension would be to introduce a custom pidfs.* extended
attribute space and allow for the inheritance of extended attributes
across fork() and exec().

The first simple scheme will allow privileged userspace to slap tags
onto pidfds which is useful for e.g., service managers such as systemd.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (7):
      libfs: prepare to allow for non-immutable pidfd inodes
      pidfs: make inodes mutable
      pidfs: raise SB_I_NODEV and SB_I_NOEXEC
      pidfs: support xattrs on pidfds
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test setattr support

 fs/libfs.c                                         |   1 -
 fs/pidfs.c                                         |  98 ++++++++++++++-
 tools/testing/selftests/pidfd/.gitignore           |   2 +
 tools/testing/selftests/pidfd/Makefile             |   3 +-
 tools/testing/selftests/pidfd/pidfd_setattr_test.c |  69 +++++++++++
 tools/testing/selftests/pidfd/pidfd_xattr_test.c   | 132 +++++++++++++++++++++
 6 files changed, 301 insertions(+), 4 deletions(-)
---
base-commit: ac79f1c5b96d8d2f39b3eed1084588160198f6d3
change-id: 20250617-work-pidfs-xattr-1111246fe9b2


