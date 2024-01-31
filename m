Return-Path: <linux-fsdevel+bounces-9739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA0844BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA97296741
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215047796;
	Wed, 31 Jan 2024 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRUt5zv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8647773;
	Wed, 31 Jan 2024 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742172; cv=none; b=ECwNt9bDJbPmg2EOOK6Lo2sEv4Nm1/2OuR6euNTd1pBCUtx/arhHxcQnJ9N/bkWxEvA4fcOYxTSAsI85b75aWRpyQzSg1FINLA2ZYTJE4LjmM56OZGd8Xrq8O6uKLOgUrsB8xjUx7lje5uO7EFeRYYO0gmXwZ511zfMzE/NuWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742172; c=relaxed/simple;
	bh=6lT/AJ7DI7EcIyd9sTjj002gtwJ758Oz0KnZq2omTSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kb6dki62sE0q/tugZxR6iXrQmAwODzHvZTIQswYph+vPp40faI4Ktx8fevsagYn2MRwIDSq9Jvisums3V+KPXMWUm2+jgMAE0ax/gJ3dLQRvvw/ZWFTxtoAO9HGgXHBA31c0eB9H53wuoIib0+CQjfduk93yU08ZUBFahqWLZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRUt5zv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ABBC43141;
	Wed, 31 Jan 2024 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742172;
	bh=6lT/AJ7DI7EcIyd9sTjj002gtwJ758Oz0KnZq2omTSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mRUt5zv/kraGlqbTxQqaVL/bTh+i6dTpaDA78iwP0gYbEt2134w529lERRv2N2JeP
	 q+Bw+eYnQGvxKrAD6bmt+T2fKnD+uanKifpJMvgQ9L0sncND2Bgw9KYfgJUeuK/NWU
	 eWVTlzcFtCwbOYNtZHkmj4vcDFkTBAkBM73flRcTEnyvXrpf0gz/OLSKrySlWvKOfY
	 U3nIZi8oZx1C6C7NBopDvUubate0vNBWaT2nKbC6LgSb+RzkcWjitAi2p/OKEp47Ox
	 mrVJRhnVV3PAfwZl/nWXYvfoi5oD6/uWWlyf+COaSHmo0AkCeGaB0FNPU2jS90zjnp
	 yMSzhcNX2wBPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:50 -0500
Subject: [PATCH v3 09/47] gfs2: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-9-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6lT/AJ7DI7EcIyd9sTjj002gtwJ758Oz0KnZq2omTSc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFvJm0d1jiXUa8dmKAKx/rdNZx0AaqYhFOch
 7fu7f0iAHGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FTuYD/9u6c1S8nZFiijh2qT6BQlXdfQXeJFmCKu/GmfGttkXK7lIjFM0a3SOgEMvkviKfKyYDWw
 2JCwlKaP2bYEuS52x+183j0KMdOMe0zpKF9bKbvQn+OVK1t2XDW7SJ1tyDUuPXckzN0+tWt6b7G
 UoqSySu+hkcFIDKAR3IDVcjjajSFC16iQkdplc1Offv3dA47viT6jMvYqLqqk4/EGrBDbIrfy5v
 uXds6Niams1hnA2hD0tmcVGHjwb4RLzp9Sr4Jp6GLo7KjbPN6nxAc+/ELFXjDvhzD3bXjwTKMBq
 vaEp7u9a4wTGddT5H7xfiMTrgPey2JiiOQV0q8ObEbs0Y5/OJ7gL/sAddzCcbYPMwlaGmbPO0gW
 Qbfjy50xeArmepuFt4M3jmZMmbHOQBLU1Omwxq1ukO/tGxaielwqy53IlI2p2lrnXJwT61tWqJj
 SrGVThxwxPZcNVQjaD38K6MgF6QbLXf21uSxl3rZBEVWC4oC4chXwGsu3adVIKVb7SZRYsfoZDk
 HdetieVeu1QLgfFk1Z2vHvHi/5Fu/qvy2a5F5DRYzbj+p4vtWRzZfrwXehk97wp0cAl8TYx580i
 doC26gg7e+dTbci3luI4qpG9WEwVYkDI9onu/hmEyt15URo/AaHyT0R8Uvo0vDxGXyif9Xx59u6
 h2QgPHmliPZZfKQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 992ca4effb50..6c25aea30f1b 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1443,7 +1443,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
 	if (gfs2_withdrawing_or_withdrawn(sdp)) {
-		if (fl->fl_type == F_UNLCK)
+		if (lock_is_unlock(fl))
 			locks_lock_file_wait(file, fl);
 		return -EIO;
 	}
@@ -1451,7 +1451,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 		return dlm_posix_cancel(ls->ls_dlm, ip->i_no_addr, file, fl);
 	else if (IS_GETLK(cmd))
 		return dlm_posix_get(ls->ls_dlm, ip->i_no_addr, file, fl);
-	else if (fl->fl_type == F_UNLCK)
+	else if (lock_is_unlock(fl))
 		return dlm_posix_unlock(ls->ls_dlm, ip->i_no_addr, file, fl);
 	else
 		return dlm_posix_lock(ls->ls_dlm, ip->i_no_addr, file, cmd, fl);
@@ -1483,7 +1483,7 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 	int error = 0;
 	int sleeptime;
 
-	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
+	state = (lock_is_write(fl)) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
 	flags = GL_EXACT | GL_NOPID;
 	if (!IS_SETLKW(cmd))
 		flags |= LM_FLAG_TRY_1CB;
@@ -1560,7 +1560,7 @@ static int gfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (!(fl->fl_flags & FL_FLOCK))
 		return -ENOLCK;
 
-	if (fl->fl_type == F_UNLCK) {
+	if (lock_is_unlock(fl)) {
 		do_unflock(file, fl);
 		return 0;
 	} else {

-- 
2.43.0


