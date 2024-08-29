Return-Path: <linux-fsdevel+bounces-27832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7196466E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444E31F211B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFD1ACE15;
	Thu, 29 Aug 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAN+pHie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD231ABED0;
	Thu, 29 Aug 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938012; cv=none; b=d4LweUMkPecIltJW+l8udMu8Ili9Z8bVhfBt0VgbRUdlnioeFKcEkL4ZCCpCYwLdKBmTTY0NZiEdloNoOdEP4oO0nUAD9yEeKwwU4+R2HzCqHe1o6l3IdaTgitoiRW3GdkM+ZARJbX10k/DmojXvxqr98OxjXOM6kVpgqTrtib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938012; c=relaxed/simple;
	bh=DOAO3+oC6YizpcQwSETjUEGRUke0nZ2pfAyJX5iZLVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9fFBaK6RBg1k4aLX5CcFf54h2he+Wm/TCAmj6JqVsZ29uiMNWDDAG7TGIVr6C1LJ4pPV+7MVjaCcMAxtBRm+x0y8Yk1PSP50F20told1UFklY73OF2ag0d0JFGhKC94AM6fFSRyBGLjnkb8FiLp3cdeu9xJWI6CBZDEZF53cCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAN+pHie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7548EC4CEC8;
	Thu, 29 Aug 2024 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938011;
	bh=DOAO3+oC6YizpcQwSETjUEGRUke0nZ2pfAyJX5iZLVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bAN+pHiev2LNcdP8X6duFV3VlR4HqUm796B/13ePTAwP3os9ZnmSX67xpIC2jc4v+
	 W7sZDG7Bn0bwmPna1aU1wGE59B7VeeU+inNt0QjLK0J+f6aBqD6FExbKFy+sUL/6to
	 P7jIK7S0pWF5wKH8QByj99m9XEY0Va7BVe8trUuT93JT2yoGhoupiS++STjmXYL4Tj
	 h02TJ+o6GV5RcE9XOxhzNIw0EwA1f9Sp4Fh3/y1+jMZ+wYBGjWCu3Xi7fClth3PNfj
	 0Rdaqhhj/HJ9K5XDhSO3pGvhS+54kO45XStQ417XyKsgYvb9ijcoE+RgDhjawanQ89
	 YhhCstwhcgOFg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:39 -0400
Subject: [PATCH v3 01/13] nfsd: fix nfsd4_deleg_getattr_conflict in
 presence of third party lease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-1-271c60806c5d@kernel.org>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
In-Reply-To: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X+VzQ5tWBrDRZPw5yaXZK1DNCjxb4s7t+AB6ZzGGecE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcWfUhvZZfPYuxUNidZ2yRhdmSg0l9misQKZ
 HmRZZ1q4qOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FgAKCRAADmhBGVaC
 Fdr8D/sHYlFA0RM32n+zoZfn98GsMBaGGgNqfPftRQ6grKWRSrZQEZ3erbCKi7bq4E1RYGuLzpY
 j0ph0hsFa+UDpmMqr95fnMr8/3kquGmBZZNKtMmeAI3PPhp5uU4vzXpA3MtWQx6+yIf0+Xck2dG
 L5p4Qg5cSdvlwrPv74GKgM1C1pcV7lp3zpFYX154ObNe8zbJZCKqVz61ggJnNS2FufUiSYHuaUg
 9qhk5vmYuryMEbmsRXK5kgAE7Cb1Ulj7dpd51vgZxE66V7jD7VwFXtzg6s9QvgSuP/3zh5tSOqD
 MFCVwLwBfIRWwKixPgv266SDkMxzDQuzGnG5LHb0agBjqg0bZ2dtEbEoexaEZ0Dpd54Ejuf1egc
 MaxVaDEB1hG4uRVIt1jKmNBabz/osbBOAjjM4fevnZKMuiBB6QKlNI27rS62XbPPpbMB1cRsD93
 QUU2n58x2FK7PrtqS69m0ubAhfBeILrLKB5X9DE1zYgDU7zW+1uFrGC1c9Br39jgHDFQdk2JSAV
 dQOwVlpZ/yjM9cbwWp/aAm/KftkCC+MNzUdVGgwIF6dW0OA1laQVONWXtCctLpc8UTrJU3AcveO
 j/HAb6mDyOzKyYQ5ti5U2M20M4EFZhtEQTjxc+EyWB89sLQkavLLdYWiI1rPiiu305y6orhwT+6
 jKf2u1idIarP5tQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

From: NeilBrown <neilb@suse.de>

It is not safe to dereference fl->c.flc_owner without first confirming
fl->fl_lmops is the expected manager.  nfsd4_deleg_getattr_conflict()
tests fl_lmops but largely ignores the result and assumes that flc_owner
is an nfs4_delegation anyway.  This is wrong.

With this patch we restore the "!= &nfsd_lease_mng_ops" case to behave
as it did before the changed mentioned below.  This the same as the
current code, but without any reference to a possible delegation.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b6bf39c64d78..eaa11d42d1b1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8854,7 +8854,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 			 */
 			if (type == F_RDLCK)
 				break;
-			goto break_lease;
+
+			nfsd_stats_wdeleg_getattr_inc(nn);
+			spin_unlock(&ctx->flc_lock);
+
+			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+			if (status != nfserr_jukebox ||
+			    !nfsd_wait_for_delegreturn(rqstp, inode))
+				return status;
+			return 0;
 		}
 		if (type == F_WRLCK) {
 			struct nfs4_delegation *dp = fl->c.flc_owner;
@@ -8863,7 +8871,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 				spin_unlock(&ctx->flc_lock);
 				return 0;
 			}
-break_lease:
 			nfsd_stats_wdeleg_getattr_inc(nn);
 			dp = fl->c.flc_owner;
 			refcount_inc(&dp->dl_stid.sc_count);

-- 
2.46.0


