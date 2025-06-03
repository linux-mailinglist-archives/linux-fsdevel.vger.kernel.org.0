Return-Path: <linux-fsdevel+bounces-50464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9FACC7DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6CE1895676
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5ED230BE3;
	Tue,  3 Jun 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv/hmziF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39B18C00B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957531; cv=none; b=Q2Qg5msCsyWCGY2CK4E1Q1GLkecI/9uLPaXSk4wtxajOd3uL4q8JaaQxZK6Mqcpq4PQkNtzTQq7pYivRP0O/rmsnGFA805ihIKLEZVok5XawbOuMGsbq3mr3A70G450s+I0DumC6AnGyJ8Tx1f3HiFD2IYwH5MvtpW9sFslqg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957531; c=relaxed/simple;
	bh=Rfb6HyM/n4vESq4M4He6s4A7afx7OX6KJH215rV1y0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MoCAwpKHcypE/0YSNs0Yo9bvv+p3g50WKIFpF52kAmBBPCcd3LNMgCtwrscYLVMA4Ia8uIeq/Zx9znNu2NL4Wld51tm9yO1mAmpNU9mv/LaubUi07vAOMF8Gj75c6URz+344+uaZjTIbu/a1vwOUEhAcMFMofy4XQefR2WVa4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv/hmziF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528B1C4CEED;
	Tue,  3 Jun 2025 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748957529;
	bh=Rfb6HyM/n4vESq4M4He6s4A7afx7OX6KJH215rV1y0E=;
	h=From:Subject:Date:To:Cc:From;
	b=Pv/hmziFcq1JaZZ8AglB0KwMLtkMDbtBxMnUtzKpmBxgJT0IvDnw+A0uqE6+uQ+ll
	 X9gIkVcEoRy5lFPWfXwMwkSbi9nYQPwzG3+fOvxs7K0vVIyFJVjjjM843kUa9hr7dD
	 lyrD0zOljMcWWxazCvHa7Wcl79TLV97GJTNJkrzPMbB9hOVABV1oNOhk8BdDe0eKxh
	 KRrnky6e/j3yyBLNB4fk1xyzZS929f8LsLs1xkY1+CQdBCE0IwBVUyH8SrFYqZumJY
	 eAUnqhNW0mXs6NyCACsj8OqE2PPofFcAPHL+0fNJM4+gbrUJ4l4AQLAab0CztLnIYG
	 SDx+tW4uNh8RA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/5] coredump: allow for flexible coredump handling
Date: Tue, 03 Jun 2025 15:31:54 +0200
Message-Id: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEr5PmgC/4XOTW6DMBBA4atEXteRx/wEsuo9qizG4yFYJAwaE
 9Iq4u6FqPsu3+bTe5nMmjib8+FllJeUk4xb+I+DoR7HK9sUtzbe+cpV3tmn6GBJlOPjPtksNPB
 sJ5VZSG62bhsXoatK8p3ZjEm5S99v/+uydcDMNiiO1O/qHfPMeiy4dPWphABt0zoqYoOeI/ga8
 US+COBqwpZhF/uUZ9Gf9/ACu/v3Vvz3toB11rsQGSiWHeLnwDry7Sh6NZd1XX8BeAGjJw0BAAA
 =
X-Change-ID: 20250520-work-coredump-socket-protocol-6980d1f54c2f
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Jan Kara <jack@suse.cz>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=4537; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Rfb6HyM/n4vESq4M4He6s4A7afx7OX6KJH215rV1y0E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTY/Qybmhp+Yd1NieQZCx+tvG49O+QFk9b0JEZtddbUn
 Wc35M2e0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRZT4M/113nOWfxnhw48SM
 7N/R8mdnHWI7ZHvLXUqlUtON+15p5xNGhinP+PKl0hvWnhSSnXj9+CmDG5P+Zz+sXJZR+W+3u9i
 1A3wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In addition to the extensive selftests I've already written a
(non-production ready) simple Rust coredump server for this in
userspace:

https://github.com/brauner/dumdum.git

Extend the coredump socket to allow the coredump server to tell the
kernel how to process individual coredumps. This allows for fine-grained
coredump management. Userspace can decide to just let the kernel write
out the coredump, or generate the coredump itself, or just reject it.

When the crashing task connects to the coredump socket the kernel will
send a struct coredump_req to the coredump server. The kernel will set
the size member of struct coredump_req allowing the coredump server how
much data can be read.

The coredump server uses MSG_PEEK to peek the size of struct
coredump_req. If the kernel uses a newer struct coredump_req the
coredump server just reads the size it knows and discard any remaining
bytes in the buffer. If the kernel uses an older struct coredump_req
the coredump server just reads the size the kernel knows.

The returned struct coredump_req will inform the coredump server what
features the kernel supports. The coredump_req->mask member is set to
the currently know features.

The coredump server may only use features whose bits were raised by the
kernel in coredump_req->mask.

In response to a coredump_req from the kernel the coredump server sends
a struct coredump_ack to the kernel. The kernel informs the coredump
server what version of struct coredump_ack it supports by setting struct
coredump_req->size_ack to the size it knows about. The coredump server
may only send as many bytes as coredump_req->size_ack indicates (a
smaller size is fine of course). The coredump server must set
coredump_ack->size accordingly.

The coredump server sets the features it wants to use in struct
coredump_ack->mask. Only bits returned in struct coredump_req->mask may
be used.

In case an invalid struct coredump_ack is sent to the kernel an
out-of-band byte will be sent by the kernel indicating the reason why
the coredump_ack was rejected.

The out-of-band markers allow advanced userspace to infer failure. They
are optional and can be ignored by not listening for POLLPRI events and
aren't necessary for the coredump server to function correctly.

In the initial version the following features are supported in
coredump_{req,ack}->mask:

* COREDUMP_KERNEL
  The kernel will write the coredump data to the socket.

* COREDUMP_USERSPACE
  The kernel will not write coredump data but will indicate to the
  parent that a coredump has been generated. This is used when userspace
  generates its own coredumps.

* COREDUMP_REJECT
  The kernel will skip generating a coredump for this task.

* COREDUMP_WAIT
  The kernel will prevent the task from exiting until the coredump
  server has shutdown the socket connection.

The flexible coredump socket can be enabled by using the "@@" prefix
instead of the single "@" prefix for the regular coredump socket:

  @@/run/systemd/coredump.socket

will enable flexible coredump handling. Current kernels already enforce
that "@" must be followed by "/" and will reject anything else. So
extending this is backward and forward compatible.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Add epoll-based concurrent coredump handling selftests.
- Improve cover letter.
- Ensure that enum coredump_oob is packed aka a single byte and add a
  static_assert() verifying that.
- Simplify helper functions making the patch even smaller.
- Link to v1: https://lore.kernel.org/20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org

---
Christian Brauner (5):
      coredump: allow for flexible coredump handling
      selftests/coredump: fix build
      selftests/coredump: cleanup coredump tests
      tools: add coredump.h header
      selftests/coredump: add coredump server selftests

 fs/coredump.c                                     |  130 +-
 include/uapi/linux/coredump.h                     |  104 ++
 tools/include/uapi/linux/coredump.h               |  104 ++
 tools/testing/selftests/coredump/Makefile         |    2 +-
 tools/testing/selftests/coredump/config           |    4 +
 tools/testing/selftests/coredump/stackdump_test.c | 1705 ++++++++++++++++++---
 6 files changed, 1799 insertions(+), 250 deletions(-)
---
base-commit: 3e406741b19890c3d8a2ed126aa7c23b106ca9e1
change-id: 20250520-work-coredump-socket-protocol-6980d1f54c2f


