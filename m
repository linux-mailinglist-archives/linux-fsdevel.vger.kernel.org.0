Return-Path: <linux-fsdevel+bounces-51913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ECEADD278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED2A3BD8CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9122ECE81;
	Tue, 17 Jun 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGsqBheX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C81E8332
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174939; cv=none; b=FuS1TJJ0UEYE+SHpP2AZUE487zCA5J5E2RTQaoZZlzAlF6BPakcn6DGgi3Qq+Y4y+ipKzin4cWKOFEcUjoAXSmHuFGsv7rUlkG7rD+v5xVd/yQL+XIN4CNb3Z/hXzd5scscNzLKKuxiunyeFD50gtItRWKQMQUYkh8DA3NUmPCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174939; c=relaxed/simple;
	bh=EXMMdCywt09TLnPppGdrB8T1z3UZtMF3Gr8n5REpoa8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pkip8+rKViJ8mpZS0/80W7aUXLDEPVlvst6Xa7jYdPWPySiCWA1LIFqTQiOc3+8EIAfyBlC+DWurZqQdk9EzpDKkVahU7Y3Dwa4gtxHdyKbtqfhPcaMrsN6ualcZAcy7zV9rAuAmZpLOU8Wmab6wBQB2w+zHxt4phTnzUw9PazQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGsqBheX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55773C4CEE3;
	Tue, 17 Jun 2025 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750174939;
	bh=EXMMdCywt09TLnPppGdrB8T1z3UZtMF3Gr8n5REpoa8=;
	h=From:Subject:Date:To:Cc:From;
	b=hGsqBheXq8xStJbRJOrCY5N8Jk6Tw2+/TGU68sOdrxYC7AZNnOSdpeeCnW2C1r4Tx
	 JzdwqIN9vQC5CS7G3kCjDj5/5nNmDaV/hPtuT1Pl86calowHxBOG/o9ppMVPsxPHST
	 TEH5HPZEL+ClWmXIqf2QpnQp/TmeJQ01vIc88Bx1ViNu0nE6syWEaiuKjFYoJ0fyOp
	 +HrcnGX085gCY2KRCIPJb9sDeuWfuw3uw/KlxhXx+KT/9Ae+LLpTT3zrOJO1fao4it
	 1TDg0VEyGPbFyon7wtuLiO4Pt5obo8O5gCK/6ZulP8AmPiT2613pscan81Nm5sVrhW
	 mDceaPM4WFQWA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/9] pidfs: support extended attributes
Date: Tue, 17 Jun 2025 17:42:08 +0200
Message-Id: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCMUWgC/x3MwQqDMBAE0F8pe27EjSbFXgv9gF5LD5vNpoaCS
 iKtIP57o3ObgXkrZElRMlxPKyT5xhzHoRQ8n4B7Gt6ioi8ddK1NbfGifmP6qCn6kNVC85wUluj
 WBumchnKbkoS4HOQTHvcbvMroKItyiQbud21HqgOpyDoWhxa5YUOMvrO+9XVAdqS9cOMMsvEBt
 u0PvIs6/60AAAA=
X-Change-ID: 20250617-work-pidfs-xattr-1111246fe9b2
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EXMMdCywt09TLnPppGdrB8T1z3UZtMF3Gr8n5REpoa8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9tyoE8yS2+Fs4+kRsl5oydw598TE71i6sC72mRt9n
 52zdc28jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncE2ZkuDH/v4fv2wquSd5X
 34eX3bu4cturnEVy9raOyXFtJs3OuYwM266xz7x0utKH/07Rn5uSDy9nHlNmX+7213idvqZlX91
 XXgA=
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
Christian Brauner (9):
      pidfs: keep pidfs dentry stashed once created
      pidfs: remove pidfs_pid_valid()
      libfs: prepare to allow for non-immutable pidfd inodes
      pidfs: make inodes mutable
      pidfs: raise SB_I_NODEV and SB_I_NOEXEC
      pidfs: support xattrs on pidfds
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test setattr support

 fs/internal.h                                      |   2 +
 fs/libfs.c                                         |  23 +-
 fs/pidfs.c                                         | 289 ++++++++++++++++-----
 kernel/pid.c                                       |   2 +-
 tools/testing/selftests/pidfd/.gitignore           |   2 +
 tools/testing/selftests/pidfd/Makefile             |   3 +-
 tools/testing/selftests/pidfd/pidfd_setattr_test.c |  69 +++++
 tools/testing/selftests/pidfd/pidfd_xattr_test.c   | 132 ++++++++++
 8 files changed, 448 insertions(+), 74 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250617-work-pidfs-xattr-1111246fe9b2


