Return-Path: <linux-fsdevel+bounces-62647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8CB9B57C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF171BC1782
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6803B32CF85;
	Wed, 24 Sep 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8wgb/kc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7C32CF62;
	Wed, 24 Sep 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737275; cv=none; b=eI9OLykaCqvUQSdAC/FoEnDCmUyuMH3BabsR1PaiLXKwsp1vambPsAHaREGjZGJv3njh1mJZsy12s6Uds1jd2KVCkUAwaC0CapmWbVyOY7AV/A+5JyHj9IlU4VQPVmuEjlYzVMz5WTQB914mr8cIF95spH7JJSUfbRt3GMm7Fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737275; c=relaxed/simple;
	bh=K5hsMYtQXjyOKS60Uf3VyfFpCL0/dbOW4BLDAmfK1SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcLQOskIRtlXtjsdQgcBeXtPSqQcQOo7bcaW+7KRCNIKhmeeoG8hOCp1mbOqH36AGnQAxyUG8aX83rsZpJYbZijJIBR6x5qGfIOvx0NdDGgDRR0szGG9fXNT1VYhkbXuHtcCKMc7VyWzbWXM2KWqqFtOvvmmTXZucFTywD7H9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8wgb/kc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4798BC4CEF8;
	Wed, 24 Sep 2025 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737275;
	bh=K5hsMYtQXjyOKS60Uf3VyfFpCL0/dbOW4BLDAmfK1SA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R8wgb/kc3BcqZjJXY3FbPlzAU6Vrgmhur+I4rs4sh3hsSw1VKfcMmDykLvJAAi+yX
	 FDRRFPUFxEmlYLZrEne6kMUnQZyt/4b19+zrX27VxIdXkNTtnQuXRCHamCrSSeRTHD
	 3A0DAGmc6sBQqfpJpRxJh4eyYnldnW78qqo+McztfFStlc6u/CnEobMhmzjUu1UAS4
	 zJHVlXB1D2scXPpER5qlL5/SFecvaYGJUDWoSqI1qtDwQ1cq/zFlnkBv+M+FHFs14h
	 /GIWI4vo67GFKoJqVRa3ao7tZCHgNfa61Y6R1xVPF72UFyvWs9V24TDK5sdVvtK2Ew
	 0Gc19yWlkGJZA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:15 -0400
Subject: [PATCH v3 29/38] nfsd: apply the notify mask to the delegation
 when requested
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-29-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=K5hsMYtQXjyOKS60Uf3VyfFpCL0/dbOW4BLDAmfK1SA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMQMvdIPknrW1MptHugAUEwdl5e8EknKuE4Z
 twhQAq1pquJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEAAKCRAADmhBGVaC
 FbujEACfsaYwLWDSW6Lh5L7Qsm8v5al2ixv2jZXI0EFbS0n1ea0TAMjKIgzplkSJso2yLfIKt75
 VpgKTfBEtcZQwMfctH2bshZzdq9k2tKdjTu/QKfCm+Aigc4kI2ukPPOBHrBHqwrillvbz06m88M
 jcsr3iVvfR+0qrTzM/Yo21oLBQXSSZ8ILrhvPyWBcqyrRnMtbSg0Sxt0+kYIomTlIKT+aUfSMBq
 IfE4sgrVIuWR2JGcTIKmtwmP8xBv7fvbX9R8zig49GE+0pohNv56RbEzxoEZd+haIS0Yq9noMyh
 C8C8wHcpFsNJgLgWceYxAyAKiAQ3wvlY6X7FaD7eLcbnFs5RoNlaYUIlSyS8Ku3ZVQ3p1jwnMeI
 1QnuQsRsoLNRDEUob6HTefy2KTYnjabvfb1tD9upClOXZjsrqH6kNEPvpD21E4sYQbEtJXD6ET8
 7LqNrpMhuyBN9UIf/gIbI71dgELiZmGCZyKDiDptsn/IzpfSV+x9YcHRZ47HlS+67xZSpCEnMvo
 phq9Evav58WwFDcsfCCdRo8QBBl+cLx8YR9sD1nNr3KqFUz9I1jho0HfADJL+pZ7iJc1ze2Kqop
 JJW7pFIjXwMuQbknSnV82o99RgH5lLUGr4EdJqAIdfIagQpRk7bhmb40ET1h3ASKqXGpYdxwDD6
 ratkwwRo2WZ/kOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the client requests a directory delegation with notifications
enabled, set the appropriate return mask in gddr_notification[0]. This
will ensure the lease acquisition sets the appropriate ignore mask.

If the client doesn't set NOTIFY4_GFLAG_EXTEND, then don't offer any
notifications, as nfsd won't provide directory offset information, and
"classic" notifications require them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 277022d437cec18e527c836f108f0e97c6844b23..220fc873db8f08a90ac74e51ac9d931fe7edb9e4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2335,12 +2335,18 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
+#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
+				 BIT(NOTIFY4_ADD_ENTRY) |	\
+				 BIT(NOTIFY4_RENAME_ENTRY) |	\
+				 BIT(NOTIFY4_GFLAG_EXTEND))
+
 static __be32
 nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 			 struct nfsd4_compound_state *cstate,
 			 union nfsd4_op_u *u)
 {
 	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+	u32 requested = gdd->gdda_notification_types[0];
 	struct nfs4_delegation *dd;
 	struct nfsd_file *nf;
 	__be32 status;
@@ -2349,6 +2355,12 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	if (status != nfs_ok)
 		return status;
 
+	/* No notifications if you don't set NOTIFY4_GFLAG_EXTEND! */
+	if (!(requested & BIT(NOTIFY4_GFLAG_EXTEND)))
+		requested = 0;
+
+	gdd->gddr_notification[0] = requested & SUPPORTED_NOTIFY_MASK;
+
 	/*
 	 * RFC 8881, section 18.39.3 says:
 	 *

-- 
2.51.0


