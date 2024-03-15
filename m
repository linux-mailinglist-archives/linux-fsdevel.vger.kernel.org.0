Return-Path: <linux-fsdevel+bounces-14501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3287D1F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032521C21D92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B635C619;
	Fri, 15 Mar 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5OVqFXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036B5C5FA;
	Fri, 15 Mar 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521628; cv=none; b=pSOXeylz3F/ml+QLXo/AQbYeu6TnahU1mOq6hN6ejboRNF+I0rpc0GS+kyHJF/4p5p63Cfmhv/EHhqQh9XrcSMz7atVZIkS+FRw9F8OChWL6XXfcjfPrM+Wpfche9jW/kJu1MDmuCjYUn7VDSlfXh0Q7fubuTXX1l9wEKDbmz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521628; c=relaxed/simple;
	bh=ljfAQPv8SeghXncJudqqzHNlIKkPlPHDHVqidwfmElY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFTei/07zszNDXX/2uA8/9EoLlhTLoAzk9M76EZKL69SbOqJRXaEN+dxc/dRKuKyJkO83MLSqAvUVgBU06NXNEGNnB2ViaGK3KA73a+c2y3d/4bA885vZT5CAuRjA2RVPyYPVGvo6Jk/PU/dJz+oo1Ppps9mRFxYMB2QXm1lGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5OVqFXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1D3C43601;
	Fri, 15 Mar 2024 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521628;
	bh=ljfAQPv8SeghXncJudqqzHNlIKkPlPHDHVqidwfmElY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L5OVqFXMG3yzOuJfCE3MrXJQ+Mf1tkLr7lCvot4eRiRHsH7ZpVLRjuL9QGV6ZI7cg
	 mIjwvBTcY9/Cyk2wshFhjwGgFvWSd2hPtiEgGc0Vbug/YmaiY+oqmY9tWN3oZNnETY
	 LxTEwkJvxl95xaXQpYvvhUn6ikNacD1y2a+18MUObH1TLh+lhIbp0E8GLisBjHN1Tv
	 NEtO3ThsBCc4y/rtGaKCuPKNTMHcDRM8ccp8G0nggVB4d95cENDC0cZhvNqHnbvoBX
	 K0JzYY1ujVM38K+nosFbuhRtDFucDJqnI9jPY9ScwIt7moGd6jvmGT9698cdSzubSU
	 Gy6m3N//1dcpw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:04 -0400
Subject: [PATCH RFC 13/24] nfsd: check for delegation conflicts vs. the
 same client
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-13-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ljfAQPv8SeghXncJudqqzHNlIKkPlPHDHVqidwfmElY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzuZG1C9GcHSunh24sr9Db67Qw+SIGDz0sjv
 OWi/9rr9/iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 FXTJD/9h2vD0EFl2BzLQ11an322nL8117C5bpnqClsrmJl4Co0TnaVOG3vyTMAwK8por1WAasN6
 k+/1POyLZn1bTc3w5Byzzs88DNhDufzBiPwzCkW6gKjXeP9oVfa/n1IKvfX7Qz3t0wmnW0r2RZk
 HOUT30c/9BbcXqAKzvQpKZeSuX3dhVdDnAjKkVP0FdYW1eFrKdxfwN6Y8j1NtrS7FF9UIBc4Ut+
 csrRXoz2zY25GyTNYKA1lMxLsQHIBXUqmuPNH5FnvTji/saxVFG95ExoKLoglL1mzGmXTLefHig
 LU+IbRvgKm1v3rdwBJsFhazvJRL9ww3P1y0+nfZ6BxzZdRSjlTIoJQ/VkxcHk3Dvmt4gZr1DHLp
 WHUU6EH69V9V9p/kBYTBck8w9RfeaLZha+6KiYsRa+OjBDpvYv3MX7Fdj7Jtp7DAs9NSxGjhHzl
 TnU6Rz5CJYrfxoQcO9GnOSlp+ygAbKmTwkXwzyCYH4TtszXO3/42S0R9Ig9EK/3ORlh9efM+K9j
 jxIjwDLYlbguoNwyc0WxwJr0TEmzL3z3IR29gs6ag9WEjr3wFpQSDPtoNTFqdyZBAYu5aCMnsGW
 t/boh7DvKk63x1DAkDq+ibjEyFMUr6jAe+sF2CTZ0iJFaAXCqr11RzrjWeNGWpThMUo5vZN1wTF
 ag5O22Ysl6sEYdQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC 8881 requires that the server reply with GDD_UNAVAIL when the client
requests a directory delegation that it already holds.

When setting a directory delegation, check that the client assocated
with the stateid doesn't match an existing delegation. If it does,
reject the setlease attempt.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c52e807f9672..778c1c6e3b54 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -88,6 +88,7 @@ void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
+static bool nfsd_dir_deleg_conflict(struct file_lease *new, struct file_lease *old);
 
 /* Locking: */
 
@@ -5262,6 +5263,31 @@ static const struct lease_manager_operations nfsd_lease_mng_ops = {
 	.lm_change = nfsd_change_deleg_cb,
 };
 
+static const struct lease_manager_operations nfsd_dir_lease_mng_ops = {
+	.lm_breaker_owns_lease = nfsd_breaker_owns_lease,
+	.lm_break = nfsd_break_deleg_cb,
+	.lm_change = nfsd_change_deleg_cb,
+	.lm_set_conflict = nfsd_dir_deleg_conflict,
+};
+
+static bool
+nfsd_dir_deleg_conflict(struct file_lease *new, struct file_lease *old)
+{
+	struct nfs4_delegation *od, *nd;
+
+	/* Only conflicts with other nfsd dir delegs */
+	if (old->fl_lmops != &nfsd_dir_lease_mng_ops)
+		return false;
+
+	od = old->c.flc_owner;
+	nd = new->c.flc_owner;
+
+	/* Are these for the same client? No bueno if so */
+	if (od->dl_stid.sc_client == nd->dl_stid.sc_client)
+		return true;
+	return false;
+}
+
 static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4_stateowner *so, u32 seqid)
 {
 	if (nfsd4_has_session(cstate))
@@ -5609,12 +5635,13 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	fl = locks_alloc_lease();
 	if (!fl)
 		return NULL;
-	fl->fl_lmops = &nfsd_lease_mng_ops;
 	fl->c.flc_flags = FL_DELEG;
 	fl->c.flc_type = flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->fl_lmops = S_ISDIR(file_inode(fl->c.flc_file)->i_mode) ?
+				&nfsd_dir_lease_mng_ops : &nfsd_lease_mng_ops;
 	return fl;
 }
 

-- 
2.44.0


