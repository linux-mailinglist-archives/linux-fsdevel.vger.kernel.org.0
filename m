Return-Path: <linux-fsdevel+bounces-8880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0933E83BF64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDCA1F22EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB654BE3;
	Thu, 25 Jan 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuY6z5xw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142795466F;
	Thu, 25 Jan 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179426; cv=none; b=BvNKcHXdnnudafel2bYh/J0fS9PgFz5TcwLxAcgOcSe8isDwaOjo6yg9WCBrw9WYkLA00W3tI4wSPTBtQq2hOx1UuIXR2v7cS26KXgt7NdSb8Bri5CHa6VUHG4/CV7XoTUXDYD2rhVUE4at2lKA8Lcj5H427Xi7+Z6rt1XyR2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179426; c=relaxed/simple;
	bh=76JoANNb/cZ0aZqm7odWxaM42ZvizPqQ7xwZgaYaPBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3kLMZpsJuR4QPd1wj0+dSoQ49UDlHJvGix4lOGf6PwaykfLplOLAJ02a+4bJU78OG3GKFzP9pBgpKGm909yeRFtpK927kEYeRdbfBJ/IHVeA9QtDeVqLrwqap3em+QlLEuKgBHoIO/x2mI7YHIMGtkMFCeExqY2QyYW715HC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuY6z5xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AF2C433A6;
	Thu, 25 Jan 2024 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179425;
	bh=76JoANNb/cZ0aZqm7odWxaM42ZvizPqQ7xwZgaYaPBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RuY6z5xwFBbrq8yDxdGgG3VBgCM9WqnarHmKN3wPlh78wBjb8NkDPqMbDgOa4NmVK
	 526CuXKaTkh9uahfp0FIiMJ4dcCLlxyyQFp9BH7zcq0VcD197UZRm8YR5SXsFje7lF
	 qHCTpZptAJi82e2cJTyTmN9wPyLo8XIlEOfXZJR+qtBUIJmcEDtmWaUKsJY/tbzOr4
	 bSXXNXCj8+wDs5OjVEpvAUObk7dwk0m13MgxBxqhUyxcNm6xaCkNJEc3ZSihJmCCuQ
	 I/tqom13BkJRby1bXFdgHxd6RALsxa6chUbb/xK2i+nQT07BrQxTFdAYhhooofXU9C
	 BpuKMn0A2LAaQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:49 -0500
Subject: [PATCH v2 08/41] afs: rename fl_type variable in afs_next_locker
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-8-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=76JoANNb/cZ0aZqm7odWxaM42ZvizPqQ7xwZgaYaPBg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs6mlzqlus0seYs8plExb25HrMSBcuHuJlcE
 b9UfC3dIwKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OgAKCRAADmhBGVaC
 FQhXD/4gu6zQnlekyIer5PJjqTfhNFt0AivH2IxxSvvwziWlIKPQ6B11Jm9YHG31Cogeo0xpkZe
 K6Q1f9W6Hrnc2qIWZMTgHt8JfLBNTZygnjghvzxnJEawm5xxr5aELj68TGWBMnWjIF1skd8nu5c
 Qn9IopFQE8q7lFtO3SWQwtDU/W73m8/UfYbHNMrznC5XuXK9yLIT5nI5T2xxxxqx1zUHJxSjVLq
 uz+rFiRaGxhANGdx7GmgL/1cQwJCbN7q5Tdm5UcFuj86MlylyyAWD7Biu+40PbTwLjTelyqQyD+
 Makh8iGaS3zlTZu5ny0Yq1nlwOaIlfFLtZEgssYKqTTG+oG7GuDmWSPyY7/WfqQ3NF5o0gWfjMd
 bhJqhWSmmMRAP69ugzS3HPp1Z64GaTCLCQX6TF61Qul81vjxzW7+sEylQN/baVof0TzhBcQDREp
 tmoD6wehNYbuTw35x782VGyA3Jz1Ck8H9qPCYPJzfWzEbHWrwkK9ppMFKor7cQvq/ux3zZEu3Zo
 3fkVrwL3XM5Z5FRkf8VHZ0EfUL5S7LNuLMXAtWYuOOFAUc4lQEAmua77WZaem1XQ7WVsGJJYgT0
 WbNpDG33KNGBhZfIjZ69bfAmlHxbv4IGJQZNhyLJ4DDc6m29DeTNd9hj0f6GvaotJn6ag34XjCs
 tZaUZHJgT4EOGQA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to introduce macros that conflict with the
variable name here. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/flock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 9c6dea3139f5..e7feaf66bddf 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -112,16 +112,16 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 {
 	struct file_lock *p, *_p, *next = NULL;
 	struct key *key = vnode->lock_key;
-	unsigned int fl_type = F_RDLCK;
+	unsigned int type = F_RDLCK;
 
 	_enter("");
 
 	if (vnode->lock_type == AFS_LOCK_WRITE)
-		fl_type = F_WRLCK;
+		type = F_WRLCK;
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
 		if (error &&
-		    p->fl_type == fl_type &&
+		    p->fl_type == type &&
 		    afs_file_key(p->fl_file) == key) {
 			list_del_init(&p->fl_u.afs.link);
 			p->fl_u.afs.state = error;

-- 
2.43.0


