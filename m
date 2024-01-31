Return-Path: <linux-fsdevel+bounces-9768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40CA844C76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD0A2940C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12F14A09A;
	Wed, 31 Jan 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN+rpYsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F014901F;
	Wed, 31 Jan 2024 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742287; cv=none; b=JJAX52h3Q2wBt/6Kb+j/yULP4hlFNGWcYpVyFTfVXFdL7Eg28jV8BG/b+MDOYOSN81LV96/ZXdX+e4Y0xzT5uWEp6lrWzGm6ynFuefAnVQhnZgzEC52KRIogta9hJG9huuVA98Nfe+v396gPZ8aP1kAIpzjaqlvZSbkRrS0IK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742287; c=relaxed/simple;
	bh=4ZOQeMBtojTDDJSJwWsp0/MVm2972cKMy9b5ij4mRiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0dtdpXfaCAu4sNkZi+TFRa1ia71NwyAdZ48cJjgrN0OvMYdfyOAtc44GG02A7y/xkxcI9cR0ZClm/DaJHDvwPUCzHHXRwD49VFdkCLuqm0n0abUHu/mW57wozzi92DMdVnjHQbevgAiXRGV3l5E2Fb0XtGQcnKPDguWPzgpR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN+rpYsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B989C43330;
	Wed, 31 Jan 2024 23:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742287;
	bh=4ZOQeMBtojTDDJSJwWsp0/MVm2972cKMy9b5ij4mRiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IN+rpYsbZpGNkvIJwRXHa7EcoIMdGwA80JW8UnlKkKb4kq7Ffr3q4PMWqL0ULIbkf
	 lwivmaIkiGjDAHR9GAL099jhknwr9AatyksecvKpD+zVOut/Jo6D7hnHscNqRwBKHl
	 V+slnakP2/XkeZVebx1xUbhEg/HEQi+tuAliTLEEy+ZrlBrMRf4FwIKj6rmPYoavql
	 OogalLWz5tLEhmV0RvOjp4/e05mYxhO7a5CxW/n5pGACmMJqM8Bo9u4YxxiO8ogxSQ
	 wr3MwbGCSKYqMGjt0w+GbYEg2UypegpECkrjdDg6JUInksTKDgW4uE65HiLa8FE3Kl
	 sMSR5lvkj0ySQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:19 -0500
Subject: [PATCH v3 38/47] gfs2: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-38-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4ZOQeMBtojTDDJSJwWsp0/MVm2972cKMy9b5ij4mRiw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFzLimfbNTtjRonFYNlGDxC7udswfHVrqUVI
 KUb3f+hYDuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcwAKCRAADmhBGVaC
 FU2IEADJHRooL+EBsYbvtx4WjjJxjO30AlATfLkx/2BKisoEXYXd5mWYpi3QwGSSx9CxnO+c2a8
 JJkS3+E+g6vyq1B69+M3ow0xHc/4qPl4VV1V9UAAULt2dbHC7I1EN062xw/tei8V0Fpd8DTJQ4B
 QMV1fD7l/cM2Nrq76FshDRf+XCnRU20Tg8dBJ+mXea4F0XMNnTwyEqVS/PhH3ILDzQuwLRaOIDm
 uHCSW+V5toNqdqgaauJV0q4aLNWdIEHRcPWpg2bg/KivqaB0e6kW/WYHS74rLYbqzLmLj3k7ypa
 h7Ue/oZEAbNinJHRmiHfwgMXYrHj56By3Dk3QkQaZtzaVhNJVrL3x7SjnPB39hVv9d6/eByqRRs
 Ga4wds7b1zwoHaVBAJnevfS8/yLVWCUuaFbphyezWO5ECOQV3WlL9kJBUCnHEB9ClfO5jZWhsEq
 Lg5rvxRfVY+BsDJnmonylpP9gNZSVISIFp0RuapdthIYhMrkqCcWuQTlzFCqvdKSBEoTjzetzXn
 RCcc8R8x9QnL8F+C/OQOkfbOkeOy+/vkMTQ3oOIbcmdgjzJFYefc9rOphxhyogGXhtNB1z8OzXK
 7OJRbX7ruo8w2NdYbdOcL0SLD4G/r9+n8eGZ4yP01pLj7SFdjgK1+LcRwRaj8U9dhiE2w/IjbB/
 cnu+K3vRxuFrqsQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index d06488de1b3b..4c42ada60ae7 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -15,7 +15,6 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/falloc.h>
@@ -1441,7 +1440,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	struct gfs2_sbd *sdp = GFS2_SB(file->f_mapping->host);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->c.flc_flags & FL_POSIX))
 		return -ENOLCK;
 	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		if (lock_is_unlock(fl))
@@ -1484,7 +1483,7 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 	int error = 0;
 	int sleeptime;
 
-	state = (lock_is_write(fl)) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
+	state = lock_is_write(fl) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
 	flags = GL_EXACT | GL_NOPID;
 	if (!IS_SETLKW(cmd))
 		flags |= LM_FLAG_TRY_1CB;
@@ -1496,8 +1495,8 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 		if (fl_gh->gh_state == state)
 			goto out;
 		locks_init_lock(&request);
-		request.fl_type = F_UNLCK;
-		request.fl_flags = FL_FLOCK;
+		request.c.flc_type = F_UNLCK;
+		request.c.flc_flags = FL_FLOCK;
 		locks_lock_file_wait(file, &request);
 		gfs2_glock_dq(fl_gh);
 		gfs2_holder_reinit(state, flags, fl_gh);
@@ -1558,7 +1557,7 @@ static void do_unflock(struct file *file, struct file_lock *fl)
 
 static int gfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 {
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->c.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if (lock_is_unlock(fl)) {

-- 
2.43.0


