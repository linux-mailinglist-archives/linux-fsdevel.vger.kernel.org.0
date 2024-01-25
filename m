Return-Path: <linux-fsdevel+bounces-8885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6783BF82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E0A1F2A371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A845B5BA;
	Thu, 25 Jan 2024 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMxlmMVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503455A7B9;
	Thu, 25 Jan 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179445; cv=none; b=Y3U2DrBq0nTeQM7+2xupGRq6gEJ7J1+bb5FGdVn0T/aaHk2wWrUzUMKCsU4cOb+NMO0q310sdJ0hKSDEVylcW3k7BNjlD5nlJLnAp5WjBnuqZoregtfQ9LO0RPVWArnN+mAMnjg+9Xr1EFuKmJiu4Yji40U/bPfWNwVDyahI2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179445; c=relaxed/simple;
	bh=d1wKW+uOYNY5LucFFfJnlWA/GEA3kZuTsZ+64BbFtXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouap9TiCXJ5O14aoHIn0A8YXhiMwzGWysUHOiua9Wtaj974G7QHImtAnvfiGqyOHglzYvJptTMWItkMJRO6Yvv1yOC8o10oYMxD6rs5dwoyHvkVs7E7exGh6lZWKx6hdiQqKY68mPovFAZqGTFioyYizNFYAvz//Beib199Nurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMxlmMVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC45C43601;
	Thu, 25 Jan 2024 10:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179444;
	bh=d1wKW+uOYNY5LucFFfJnlWA/GEA3kZuTsZ+64BbFtXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qMxlmMVlr+sx0G+5jYEGTmCMCmLXbpAmumPdwe1FuJxm/RZQvGSUyEHnA7z88O4Xp
	 5z4+lHtZlnhWAEGCMdGko2TBEYQM9rEZymHTyrMEDHAcq1tSiAXaY4EaoBCXB2/x16
	 iDWqU2v7/ZpZKT/AyPbzDgS9OPLmYfkd9eByTHHCjFd8CYhGZbCaYGuxP1Kb6FmUz8
	 gMpsGCBBuijPmxxYKGk7y6olSSkU2lPDffilNVS7kexKoleGoX/g8S+uXy98Cl+R01
	 qjUdwjaFKhKkUc3CQqK15x+/C3KSAWezBEjGVeFyOG0s+aSIUw53NUdhHFfAsevka7
	 SWXxFvTAmx6MQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:54 -0500
Subject: [PATCH v2 13/41] filelock: convert some internal functions to use
 file_lock_core instead
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-13-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=d1wKW+uOYNY5LucFFfJnlWA/GEA3kZuTsZ+64BbFtXA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs7ijG032NvpXqx5U1Ss+bt2Ge4+GPeuITEP
 GeF6qbAiWuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OwAKCRAADmhBGVaC
 FSNOD/9qXTZbLpJya3G4IjPbYhlbEysVgVafUDB2353dfD1z/X2Am6wgPdxzKN6vPuQjOuhEO7e
 9zBKt2po3GMQp8xGjYAZuAE7JeE+3LRVdrQ8IBaLRYNsgKLTh3O6RmYUzp8At22UiX4jCYrofh7
 32mknwkIE2i2wZTP5hOqCtvReTxTJkzgIHtNrJO0lk3YOhDHSw0Gasf6P5EJ+eAbc0mDUWFHd48
 pyA/ISCTjDN//TfFU8IAvqFBbKWfXGlNiofzwkTcGrQ0Y6Vnf1qonC67f55p4dyXX7M12FPoHMF
 V4rKAMARCiADhnaWch3EjsWDRAe8/bWGBWnjMFJYxX1qdJD3o3Ep01sUkgReT0MD6pJ4IJGUSj+
 2xpwZ6NTeT1PYiTH+mXFBfoYm1XesOLG09Bq1mUCQkE2rMr2+1OZMpYKGSK7j2nemyzX6yZCAXR
 9c+pZlXL3bOsWvY/vb3N2Vcxorq3M5yl2Mc+458mEeHINSbuBgMz8UwMjRoaQMG29VTp2LJo5va
 98ygDCtu9lZkVkNdvukbq4NeUAt1miFsHLqULiIojpWi1ww4b7ApwNV3I18CR0ZrDDMUQCtcLjt
 Lyal54J+bY0tfXb14q16bqkPcw++chZUiz966wHAKhD2+UiwnPCDc7up9Q7lYCCEJscvJd2OmhO
 d9pzWkXc2eE4f+Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert some internal fs/locks.c function to take and deal with struct
file_lock_core instead of struct file_lock:

- locks_init_lock_heads
- locks_alloc_lock
- locks_init_lock

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b06fa4dea298..3a91515dbccd 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -251,13 +251,13 @@ locks_free_lock_context(struct inode *inode)
 	}
 }
 
-static void locks_init_lock_heads(struct file_lock *fl)
+static void locks_init_lock_heads(struct file_lock_core *flc)
 {
-	INIT_HLIST_NODE(&fl->fl_core.flc_link);
-	INIT_LIST_HEAD(&fl->fl_core.flc_list);
-	INIT_LIST_HEAD(&fl->fl_core.flc_blocked_requests);
-	INIT_LIST_HEAD(&fl->fl_core.flc_blocked_member);
-	init_waitqueue_head(&fl->fl_core.flc_wait);
+	INIT_HLIST_NODE(&flc->flc_link);
+	INIT_LIST_HEAD(&flc->flc_list);
+	INIT_LIST_HEAD(&flc->flc_blocked_requests);
+	INIT_LIST_HEAD(&flc->flc_blocked_member);
+	init_waitqueue_head(&flc->flc_wait);
 }
 
 /* Allocate an empty lock structure. */
@@ -266,7 +266,7 @@ struct file_lock *locks_alloc_lock(void)
 	struct file_lock *fl = kmem_cache_zalloc(filelock_cache, GFP_KERNEL);
 
 	if (fl)
-		locks_init_lock_heads(fl);
+		locks_init_lock_heads(&fl->fl_core);
 
 	return fl;
 }
@@ -347,7 +347,7 @@ locks_dispose_list(struct list_head *dispose)
 void locks_init_lock(struct file_lock *fl)
 {
 	memset(fl, 0, sizeof(struct file_lock));
-	locks_init_lock_heads(fl);
+	locks_init_lock_heads(&fl->fl_core);
 }
 EXPORT_SYMBOL(locks_init_lock);
 

-- 
2.43.0


