Return-Path: <linux-fsdevel+bounces-50342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C38ACB0A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DBD3AFF4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E422FE0A;
	Mon,  2 Jun 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8gcVocP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A428221F24;
	Mon,  2 Jun 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872967; cv=none; b=MYwGITET4Kw44J77eySDOEOzHKMylREM3fxNPfTfvjAfCw4kSR5QdK76Xiz8xKt2308cQIhC34SMsx/bEgE0mDCy+r90/la+Jp8aRbLN762tLXJE9W2N1vfnjKDIIkH21qFxqIFgB1yKF3g+6+u78/yUWR9VF2q5AJg1dzGCyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872967; c=relaxed/simple;
	bh=PXBLMUX1p1ivEi2SghQqejpVOASv6EpMNz942WPIY+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuRXcSiUODd8xg2C0/vdCOaa4Nb6bxMJpLW3SEylMXsCnL4fbdnLxJkVCjo0KUANfTfEUzKIV6ACi9EYZt7CoRcsNxji92xauZvcoc/PvGTA3nNtazu892Jk2TWgJijfyqIaFjBPxsiK4K8TFtKei5E+bikxFlyUYQh9puJEg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8gcVocP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938AEC4CEF2;
	Mon,  2 Jun 2025 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872967;
	bh=PXBLMUX1p1ivEi2SghQqejpVOASv6EpMNz942WPIY+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f8gcVocP2QNIDJ/gaynZuucaR+HgwQLwy82FloAU3WnGCVofkw0dRj1q2vAZG0NSb
	 uHnRO8GQSzUD+aw5z6bHxZoaKApUmJ2oF5SaRAaFh7yUO5Si22vV+WVLKrXLQ/8kYN
	 9awGrp1Vl8yJNW2c/YpiOoC7bFNBDGjv/ZgH19URL4idVq1N8+PUuAx4Lb+KdxZcw6
	 mg/d5jAKp4Jn2hE7Vkaq6LmNksIILq2tpk2lzlnO5+Sx7VeLVpzdjGnq3kbd+YPdqm
	 1YuqYBy07P3LNvoQORme01L6wUCqibWGo0S09Jw31I/FynelAa/rgDIa+CWQjP74SU
	 v+oyF4PcZ0LSw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:55 -0400
Subject: [PATCH RFC v2 12/28] nfsd: check for delegation conflicts vs. the
 same client
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-12-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PXBLMUX1p1ivEi2SghQqejpVOASv6EpMNz942WPIY+Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7ms1aKe7zhc8MXHDKI3jra3rX582Xton3iw
 d5scL6lQOSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5gAKCRAADmhBGVaC
 FcrAEAC4t2TYaUqLPw3qoHmgyPZz2urj8ypY4VH1R9ntDiFxdTTVDXpQ0TX0TmzFH84aGzUvh//
 74vRhKcgUbBJzPYNk3ZndHIfmo+D+YUhx79nKZtpLwiAKsJ289LkfZB1jLcgwu4/rbHbpbaA6Pv
 zPEDrdy1xKZjyd2n4tnZHHNyOojHYhfUxoL5ILIcoY/WV0Epj3ZRqeZVSgcD3QMSinQ4FGCklnw
 O3WMXQZ88B5nmmna+aGZCjtUHNMO+gDkCp97R+IO83giTCzuf2WYw7gZ0iOiuPgmSyMjW2HOZYV
 Bb7bqlhcyvAM8Yn4/Yg+ShsJu6T1fVhs5HaeFjRp2YqlYfHqM8kuex7IZ4V4vHJP3Lh+AIkzDpC
 PW2kLRaZhgfOIiUvmo1Y4tZVkvTD9mUE+9RkzloWxhj8yrGUkjxjlUau8rcJD7DYHGCpegUw/rA
 gmdy1IbDUwU3KMfU/z6EbYZH/VLPg4iJIB6WdiIn9Hhaef9cam+hrtKReWixGn/2DfjTsdnGzRn
 5w2gH/P+t+lMSZ779cbOGVUNEsfhwUpz2AmmmOWE0ZFyGiv4TY2hayO8LFJ7F+A59On9fg4H5gb
 5tfu/KbtCO8dvM9cWKLsuyvvUoSm49LLkIqECy1PSS4bnDG0zcz09r++6YSS5MDoSl4E8lvM7gB
 oJbhyUqjnb6kwTg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC 8881 requires that the server reply with GDD_UNAVAIL when the client
requests a directory delegation that it already holds.

When setting a directory delegation, check that the client associated
with the stateid doesn't match an existing delegation. If it does,
reject the setlease attempt.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5bf12abe4778ca0a16cd68965062da25470c8a93..12f20e3c9c54b68cdd4c62aa2904c22c9ccfae0a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -88,6 +88,7 @@ void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
+static bool nfsd_dir_may_setlease(struct file_lease *new, struct file_lease *old);
 
 /* Locking: */
 
@@ -5503,6 +5504,31 @@ static const struct lease_manager_operations nfsd_lease_mng_ops = {
 	.lm_change = nfsd_change_deleg_cb,
 };
 
+static const struct lease_manager_operations nfsd_dir_lease_mng_ops = {
+	.lm_breaker_owns_lease = nfsd_breaker_owns_lease,
+	.lm_break = nfsd_break_deleg_cb,
+	.lm_change = nfsd_change_deleg_cb,
+	.lm_may_setlease = nfsd_dir_may_setlease,
+};
+
+static bool
+nfsd_dir_may_setlease(struct file_lease *new, struct file_lease *old)
+{
+	struct nfs4_delegation *od, *nd;
+
+	/* Only conflicts with other nfsd dir delegs */
+	if (old->fl_lmops != &nfsd_dir_lease_mng_ops)
+		return true;
+
+	od = old->c.flc_owner;
+	nd = new->c.flc_owner;
+
+	/* Are these for the same client? No bueno if so */
+	if (od->dl_stid.sc_client == nd->dl_stid.sc_client)
+		return false;
+	return true;
+}
+
 static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4_stateowner *so, u32 seqid)
 {
 	if (nfsd4_has_session(cstate))
@@ -5841,12 +5867,13 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 	fl = locks_alloc_lease();
 	if (!fl)
 		return NULL;
-	fl->fl_lmops = &nfsd_lease_mng_ops;
 	fl->c.flc_flags = FL_DELEG;
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->fl_lmops = S_ISDIR(file_inode(fl->c.flc_file)->i_mode) ?
+				&nfsd_dir_lease_mng_ops : &nfsd_lease_mng_ops;
 	return fl;
 }
 

-- 
2.49.0


