Return-Path: <linux-fsdevel+bounces-21905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9E90DF4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 00:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5121C22842
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 22:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620518EFEE;
	Tue, 18 Jun 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6biJYZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50918EFD3;
	Tue, 18 Jun 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750745; cv=none; b=qPrRz/KZmQiVJogWeARfPL2fP2H+jzCc82G9As9/PHOQGbgfkNzsIMAVVsGMMfJUM26oOlDMAGh5tzR2qHLO9QvYT3EvsDgoUeXcc9SUEgXTb8YBZB5WXl/lWrNlUAWGSx5s+a/SwbrWsNzvpW13p8mMu6MKMi9E+HYWDcU9w8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750745; c=relaxed/simple;
	bh=OCMwDvtwnM9ll0Ws/wHw8cfOMgOXkr3TtaYN7UcD3wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0LHebFcU0lXVreKlWgNvkdqSsJOVsSYQjnkI/uaC1LUjNTCuV17bAOnjFKj1CoO8cSZTZqUb6gOr2b47KNmfRGc9CUIQ3iM2gpEIm9V1heaL24utLkJXzzt0KlvOxo0tAdNU65CdDZ4NM4+5nH+pV8LIciwU2pj2qNEXNEnzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6biJYZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2380C3277B;
	Tue, 18 Jun 2024 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718750744;
	bh=OCMwDvtwnM9ll0Ws/wHw8cfOMgOXkr3TtaYN7UcD3wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6biJYZjx6n/yCnySOnJ/0QKNa/AdfaW7t0ofQIiqUjfxQORpwwEtMKkdom44OrDp
	 ciJqfeQLQp6xpBxzairrodBgPeEdKbthUWTC8mOpCqWJXZIF1lkgS2Ovcb3HSouGco
	 odzJtA+I/GY+BTi2k8Y975PSowJFGg+RJyoAZx+D+HkVHKxap3ozWJnwi5/UUSeTK8
	 wgYNclpkinStLKlNAmuF0/30bdegIQUmot8p/2thA1xiyHoEpypV8AzoW/DX/tAH4D
	 Qd/1lXbdNvu30g67If6EG6mqTC++NuB0wG/3mkRolc5ow+dFDtDH3pculy5/ICg6vq
	 a253IBmOo5Dtg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 4/6] docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
Date: Tue, 18 Jun 2024 15:45:23 -0700
Message-ID: <20240618224527.3685213-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618224527.3685213-1-andrii@kernel.org>
References: <20240618224527.3685213-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call out PROCMAP_QUERY ioctl() existence in the section describing
/proc/PID/maps file in documentation. We refer user to UAPI header for
low-level details of this programmatic interface.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/filesystems/proc.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 82d142de3461..e834779d9611 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -443,6 +443,15 @@ is not associated with a file:
 
  or if empty, the mapping is anonymous.
 
+Starting with 6.11 kernel, /proc/PID/maps provides an alternative
+ioctl()-based API that gives ability to flexibly and efficiently query and
+filter individual VMAs. This interface is binary and is meant for more
+efficient and easy programmatic use. `struct procmap_query`, defined in
+linux/fs.h UAPI header, serves as an input/output argument to the
+`PROCMAP_QUERY` ioctl() command. See comments in linus/fs.h UAPI header for
+details on query semantics, supported flags, data returned, and general API
+usage information.
+
 The /proc/PID/smaps is an extension based on maps, showing the memory
 consumption for each of the process's mappings. For each mapping (aka Virtual
 Memory Area, or VMA) there is a series of lines such as the following::
-- 
2.43.0


