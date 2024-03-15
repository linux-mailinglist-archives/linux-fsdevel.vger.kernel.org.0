Return-Path: <linux-fsdevel+bounces-14508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B987D226
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DE1B24917
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E955F489;
	Fri, 15 Mar 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjyekGU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F495F46B;
	Fri, 15 Mar 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521651; cv=none; b=paDVFid15KPiPxgPAuTPzgeI36qMy9cYc8uM59iKENOLgyBBzZKMY0cuwh818RenQkGkwe5BxaA4/FkOFPhMGpXykAo1QbNRYtlpyxFv3Nvp4cFNOOvPdIHCZyPbWmELjqiwsM+0lfF64c8Tc3OVBVisTBdBBKwXvV14P/oO/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521651; c=relaxed/simple;
	bh=lxV7izHPE+zlnqW3U+dTQR3CCp98pGncwQ1zL/XGIzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/UoVAvfcs+XQcludAM2qKkDw+mwGyED+NpAwHe1mGXOKy/HJEHM5l2Zv3KN2tHNFHDPleHjOyf4FzrGhlN6679ydEmyC792zbLhYra/UKptKeB+lSzD3N98MgCM2MiNiVAFE6nVRAWWjzEv7HvMHBf/QclOr+tmGdS+K8+ovy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjyekGU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5B3C433A6;
	Fri, 15 Mar 2024 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521651;
	bh=lxV7izHPE+zlnqW3U+dTQR3CCp98pGncwQ1zL/XGIzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TjyekGU7X/ycYls+a9oMTXm4AxG9GbWbVuPiPjf7qg6vAItdVfuEl+v39HJ+YZ7Nr
	 h6unXUAshinq+mq8S1xdj6aYRUGakFqAVfihUkiUIiPWKqfjQUv0idpkwyslHgwfle
	 iT105IfnP7dmsrnFqjwzd4n4kC7HjOYQqXDMo5DfBYc2ImApyTyZRyi8WCjsfQph3R
	 oApCUYdeYSpyhBbMYPp+89FdBbM0bi9jAn7nIvs34uA0WQQN+2/9S6AA5zQy97nUnR
	 tY2vpPk8EroU+VE5GFlN4MKpFIRYEsxnUg17000kDBOjynrkuuY4lqv5ReSTkB5yza
	 Z/eZ7YskP3D1A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:11 -0400
Subject: [PATCH RFC 20/24] nfs: new tracepoint in match_stateid operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-20-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lxV7izHPE+zlnqW3U+dTQR3CCp98pGncwQ1zL/XGIzA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzv6J2chYdV0t8vLEOXVZhJ40E7hMoQpCAVh
 RHtnRSKWaOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87wAKCRAADmhBGVaC
 FTzzEAC7hUKavoEeDCntzRNdIHCTFTR2R1SfnG7m0K5BQB3F5OhjGBFyfx9wCOn9b+p6h1S/fX5
 9AGnQBfoRKjeMp2Pw5Nv3BjEinIrY5HgHi7r00tA7AY4Cyz6f0YlE5ArUOt5arGyRuGxl1eIfVh
 iucv6ZF1hJz3Uc2akJ0JvmEDY289882z04rYSaxPQcGKyudfg/ML8ulETzYnmExuy8tRt7b2sHO
 9QUSUhBv5oitzj4kgrhfwHFtneUrK9FkxsdNbI8wO+kF0ECY/7D2BsAB0G1evArYZe3LR+TzlNl
 1vabY5cSEhr6xa8Mq2qXwcXj8dDIIzkmP3EIWJt2PJqlHpLyzMd1aPgNslQpCxUaHq5nhU//DPT
 gE64opgPAVQBEz2Tl0F8LSnli7uqvhCPyELAmRgj6z9oBfoeXacHimcUqP2/VKIqdLwC6Ss2uIy
 IqigI0PXXUZYvH6D5taPTBFgsP3OswfpgAnLWjWCZTLpkDt8HSmkC1qUG3fvwCyRhYjBXYsjCE3
 HSJr96+h/PRgf02son2ugSC8Mxtl14dxdb6G8JmKrWa9hSnOp3fHcWd3bhNv8Y5CO2c9V77+7r/
 PjX1F7uHkcJa1fr1wOo0UR5Fxi5KgxjKjtiqeGflNDtj2yjnfs+cbmxvG9+vXpKtJKJpF31v5eq
 PLXJwUeP2Ayvilg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add new tracepoints in the NFSv4 match_stateid minorversion op that show
the info in both stateids.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c  |  4 ++++
 fs/nfs/nfs4trace.h | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 815996cb27fc..d518388bd0d6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10432,6 +10432,8 @@ nfs41_free_lock_state(struct nfs_server *server, struct nfs4_lock_state *lsp)
 static bool nfs41_match_stateid(const nfs4_stateid *s1,
 		const nfs4_stateid *s2)
 {
+	trace_nfs41_match_stateid(s1, s2);
+
 	if (s1->type != s2->type)
 		return false;
 
@@ -10449,6 +10451,8 @@ static bool nfs41_match_stateid(const nfs4_stateid *s1,
 static bool nfs4_match_stateid(const nfs4_stateid *s1,
 		const nfs4_stateid *s2)
 {
+	trace_nfs4_match_stateid(s1, s2);
+
 	return nfs4_stateid_match(s1, s2);
 }
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index e5adfb755dc7..f531728a5b4a 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1467,6 +1467,62 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_recall);
 DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_layoutrecall_file);
 
+#define show_stateid_type(type) \
+	__print_symbolic(type, \
+		{ NFS4_INVALID_STATEID_TYPE, "INVALID" }, \
+		{ NFS4_SPECIAL_STATEID_TYPE, "SPECIAL" }, \
+		{ NFS4_OPEN_STATEID_TYPE, "OPEN" }, \
+		{ NFS4_LOCK_STATEID_TYPE, "LOCK" }, \
+		{ NFS4_DELEGATION_STATEID_TYPE, "DELEGATION" }, \
+		{ NFS4_LAYOUT_STATEID_TYPE, "LAYOUT" },	\
+		{ NFS4_PNFS_DS_STATEID_TYPE, "PNFS_DS" }, \
+		{ NFS4_REVOKED_STATEID_TYPE, "REVOKED" })
+
+DECLARE_EVENT_CLASS(nfs4_match_stateid_event,
+		TP_PROTO(
+			const nfs4_stateid *s1,
+			const nfs4_stateid *s2
+		),
+
+		TP_ARGS(s1, s2),
+
+		TP_STRUCT__entry(
+			__field(int, s1_seq)
+			__field(int, s2_seq)
+			__field(u32, s1_hash)
+			__field(u32, s2_hash)
+			__field(int, s1_type)
+			__field(int, s2_type)
+		),
+
+		TP_fast_assign(
+			__entry->s1_seq = s1->seqid;
+			__entry->s1_hash = nfs_stateid_hash(s1);
+			__entry->s1_type = s1->type;
+			__entry->s2_seq = s2->seqid;
+			__entry->s2_hash = nfs_stateid_hash(s2);
+			__entry->s2_type = s2->type;
+		),
+
+		TP_printk(
+			"s1=%s:%x:%u s2=%s:%x:%u",
+			show_stateid_type(__entry->s1_type),
+			__entry->s1_hash, __entry->s1_seq,
+			show_stateid_type(__entry->s2_type),
+			__entry->s2_hash, __entry->s2_seq
+		)
+);
+
+#define DEFINE_NFS4_MATCH_STATEID_EVENT(name) \
+	DEFINE_EVENT(nfs4_match_stateid_event, name, \
+			TP_PROTO( \
+				const nfs4_stateid *s1, \
+				const nfs4_stateid *s2 \
+			), \
+			TP_ARGS(s1, s2))
+DEFINE_NFS4_MATCH_STATEID_EVENT(nfs41_match_stateid);
+DEFINE_NFS4_MATCH_STATEID_EVENT(nfs4_match_stateid);
+
 DECLARE_EVENT_CLASS(nfs4_idmap_event,
 		TP_PROTO(
 			const char *name,

-- 
2.44.0


