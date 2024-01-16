Return-Path: <linux-fsdevel+bounces-8096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84082F70E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C50E285136
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128806BB3C;
	Tue, 16 Jan 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdIgnA3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF46A343;
	Tue, 16 Jan 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434411; cv=none; b=EPDh47pLb8mUmPE3ew2h0XJGAtHcMh9ekvmQvJ8+loyN567dZVqk3Gp/vjYOaox2QAF3EMUoLLa/33HmKMG7XozgpS7lcRBIBIy9KUnw/rX6VmTgM1uG+/8snWUfMExm2yM7p6NAQ+u6hrsPn42ITIYO/iW3zZoOJthpqP8/DJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434411; c=relaxed/simple;
	bh=YjY34dM1H484nLiPhaWW57Fe2QttFCAJUqyuIWnNlwk=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=NSYCohscd1I1IXFgwfzPGmpozHsjN+cO0IENNUOONGMs5KpfHT9/ZbQFr92vAn1UAXLoxcSQj7GNMk0pgnOFZ668gw5rRLtv1WPqdNgrepVeEROTrLmx2XqgB1pphRZYOAIyrti9eMpjSKHBLb8oJZJ7cwngsbyCW7ifplXqx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdIgnA3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C20FC43394;
	Tue, 16 Jan 2024 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434410;
	bh=YjY34dM1H484nLiPhaWW57Fe2QttFCAJUqyuIWnNlwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cdIgnA3S5spCJgft8bPEQ2cSRTib2CYHHHVTd9QZbp7rSSRir0PSNW/5pJArEoBOp
	 CCG7ZV4Vty+k0+LnwzyzCXPuNbf/8D+kc0cn1XIGDhoEK0V9QjYdH3xj2RkTgSl2lb
	 nKJxdH5EQfZYvkItb+H9yEGXstuSVAYobGuep5JUV2yLZ8cuGe8ISrjja2efG0L1CX
	 eUBZRsaNMBemw6nMOEd0JDq6UsttMvH0N8yJg9jh2A5zGwnRNRN9QzvwuzO9M43y8K
	 Epuiddlc0Ogss/9Cuf5AY5kKRT6sacFBhZXaU3FSGvGhrWvuz+Z1m0l7ChNftHZ5/j
	 4nucu9vZGs3EA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:45:57 -0500
Subject: [PATCH 01/20] filelock: split common fields into struct
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-1-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
In-Reply-To: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
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
 Ronnie Sahlberg <lsahlber@redhat.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YjY34dM1H484nLiPhaWW57Fe2QttFCAJUqyuIWnNlwk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0grorncqc9kLnslpuIZeyPyWu2iH2b3i5B2
 QhRt5u8LPSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIAAKCRAADmhBGVaC
 FbMvEACDnTZd0WkyKZFXw33wk0c2b7uo3MRrbTaAJ3SXB53MT5tXPsMrx/2rbi364MuRnoPP6bi
 Ys3m9vycKLXirGtEGtajbM2rYOPbebP7S9O+g1VFohLR1yLsN5joqExpg9aENC5dPj/lNHnSdr9
 75WIVLpf7G0qyG78AxC9PJuPduxUntrA1wqjADiLA90eF1lozTSG9oLqgqpQ6VMOBwd0Kbs0a5i
 NDCVod8SRF0fiNddU9JOiAdT1FDgumShOCW9PUCd6uU5PV0N0dLx6JHt+7PTVPYoLT3lssNET7u
 VAWTej8G43paeJujEHZDrxniexM9BSVGH8c9xjv/H6lwcsOHrK2oYuNDvd7yDMty+3zHYgY62TT
 /hJ/tchNR3PxSGmvY+aeE4i7yty4fiJh0enq1fG/6/BPMvrpK0LqzHM/sLb4p8L0/7er89TolW/
 8m7NYvGWmzilgVDsLPfyaMzjOeP+YiFRh5XSrCh3Cq1tNsfW+6sr4MAucKQLcLXaxE2PQ/wXVP2
 RVo6Q0PshEsg48lhuMGKOuyTjoKvVODmGMHNO92/xDemnCiZia4nc7lTSD8Px72ehl7408vGs6g
 amJflorwhY/bA5eWVETGdMDw7nt/06zb8dMl8qmXvG9sz/S54+3MvlnfNH842ZBqeaS3lrLhWLC
 n4OPtwY7WrvAqgw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In a future patch, we're going to split file leases into their own
structure. Since a lot of the underlying machinery uses the same fields
move those into a new file_lock_core, and embed that inside struct
file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/filelock.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 95e868e09e29..7825511c1c11 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -85,8 +85,9 @@ bool opens_in_grace(struct net *);
  *
  * Obviously, the last two criteria only matter for POSIX locks.
  */
-struct file_lock {
-	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
+
+struct file_lock_core {
+	struct file_lock *fl_blocker;	/* The lock that is blocking us */
 	struct list_head fl_list;	/* link into file_lock_context */
 	struct hlist_node fl_link;	/* node in global lists */
 	struct list_head fl_blocked_requests;	/* list of requests with
@@ -102,6 +103,10 @@ struct file_lock {
 	int fl_link_cpu;		/* what cpu's list is this on? */
 	wait_queue_head_t fl_wait;
 	struct file *fl_file;
+};
+
+struct file_lock {
+	struct file_lock_core fl_core;
 	loff_t fl_start;
 	loff_t fl_end;
 

-- 
2.43.0


