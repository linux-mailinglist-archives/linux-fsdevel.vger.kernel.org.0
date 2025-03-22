Return-Path: <linux-fsdevel+bounces-44765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321DAA6C8FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADA63B6575
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA331F4E56;
	Sat, 22 Mar 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSE3SWX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25A1E835C;
	Sat, 22 Mar 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638440; cv=none; b=o8wy3SM0MuSbIdLK/hwe+ZbKpF3d/0F11RGf3S797PA3AjOXQLuAGRSPU9mCkapy4UXOtknvY5+EcS74kqRfuwDzWTrToBJMroYdw9MDhK9H8jxGCug45Gcx16p1JtRlra+wfczPpo3jJSltwR9qSMi3O7hSS1hklUZ2uP2Wax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638440; c=relaxed/simple;
	bh=T4cBarddYoI/PPoW3RNntaHXYp2XTPzref1tDNIch1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbv9z5mTep8JxlEgrffw8IlUgR9DTUj6+LQdIJn+rb6gscxhwaeEM70+mUmVUyHmNohSC7oQ3RzUUGr+uFSkPqkay1FPrWVL6Bt4XYeWZJJwW1dMNbSqhPYDyrwHuayPQaVqIZZhR5az4eCxuhICV7pOeOii5u0q0dM30xhnmz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSE3SWX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A3EC4CEDD;
	Sat, 22 Mar 2025 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638440;
	bh=T4cBarddYoI/PPoW3RNntaHXYp2XTPzref1tDNIch1I=;
	h=From:To:Cc:Subject:Date:From;
	b=LSE3SWX+XqAf4ReG8RCSumVsC0JSCeI5ZsQUi/LEUUwHbrpQnc1z3/4iu25zp2iKI
	 VCXl8rAmfI5+KiAjQoUekqpXzbQJGmaeyu+YPBgSNzSz7q00W42qADY0+GvSg31sUL
	 8ZRi+19SH7mePd18B+VWoOpf++tVj77xOswss0haBZgC2TYaaidQp5OLHN18VawtIy
	 6kiI5ujvzC422rC4ErTja8DAZfJoV4RbUrOE8E1Vhw3KWw5i0Gq19zUHyW8mAMpJPc
	 fOdUbnLyNiReaFNvO8RmaqukIxYAoVkN3/uSqlMqeg425GEsGqom1o2TKCnY5TRG3d
	 KOlxebcEIOEgw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs pipe
Date: Sat, 22 Mar 2025 11:13:51 +0100
Message-ID: <20250322-vfs-pipe-8ecf613e3047@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2797; i=brauner@kernel.org; h=from:subject:message-id; bh=T4cBarddYoI/PPoW3RNntaHXYp2XTPzref1tDNIch1I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf601aP6V545szhx+y8Jh9e/l30hSmzuw5cy6VLLgrp PTj46mpRzpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmYtHI8D/sjbbVN8dLlyQC bM6LWu1i+6l7YNWH93dyl2QsWx5p/bCXkWGKvkuTssO1aZlGFzulpq39WX6Sd1kcy8VvM5r3qR7 79pAHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains updates for pipes:

- Introduce struct file_operations pipeanon_fops.

- Don't update {a,c,m}time for anonymous pipes to avoid the performance costs
  associated with it.

- Change pipe_write() to never add a zero-sized buffer.

- Limit the slots in pipe_resize_ring().

- Use pipe_buf() to retrieve the pipe buffer everywhere.

- Drop an always true check in anon_pipe_write().

- Aache 2 pages instead of 1.

- Avoid spurious calls to prepare_to_wait_event() in ___wait_event().

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 00a7d39898c8010bfd5ff62af31ca5db34421b38:

  fs/pipe: add simpler helpers for common cases (2025-03-06 18:25:35 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pipe

for you to fetch changes up to 3732d8f16531ddc591622bc64ce4d4c160c34bb4:

  Merge patch series "pipe: Trivial cleanups" (2025-03-10 08:55:13 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.pipe tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.pipe

----------------------------------------------------------------
Christian Brauner (4):
      Merge patch series "pipe: don't update {a,c,m}time for anonymous pipes"
      Merge patch series "some pipe + wait stuff"
      Merge mainline pipe changes
      Merge patch series "pipe: Trivial cleanups"

K Prateek Nayak (4):
      fs/pipe: Limit the slots in pipe_resize_ring()
      kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer
      fs/pipe: Use pipe_buf() helper to retrieve pipe buffer
      fs/splice: Use pipe_buf() helper to retrieve pipe buffer

Mateusz Guzik (3):
      pipe: drop an always true check in anon_pipe_write()
      pipe: cache 2 pages instead of 1
      wait: avoid spurious calls to prepare_to_wait_event() in ___wait_event()

Oleg Nesterov (3):
      pipe: introduce struct file_operations pipeanon_fops
      pipe: don't update {a,c,m}time for anonymous pipes
      pipe: change pipe_write() to never add a zero-sized buffer

 fs/pipe.c                 | 181 ++++++++++++++++++++++++++--------------------
 fs/splice.c               |  40 ++++------
 include/linux/pipe_fs_i.h |   2 +-
 include/linux/wait.h      |   3 +
 kernel/watch_queue.c      |   7 +-
 5 files changed, 124 insertions(+), 109 deletions(-)

