Return-Path: <linux-fsdevel+bounces-62635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40780B9B454
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D34189480D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D9327A18;
	Wed, 24 Sep 2025 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+xav8rN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92CE326D53;
	Wed, 24 Sep 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737234; cv=none; b=aimsgrc0q+b9VRWURaWTLY6soLNC7y4+zplraJ26+mXsZNlzlTL3Vs6JdVTcz/g5Alrc4WOoC3MrvtUjjJXWlPXS/hlIkTRsi9UH7/nd870IRhjaun9n+hlnOELVwE8wu9Fny1ZgqGh9M/bOud0Jc2JoD1lRCFm5J5tymjTjX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737234; c=relaxed/simple;
	bh=Z70YdlcSuvXtwYEoZrhrqNjLCGIDntYDP+KT+NehLQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqnIdfocIIEOalNt71NB226VZySSPxjEef5i/AugncHhhUmOv5EXLGWxVf18rkmigdnIfxl6RpD2nKNz2fShD5pwOrI9Q/AwAwE6MkV7GLU+8ocnZXccc1e+1o3gB0JQuAkPa75NFy4wiYL/Pc4QTBWWB+vjUGfbz75OXV4TpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+xav8rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D887C4CEF0;
	Wed, 24 Sep 2025 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737233;
	bh=Z70YdlcSuvXtwYEoZrhrqNjLCGIDntYDP+KT+NehLQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a+xav8rNlnm6tb1ypopOFfntG3POeWir1egIwPN/Tlt1dtyH+XXgoz0c59NDfHGaW
	 li0PWkXaZjBXVDj4HZYnJNhL/uoPsA4Vg0CqEIfFclUB2JpoxV1wnJquIfedCmRmFJ
	 RhoiKIIWGonJ1PE9HOtiHU59eJkhprOR89pG+HR7snbk7YSyrOjc1C67teu12FDrjh
	 UO884i3bc+R/LadBmHcA7ar/7wxhQHKMn9ffGg9+ZPKY2KU+uL6lekMntLYH2BvPaf
	 1LNsCm/Sj7CkOBo9nbMlBrzvVOM5I/nfpVK07aN7Cw761vlExOhLwA6RaTzBCD8LED
	 EIxRaWH7scI7Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:03 -0400
Subject: [PATCH v3 17/38] filelock: add a tracepoint to start of
 break_lease()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-17-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2245; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z70YdlcSuvXtwYEoZrhrqNjLCGIDntYDP+KT+NehLQo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMOxvXQvt7B3NRh53wXz/hDw9xybesDjwlFX
 fGA6ElYTveJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDgAKCRAADmhBGVaC
 FXecEAC7qoLE48KcL3fBX64FPDHovpTNTymnbR5+IBlFDyC5+Ywzr1oFseZXPv7OErITmOhK8u0
 aZHWH5OZYYhHEKTyJgaxTEogK4jYuBN0SJ3xiiwdK5xph8W276gnTHQ2/G80ZpeXGlqaWuta3zo
 u0bmZ/VqFSRdJNEe2jhiCjdlw5iUE+6PR6Qh1lHsJhElX5vsKWr4KqWrjWWuczg3pd3w1wKqkl4
 iraX7Kfk3F8d2zEnY1+4PkXxPG4+4ATWlhJ0iaVh/7rUjRXehzUvTEsEQSDpQl1QBCnOaNQOpiV
 W5RS2RKzt3sEVfBpeCfEzKx60UCj4orxOyXNB8lrodeKyeu6VRvhXgXNzUrR8hsY3yZrGLUzYyx
 /eyiucI3f/Ue1qyttMJxWrFcLBLKgcK17+vZWBh3v+dbw4d/TqXx8v6bYFOzHfLu/tknu31BoSc
 Pjj8k1G1c9xTg8Z/s6sCScsIlpFvTiAoqIy6zi1DQyXg3Tt41fGShN+Wt5bqdxDQfZR6io8s7HQ
 K9z/sgnRfNTJkNDyyI6IB/3qG8VfcIaP5FCSktNKq2zfxfkOWhXm10VAkjFKY6N0VWq/szbXw2n
 BQJAl5eXDZrLdrwI1ZcA0Z80PQ/2DUgqylMTv7Jb6LXuRm4rGTp1YumzHd3EnnatymtmUoLXYz3
 W0g2wA8127aQLvQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...mostly to show the LEASE_BREAK_* flags.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      |  2 ++
 include/trace/events/filelock.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index ff5f5a85680a2c8511f5828947e829c7ffc1bd59..d26372ea890cbcd1a47209adeca6778ec23449ab 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1582,6 +1582,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
 	int error = 0;
 
+	trace_break_lease(inode, flags);
+
 	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 4988804908478912c6b8044dfb3b147fc50e4823..2d45cfad18fa7b2139fb75c1aa327c00521ed9f9 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -120,6 +120,39 @@ DEFINE_EVENT(filelock_lock, flock_lock_inode,
 		TP_PROTO(struct inode *inode, struct file_lock *fl, int ret),
 		TP_ARGS(inode, fl, ret));
 
+#define show_lease_break_flags(val)					\
+	__print_flags(val, "|",						\
+		{ LEASE_BREAK_LEASE,		"LEASE" },		\
+		{ LEASE_BREAK_DELEG,		"DELEG" },		\
+		{ LEASE_BREAK_LAYOUT,		"LAYOUT" },		\
+		{ LEASE_BREAK_NONBLOCK,		"NONBLOCK" },		\
+		{ LEASE_BREAK_OPEN_RDONLY,	"OPEN_RDONLY" },	\
+		{ LEASE_BREAK_DIR_CREATE,	"DIR_CREATE" },		\
+		{ LEASE_BREAK_DIR_DELETE,	"DIR_DELETE" },		\
+		{ LEASE_BREAK_DIR_RENAME,	"DIR_RENAME" })
+
+TRACE_EVENT(break_lease,
+	TP_PROTO(struct inode *inode, unsigned int flags),
+
+	TP_ARGS(inode, flags),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->i_ino = inode->i_ino;
+		__entry->flags = flags;
+	),
+
+	TP_printk("dev=0x%x:0x%x ino=0x%lx flags=%s",
+		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+		  __entry->i_ino, show_lease_break_flags(flags))
+);
+
 DECLARE_EVENT_CLASS(filelock_lease,
 	TP_PROTO(struct inode *inode, struct file_lease *fl),
 

-- 
2.51.0


