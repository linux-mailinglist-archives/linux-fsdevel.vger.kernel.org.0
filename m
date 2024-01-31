Return-Path: <linux-fsdevel+bounces-9731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3C844BC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9173FB2B81F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34773B787;
	Wed, 31 Jan 2024 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoH2lwHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15A3B196;
	Wed, 31 Jan 2024 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742140; cv=none; b=DfXCkU0TfFogZAtacWIUQ6EERkys6QPHA2EGooyQGDJZorBaqB++ZP1yH4wZlJREbH2xEBXxfYS7SWUoovgyyl4odxFrsA82sJwf8iP1vXUrS9P/etIKgc+Hm7TwfSzkJPTWcMeddvYkzjtJzwF93oDCk/lacedYOlmL/wy+s+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742140; c=relaxed/simple;
	bh=ZsIZLQ0us2K9FLtrdhp7YEXH1YcRJz5sXc8n19Ykoxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ox7zyOwUMeeOyodWiwHTnJKtTjnKlsjtd8gRzq58P4vaYfNdHkl56Zd4dKGpyd9otJGyD/AgbYCUOVvYAZbwUmSUUIVKW3tSF6+mjqnnvb7AG215rCFvnuu/c/ifzIrmSumw3GIBKjKkXyI+XYJ+FKfuqs8q4vnkb1uVxLCaK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoH2lwHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A39C433B1;
	Wed, 31 Jan 2024 23:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742140;
	bh=ZsIZLQ0us2K9FLtrdhp7YEXH1YcRJz5sXc8n19Ykoxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aoH2lwHrZ4+Uc28Q0uNstT5t2ovjywOZvkaqMDcg7MoO9n/iseGx7fdluHBqeoYF1
	 fwbS6xtE2rRe9qDclzl0rI5fG/8TEKD+sarg8/4YMx6l1PSOBdDDtQ/vrrL2ibmKTg
	 wGhGb2PgLZE88xK89yGRcZYxx0v5wsXmEKyD+SywGrLjKB9UtomDdUTMd3Yr7QD4hG
	 DMRpazhAESX3ga4Bh9DXg78nQFJek9OykCCKN8WypTgYhOw320qc6a61ON73jqqvxj
	 GQW3E6hcqzhTM11Bvm9NjEM09y8ny4vToWVvDYvqexQwKfaAxgtil0+gSuW29IGDuE
	 EWUIbpp3++jqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:42 -0500
Subject: [PATCH v3 01/47] filelock: fl_pid field should be signed int
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-1-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZsIZLQ0us2K9FLtrdhp7YEXH1YcRJz5sXc8n19Ykoxs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFut0ryceF+dakVLeG3gaOZu3vhcmHLFjyaN
 DmgaT5qS9KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbgAKCRAADmhBGVaC
 FdNsEADFOMllI7HXTx2HaT4BcWbSFfuwUEUaiWb0QRL6ZyZ9zME0/kYCl/8EMBQm9Sagbyxor1F
 OCukt+Jbsmnul+bXGs4Yy3oUEb5PAq/m1SHdFgHGJp08nE7Sa8eyicb0OPuBVIK1ZIjITnQWvjf
 Oc7lLJlKV6aHttteI2ZBRvaR73pvP1UfZPBBY8AV1dRkohJ3TUCS0R3/POZK8BX6BTRKGI6h35m
 6ylv1crevVIfILeYh52EdATPwjqCjesum1FdLdZSL2F5IA3vNWrxB3hYVrANne0GtsTnSqWw77n
 CBibfVCC6I4gKbjFP020S3Cb/Ct/rQ4V/7gY4lFuDfOxBlm9wRgnQrGu39osYkShH5QigEhblwM
 fJ2NXSE9FszB4p/QpDfu7nklusy0f7xYaolhlA82fNA0VrfszP5VFnlmNzds8wS7zZVSDU16CFY
 ziadnd3qeNZDM4KMuEtzL5NMdWiVuokF+br25XWcMqJxlC0oV5wbA4haV20yVCqKwx9Vl/w4Qry
 YZCddWvGEjAlbzlZIYcvE6HNWbAj3qHJ3AzrhZ3l7kJ5BuQ5WqdqNm8qsX609byBpsFhpEOSjbm
 hrK+7GkPJMME2KWGiPhIlTHdyhLyQV26xLtITBvLok9L+gY7DR+lBSwy6r8Lezsi8L78NPisNTd
 sb6H/2xHD7Dnh7g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This field has been unsigned for a very long time, but most users of the
struct file_lock and the file locking internals themselves treat it as a
signed value. Change it to be pid_t (which is a signed int).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/filelock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 95e868e09e29..085ff6ba0653 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -98,7 +98,7 @@ struct file_lock {
 	fl_owner_t fl_owner;
 	unsigned int fl_flags;
 	unsigned char fl_type;
-	unsigned int fl_pid;
+	pid_t fl_pid;
 	int fl_link_cpu;		/* what cpu's list is this on? */
 	wait_queue_head_t fl_wait;
 	struct file *fl_file;

-- 
2.43.0


