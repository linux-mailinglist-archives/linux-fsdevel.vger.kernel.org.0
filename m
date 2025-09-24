Return-Path: <linux-fsdevel+bounces-62638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B05B9B4A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE9D176D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8B31B11A;
	Wed, 24 Sep 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEcB0y+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9631353E;
	Wed, 24 Sep 2025 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737244; cv=none; b=MRrcqsnooow8i6v6Pm9ho9Zm/vR8jEhVgI9yvXSokNwJTrFCPqmoe+FkYOZFuPjTXTWuRBda+lgZ+TvSfW4O/oCAYHdsN+617yHadx5F7EPr26wy0pV2ToYxjEprqjsGot2xCZmxFZvvAO3Ou1XxNnknjvSvViZmkhnBKxmi1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737244; c=relaxed/simple;
	bh=91FD/w4C9BXtWMza+TaMsFzE6zmBagNb79CWMkeMirQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAUjnDfwSwnDiA+bc+advKA8+CudxjIYmWFI4VEiu8pYDFtJ+mncR0vMHs+vblzt3/te8Tv0BdQUYFWOTQ5uDtxhh5C9whR9szP9Iq1es4V/znbrtPA4yTBBWtOUct0mnKQekgaNIjh0QhHOEIXRWTJXZZQYh+BTHYGrtUsA2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEcB0y+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4A9C4CEF8;
	Wed, 24 Sep 2025 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737244;
	bh=91FD/w4C9BXtWMza+TaMsFzE6zmBagNb79CWMkeMirQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lEcB0y+ecnebgp4qXWnZBhoG8fohQYrwKQnffnfqfa/zdCVVhJkexGMtU++KgL3v6
	 ETI6j068dvCGIWMVdCbOnnn4AMAyoNXQBPIxZbENvAvwLackToYOjcantIjObLjUIv
	 lSjK6Lew4OwVPmScYwGVtSugVGnJSkCMw9EU2qkVHrhfNs1pT1LWBvX68YWLX/v88N
	 cbf/zHOxT63FNFpx1uZYPY1xWeOBszUlJE8lvUhm0+oLJ7LPTYs+806fQ1v6BOxqfB
	 7NjoW1QkTn9pvZzoa4ck+Kn0XzQod3F6uqO1/+3/ddV6RZPvXhCVC/fmlSO+Xf22DB
	 zWl6trMMAbKcw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:06 -0400
Subject: [PATCH v3 20/38] nfs_common: add new NOTIFY4_* flags proposed in
 RFC8881bis
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-20-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=91FD/w4C9BXtWMza+TaMsFzE6zmBagNb79CWMkeMirQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMOgkIu/flu3bMKmfF4Wdt6EtMq+0kSSxydY
 nDbfljhVVKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDgAKCRAADmhBGVaC
 FXWID/4xFQMWheV5W92PCvn9BoPjSC6jQrUW2QGWk7fTtFhHg5BW1HWpUdFILFjAvdd/quWJXqB
 T067WKMm1oK8c5uzvUaX6dIo1VDsuqdURIxYgaRypZ/fjTeY5wLDuAWcrmbbmfbO2NC6GmiMtHR
 qEUDKk32f7hVvt7XOKUhUvdya/U/GPaeka/47opwwHePHZmxNj0APlXVmBk/AuFH4Q8MX2KAr+j
 xhkdlL85z9e9n6R7TsGpkrTpKfgzFNRGLba1z39NelzTPDCI0kQsrIP+gKUiLRfdJFhXvBJanGk
 NhBkpw2YmMkdThCANIvOckzAT+qcJ+MLv69RN7pkxo3/6Qlf5//4vuAJYsdV5dx3n9upnlkxBFe
 gkySwOJEBrHbelRIBc7s/jVk708hNTs/P08XQSnPcGK3BYbJXCDfNZccUbjRBOvwmdACNgra3nU
 QGaFvJRLmVQVFGaSq+9nHz8PI9WbsXNs8iYK9Q+LCngBjypOXvtPlUmtsC/A/Y64rFsoX+/qffw
 idKid2IKODyYjg6asyxkldsREZQNMwSS7pGQ4HA4IHTla8jUFlp+0vcu95/jFsZvtxdkvTlvWyT
 hHjsDFpi5tzZj810DAMxeIrBbOORtkIIiiiIVTMXdGCDxAUmWxhMQQj0arD2JMhn/c9T1IqE8OW
 Jy8KRlRdBxzMrmg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC8881bis adds some new flags to GET_DIR_DELEGATION that we very much
need to support.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x    | 16 +++++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                |  2 +-
 fs/nfsd/nfs4xdr_gen.h                |  2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h | 13 ++++++++++++-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index 9e00910c02e0aecfb0f86ff7b534049d2c588cf3..d25e2f5489ea44b74c423702feceb563a1aaa7a4 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -358,7 +358,21 @@ enum notify_type4 {
         NOTIFY4_REMOVE_ENTRY = 2,
         NOTIFY4_ADD_ENTRY = 3,
         NOTIFY4_RENAME_ENTRY = 4,
-        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+        /*
+         * Added in NFSv4.1 bis document
+         */
+        NOTIFY4_GFLAG_EXTEND = 6,
+        NOTIFY4_AUFLAG_VALID = 7,
+        NOTIFY4_AUFLAG_USER = 8,
+        NOTIFY4_AUFLAG_GROUP = 9,
+        NOTIFY4_AUFLAG_OTHER = 10,
+        NOTIFY4_CHANGE_AUTH = 11,
+        NOTIFY4_CFLAG_ORDER = 12,
+        NOTIFY4_AUFLAG_GANOW = 13,
+        NOTIFY4_AUFLAG_GALATER = 14,
+        NOTIFY4_CHANGE_GA = 15,
+        NOTIFY4_CHANGE_AMASK = 16
 };
 
 /* Changed entry information.  */
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index 306a4c30c3a4e6b9066c5ad41c1f0f7ffbb27bae..e713ca9b15203c1f5fcd14fbf70492a6b0907b40 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Wed Sep 24 09:38:03 2025
+// XDR specification modification time: Wed Sep 24 09:39:12 2025
 
 #include <linux/sunrpc/svc.h>
 
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index e8f8dd65d58a23f39d432bed02ac21cb0640261f..50e474a1cd8225108c83bb01caaa5a0a56384413 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Wed Sep 24 09:38:03 2025 */
+/* XDR specification modification time: Wed Sep 24 09:39:12 2025 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index 7d9f4c5f169bc47ddf31ff5b1b96db30329e8ad2..ad31d2ec7ce050c6a5900732628e4e7607dabcae 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Wed Sep 24 09:38:03 2025 */
+/* XDR specification modification time: Wed Sep 24 09:39:12 2025 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
@@ -294,6 +294,17 @@ enum notify_type4 {
 	NOTIFY4_ADD_ENTRY = 3,
 	NOTIFY4_RENAME_ENTRY = 4,
 	NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+	NOTIFY4_GFLAG_EXTEND = 6,
+	NOTIFY4_AUFLAG_VALID = 7,
+	NOTIFY4_AUFLAG_USER = 8,
+	NOTIFY4_AUFLAG_GROUP = 9,
+	NOTIFY4_AUFLAG_OTHER = 10,
+	NOTIFY4_CHANGE_AUTH = 11,
+	NOTIFY4_CFLAG_ORDER = 12,
+	NOTIFY4_AUFLAG_GANOW = 13,
+	NOTIFY4_AUFLAG_GALATER = 14,
+	NOTIFY4_CHANGE_GA = 15,
+	NOTIFY4_CHANGE_AMASK = 16,
 };
 typedef enum notify_type4 notify_type4;
 

-- 
2.51.0


