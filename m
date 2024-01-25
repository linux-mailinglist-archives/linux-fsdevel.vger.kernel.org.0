Return-Path: <linux-fsdevel+bounces-8888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F883BF97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773DF28D482
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76A6026B;
	Thu, 25 Jan 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4Ih6SnA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853176024A;
	Thu, 25 Jan 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179456; cv=none; b=kUKYxaVPLbJdqF73ZIAXC44WiJqzwcXlgj2gGByRClXzrSGMl5D8MmCtd9kQKDomfgdCdeqqS7QElNM0zDX1Cehu+uODcUyNbT73f4IFDDDBSMHy9L8rVZmZ/55bW3Fwe6UIMtkXeZX2OcpY/xkpzxy1P0Orgu5KzP0gwiuVh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179456; c=relaxed/simple;
	bh=xSVfPHaguydEBPpPQLuNdFuo/APap+U5zYROxyDf4gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gx0k9yW6XZgvJQTYzBzALDyaYGzC8L0pRtwGVKsoOsKn4sORkYB5lAhxds0Fh/TUHjm/Qcx9PiWUu6bH/326WGGyVY+eEQyEnpy+YRG3+C++o79SGlgrIPKuFpOZ7al9j3ftmDNYOo+Q1/mXgRNSToWGohXR/LdsYANmT0mDNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4Ih6SnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30A9C433C7;
	Thu, 25 Jan 2024 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179456;
	bh=xSVfPHaguydEBPpPQLuNdFuo/APap+U5zYROxyDf4gM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W4Ih6SnAyrmlL/pbQq+dSbWolzHvXP3cFj8zyzzuSPNDYq2GQJrkhnBV+NaTUBZQH
	 h3Wf/hISbHwISlUm6TOkbEraC0blxZ/7s+aBeUQOVA6jU+YPFh2GnrG1LPhpnjdG7p
	 yh0Vd9sOUVwLo0MWI+pST/9C9USADJdsr7jH7sqNHKZY34XOHqUr0rjuBVrxnbenx5
	 Vaa0oDCjelWWsesqrn4Rb5OUNcp+4eLwwqviC6KRTZ2OeX3DfaCmM0WgIZEyGjLdgz
	 amHUq7miwssXF9D+VUL4OkUG5A10nJHIKQ9k7tcHreHKYNIiNBTEljhsxWp8O8NaZC
	 JwcFGmjc2HDQg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:57 -0500
Subject: [PATCH v2 16/41] filelock: convert posix_owner_key to take
 file_lock_core arg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-16-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xSVfPHaguydEBPpPQLuNdFuo/APap+U5zYROxyDf4gM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs7kqDnVp6EIWs+kAfd7OL//ENkspIJLKDt3
 pgw/e/sksmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OwAKCRAADmhBGVaC
 Fa02D/sGkJvM0+1Gyqi9Ahb0gvaTr36ipvatPN8+hUBWAXsoQZcjQxmC+JnWo1I3LWtN2+B4F+x
 cXSFkYnNbCoo1IcNGi0rNpF6t5pfIfvjWI8K9b5PBgCErLUxwx+eiASCliblkPDkyDzn09w/aOZ
 3Mm5YH9A2OdKFlhcxg2qebsKYrRuXJ+kQJCOQIcXI4S3/RppUctxnP5UHwzHlQU2WgjbYZgq+7F
 nwanSumVKmXsQ6oYIji10GDmY7drFXM9OXjobNwbfp6qSQ42ggNa4UweNy5ilTI35ZxVbVU20T/
 FOnbo10FdAxehOnK0/a4kC6fiKmCgCSn2HZm/skxGegjdhwsxT6DicpgJrvJ/gY137A85PM+Ksh
 050Jo4sJMagHZRiafNZMutlGOH3jZkKsk5PulPWRewnf6H6r4YGZnLeIg+we1p0BQDy3kCH+LSG
 s22oa43pKd5WCV09AIpxFL87sd42SNpzozrYFIDKEOriNV/cIJBMfG/45nkZ6na9Qux8X6z1Bk7
 G6jqL29FH1VleuICm4oSXzwmCHocFRp9dRqWueFSH6vdjI6mKablX7fvqsgGOr7mUnFXurQG/67
 +F7ZMaCW6ELNY62DhjV2KGTLueHj2gIfs7Fkr6DIWI+Lk3rGp2Sh18MKL9ecZwSPQ5hYLrF9IqU
 Z5m2GRlSph+9ejg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert posix_owner_key to take struct file_lock_core pointer, and fix
up the callers to pass one in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index bd0cfee230ae..effe84f954f9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -630,9 +630,9 @@ static void locks_delete_global_locks(struct file_lock *fl)
 }
 
 static unsigned long
-posix_owner_key(struct file_lock *fl)
+posix_owner_key(struct file_lock_core *flc)
 {
-	return (unsigned long) fl->fl_core.flc_owner;
+	return (unsigned long) flc->flc_owner;
 }
 
 static void locks_insert_global_blocked(struct file_lock *waiter)
@@ -640,7 +640,7 @@ static void locks_insert_global_blocked(struct file_lock *waiter)
 	lockdep_assert_held(&blocked_lock_lock);
 
 	hash_add(blocked_hash, &waiter->fl_core.flc_link,
-		 posix_owner_key(waiter));
+		 posix_owner_key(&waiter->fl_core));
 }
 
 static void locks_delete_global_blocked(struct file_lock *waiter)
@@ -977,7 +977,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 {
 	struct file_lock *fl;
 
-	hash_for_each_possible(blocked_hash, fl, fl_core.flc_link, posix_owner_key(block_fl)) {
+	hash_for_each_possible(blocked_hash, fl, fl_core.flc_link, posix_owner_key(&block_fl->fl_core)) {
 		if (posix_same_owner(&fl->fl_core, &block_fl->fl_core)) {
 			while (fl->fl_core.flc_blocker)
 				fl = fl->fl_core.flc_blocker;

-- 
2.43.0


