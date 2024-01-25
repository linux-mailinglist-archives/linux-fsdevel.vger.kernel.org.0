Return-Path: <linux-fsdevel+bounces-8879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F73F83BF5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DC51C23DDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E4A51C20;
	Thu, 25 Jan 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmHdrG+9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB151017;
	Thu, 25 Jan 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179422; cv=none; b=drFmhF5GvZW5DeMssU5hkGGewn1KEWBzdS0z7X9psDeRTiJ6J7NULXDOeuLtGrRU3UKBSvXh/0qSzTPmypyDdXfsEABdOnZ4u9Bw7bj8OilGKFnBkZ93gdIRa+O6lLdmFQBSJOiU4tSiQh1Q2+Ui0s24lKA9Xufr1Aku+J7G+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179422; c=relaxed/simple;
	bh=IS3aB6yA7q+nu/7BKCjtOAugGBaz5g5IKIwQNBYmIqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+RU4jVtgg/H0b/xWK0cTwlS+xlVqnmQvQ79U7YuXvMs9jYvmWSaRYQueTV9b4ZlKJ2BAtLdzO/cC8vxDqksqA0juhhVUeer8UnChJqki2m5WaxSi85hSAHyDXEGkQsAHXmt8lYCQ5E4V/zqAhM1HZAj4ffw5l15tHCW7t8NS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmHdrG+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF7FC43141;
	Thu, 25 Jan 2024 10:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179421;
	bh=IS3aB6yA7q+nu/7BKCjtOAugGBaz5g5IKIwQNBYmIqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LmHdrG+9WciwcjOfAlc1o2jPn+i5lZU6qqRNNKOEW48YL5dGVpWuK5MPiP8Ci08wa
	 PA+54xld+rHJbQk2XQlYKh/+8wv3Irwrgvl0xfUmnt62qg8Ng8ESOobc9g47v20ALv
	 mw7TgAsEkntw1o7/gdfPPTFUF0YPMlTt+/ydLBYmu3vB0JBf/GXpCusj3Q3BFJUuMN
	 vTFarVjdvJ9jIGBzki8e/LYSo7Dtpk8uAbtF+a6gKcFzvP6hSIKbyspfUNkzB8DJBT
	 H04NyHW8lfh6L/VML9MoeM9LFyzXnnEZxp+NRdGp49OUMtnHeXk3UYFrBStcfMZLwA
	 fdqPtMvj1h0dg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:48 -0500
Subject: [PATCH v2 07/41] 9p: rename fl_type variable in v9fs_file_do_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-7-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IS3aB6yA7q+nu/7BKCjtOAugGBaz5g5IKIwQNBYmIqc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs6qXZWzHfckDwFuS8CJXkchexkMf/rKs5JX
 BNQleJ7QRWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OgAKCRAADmhBGVaC
 FbZ3D/0f04M0OOKSV+emWUVYd3d2cWArdxROUDgxD6H5jFV7zW+fTmgFT8LeVWR/CmB1TttK3s7
 G4HJMBeX/B3uX/Ud8afj/939PrgbJ1hmzeMTXKOjEefeX5fcwJZzmaPof+er57yq4T5TwzYXtSl
 CSUzEf7TdjZC1CrRdc8Yoln7PFr0luR7zKHapY0PSzE8h7ASh/g+xf0aAU0rzowV1//IS2SR4LN
 yDI4tMxdW6iVIKV/Yzwt1fh/mqWAZVf2r1G/2GY7lfM1UEDRfZ/daVFFZRisI3++y7huxx4+dxT
 v2PNi1PFNkAnlG5Kshd+QLGbyk1U1imYnnaKdDO3shhAEXejwo9eeEn4b9u0N4vyXO0fd6X7fZT
 ffD2UseUaAw3yVCDUpxH9mm5EQHD3pw2VcD5s63DaD0xWkL5af6UuxawHeZsugEVipKdVqMTgIT
 WdRHsYeUvjB7N99Z1BudLqZlFza6LQ6WmEivfQhmH7aKgL345OXUuDzghD5Xr12h2Oq2uJxLBnG
 YLq/fF1aJh7escISikfKNR/vxk0clgPd2GoG95LH8zJhDvZdBR+Rp6lOSpL08qutuqWjVRVkbQO
 qbYdF0W+9BO0socEScBudYqgVsZPzZVv8mBG2ORWqUFBg+G6vGTgoQKIXB3NeTy6lP7XhhpzBIt
 Ly+j39W5/3sOGOw==
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


