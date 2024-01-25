Return-Path: <linux-fsdevel+bounces-8877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB783BF53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13AA1C23B88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D264F88E;
	Thu, 25 Jan 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TENhNdCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4E4F5EF;
	Thu, 25 Jan 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179414; cv=none; b=V2ef0jIS4LS3u/Wy6ItmtmnqFY3TCYN1ttV8U7vRep3WphmnfDrKWuleAG7XfZzI5EQV4AhFACh/v9aPGtOdsadBMU57FzLJktOwvuY3HtLHFuG5TDnQHKbGR2B6eZpq6LIC8FM5kLEyJ6egL+qWfe3VfcWD+HS7cQOeeQMDHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179414; c=relaxed/simple;
	bh=67tgcGcBr3M1TKgZg1fl7B4O9bsOgbylOGJue3HCOI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lB/70tJAr2ky6YwMetVh1cVK/rUpPMK5i3yeUv45fJ53HOPukpiED2n/tmvQFKpRrvvEnDMXYwv/pmF32WYcD2iVgkBZW1Bo6P3Byy2SyXiG1/iZB/wXTdMZEpRvaeKaROBPhBW37qf1zm4H/XGV081Wlk445hEcmsm7Yu+L70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TENhNdCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E521C433B2;
	Thu, 25 Jan 2024 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179414;
	bh=67tgcGcBr3M1TKgZg1fl7B4O9bsOgbylOGJue3HCOI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TENhNdCkl3LbP8J7Y5pctGbi/MNsppzrVnjbWKN0uBVn9ve3EgR34dZt20ExdjbRv
	 3hQzATNpCUaLmdqY9OMsKQy2235DhJGtxxTPs8Kf8Y1dMcR+6u9ffeBq+4nQiirB/S
	 V2akd7YivvP7kTcGxj504iTkLR00ebi4W6ORJR0+FLZIHGQiz6adES7E66nZWBTUA5
	 Ys92TDgaIF6UXtbBJt3tLlwW2J1nu3FZn5QM/cTYSqbdxwIenE6YO0De8COSaGg6Lo
	 FC+8lRjF/Gt6bAnhNYx6jhrboS5ti62aco3Tt3ZOpGdowtU86kqRfWZq5386BNB+ul
	 DmGZ4vyO/Lulw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:46 -0500
Subject: [PATCH v2 05/41] nfsd: rename fl_type and fl_flags variables in
 nfsd4_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-5-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3667; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=67tgcGcBr3M1TKgZg1fl7B4O9bsOgbylOGJue3HCOI8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs6bAIQhNU0/UBqC4/mSm3HkicBp81Q+ncaK
 rM0HwF9VpeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OgAKCRAADmhBGVaC
 FRmLD/4waedvLVnPXKBXKI+UTKPxVA4gJHs881wNp23UhynANp7YSTJZl/KiMkrL7LTlsSxWGAO
 RnRRGrdoBX2pJU/nap8iMzSWsyIlFsrYH8ROwRey8e+YdVFEZjZthtD/Rqasds1hRXnAYtEiDPC
 qQDqtg8ilPlPXr+JAkYM5yJzlj9UPktBTLQ9DS2E/n0aAL41nelC1ksT00mVHUQ2As43h1IFIeY
 LuFu5VEdsC4e/7LvggeitNQ3AK5c7siAoaUj4OUEbO7ZjLGm4ATTZ/2e+4vxZmUFbKM3RfmtS7a
 LH+dUVtdlnZ6lRtGisG5mK1Dmq21LZXAwF9czIJu8aaNrKNKRo2roKY2OV+mosGQ3Gh3aYMupHW
 KffYGjzDTs/a94AAeYXOpFmWs/OcLiY6yS2SWwaaHgsf+DFkoZJ3vbP6PziPotO9sxyaAS55mGQ
 lgCoTEuCIPU/yHAtXHKuZQXI1cM16aWQpzFK75aZnT58f0E6g523b+DAoP/82oRpJiFvpGSFPCX
 Mu8/GQLG89N7ylyYFtwBGesEOy+xbq9AdK3QvIn9rgx8UNopISgAJ2/ascibtzUDkGWE0Y1zHvX
 JCuNP+AApEPqL/dEnXAxMVH3v+U3Qp//L3liMqIXuKWDr+mw+ik5J6zq0ylgeOjoTnXpcua8PPw
 yhknNJW6rxKPh+w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to introduce some macros with names that
clash with the variable names here. Rename them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2fa54cfd4882..f66e67394157 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7493,8 +7493,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int lkflg;
 	int err;
 	bool new = false;
-	unsigned char fl_type;
-	unsigned int fl_flags = FL_POSIX;
+	unsigned char type;
+	unsigned int flags = FL_POSIX;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
@@ -7557,14 +7557,14 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 
 	if (lock->lk_reclaim)
-		fl_flags |= FL_RECLAIM;
+		flags |= FL_RECLAIM;
 
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
 			if (nfsd4_has_session(cstate) ||
 			    exportfs_lock_op_is_async(sb->s_export_op))
-				fl_flags |= FL_SLEEP;
+				flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
 			spin_lock(&fp->fi_lock);
@@ -7572,12 +7572,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_READ);
 			spin_unlock(&fp->fi_lock);
-			fl_type = F_RDLCK;
+			type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
 			if (nfsd4_has_session(cstate) ||
 			    exportfs_lock_op_is_async(sb->s_export_op))
-				fl_flags |= FL_SLEEP;
+				flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
 			spin_lock(&fp->fi_lock);
@@ -7585,7 +7585,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_WRITE);
 			spin_unlock(&fp->fi_lock);
-			fl_type = F_WRLCK;
+			type = F_WRLCK;
 			break;
 		default:
 			status = nfserr_inval;
@@ -7605,7 +7605,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * on those filesystems:
 	 */
 	if (!exportfs_lock_op_is_async(sb->s_export_op))
-		fl_flags &= ~FL_SLEEP;
+		flags &= ~FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
 	if (!nbl) {
@@ -7615,11 +7615,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	file_lock = &nbl->nbl_lock;
-	file_lock->fl_type = fl_type;
+	file_lock->fl_type = type;
 	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
 	file_lock->fl_pid = current->tgid;
 	file_lock->fl_file = nf->nf_file;
-	file_lock->fl_flags = fl_flags;
+	file_lock->fl_flags = flags;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = lock->lk_offset;
 	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
@@ -7632,7 +7632,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	if (fl_flags & FL_SLEEP) {
+	if (flags & FL_SLEEP) {
 		nbl->nbl_time = ktime_get_boottime_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
@@ -7669,7 +7669,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	if (nbl) {
 		/* dequeue it if we queued it before */
-		if (fl_flags & FL_SLEEP) {
+		if (flags & FL_SLEEP) {
 			spin_lock(&nn->blocked_locks_lock);
 			if (!list_empty(&nbl->nbl_list) &&
 			    !list_empty(&nbl->nbl_lru)) {

-- 
2.43.0


