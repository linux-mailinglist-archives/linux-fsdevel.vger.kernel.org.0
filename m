Return-Path: <linux-fsdevel+bounces-51461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A9AD7210
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D72C1C247A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B71253958;
	Thu, 12 Jun 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7FvIHzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F624887A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734731; cv=none; b=Vs7y008ju2hSlhS4dvOp2lxz4961hsfz4O64ABH+E9biua6kpGtebMq8JPs4xbDT8GaBbiOOD8mShYOxIdcyZYPkyUNEHKDLmrY5qo8ivH3ccofboziKtUxwbZI/CXcbTlJjqU82Lhz0UhT7tlaEldoMktFWcgaZZUJ8GrIeyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734731; c=relaxed/simple;
	bh=NlHBcSrRcxGElkasYU9bS+WIlWut3vJ0herzprFqtFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OHpQRmQJyfYe9z8GCMx0K4RKHzPviW3CXDlI/3b9QEWJdeZAZzSTFPy8RGUl85J7VYBFEgWR40C/29xV6DjzyCsFy9jJXSdA5GP48s2mYumcsXdsNfawwcKPGvlOe/oxVkzhamGnEe1mSLf/480WmvHUVueqI9YE4Y+oOh68D+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7FvIHzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57631C4CEEA;
	Thu, 12 Jun 2025 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734730;
	bh=NlHBcSrRcxGElkasYU9bS+WIlWut3vJ0herzprFqtFg=;
	h=From:Subject:Date:To:Cc:From;
	b=h7FvIHzsgqKViC12fe5wgCkLQ9/k5m533rvOYyHjlZQxkYX7PF1s/hxrfbpf9tKgf
	 cm2wPYF8zJL6ZjZOoiJA6LEAYH1lYAK5kwKFgemjN3ZYWGWXzo6ZdK8f7ha/NGUKwa
	 V9ovnjt1S2YPsE5IAh3z1bQZYG9Ql8qSe8WntTcp1qEsWrLoqOPrpM7VHUdkDZZgay
	 N1RHcwdVPoAB/zWNzhuG+K+Oad/CioMlzylilB9x3krdUOzT62boctTp3MRCtINlb3
	 G4tr8xJ3fTHdlor7V/vsHeKXzNY5OXPKnpIUB1bsmsi7aQj+/vhzzmXhdKsTcLXGzK
	 lXAWDDMK0fqTg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/24] coredump: further cleanups
Date: Thu, 12 Jun 2025 15:25:14 +0200
Message-Id: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvVSmgC/zXMQQrCMBCF4auUWTsliRjBq4iLSTKxQZqUGaxC6
 d2Ngssf3vs2UJbCCpdhA+G1aGm1hz0MECeqd8aSeoMz7mS8dfhq8sDYhNNzXnAmVeojdsHn5KO
 hcIT+XYRzef/c6613IGUMQjVOX23Nin605/EPwb5/AEygpcaLAAAA
X-Change-ID: 20250612-work-coredump-massage-e2b6fd6c0ab3
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NlHBcSrRcxGElkasYU9bS+WIlWut3vJ0herzprFqtFg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXW7seP25KDuA2Y3TL6KND/0O/N09Z17P7ZkTT7Cz
 HRr5VruyR0lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATUXBj+B/W8C/O9+5H3fPP
 Px2uEu2J5TXeEeR+r3fPT69vTPd23o5j+F5l7n1WTiHofJKfwxw52UPSlgfPtHAqx1UX/SnWumf
 JBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Continue reworking the coredump code so it's easier to follow and modify
in the future.

* Each method is moved into a separate helper.
* The cleanup code is simplified and unified.
* Entangle the dependency between the pipe coredump rate limiting and
  the common exit path. 

It's likely that there'll be more.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (24):
      coredump: rename format_corename()
      coredump: make coredump_parse() return bool
      coredump: fix socket path validation
      coredump: validate that path doesn't exceed UNIX_PATH_MAX
      fs: move name_contains_dotdot() to header
      coredump: don't allow ".." in coredump socket path
      coredump: validate socket path in coredump_parse()
      selftests/coredump: make sure invalid paths are rejected
      coredump: rename do_coredump() to vfs_coredump()
      coredump: split file coredumping into coredump_file()
      coredump: prepare to simplify exit paths
      coredump: move core_pipe_count to global variable
      coredump: split pipe coredumping into coredump_pipe()
      coredump: move pipe specific file check into coredump_pipe()
      coredump: use a single helper for the socket
      coredump: add coredump_write()
      coredump: auto cleanup argv
      coredump: directly return
      cred: add auto cleanup method
      coredump: auto cleanup prepare_creds()
      coredump: add coredump_cleanup()
      coredump: order auto cleanup variables at the top
      coredump: avoid pointless variable
      coredump: add coredump_skip() helper

 Documentation/security/credentials.rst             |   2 +-
 .../translations/zh_CN/security/credentials.rst    |   2 +-
 drivers/base/firmware_loader/main.c                |  31 +-
 fs/coredump.c                                      | 554 ++++++++++++---------
 include/linux/coredump.h                           |   4 +-
 include/linux/cred.h                               |   2 +
 include/linux/fs.h                                 |  16 +
 kernel/signal.c                                    |   2 +-
 tools/testing/selftests/coredump/stackdump_test.c  |  32 +-
 9 files changed, 366 insertions(+), 279 deletions(-)
---
base-commit: e04f97c8be29523bae2576fceee84a4b030406fb
change-id: 20250612-work-coredump-massage-e2b6fd6c0ab3


