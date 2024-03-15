Return-Path: <linux-fsdevel+bounces-14507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E387D21E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527EA1F21522
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD25EE85;
	Fri, 15 Mar 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQcjuNwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521EF5EE72;
	Fri, 15 Mar 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521648; cv=none; b=oBrOqqwhUTUdre77ifZdHakXlF3vJBSFZXwQroxB6YDo2T/gtpZMvVYfomWgBIHHK7n4DyyPPlkFN4R5ZXJuGAjL/enVltTjeXWDn/oXIRP15sihf+bg3abB8s0GBjQ4s4R2DEDQj9YFUxKAfMX9jB+a1h+EPgiWv/jfnwItVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521648; c=relaxed/simple;
	bh=9chmKcIKKKzx4wiFjA6GZHLU6rDBlxqhwWoI/uEcrUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a4qKA29nFKWF9C90Jth6zh5YmYhAPy7i1JaI5w2+RJtd3AGSB6VBFLEzxPiqp+mZFyK6PmDIOspXLKLjZnGt0x40ZjsxlihDlQK/iT90npu13S08W76mjbXA+vc0NmiKBYiDAZt48KIEYr43Tre+XezctHnaMIvbsfhFRV9+LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQcjuNwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF968C43609;
	Fri, 15 Mar 2024 16:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521647;
	bh=9chmKcIKKKzx4wiFjA6GZHLU6rDBlxqhwWoI/uEcrUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FQcjuNwrvn2abT6HRblgJnmtN0oyn8AsfV+GwF/na6KmAs3behS8JmXwQCjVsPI+Y
	 yr9Fd+y3+KZtYdRBdNVTX/AQ9m9JdEXiFnocFwUbxvgQxRjxIy4+NuY1bez0dRZwme
	 2G6u8Kzxlq6ShHYKj8/hwXPGzFi8DLTTD+bSjIbLIjavrMMP4PCFlTtG20ez30T+Hh
	 K5RweCefPmuaXSNPjHYI8eQ/oiDuZ9S7kPoyqWwRvjg4m8+OQf1bKWo6MugLflHrW8
	 5a2oLTfSpxW1OFZVaCOQh1v8WJVr+6hPJ4tjBxGeauaF2fBHCmOh3XoLgPKtbBYl3L
	 KbovwrSB6fpoA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:10 -0400
Subject: [PATCH RFC 19/24] nfs: new tracepoint in
 nfs_delegation_need_return
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-19-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2950; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9chmKcIKKKzx4wiFjA6GZHLU6rDBlxqhwWoI/uEcrUU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzv07jA46HEdrPEpbu9KUs+t+dT0TuGhYw8U
 0l2zVbU5sGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87wAKCRAADmhBGVaC
 FewED/9pQa7cC+u8jYnK4XdPPAVW7u+Z3/GhEDioItysl4TeWHxviBhXxdtxuKvvjWjDJ3lY77p
 AeVS7ugRv9+XZM71qj0UXrAoKARZevFhOTzXzDE2T229Z/koSizUvlwfJNaxk7GM1n3wFv5e2B1
 TJUOmPFr4lN2/SIeCv8ZbR+kva3c2KaRy7HtEGF6J4fn4wnWtsU0G5AYLuyibb6zmd6ory8964/
 Nbv8IHiRI/k4VPH+oPO+jXwvTY1EIRLsNdmZhmQ8zwNr9RVNcP24/4EmFcATlfLzTv5/r6guIrA
 03cI/J69xlX1pNt1lIQV+VTBLneSV62JiLGu2fLHgHB/ynp02d0QpfxH0Grhviop8eFSnJgbQzu
 1aHjhYBM1xO8uATiMfT4mfl5aVBzw1Aaq1HivvLFTTdYx7hQsUuI9pI7ZlvIxKGz2A/+LcbzZMv
 kXLEjBbiOmXJt30wHOLNriDCsVWwcx4F1BI2dRAybX/TUkOBVT1P2IjS/ObuG4KDeD1BZvTP8ei
 bVMuS0upLkS8KN4HE+8hnAt8qIFiHka1zbf4FPnJrGUuC9dDzLKzsNEIJ5DMb5VMxFnpxqM89M2
 WphpMPAtqWYioxQM5xoJrzJlmJNRPuJCHIpY3CyYLNKZ+Iwnej1iaRksnXzxrfvGfaLRf/LWsh9
 wjPnoUaUGo/7KQQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a tracepoint in the function that decides whether to return a
delegation to the server.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c |  2 ++
 fs/nfs/nfs4trace.h  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index a331a2dbae12..88dbec4739d3 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -571,6 +571,8 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 {
 	bool ret = false;
 
+	trace_nfs_delegation_need_return(delegation);
+
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
 	else if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index b4ebac1961cc..e5adfb755dc7 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -14,6 +14,8 @@
 #include <trace/misc/fs.h>
 #include <trace/misc/nfs.h>
 
+#include "delegation.h"
+
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
 		{ NFS_ATTR_FATTR_TYPE, "TYPE" }, \
@@ -928,6 +930,51 @@ DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_set_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_reclaim_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 
+#define show_delegation_flags(flags) \
+	__print_flags(flags, "|", \
+		{ BIT(NFS_DELEGATION_NEED_RECLAIM), "NEED_RECLAIM" }, \
+		{ BIT(NFS_DELEGATION_RETURN), "RETURN" }, \
+		{ BIT(NFS_DELEGATION_RETURN_IF_CLOSED), "RETURN_IF_CLOSED" }, \
+		{ BIT(NFS_DELEGATION_REFERENCED), "REFERENCED" }, \
+		{ BIT(NFS_DELEGATION_RETURNING), "RETURNING" }, \
+		{ BIT(NFS_DELEGATION_REVOKED), "REVOKED" }, \
+		{ BIT(NFS_DELEGATION_TEST_EXPIRED), "TEST_EXPIRED" }, \
+		{ BIT(NFS_DELEGATION_INODE_FREEING), "INODE_FREEING" }, \
+		{ BIT(NFS_DELEGATION_RETURN_DELAYED), "RETURN_DELAYED" })
+
+DECLARE_EVENT_CLASS(nfs4_delegation_event,
+		TP_PROTO(
+			const struct nfs_delegation *delegation
+		),
+
+		TP_ARGS(delegation),
+
+		TP_STRUCT__entry(
+			__field(u32, fhandle)
+			__field(unsigned int, fmode)
+			__field(unsigned long, flags)
+		),
+
+		TP_fast_assign(
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(delegation->inode));
+			__entry->fmode = delegation->type;
+			__entry->flags = delegation->flags;
+		),
+
+		TP_printk(
+			"fhandle=0x%08x fmode=%s flags=%s",
+			__entry->fhandle, show_fs_fmode_flags(__entry->fmode),
+			show_delegation_flags(__entry->flags)
+		)
+);
+#define DEFINE_NFS4_DELEGATION_EVENT(name) \
+	DEFINE_EVENT(nfs4_delegation_event, name, \
+			TP_PROTO( \
+				const struct nfs_delegation *delegation \
+			), \
+			TP_ARGS(delegation))
+DEFINE_NFS4_DELEGATION_EVENT(nfs_delegation_need_return);
+
 TRACE_EVENT(nfs4_delegreturn_exit,
 		TP_PROTO(
 			const struct nfs4_delegreturnargs *args,

-- 
2.44.0


