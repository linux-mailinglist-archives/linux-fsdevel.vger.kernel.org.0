Return-Path: <linux-fsdevel+bounces-56080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D1B12AFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66902AA1005
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC59288510;
	Sat, 26 Jul 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYAhKQfY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC42877E0;
	Sat, 26 Jul 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540327; cv=none; b=MuIkj9JdCwemd5AmMiZyQu2b0T/ozAlzAKxodIXhkgXto4wx0rFjVH0aolmd2wpOb8VN/uUWFq+3teTU50ltweO9ZwiCog4Z3klxyiFLCHogP0p1igH2Q7uzqnH4E0y0L+VL/B4IjuRetWJWI8oe/Mjumya/DQO8Dd7HmdCerPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540327; c=relaxed/simple;
	bh=r7yx7kdAf9pxTUof3VEIKP4LhrLVZ9kWufEdB0iUHls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biFkwKzyXzLsEapc1FWGjkGXt1HzwLdgoac4LEOcwcAR9e0oCE56c4QPHMviEt434P+gtz5gypm5IHkGNXDG+xpvYTgMZSLfzTFNkAXVrKCRLW02ch+CkSw6qKBYlq+f5PUoaEOVQyobC5lWXkAvLIF/LrtHlgoQKUaOtiGWLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYAhKQfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16915C4CEED;
	Sat, 26 Jul 2025 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540326;
	bh=r7yx7kdAf9pxTUof3VEIKP4LhrLVZ9kWufEdB0iUHls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eYAhKQfYLaWJJIW2vTgjBAxhpvSohOab1gorflzrwg1bpCMOVC5BB4ieC5Eqku7/M
	 /hthPwbcyccbfWdRmxX1baPIMIPGkIeMnoIdfpSLymwXKWf53kO8GEuaegmis1GFFl
	 9c468wlPH7YzUNOA86xgVZR1NJcLsC7t00hU5lWcxj/8V880JM1Icg2/EI2inPHDmq
	 t/9g5SuIf+PmOTeyUa3Wbp25KO7mxoxE41tNUit0SVQ0lvBaZk7iIUFrIyG8ghJ2ge
	 WAnN6Ur/7Q91FgNsJ/Kiai1UI4C6EwyjeUWQeC7dEQvnFFTN6l8b/fvog9j3/kCzPU
	 62RLlN/wA9gNg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 26 Jul 2025 10:31:57 -0400
Subject: [PATCH v2 3/7] nfsd: use ATTR_CTIME_SET for delegated ctime
 updates
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-nfsd-testing-v2-3-f45923db2fbb@kernel.org>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
In-Reply-To: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2843; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=r7yx7kdAf9pxTUof3VEIKP4LhrLVZ9kWufEdB0iUHls=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohObf2Vk5RtZz829UGIYhS4geaSIcO/cmG2btM
 xMG2I4f7baJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3wAKCRAADmhBGVaC
 FUpnD/sFt5m266+0u4xYacBrHpiT5Hm9BthrTmud/ZVyyRA45+v5LCTiQqSc1mWZD10AP5GzcLA
 rjQI99t78z/Ilnc9g0Px0iX1wdWr8xtwSkCJK4+/xqRdrF48Br/2k+NDkgMfas+ogVuNA1tFeas
 p30m+LxyvFelYRX47vbhjELBtxskRiFDRNZYk5UwyZu9UoSV/g3BpKEqhIkPB8WUhtmFJMbUE2T
 wxHoj+DBtWw5LA3fm0KgxJUwqBjEH4onJLtKqlOSBa1sU5anvy2ole4Ykpfcw7YgIJbzKj2wUHK
 QB91lxbZnMC1L//+hZ5cUNwUTps2nMgoR/UugYst2+hE8WDGfkn+AFcWVAl+6ZEL5ibwlk4937b
 O9HD/LbUFZNe47bw6VtYsEHBZMYuvXAwluz2a4NaDJ/8DX/oBw7fqJ6tFoYQ+7wSQT9svPIbs9o
 hM556QM3PGLK1siMTnnMDQobBQz3Ws2cGhMnGd3hGIpFNZPUJjX4PGEDI8Q47IcpLUEjQt7PEvY
 WvW1KSjhB2FdDs/7PMPTs7X5bXM9JLpUkPvhJ4ThFkvKuaC09hxa2HtEn2NVDc+65NYKj1t3sSq
 Yz6nJTiUWusl71fjmI4Izc7Mzh/VZH76fcth9Ruu3ueeANzz+PqZuTkJi20gZo7/PV6jE4l+jYM
 KQqMVurViy6SXgA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Ensure that notify_change() doesn't clobber a delegated ctime update
with current_time() by setting ATTR_CTIME_SET for those updates.

Also, set the tv_nsec field the nfsd4_decode_fattr4 to the correct
value.

Don't bother setting the timestamps in cb_getattr_update_times() in the
non-delegated case. notify_change() will do that itself.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 +++---
 fs/nfsd/nfs4xdr.c   | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88c347957da5b8f352be63f84f207d2225f81cb9..77eea2ad93cc07939f045fc4b983b1ac00d068b8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9167,7 +9167,6 @@ static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
 static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
 {
 	struct inode *inode = d_inode(dentry);
-	struct timespec64 now = current_time(inode);
 	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 	struct iattr attrs = { };
 	int ret;
@@ -9175,6 +9174,7 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 	if (deleg_attrs_deleg(dp->dl_type)) {
 		struct timespec64 atime = inode_get_atime(inode);
 		struct timespec64 mtime = inode_get_mtime(inode);
+		struct timespec64 now = current_time(inode);
 
 		attrs.ia_atime = ncf->ncf_cb_atime;
 		attrs.ia_mtime = ncf->ncf_cb_mtime;
@@ -9183,12 +9183,12 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 
 		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
-			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
+			attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
+					  ATTR_MTIME | ATTR_MTIME_SET;
 			attrs.ia_ctime = attrs.ia_mtime;
 		}
 	} else {
 		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
-		attrs.ia_mtime = attrs.ia_ctime = now;
 	}
 
 	if (!attrs.ia_valid)
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..c0a3c6a7c8bb70d62940115c3101e9f897401456 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -538,8 +538,9 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		iattr->ia_mtime.tv_sec = modify.seconds;
 		iattr->ia_mtime.tv_nsec = modify.nseconds;
 		iattr->ia_ctime.tv_sec = modify.seconds;
-		iattr->ia_ctime.tv_nsec = modify.seconds;
-		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
+		iattr->ia_ctime.tv_nsec = modify.nseconds;
+		iattr->ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
+				   ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
 	}
 
 	/* request sanity: did attrlist4 contain the expected number of words? */

-- 
2.50.1


