Return-Path: <linux-fsdevel+bounces-9735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98853844BD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5391C2934D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE273FB22;
	Wed, 31 Jan 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I00G352G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADFF3F8E0;
	Wed, 31 Jan 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742157; cv=none; b=Pe9aD5MxlE15Ujid6PyVUjhyZRd4kVv65UtSYHEPbQncWGIDGUWkOOI9RL8iZUfTUu9pAEi/BuYuTU48s9NQWVdEIuaMCh7I40tbVYV17xl1isjR73dUZwsTyiRJ0DnM0XJ9fiSFZlkVApNoNLTXoKKFcwKE0mrAqRPce1K1tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742157; c=relaxed/simple;
	bh=IS3aB6yA7q+nu/7BKCjtOAugGBaz5g5IKIwQNBYmIqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r34ew37lRtutKHf9rToSny4JVvePG2lEbYzk7XdAH6Hz3ZBspi4dZudaTvNEHeh+qGJHWavvHvwG3WDWeSc8dPNo6Wj0hI3AxaxoKMH5bKnkjHA4aXHbgUnUJhQfUkw2uTL8GXncb3zMil/IikAtX+E9481vNN/jydnRPDK8NJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I00G352G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A125C43394;
	Wed, 31 Jan 2024 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742156;
	bh=IS3aB6yA7q+nu/7BKCjtOAugGBaz5g5IKIwQNBYmIqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I00G352GBas2RJyZWbnK2TnCnCEoCzhDnawB6ut+ctYqqFzKs/8rI1fFPfX0jPB7P
	 wFjSvD69aJ6CtPpEpV5aSLwnHq/XaUNz+doTMArhLysWOCqxMCh0Awaxg8vqqoHSlV
	 vuo21c9G+sylc3M2sjrtrQbR4yRQYNr+Ii8h2k4rvg3/yDM+438m4cLYI68ZYYoVtZ
	 yOMmAZA+8NMcJS9ZpkEpevdhdbrpPwf7IlwLmmGvrxQZqtOovqIwAZ+XEw+sVUWxxf
	 RMNACZei4U/qO03fQ73RAou09strX0HLv5Pq8xks+2qMs9z4Ctkx9td9J/zetg8FI6
	 2p8kbqWsyhKPw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:46 -0500
Subject: [PATCH v3 05/47] 9p: rename fl_type variable in v9fs_file_do_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-5-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IS3aB6yA7q+nu/7BKCjtOAugGBaz5g5IKIwQNBYmIqc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFuC+zRJivp63CkpaP1rRv4yjd7BIhWeDOLE
 JI6sv9DaPOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbgAKCRAADmhBGVaC
 FamfD/0dEQwhYyP3yd0IC66HDGEo8mN+o2mYFFFf/Tuz8UQryKRGPS9Fn0HuYyrQmVA4IyoZK6x
 TqwzWoZmtvAGWWV12Rs/0Uy570kXbg++1YGMPySFIIRLSS7yZPPQgbBUATDmALlOrR+arEzUZN+
 X8ag/4pYipE0H6yMR4g6jMYODSH48Q1psVFUSAMP/N7FlZmTjlFa8xy2AW0Hb3bjUw5UkKVuJaD
 AU3QXruVSbGyapFbfu+dDjWLFd059WLWJEJzH87RRV90pv40NlaWJ76c2bNVYnOicucCUNzhgMw
 T1AD58U0nJKOrbzBrxepHtWTEmSS61vvZN/MxaKwQVRd6sPp3787aUK6pviDA95w6NtR9dCw/mK
 +2JzWf0yuYrnH7A0ILv9HAGMGpNIySrnZxXI0JwY+IlVlBjo/RJ2PsOmQrBGgRpKzGAk3VbNi70
 Qxa4VMXk2NK4UUxFjr3uUu6d5E2NpGxQxjD3O6GZbaJYh3QA/NDiqpTfZpbGVRC1KOolg6ZXu49
 vNZ+eI2ascAaS1fl87nQMT7ghNHWNKMV8Zy9VhuwplC0FWeXECQ0dnXbdbGNhCev1vFL5JcfIrO
 S9V7SIoOM3+hlTm8AI+Px/O37gf2j3wEY3RMz6yXBKunNdvM0shZgrh06C5b7EvebrICgyFLg4S
 P9iidi/Fv5K2vEQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches, we're going to introduce some macros that conflict
with the variable name here. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index bae330c2f0cf..3df8aa1b5996 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -121,7 +121,6 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	struct p9_fid *fid;
 	uint8_t status = P9_LOCK_ERROR;
 	int res = 0;
-	unsigned char fl_type;
 	struct v9fs_session_info *v9ses;
 
 	fid = filp->private_data;
@@ -208,11 +207,12 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	 * it locally
 	 */
 	if (res < 0 && fl->fl_type != F_UNLCK) {
-		fl_type = fl->fl_type;
+		unsigned char type = fl->fl_type;
+
 		fl->fl_type = F_UNLCK;
 		/* Even if this fails we want to return the remote error */
 		locks_lock_file_wait(filp, fl);
-		fl->fl_type = fl_type;
+		fl->fl_type = type;
 	}
 	if (flock.client_id != fid->clnt->name)
 		kfree(flock.client_id);

-- 
2.43.0


