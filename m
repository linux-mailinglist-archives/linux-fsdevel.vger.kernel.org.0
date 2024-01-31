Return-Path: <linux-fsdevel+bounces-9751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB19A844CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A7FB2ECAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EDB3C497;
	Wed, 31 Jan 2024 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0EWzwTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE213BE9E;
	Wed, 31 Jan 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742220; cv=none; b=N801ZuB9zQknjFtHLiMC6bg2cn+Fhs0SelayQjy3v+uih37XYUF3sW+Pl8fw69U/Nv2pS7JGDicQtjY8foBcYT0D1Irnc09yLbtMAjU7XSr07cVy/Typv6Z78bXQ1eR993RhXBgrBUm4J5AHCj5sHW0ZxkRT7UVjTJalomBI7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742220; c=relaxed/simple;
	bh=oU1l+ksOKxD5QTjyx5Q3wpjW56H/LXw8me0TimuRFek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qzfq9uo7dEPth14yVwPCsEGyLmTgoVXcCCo9hCkt4I0tkhgav9ss/kxz0miVGih4CGmP+wJFiBz9oNfuVknUKacl6v9BrpJrNbLj4/GU0s90M2BDg6KTTqJRv/HLH61gAvPlyPSFM4jZknHiNP2G7ePCmtmUkeE1GUA6OSV54uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0EWzwTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3E9C43141;
	Wed, 31 Jan 2024 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742219;
	bh=oU1l+ksOKxD5QTjyx5Q3wpjW56H/LXw8me0TimuRFek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l0EWzwTco/GVPhpeXnEma+B+VHEKwsEBFkRAd7vZrdu9jYwrqfrmAfUIfYZYmZwzL
	 RN3C/uo/wWY+tq3uZz+MBYdS1ylWHaA1qkzm5uwF0bk+ug8YaC4WMYkRNiQg6O+ZQT
	 9PYWd5yav4MMszJqpm2uua7wDOUGGQh2sn6+xCH32wz0q9A4Qt9OkAwHxnMgp9bU5Z
	 E+YDdjKM6392cCgGsYOwNRNjM97+VxcfFGFvFb2LudUsAlTfvP8GnNa/1qr84gNIbw
	 Dy/Nr95zcJ6NcSvFx6Z06NrrJfmurE6nunR/BMLiUjdBsHxDYEDHrEnWag92wJghJj
	 8l662xfg41J/Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:02 -0500
Subject: [PATCH v3 21/47] filelock: convert posix_owner_key to take
 file_lock_core arg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-21-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oU1l+ksOKxD5QTjyx5Q3wpjW56H/LXw8me0TimuRFek=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFwRfnmGuw+kZZnzAb0prMEAPMNT9x3XjV3y
 MD6YsS59veJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 FT4FEADHoubPCG9Ssate8KyC9UXdDZ52tJtOxTqhlYEsbKtOcDqrSPS0oiQ3lP3JFrisKxkdoff
 Dn5yeZ2Y5B88LmvpyXU+/drV1HMyZrg07QbmtlsD7QvzrVxHstydUmz1qaHu9+ogiz8e/53quq5
 rS+8qwY3FG+jj6HIxSGqyfA2ow2IrjNnwkctfhBJXTD/uMpZBFccBdsXBl/SE6Vm4tNBY6i5Mtf
 51lTNEoOo6jsyJ2Cn6QInC5PFcx+kzF/5ZUfjMv/KU1c5gvVESxaKHNQzfsZd9h8f1nMGa8edhH
 EUc4oP5/FpO01ZhN96OT7whltuYwE4BvUJI1QKGlaCXUSeV0gAKCcs5Twt+DnuHGDIOIgRmjC47
 6wJl3TZIuJ86XRfSbUrJv8TJT2/UTcmSzmNvRy34kKlMMweNBbwNknDDHb95lb44YBzpG+LkLb8
 vTRPfBAY1sAA7ySLIO61TPJk2bp19fNF2mC31sKxEgjuiMCfSKG07R95pKgYe21Q0ofvq9ql9mJ
 sZHhcZ5ntsbfxlL7HtU3/oD0oQHFq2mjZPI8ZX5idbyawcQv9CYDOmZdbu+RkpSfLxSPjj4ATbj
 qF7USRAnnbgGRgCcAPLNLHa4qGsnPQJAD7hbNJ1zpQ7J4PQgWXurWpfqcheZ3PHSXUwFpWu3JEm
 W9lPU4Ot6JLf1Mw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert posix_owner_key to take struct file_lock_core pointer, and fix
up the callers to pass one in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9ff331b55b7a..1cfd02562e9f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -630,9 +630,9 @@ static void locks_delete_global_locks(struct file_lock *fl)
 }
 
 static unsigned long
-posix_owner_key(struct file_lock *fl)
+posix_owner_key(struct file_lock_core *flc)
 {
-	return (unsigned long) fl->c.flc_owner;
+	return (unsigned long) flc->flc_owner;
 }
 
 static void locks_insert_global_blocked(struct file_lock *waiter)
@@ -640,7 +640,7 @@ static void locks_insert_global_blocked(struct file_lock *waiter)
 	lockdep_assert_held(&blocked_lock_lock);
 
 	hash_add(blocked_hash, &waiter->c.flc_link,
-		 posix_owner_key(waiter));
+		 posix_owner_key(&waiter->c));
 }
 
 static void locks_delete_global_blocked(struct file_lock *waiter)
@@ -977,7 +977,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 {
 	struct file_lock *fl;
 
-	hash_for_each_possible(blocked_hash, fl, c.flc_link, posix_owner_key(block_fl)) {
+	hash_for_each_possible(blocked_hash, fl, c.flc_link, posix_owner_key(&block_fl->c)) {
 		if (posix_same_owner(&fl->c, &block_fl->c)) {
 			while (fl->c.flc_blocker)
 				fl = fl->c.flc_blocker;

-- 
2.43.0


