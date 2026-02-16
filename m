Return-Path: <linux-fsdevel+bounces-77275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJWEDq8ck2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:33:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75300143D73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D1B6300B9F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41C2DA762;
	Mon, 16 Feb 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnzGrS+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7519202F70;
	Mon, 16 Feb 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248738; cv=none; b=uQI1WVL5c2HKDaQHJcnbfCajORzW5Om1KFC3VKNpDIAYX/TvJsON9oXnGZVuSmzw9yp69SStqmQPm80F+N11r/f9Xf+bzyFdltv1/8YVM+9rIceIvQHgiRg7l9cTZJ9+nFSXth8Rmo048qyjv1hi9JRF+O4na6GOh+UCpBudlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248738; c=relaxed/simple;
	bh=IBfriahGCrZbgG2xPZaipNIY6Lm5nqv5xPLiQPNO0VU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XlAbD0JdKHXfyHTLXd6/bgoTTtrbJrvYbB5LmNtAPQUDhysTCbpej5dQ9PTNvSdjvaCCq1UMP4Ac8bm3jRp9rh6ldBVMTKDG7K3RXYFU76if8xJzI7iUisShurGkxoEDNOaP1MfPZ+B0H+0jYvWpANfuiF7SlerkCfcTV+NYtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnzGrS+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44616C116C6;
	Mon, 16 Feb 2026 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248738;
	bh=IBfriahGCrZbgG2xPZaipNIY6Lm5nqv5xPLiQPNO0VU=;
	h=From:Subject:Date:To:Cc:From;
	b=qnzGrS+EGxMXTIwtFfpkP2HXkzwc0TfKfB9GHqoclOOIDAme6AsyKLaqS9E7Jtqka
	 f6gnJXGflC/unzfnHNAHt2Vulcy4z61/ZFYwFdYdczlZvsSOBRrCEqVSmspPphRoy9
	 yF/sMzGeB6kWmJQXp7H8Vfa6w3Ei0rX3UQoNp5nEhXqWE8kqSsdG9CGlh/rf44hjpQ
	 qP8XHTBhvyl+B9EyyHTPIEJK1w1vFuPw2o+gJTKkgLGJxb2LXI925d1+SS5jjjloEx
	 h3NPtd108rWtrY+y0O1A62vdnRHBtjd1Uq8x+m72u2vhcRoOSyKbRyAclc0UGzxxQR
	 2G1SZh+oI4yYA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/14] xattr: rework simple xattrs and support user.*
 xattrs on sockets
Date: Mon, 16 Feb 2026 14:31:56 +0100
Message-Id: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwck2kC/x3MTQ6CMBBA4auYWVvTvyngVYyLdphKQwTTNkpCu
 LvV5bd4b4fCOXGB62mHzO9U0ro0qPMJaPLLg0Uam0FL7aRWSnzWPIvN15pFWWnmKqjHaEcT+t5
 20LpX5pi2//N2bw6+sAjZLzT9Tk9fKudLp8kMKLUdPSFrhco4CjF2g7GIUTp00gTp4Di+DYKIv
 aUAAAA=
X-Change-ID: 20260211-work-xattr-socket-c85f4d3b8847
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4849; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IBfriahGCrZbgG2xPZaipNIY6Lm5nqv5xPLiQPNO0VU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlolVf2J3f36a8ze/m4FeS2S03091//pKONFFL3V/7
 o5raQlvO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTAC4SwcjQ9CDunvilFdtFXp3J
 3LXpydXa0ve8ct39mhkmOxclbDypyfDfS1fQoKkiscXO6LCGhUnA9Rs1i74dSH5eat2qI1/z/yk
 nAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77275-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75300143D73
X-Rspamd-Action: no action

Hey,

This reworks the simple_xattr infrastructure and adds support for
user.* extended attributes on sockets.

The simple_xattr subsystem currently uses an rbtree protected by a
reader-writer spinlock. This series replaces the rbtree with an
rhashtable giving O(1) average-case lookup with RCU-based lockless
reads. This sped up concurrent access patterns on tmpfs quite a bit and
it's an overall easy enough conversion to do and gets rid or rwlock_t.

The conversion is done incrementally: a new rhashtable path is added
alongside the existing rbtree, consumers are migrated one at a time
(shmem, kernfs, pidfs), and then the rbtree code is removed. All three
consumers switch from embedded structs to pointer-based lazy allocation
so the rhashtable overhead is only paid for inodes that actually use
xattrs.

With this infrastructure in place the series adds support for user.*
xattrs on sockets. Path-based AF_UNIX sockets inherit xattr support
from the underlying filesystem (e.g. tmpfs) but sockets in sockfs -
that is everything created via socket() including abstract namespace
AF_UNIX sockets - had no xattr support at all.

The xattr_permission() checks are reworked to allow user.* xattrs on
S_IFSOCK inodes. Sockfs sockets get per-inode limits of 128 xattrs and
128KB total value size matching the limits already in use for kernfs.

The practical motivation comes from several directions. systemd and
GNOME are expanding their use of Varlink as an IPC mechanism. For D-Bus
there are tools like dbus-monitor that can observe IPC traffic across
the system but this only works because D-Bus has a central broker. For
Varlink there is no broker and there is currently no way to identify
which sockets speak Varlink. With user.* xattrs on sockets a service
can label its socket with the IPC protocol it speaks (e.g.,
user.varlink=1) and an eBPF program can then selectively capture
traffic on those sockets. Enumerating bound sockets via netlink combined
with these xattr labels gives a way to discover all Varlink IPC
entrypoints for debugging and introspection.

Similarly, systemd-journald wants to use xattrs on the /dev/log socket
for protocol negotiation to indicate whether RFC 5424 structured syslog
is supported or whether only the legacy RFC 3164 format should be used.

In containers these labels are particularly useful as high-privilege or
more complicated solutions for socket identification aren't available.

The series comes with comprehensive selftests covering path-based
AF_UNIX sockets, sockfs socket operations, per-inode limit enforcement,
and xattr operations across multiple address families (AF_INET,
AF_INET6, AF_NETLINK, AF_PACKET).

Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (14):
      xattr: add rcu_head and rhash_head to struct simple_xattr
      xattr: add rhashtable-based simple_xattr infrastructure
      shmem: adapt to rhashtable-based simple_xattrs with lazy allocation
      kernfs: adapt to rhashtable-based simple_xattrs with lazy allocation
      pidfs: adapt to rhashtable-based simple_xattrs
      xattr: remove rbtree-based simple_xattr infrastructure
      xattr: add xattr_permission_error()
      xattr: switch xattr_permission() to switch statement
      xattr: move user limits for xattrs to generic infra
      xattr,net: support limited amount of extended attributes on sockfs sockets
      xattr: support extended attributes on sockets
      selftests/xattr: path-based AF_UNIX socket xattr tests
      selftests/xattr: sockfs socket xattr tests
      selftests/xattr: test xattrs on various socket families

 fs/kernfs/dir.c                                    |  15 +-
 fs/kernfs/inode.c                                  |  99 +----
 fs/kernfs/kernfs-internal.h                        |   5 +-
 fs/pidfs.c                                         |  65 +--
 fs/xattr.c                                         | 423 +++++++++++++------
 include/linux/kernfs.h                             |   2 -
 include/linux/shmem_fs.h                           |   2 +-
 include/linux/xattr.h                              |  47 ++-
 mm/shmem.c                                         |  46 +-
 net/socket.c                                       | 119 ++++--
 .../testing/selftests/filesystems/xattr/.gitignore |   3 +
 tools/testing/selftests/filesystems/xattr/Makefile |   6 +
 .../filesystems/xattr/xattr_socket_test.c          | 470 +++++++++++++++++++++
 .../filesystems/xattr/xattr_socket_types_test.c    | 177 ++++++++
 .../filesystems/xattr/xattr_sockfs_test.c          | 363 ++++++++++++++++
 15 files changed, 1547 insertions(+), 295 deletions(-)
---
base-commit: 72c395024dac5e215136cbff793455f065603b06
change-id: 20260211-work-xattr-socket-c85f4d3b8847


