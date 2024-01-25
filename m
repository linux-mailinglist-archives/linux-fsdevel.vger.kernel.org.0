Return-Path: <linux-fsdevel+bounces-8875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2383BF44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A71F270A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128945033;
	Thu, 25 Jan 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpwx7wP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE845025;
	Thu, 25 Jan 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179407; cv=none; b=lVy9F/AJ8kCNUXXktq1npIjJsqFAj/DusjyTiTPaCPM/MmFAYrWMiBJOQe7w1X0cB0WrN3RJ4E9fgpPASvJWV6tXb79aI2EaXi1i1yV5Kgn0+iL995x/Nv1kArG/ZUSjQ70zvjHua01luF/IjU8Lktnh9NGI8kK2AmHBz8hlbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179407; c=relaxed/simple;
	bh=+4M6T+k2C0cQ+WFh3iNf7iR7sMPN2w2MqFWDMSVw904=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3XzZlKsnk9CVSRHaxBNqg3CeOBuSz+nNJ3rMRnOnzwyhUjZa7VX6Row0OZtER9cbM2+IGpcdiZ6hMCX82Wa+H3ikvnfPmMLziEueo+VHOVMPFdqpTzsPdDpg4d+r1YmuvqrKQzvZ1qWJjvsjiyTRwHl7K2V3/WkbAqEtygCfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpwx7wP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2426C43609;
	Thu, 25 Jan 2024 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179406;
	bh=+4M6T+k2C0cQ+WFh3iNf7iR7sMPN2w2MqFWDMSVw904=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tpwx7wP2VA7YKWMB2O+JJsxglfesc0hWtkPusegJ9ldc5at6b7NeZtTtpH7imHdk+
	 Z0r6/nPj3VGv+tpoli6QmVEx0VEZyJIJLGA07F7L+mkbvDDFqHmM88+8km8+E5Y1GZ
	 OMxiNMuaCWymffjCsf72vHyuND0u4wgQHkeSmS1nNxcRKQ1DaKiA8MOOo2yKDdZOUx
	 6PpyMeZtZVhwNEnZSWgdVqoc5nJvHOAnC/RzDRMEFPn5GebByGJudVcvNG94yckYIx
	 SiBZ3meedUu2yvHQGsT2aVOBTeiifly/G18LkzfQ1y+TuTgVymBGM0c3xY1rxP2XUC
	 VyDqIbbfr00fw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:44 -0500
Subject: [PATCH v2 03/41] dlm: rename fl_flags variable in dlm_posix_unlock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-3-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+4M6T+k2C0cQ+WFh3iNf7iR7sMPN2w2MqFWDMSVw904=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs6RsDWXNzTUUVoOvstUEH82Iss9jJB8Rk5G
 XnlZe9DCjeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OgAKCRAADmhBGVaC
 FZ8+EACATg0lUdCqVXrzJONHHMrtX3P7yp+kwAwRpR8GH7c5TtttYihIuNExewt3BWjoQW5O5BM
 6STBl0yYChve/mfjqXxImTkfR7JqMM8RAOCc3p3NPpzN0aOgpVQNOl3Z27z8AmguA/rxnL2e6GD
 u9kPBSYw+taNY1fXLEksiUKLfm4rAigWVfMncHNiSNA4ebTDY4wtjNhxBQRIfKNbRZQptkGXrDf
 vpRon0lrIpJ5BeQFGuWlBxUN0B6x3L9B8lLCThrQDkQYK/ElCI1gSbEJdnNuilpO9jT47A9I+wc
 2Ia925naPlnh+wY0ST/X7I7azuXW1ZNwh88IA69cacJndLrLg20qMnOYMRodiT1LzYZ7nnb0jEN
 r5FYm8aGt1QQuYV/ldsgGbgNOB8xEIN4EGa9YIHE1Wh6CltsfM7GpWXJn2nuNICoxaiCCbqnnkg
 4R0fy6ineQjFKHhnWZdCt0z1BKN9qNM+xMCgQR6oo1XSnhgI7s8oVfDbBMBh5J5r7slMjaeHfWO
 kMpoLqz6c7oaV/Crbfv8E/AufPI0EJO7Ft7Af8Q7ZjfwpgqL+WrXJ0H8ZWoxGrZTfb6TYSkGLdO
 FhiIFsu7gpBGX0djLx2tErYudDnF8c9Xr7KNn/UhCZ3TivOzEcllGMBADgOw7GB1lL/JXnwSBlW
 1txabrilKYDl3vA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to introduce some temporary macros with
names that clash with the variable name here. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/dlm/plock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index d814c5121367..1b66b2d2b801 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -291,7 +291,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct dlm_ls *ls;
 	struct plock_op *op;
 	int rv;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char saved_flags = fl->fl_flags;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
@@ -345,7 +345,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = saved_flags;
 	return rv;
 }
 EXPORT_SYMBOL_GPL(dlm_posix_unlock);

-- 
2.43.0


