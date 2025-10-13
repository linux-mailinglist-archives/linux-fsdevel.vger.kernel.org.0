Return-Path: <linux-fsdevel+bounces-63984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76EBD3C03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8A6034D9FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1C30EF70;
	Mon, 13 Oct 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf2U+eFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48E30EF64;
	Mon, 13 Oct 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366937; cv=none; b=a3lLBuv4RHQVMLcYTtzuHSVH2S0aoqOASiW6O36aEUzIGsxcevoq56FnntVJCSC5HK6YAXX8Zga6Rf9a+jvCDhy3cgMTvI2njydroAB1fqnvk4TY0auF41SL+IiSg//LC4dkckJUmkHRrzG5wxJ++roZ/mxVepTfDs5CXz3D3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366937; c=relaxed/simple;
	bh=XdFZTvLBv8jG97H/465+ay12gK3EocumS5jEZExnjFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBf9gqZLzV5o6kvhMasR+g1ZouvWcacIi3eo+svvuV2VMOvZ0XNSscBO+Ft+x0ZfQ7cBA4wpn6wOL8+e2JyKhPEObUkhdh9iSePL528L8xkReDJYmhNNb1X4MfSV07kK7T8eMjchq4duTmOQypwtytSSaZuZdEavziYq/Uzya6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf2U+eFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8B3C4CEFE;
	Mon, 13 Oct 2025 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366937;
	bh=XdFZTvLBv8jG97H/465+ay12gK3EocumS5jEZExnjFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nf2U+eFyWfPz1UjAB12UjZh1t8ZFKYnt9ac7SNRTYsGHGMEMBvCl+1s22x0HyMzs2
	 dt6jtb17kJMGMLJgF7RJ0+qCwkqiNxa7XqwypWm25PTRgU2vfCz83W8MbRXZnuuGF5
	 RxT0rKvFuZsArwQqD9zD/tBIouvRin7D338WqJsR4i/12x+bH3DmFPKhsH1FKW8DWG
	 4vX1BU2MQ80zDq7JnV8y2bSIKEDGqpba+hzibeHZMuosc7eTwWbxZkLwoEc63W9f8I
	 r+Ip5PwJDi1zZyi6lcvee4nCqRFUtpf7RCNEHoKe54iXHzGzGzeF0wayucokOpMX0K
	 F8CipGEplkS5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:10 -0400
Subject: [PATCH 12/13] nfsd: check for delegation conflicts vs. the same
 client
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-12-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XdFZTvLBv8jG97H/465+ay12gK3EocumS5jEZExnjFE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REsyVLWKcjMsWV334tA/TwSVQZ4YXARM3QDA
 GmN7aMpV2eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RLAAKCRAADmhBGVaC
 FWgXEACJ8AfPAskwnoPwDaw1BvIZoBTIbDQT4PTjnX+YbY5BdDm3nBWD+ki2u5QY5597noRlAbD
 +40FDIuz7ur2qLZXq6/lj9omlP31dytNLenL0KcqTUkAGuM2RWUIAHc90WcIpss8w5X5Gr0Eu0t
 i8H6ubBg9+kaTh+ALoGhR/MRvfVJzRoeHaYLgg5t2ZRkJ7H3GKG4Q0xXxMPd3uHMoDF+BARexze
 4qx3q+czhixcAMRhJLExo1KN4u0Gf2Ef2b4s/NA9mYMnQsHIMB4uK8pUYpyNYpwWd1zo8WSWyMA
 R9sSFUcbgRYRjX2LwubTcxLWbp18xpr9RZ+OlP08I2bM5LCW6WtuTmfJ0EHId7HwZ8VN3Tg4xOt
 3V2BmY3V0wiT4I7zyudHewJKhEWMXQQAKepsr9/PaJQeIsdu4HD+fF4YrW0oxS+1Gb76/c5QXr4
 rpJPMglDc4k8lhnspxAFE9n1dmdCJHOpOSHZPxlNT7I8sN6U/+f0yS0RwYEnWw3vVtVid3lq2pZ
 RkOmgW9RQUowvl+zuMJoX6P9VbR8/INz+OF9TKtkYf+D2dSTATzqV1oZQnJ4miOvqbVFp8gcfca
 YjrX5ksYr46mQ4dy9XUelwHQqo6KiTAsyRqggZ6f0ZwNWwjHNZcEC5yBBk5c3uaAsU3zelkmnj7
 eGxqiv4Kt9p2xyA==
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
index b06591f154aa372db710e071c69260f4639956d7..011e336dfd996daa82b706c3536628971369fb10 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -88,6 +88,7 @@ void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
+static bool nfsd_dir_may_setlease(struct file_lease *new, struct file_lease *old);
 
 /* Locking: */
 
@@ -5550,6 +5551,31 @@ static const struct lease_manager_operations nfsd_lease_mng_ops = {
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
@@ -5888,12 +5914,13 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
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
2.51.0


