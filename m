Return-Path: <linux-fsdevel+bounces-66790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD1C2BF65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A809C3B7084
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4F3191D2;
	Mon,  3 Nov 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHssLS+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A114316900;
	Mon,  3 Nov 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174422; cv=none; b=Kowduqz8Ir4l0qTOF028XWSpoY+gOcJVjA3Ip8bkQiWCWA4EaQEjy++LHRwbSuDWqFKrEFyDbVzLqzaGuowMY9l9VVZCdevMoa2WCcDNzOApSirLGTuTJUAeG12lzj7ikFWBfOWgCHumOBcsuaJwpH58xUQbicIBGc6Hc9Dq20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174422; c=relaxed/simple;
	bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGt52B45iXfpHOEZNQ2YE9JWFH7heYe9CZweo+wjfR+iFjMoVtDJJ5MEg3LP+yIahjCgWvdpqrX2sR4MI03JVPTWv+VA5wGUdpw3vs8+v3xmsg1Kt1imETag5HhrE2QIc+BEoLH+MnNIUAmpvhjeu5D/nUE7ui3/k/VxOlgiX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHssLS+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56ADC4CEE7;
	Mon,  3 Nov 2025 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174422;
	bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UHssLS+EqhPcmq4VX9kZY0n2kc8tsCfVCjt6DuBstuv8EC32KZlxDwa9aLUG4Y5RW
	 bzDFE+AjQiL/+4Dmglxi9BQE7ek244+mr2ZVlLtff0GkpjA2GwpkhybdhtsFro4RH+
	 zKrsUc9P+wtgp7fxV6PApqlPVF6FIGl8VBKRzQjtdzHqOF9xzCdoi0DVd/xRPG7BYW
	 0zeeadflKBwib7ooXitByso+Gr9wLB5VwH4uC6UxMHmIZN+nGuVCPMG7pj9djf3gA+
	 MuvY6e5z1u7rFwcu1qRKGA2wTrCiOmVMfrap5MLOYv3Rqwq0IXmtve0nNBeJ9kPy0j
	 KKAZ/WDXXGLCA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:43 -0500
Subject: [PATCH v4 15/17] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-15-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
In-Reply-To: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWeE480+wABQYqJklPZE2R0cp6NeFSJ3AyaC
 XhUBRMgxMSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilngAKCRAADmhBGVaC
 FYB3D/9XuPIJashthYWvmksA9OtHQX/KiRSuH5SXxC6mf62tXE1cHMJBoaV0gLHl7Ak4fMX9aKI
 Ma2wZG111/8u42PZ0/Z5UNJ5Jx6Q6ptO0ltEgYl4vJpHmh4tI81ZE+QevqnRna8pJkBkINIzjjm
 9KOurX4bg34tzdE0VIYx6FKy8nFUb5+JHTprjcAyy44pGpezXMzXgB9T/Ynpm7AeAQwi1XbqUzW
 P9aaeOiVeMJmUXJBI4Qm62zrzno8dgXr68e0HdmuGn1qH8DrMJOrN9t6gGNcRaulahmuw5z1yf5
 pDK8SPa9xx3cOit33yNTkn3T39600VZW/XGtmUmTE/VTjcWOt74sP+belIqSsh1M3KJhflOxFuD
 u4yjtb7B5dImLrxYjVFZL39P1H4WqA8YierlxIZa/wCaegLFaed4GCOys0BeLzkiJTcXraRpkPf
 FmPfuwjshGemRACFaiAmvlNZso3YDV5iSbMmeNghgCPl2XV7XKwzHOd1l9PWyXedupt/NdqQ7Ls
 v6aDsu7jBXjaAFxgfb27K4hSTXM0tlMkJpJTDXql5fjRvnWoheqDqOmdGLwvtLQcQT5eYOGkwaa
 2TGBEUJBJ6S4H5z2muhfDa0rZ50UldQK+7a8N6dGNKcQ5Sv48tobCc+9eNdP5Gix3IqVyFtJnSJ
 qUTozEBnALhX8Ww==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Trond pointed out: "...provided that the presented stateid is
actually valid, it is also sufficient to uniquely identify the file to
which it is associated (see RFC8881 Section 8.2.4), so the filehandle
should be considered mostly irrelevant for operations like DELEGRETURN."

Don't ask fh_verify to filter on file type.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 81fa7cc6c77b3cdc5ff22bc60ab0654f95dc258d..da66798023aba4c36c38208cec7333db237e46e0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7828,7 +7828,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
+	if (status)
 		return status;
 
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);

-- 
2.51.1


