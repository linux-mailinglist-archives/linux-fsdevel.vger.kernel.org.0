Return-Path: <linux-fsdevel+bounces-36983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D69EBB4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527F92844DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEA22B5B3;
	Tue, 10 Dec 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5yk/xbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572D22B5A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864289; cv=none; b=fhfGpXUeHvHnjiiBnfX9N5ike/AJyUZwZjZ2e03Bo6PLW8uAK7+Yj5KuB//5w2ZCZs+nkRJ6HsQmtJkOjqnmj4t/LvGamWAzVHC18C7rztH7BJEkgOYUIc3SnBggAZ1RFPgaVqwUJFR8ABilKzgdySevaZHSbC1RCEbtmE/ZmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864289; c=relaxed/simple;
	bh=xbjQ13ZL7ldSJmx80rNPDdOZbd+ylMnIp7tIdL2MjDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Av30ZCBoxu7BgBJiLmXmWBqF1VC4EfGb2sT6RdAIKXx3GAplLkHFastb0awFioNMUUVH1rYLz1a8sJOLEb3YUTc4SDjuCTf+UTDzvyySuvChPuELYuaoPKkU9s7rCLxQ1tzAhDjTuUxwJVmYueErYPchB2QaD5Xmlkt5kpp3tXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5yk/xbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125A2C4CED6;
	Tue, 10 Dec 2024 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733864289;
	bh=xbjQ13ZL7ldSJmx80rNPDdOZbd+ylMnIp7tIdL2MjDE=;
	h=From:To:Cc:Subject:Date:From;
	b=r5yk/xbtQYJV59WFlmy/U4xPrOJ4csOzo8I3MuZlEK+5hMSpLEbRQX/9mR4jP4mYN
	 5uBh5hAchjIhf+fmThciqml162+6sEaE2Kbz2ocj1mqCr3eOP+IFdiphIsZbh88dYp
	 xp0vDQFvr5IFon4WBlmlEwuiTtxSR6tn+PH48C5ws7o1F5HB9WNJjnG2HLbV00/s7a
	 To/74Uqxo6pLrsVFiIpIwBWl8XhmcQaDwfrOMVoQMn4EQyJP7GYEasxOlGhI4+OAJH
	 BstrimJFScJYVihqH/FWKGOCWpWwiZ3djPog+hlEI3WvYdzshb+HdXMgB+daHTxo3X
	 4/y6T1O+DfvoA==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] fs: lockless mntns rbtree lookup
Date: Tue, 10 Dec 2024 21:57:56 +0100
Message-ID: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241207-work-mount-rbtree-lockless-7d4071b74f18
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=brauner@kernel.org; h=from:subject:message-id; bh=xbjQ13ZL7ldSJmx80rNPDdOZbd+ylMnIp7tIdL2MjDE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHrA6Lv3baIJP/MavhK3HWi+XXIn79eVvz49qlxaYaf 27oTNO80lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARQ0lGhusqAmofm5x5roSd eVa57/G0D9siNloufaRU86uOV8xffx7DP82cXd8vxjarmIooXgpNuaef3/XeVHeHra0tcy6DSNY yRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

Currently we take the read lock when looking for a mount namespace to
list mounts in. We can make this lockless at least for the simple search
case. I'm less certain about stuff like rb_prev() and rb_next() that we
use when listing mount namespaces via nsfs.

Creating a new mount namespace is a rather rare event compared with
querying mounts in a foreign mount namespace. Once this is picked up by
e.g., systemd to list mounts in another mount in isolated services and
containers this will be used a lot so this seems worthwhile doing.

Thanks!
Christian

---
Christian Brauner (5):
      mount: remove inlude/nospec.h include
      fs: add mount namespace to rbtree late
      fs: lockless mntns rbtree lookup
      selftests: remove unneeded include
      samples: add test-list-all-mounts

 fs/mount.h                            |   5 +-
 fs/namespace.c                        | 102 ++++++++++-----
 samples/vfs/.gitignore                |   1 +
 samples/vfs/Makefile                  |   2 +-
 samples/vfs/test-list-all-mounts.c    | 235 ++++++++++++++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd.h |   1 -
 6 files changed, 311 insertions(+), 35 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241207-work-mount-rbtree-lockless-7d4071b74f18


