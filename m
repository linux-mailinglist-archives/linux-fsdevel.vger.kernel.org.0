Return-Path: <linux-fsdevel+bounces-50217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D86AC8CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58229E747F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7DA225788;
	Fri, 30 May 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tewpys3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6F19AD70
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603428; cv=none; b=YjZIyzXqooqYecwo/1ka1KmbcGbggQnPLGTNLZFEa5CqnZfhPydsfULs46P6gxWquwVHYcWsBLkoDk6TA7fygW84afNk9M8VGT1cu0hO5vs0Otsm6TL0d6rR29wHnk2n/xIiC0Y9I1MkcUTcdC+ML4X+xnpaxv1CObVy8j/gJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603428; c=relaxed/simple;
	bh=0XmBHY8t8AQ+W3Eleh5UoNwqInw8vW9qB1t6H0UO9z8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CyI2a+5mJAaZ7LLZ0C8YGeb8hTeVhO51dW+Ov4Gu5SewhbHyrtQmXXGDpBIxVuDP+OFTISDPaKTutLeDyg7DqBKNDa4hoc8SP9T+P2bXHQpOcu6FGqgUF2T1fTdR7oTrWTtssgR2A0uTT0Emc5ouUq5DdCfivi2sXa4dySLIPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tewpys3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCD6C4CEE9;
	Fri, 30 May 2025 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748603427;
	bh=0XmBHY8t8AQ+W3Eleh5UoNwqInw8vW9qB1t6H0UO9z8=;
	h=From:Subject:Date:To:Cc:From;
	b=Tewpys3c5BuDSUOC4Nhz/YlR54xbaNO/x/ps0RNAlGaytnaDMNhrun2RG6/1LGAYZ
	 hOUMqzstFMD321w/0RwekzwS89o4TcEKSIbkPnbOfeyrneR/zeE78xw7R4gCAASL91
	 sSvg9Hot10rHb0G5Yd22HEOkbXKXAnIG3onwoGf8nr6qS1VPTP4KkDg6ly+QnQ7L+i
	 Adov9L9lidgCvv1XSz2xB4np4WPYmmXCp69bzV8/zVDUtL1/od2YKVVy5+CIPUuLDw
	 qlQBNRV5299raG350t0GJcB05So8/4Vly2ajcGuo6Q7TTFpr6ix/k9TI0jZ7D5MItq
	 aWTq3n7Hn6WzQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/5] coredump: allow for flexible coredump handling
Date: Fri, 30 May 2025 13:09:58 +0200
Message-Id: <20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAaSOWgC/x3MSw6DIBAA0KsY1qUBVJRepeliGMZKrGIG+0mMd
 y/t8m3eLjJxpCwu1S6YXjHHtBToUyVwhOVOMoZiYZRpVWuUfCeeJCam8JxXmRNOtMmV05YwPaR
 1vQp6aBs0gyjHyjTEz/+/3oo9ZJKeYcHxt86QN+JzTY2yXaO9dr1TWIceDAVtLECHpvZaWQRHW
 hzHF7LEr5uxAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4225; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0XmBHY8t8AQ+W3Eleh5UoNwqInw8vW9qB1t6H0UO9z8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYTlL40TX/ltWTkKPRLPUPOlnOz0zXm3gnS9Izde66T
 qGPKWFpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZqMbIMMvth8r7ayEr+9qn
 BRw3Yj9WuS/zKU+whOT3xyaXdpkliTIy/PQ1CLebZ8556MrX+ULf7MSPdjhJPDhiWxB0oZc1nqm
 aAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In addition to the extensive selftests I've already written a
(non-production ready) simple Rust coredump server for this in
userspace:

https://github.com/brauner/dumdum.git

Extend the coredump socket to allow the coredump server to tell the
kernel how to process individual coredumps. This allows for fine-grained
coredump management allowing choose how to process individual coredump
requests. Userspace can decide to just let the kernel write out the
coredump, or generate the coredump itself, or just reject it.

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

If the coredump server sent a valid struct coredump_ack the kernel will
place an out-of-band byte indicating that the request was successful. If
the kernel is generating the coredump and sending the coredump data on
the socket the success out-of-band marker can be used as an indicator
when coredump data starts.

The out-of-band markers allow advanced userspace to infer failure. They
are optional and can be ignored by not listening for POLLPRI events and
aren't necessary for the coredump server to function correctly.

In the initial version the following features are supported in
coredump_{req,ack}->mask:

* COREDUMP_KERNEL
  The kernel will write the coredump data to the socket after the
  req-ack sequence has concluded successfully.

* COREDUMP_USERSPACE
  The kernel will not write coredump data but will indicate to the
  parent that a coredump has been generated. This is used when userspace
  generates its own coredumps.

* COREDUMP_REJECT
  The kernel will skip generating a coredump for this task.

* COREDUMP_WAIT
  The kernel will prevent the task from exiting until the coredump
  server has shutdown the socket connection.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (5):
      coredump: allow for flexible coredump handling
      selftests/coredump: fix build
      selftests/coredump: cleanup coredump tests
      tools: add coredump.h header
      selftests/coredump: add coredump server selftests

 fs/coredump.c                                     |  151 +-
 include/uapi/linux/coredump.h                     |  104 ++
 tools/include/uapi/linux/coredump.h               |  104 ++
 tools/testing/selftests/coredump/Makefile         |    2 +-
 tools/testing/selftests/coredump/config           |    4 +
 tools/testing/selftests/coredump/stackdump_test.c | 1524 +++++++++++++++++----
 6 files changed, 1639 insertions(+), 250 deletions(-)
---
base-commit: 3e406741b19890c3d8a2ed126aa7c23b106ca9e1
change-id: 20250520-work-coredump-socket-protocol-6980d1f54c2f


