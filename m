Return-Path: <linux-fsdevel+bounces-62629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33DB9B3BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E3F2E0D59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18ED322A21;
	Wed, 24 Sep 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laUG8T3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F7322778;
	Wed, 24 Sep 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737213; cv=none; b=F5iV11WChHe8KSGCjbf7A0iZcYfywm1rtcmEieDJvuO2DRKxJdwQat+WYnEMIb31gN3vXp0G/JuDJmQ07goX1IfsfWfzlIHZqaoG4dYtjKaQyDByc3Gl3350W9+uBpP6lksgmX1JRqvEkAIXC3ln8CTzCYYscAcv+Qe7TEOj7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737213; c=relaxed/simple;
	bh=3NdGcT+E0zFyj6LsVCuP9emmVP/SCclAYe3dZrqyRaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pi0UN3aFtAegDu6/C69RPWWWBP7tKPlJIlNnZNrSOWcrRZsC6uYtI/qbjHS5UkNFQGQlwT90jrd8RdCmRT02KKe4IX+10MjIWfx9lBSOXyZZ7NYDrotdHQsXe07hV9+NWxuX4+Cx5Y6zGrXV7l8Z/6oDCQ9L1HJYnot3623pq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laUG8T3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C2C4CEF4;
	Wed, 24 Sep 2025 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737212;
	bh=3NdGcT+E0zFyj6LsVCuP9emmVP/SCclAYe3dZrqyRaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=laUG8T3o6UBMdsQV5RjtKxLCKc//dEaNwsRKO/DvdGwIo9PLMdFWKhQ4xHlhOxP/i
	 xRUm4E/8VHpvhww47zwhLX2ArhFeaqlT93YJhGqXcC40FvOU0aVlsV2MGODfF/IWjc
	 loaizm18Stu/7Z9GQ79zFcPa0l2xVeX6l98a+KLlOaDy8FB+I2mXDllgdyRGCjEvlY
	 4OOnqyAUKFSg+r4UcgfGmJq8Pp3I8Qls6pY2enSH1+Lp4OQQ7BvyoQEMQj2p9uqK3J
	 yQpF8SyBEQdgBSDr+PLhk6OrT/Ky2FSkcKQvb0woKIJ80oLOF8uva1NQ+H+H7MV4cH
	 fkcXLnoL6o/KQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:57 -0400
Subject: [PATCH v3 11/38] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-11-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3NdGcT+E0zFyj6LsVCuP9emmVP/SCclAYe3dZrqyRaQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMMHL0aK9fj2ZmPrttzDdyuryLZdwUKq1jyM
 FNa24PUViuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDAAKCRAADmhBGVaC
 FcwwD/wIx7dzrZmx7M8YnXKd5/ryLscLafFMpIBDwD2jmff8RKKv5uBVSkgKZKAXII9mueLhzMy
 zk2EFur8FbmXwNleGGhrFLvEa61tuqqrxeCyj6ag04n8L2KmmNnlTEyRWRDAFdLr1/F2Y1P85m7
 H7ze9DWplf7K9PywEZJCO6sN1MzxSk0V5CiH/gC+UTgIGcRwlK3ruXq6patJkyuRVpoUY4eMkf/
 EMVOCYB48QRLhx7ZrYC56D6o2kwG6V9A5iy13R+WvVwdszcIqY+7jAuhaofkDfkGMSfLPCkflXt
 wKFugF9gLkM975xkeAhpRGZ+8QB2yKWGo2rXOHF6lqLlBPo4KSkqzvf6Rvv1zJn+QvramnDVEWx
 Deizoo77x53ClDZjZqV+ytMctDEgd5qfDbKAClTuHaktUZhVlhkbUE7XJn4O044Ph4HVhjjkxHC
 IqSNQ2p8GilPnAEf0hvGZyyFfYUxSxh0UvSL55c1S9e+JdxWIRIWzHicx8YTHuW29vFSq6GDxzW
 Y8LX3I05CCkyffmhH1a6yzvecX3TLtnfTQTkU4k6jysjTNKrnJMkOYc7xn0ZPpJUdRG3DV31Lyx
 WkPhDZ1DyVbtgg60V+tR/Es0oH2L5eqR4rtU2wGJdIUSGiUh38eZl/eWOFVNhceHPhqxOLs8QDE
 Gk/yKdKoweTqnaA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Trond pointed out: "...provided that the presented stateid is
actually valid, it is also sufficient to uniquely identify the file to
which it is associated (see RFC8881 Section 8.2.4), so the filehandle
should be considered mostly irrelevant for operations like DELEGRETURN."

Don't ask fh_verify to filter on file type.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fa073353f30b68704cf6d503a752990e6d18c8aa..25e4dc0a1459b73a0484c05cb3d1f0306784bb74 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7859,7 +7859,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
+	if (status)
 		return status;
 
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);

-- 
2.51.0


