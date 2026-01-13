Return-Path: <linux-fsdevel+bounces-73398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF510D179BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 558CC309E461
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4238B7AB;
	Tue, 13 Jan 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D47oGLi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8F3815EC;
	Tue, 13 Jan 2026 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296073; cv=none; b=gD7l9OyM8HhgHEqxv02+zPFQAKp5ZlTOEYhZ5X6DWMk9M2WtwkW3MusJZv7Q/PzV7C6KWmVzzJt/k1Sj1+UKKrmivYxmXHbhat+QcijnLSh5iUPwdT4OBANPyMZYyQYLQ3I/9P14abKViF9SBdOeB5cG/iT1tPUc01wyVJejLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296073; c=relaxed/simple;
	bh=gkf9N4Ta95K8cpAwSm6uLGWfXQ2rm0P6LOSwgxcXoW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXq3B5jCKD83PTr8eanfyWK23QwYb+ieF17WpA0vDquqJNhQyfP7VMPfTV+crYaXAX1xqePYgGzW/NTZ1DGbb6/wSYU++b1Oo4fYJUlpPzkLEUnhKAwFy/gTKwq2kyw4YCfYSQEciuxRxGinWiG/cxFdaJQchZYYnEUNh59QRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D47oGLi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DFAC116C6;
	Tue, 13 Jan 2026 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296071;
	bh=gkf9N4Ta95K8cpAwSm6uLGWfXQ2rm0P6LOSwgxcXoW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D47oGLi+PEe9fiifGKgMxibo+LrY0ZuRG5bVYrmZXZf66Fbb1wrbmDcclPDhQS0fb
	 XT7lXyT5bPab8AM7VH+WhMDNn4Cris65KUbL88k+mnXhiqhos0JSDJDztDH7KYZTlP
	 IbQoZ+DCILkZXh4YuKn+3vteZk7lhEZ/Eo5ONnnXEXUSeaulXzI4WfJUhUNGzxQCfJ
	 sYHr2Qyq4XiT7RXIXBEbhmPsI6ZVOzTDNkNM4eBsIEKH19x6B6YC56PyxZQkFhWINQ
	 tk20sOGetMPHdUtpdcIG0AFT5hIhi8hw7dzpO0pYQeL+1lTcmAiPiRvBCvtUwfxD1v
	 Ea54HtvmvsPCQ==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] proc: subset=pid: Relax check of mount visibility
Date: Tue, 13 Jan 2026 10:20:32 +0100
Message-ID: <cover.1768295900.git.legion@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213050639.735940-1-danilklishch@gmail.com>
References: <20251213050639.735940-1-danilklishch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting procfs with the subset=pids option, all static files become
unavailable and only the dynamic part with information about pids is accessible.

In this case, there is no point in imposing additional restrictions on the
visibility of the entire filesystem for the mounter. Everything that can be
hidden in procfs is already inaccessible.

Currently, these restrictions prevent pidfs from being mounted inside rootless
containers, as almost all container implementations override part of procfs to
hide certain directories. Relaxing these restrictions will allow pidfs to be
used in nested containerization.

Changelog
---------
v7:
* Rebase on v6.19-rc5.
* Rename SB_I_DYNAMIC to SB_I_USERNS_ALLOW_REVEALING.

v6:
* Add documentation about procfs mount restrictions.
* Reorder commits for better review.

v4:
* Set SB_I_DYNAMIC only if pidonly is set.
* Add an error message if subset=pid is canceled during remount.

v3:
* Add 'const' to struct cred *mounter_cred (fix kernel test robot warning).

v2:
* cache the mounters credentials and make access to the net directories
  contingent of the permissions of the mounter of procfs.

--

Alexey Gladkov (5):
  docs: proc: add documentation about mount restrictions
  proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
  proc: Disable cancellation of subset=pid option
  proc: Relax check of mount visibility
  docs: proc: add documentation about relaxing visibility restrictions

 Documentation/filesystems/proc.rst | 15 +++++++++++++++
 fs/namespace.c                     | 29 ++++++++++++++++-------------
 fs/proc/proc_net.c                 |  8 ++++++++
 fs/proc/root.c                     | 24 +++++++++++++++++++-----
 include/linux/fs/super_types.h     |  2 ++
 include/linux/proc_fs.h            |  1 +
 6 files changed, 61 insertions(+), 18 deletions(-)

-- 
2.52.0


