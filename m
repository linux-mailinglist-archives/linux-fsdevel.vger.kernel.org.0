Return-Path: <linux-fsdevel+bounces-62627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D343EB9B399
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9364A16F084
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F431A053;
	Wed, 24 Sep 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi/q9Tha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697B321444;
	Wed, 24 Sep 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737206; cv=none; b=fwljmT1NmQF6o9vgp7wxdKdQrqVkdt/c2e1eMJXlBbkur3d4ABXhd3+beVJA/dx4XtQ94M4edQh1BJ1V9Qmpc+YBlCssBgb1v9Z3oH2Pi6MQO3J670LOAXxi/AQTMvbB6tUeg9krP22v/MAKVCpkACturc3fwxfzmNDQpOGL6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737206; c=relaxed/simple;
	bh=75yuTCKylRiCZtlQq5mTPX7wjiZbu3JeDtIqVqE9biU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2mCXn7agqx3cqHkZdD0cvEck9LAch9ICpjvJrhv7IAgWwOSzRWt2Dnsn4Ll1nMUbAuwMtmHMfQL6KiFUxXzzbKDN9pt0tyfHyp+thYDq3nbBIFAIJm2LqtYmqAnWzXcDlXCBPIJi9VWzZ+qvCox4se/SPfAlmBa+5sCHVzJHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi/q9Tha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684EEC4CEE7;
	Wed, 24 Sep 2025 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737205;
	bh=75yuTCKylRiCZtlQq5mTPX7wjiZbu3JeDtIqVqE9biU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hi/q9ThaLChLoM64aI4aiTRYiLYU/0Bg9WlmLT8JwnWtt7QKHZuL2Snst7AY8sZms
	 qMGea63fojVYVk0pZ5WtcPBc/vtOHqlkHlSFHlyfOiid1iEroK2T7XsC+Bqbh0nfg1
	 rM9kgQAxmfVebp15DATSorcVdqSlFJEywHOaqPacq/lfytNqYstFPbCB93y76tgPpq
	 7BSoiGuBaoo8cB4TClF/wrCq+VtpdG/AIXTXUXk69WtmhVIDes2HByNJp5sOzm8uMC
	 dhaQtniHzngr6PVLP2b2oD2+E2YWTJeSb9IBOIwt+Cf0hdbamqnP1M/LPoNRk8+dgo
	 /hfbYza2pu0SA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:55 -0400
Subject: [PATCH v3 09/38] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-9-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=75yuTCKylRiCZtlQq5mTPX7wjiZbu3JeDtIqVqE9biU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMMIOcU0Afa3evNE5kdUgW1dovMonuxlw0Lh
 zAXLLqYguyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDAAKCRAADmhBGVaC
 FW+zEACZh2zkV2oD83v83cFAHgfu89quKTEbuaBJ9uBqeZcYgOBzUl2LOUhDuAqHFOYDbEtDeYt
 yZF2Saf8iiv1aEmU9JfQlhmfJi3znPGBpoOqq4QQrZUrbUaE11XeBeJI0C8TMa//hAbsLLCGfDk
 57ooLpT/BtnRQHTszHnTdFqBhMHaQLpmTeori7P3/86U+80/VSqpEc326bgvtt5K6GRnVAm4NTA
 fIwbhddUjiIikaPpP6qMnFiq/fizvyfZTe/HtX9VxG/1PQLpF2hWp5SLNiaiyEUccn6EO4KPV0K
 aPs3Bi2KzJQgcrqGW8hxSgycbYCpzgdXYuP0onym/BQL7lhfRKSx4b9WyO7efS4pmsWNQ/vf1ae
 e1H3Hj4EPk35a432at1UuSlEeT++VUhdjQRza8SGGFG3TvYQ5Mh3+1Eze5A72PxO/UfTH1qqTdN
 XNUzD36lzPBGjVsWAss/f360Az7Oaqrz6QYvb0M8xb9XvYZzrNfuDzrL0VLRWzke0Kw+j1IciPm
 p+WP+KLZCTMGREdNHBw/IgdffZblyB8XxnDG7qAam5Y3bKSoD5twJKcAzTqWn+8ZW8Cy2mlQEYo
 fpNm3oXQ5tVd/nwUBBhGXlLed4jIr/NNeukdnXHHbRymRTwY8Fy9y9s+f2dBo7Ev5P3YawaXMa1
 yVcFkx0mLnudqgg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the addition of the try_break_lease calls in directory changing
operations, allow generic_setlease to hand them out.

Note that this also makes directory leases available to userland via
fcntl(). I don't see a real reason to prevent userland from acquiring
one, but we could reinstate the prohibition if that's preferable.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 8bd0faa384a9bdb0ef0ff40ba7269aed72439739..c1b4575c827648275a8d6628a8f279d382e46fc4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1934,7 +1934,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
-	if (!S_ISREG(file_inode(filp)->i_mode))
+	struct inode *inode = file_inode(filp);
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
 	switch (arg) {

-- 
2.51.0


