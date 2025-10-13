Return-Path: <linux-fsdevel+bounces-63981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A60BD3DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BB53E5661
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4074130DED1;
	Mon, 13 Oct 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKk6Obqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7930DD29;
	Mon, 13 Oct 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366927; cv=none; b=g5aui/RqySl+dYkQPgCLmyooRzr3dujwzcHn0qyTOCPeDZYEsWVyJb0+lzSJ5yaO9sl7nVcdpOLnok23mW4o0cIjyhC5BAhuH5wM51DmFNyCPdrO1biyjN4eh2NtGmPPm5odJEJf3kN/HSyMhFRHewiTBZ3TKu7DwHu7um9vfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366927; c=relaxed/simple;
	bh=slSG+3J1/tQx7TfRkB99FbBkUrMXPOZ1kKaL1V7X6Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQ6pNNxSu8oQpy8y9BmpaU8n6kQNLIWC4w02W0z8PAEj4cZgdk7mnCFJD3K7A61VSQJlyM8Pdl0ZwAVUlGm33ojV+KMv2sfVeQxed8p1JNfrb/uW99QyZr22cYJLIuv8dk8Plwjao2nHodhP6L1YtfaD3Tgcx0jDSTRAPJbwijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKk6Obqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B289AC4CEE7;
	Mon, 13 Oct 2025 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366926;
	bh=slSG+3J1/tQx7TfRkB99FbBkUrMXPOZ1kKaL1V7X6Mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GKk6ObqpbzcNxmEzsRQ7kYSiluVFk09440+eUiCayJQjl1mGEYmjCyF0ii5FeYCgU
	 2rXk2L5KNUkG01fCCv4Bix7iVRcBkJV2msjUtpbr9FGtf40sjki90SFX/Ntmn5HflA
	 H/txLPbuMIfBoHE2xHPmWUgnc/b3b/5tvREXBAPaLcVzCEhN6FVZwqtCV92OhLPOhO
	 aS9YUZBo3wWTU0ZiLxUEIjNKtnLfTzCrTpfT14LiN9br8wTe+aoNS9mI86GVdxVMH/
	 p9CD+1aVDZyHN+BLBzF125/Nh6zRoXUb+T98/2nb/PkIC+1ZO+MCz3cvVZSAAKa60w
	 p1RaRbKCqpNvg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:07 -0400
Subject: [PATCH 09/13] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-9-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=slSG+3J1/tQx7TfRkB99FbBkUrMXPOZ1kKaL1V7X6Mk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REr8r+3hUFfrFM/If3b8LOteej7cPUKY/vvn
 ABlFCIJmTyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKwAKCRAADmhBGVaC
 FaHnEADN3vNO94QWfiHoQTjfFijRWK2Bb9ZX+Wlr9P2IbEodkZtgiV5J+YK3LFlv65DEbUEK4YQ
 4/OVinW3Vj0zNrxy28wb6k6Q7GOjWrYbcnUyZHzQ+k9+2js7PVnCoP5at0wjA7EcL56AhB0SDyx
 B/IwobaRvZLYiaRPpC57Xr+5iZMw/I4JhBU/04rfjtTbT+C+j0XQhpF3cAX7wYimb9MI55ciMZk
 yhaqYh3CWTUEjpuIL28N3QW5XlhQ8gxZyoqpa3jdXOEunEt9dz+zUeFL0We+MAzicJrXyLnZ63L
 rPUHxox6ZE2RDAioExUICBv7s2nab7Kb3pqXtKbMWXZMVUTc5UVzdjh9SnaJpNRdC2pVJ6dImpB
 qFEfWU2ZFzGJVs4NqX8sgPhLo/PqwzBoSfPJQUdrlc5JScdcVpOUjkDC9LNQmOOKMDv17kvkfVb
 AxPJrKeznwAB3f4JwHkGJbdoz3OBQxDQU74fj+HMd5a8zFMHmzIwhzuhevgEJs6UW7Fm5Zi8ZzT
 Qjg3dnYDaUDXjfuURGWLCUTfb20UHHTCjhqkkTFgBd8L6FOTeBql8pL3sqj2VBkUmzVPjp0FCnt
 ZOs9hR2gi7El4kxgbu6MdtwUxUII+ikLnjRrhwgttbiyi3061/xTMVoPC0UinayYtKcsjlawgP5
 ytOGR/V9ITlM0Eg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the addition of the try_break_lease calls in directory changing
operations, allow generic_setlease to hand them out.

Note that this also makes directory leases available to userland via
fcntl().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9e366b13674538dbf482ffdeee92fc717733ee20..ee85a38a7d42fb9545887a4879746c82779ace90 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1934,14 +1934,19 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
-	if (!S_ISREG(file_inode(filp)->i_mode))
+	struct inode *inode = file_inode(filp);
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
-	case F_RDLCK:
 	case F_WRLCK:
+		if (S_ISDIR(inode->i_mode))
+			return -EINVAL;
+		fallthrough;
+	case F_RDLCK:
 		if (!(*flp)->fl_lmops->lm_break) {
 			WARN_ON_ONCE(1);
 			return -ENOLCK;

-- 
2.51.0


