Return-Path: <linux-fsdevel+bounces-56103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AC8B13148
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E11773A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A81235358;
	Sun, 27 Jul 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq7cGl2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406F2343C0;
	Sun, 27 Jul 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641390; cv=none; b=RiirG7U+tK2Y4ds6d7OAds5ZtyJ2DKpT9q8bFbOl6aY05LyCXF5KZqqcqFMe+/7UL2JAlPpdZmYIgaVd3mmWGG4btrafJJhjD3Uj0VLuI6Qe5ys52Odv/yCYxt4ger8VsGSeSN79rE/HiKvrKDO4+pb5VE/0A3jeJbzlWEiF05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641390; c=relaxed/simple;
	bh=tB28A7UEW/1kAwxOpup/7X4hmWe1RoJvUGt2RZpGRko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UChe9ciDMVctw2U2LTtFrj5Owfb8Q6X6De8MhqB+6XhQ4Wf+vo3Z/RpWK9kzcMFxh7C66lg1Viwor8fcOn8jj3o5wly01cifhz8jUyFaGVjhFrQ18K58Y+ZquTAOB6y58XZyxWLJzDSbmprgk5vkpX8AcBpzLAXwxZ1gQTJRVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq7cGl2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDB7C4CEEB;
	Sun, 27 Jul 2025 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641390;
	bh=tB28A7UEW/1kAwxOpup/7X4hmWe1RoJvUGt2RZpGRko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xq7cGl2MrD/BJSYSAtROGzOlynYxA21pxvfarm4zPIrmZAe2P+YgqI0K5smqsEZZI
	 QAJQtfCeeMSs0VgHWlbIrBqLnMOudeCk2ccKm5ElpxcVfZ/6cmSZonqibb5/tCNtQX
	 Rvck77Px6JSs8cJw0YAj+uhUFT0RexGBAPYFHD3HISJF/8gN2AzP0GhMj6ID5Di4Tm
	 F9KUY5nlaFtlTacFJ4+Jd20XkcA2hsSSDz2KY5YQTRPc69NW/IUNURfqATCqJHiMpN
	 b2PwcoGM5EZHyOqNtZmWF8AmN9sEeXxL8GvEyKA9Y/BXoUwk/72JHepEEISoWSELjI
	 IjUMYBVzvV8xw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 27 Jul 2025 14:36:14 -0400
Subject: [PATCH v3 4/8] nfsd: use ATTR_CTIME_SET for delegated ctime
 updates
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-nfsd-testing-v3-4-8dc2aafb166d@kernel.org>
References: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
In-Reply-To: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tB28A7UEW/1kAwxOpup/7X4hmWe1RoJvUGt2RZpGRko=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGls1yb2RnpV9ql6Wo1JRJszwnE/7UpUdCym
 kjUViPElkKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxpQAKCRAADmhBGVaC
 FRSSD/oCdv0wKgUqqEZE7shc6/M8ZRGEa+AB8MnmPU+lZq2LTq5EP2sIPpUx3il4TeiEOjP3YvB
 YfmS+xUb0q5sI5sNNOSec8XeiEqTfisInQCrGNKlLrw0I8Imqn1FDdfqtGEa2V/zssbJQMTgVK0
 Ge7ir9gw0s79z5AL7EztP5+AgvNINugerG6qX/eSnRhBHQw2RCAptpvoey6Xd+JOZImHbUDwYJG
 TUjrlBDBUMZ188L+dmUnOk2KQE+I6yWinOqsUri2sfMfNbRmnkOQcIVoHoZg6l8K/n8u8enp1Tn
 hfJXei42MFhQwRwT0jK+wFMz+8tebQRpP/DroNDB3+xJZ6jxvOThLAiTY2Pz6LVvROskbyIxB3b
 zZ/NIVH5HKcOfdVUbntWTUrz16aUdC2/iBc5RaHqFqRAx/ro4pr5tNvwEEA76thHfudJ1vF0tKb
 dVGSzNU9BOAsuPzCZt0HpHh4eE1A9akFGRFRnSp5TkiKDjCU47TYHvJ0wQTi/x+j/2O2Anv0haf
 1bw1FfTHOB0WdmndkDNgOuGm3e6dzX6IpMmLORwjhkS9tc9C/5HjqkctGTByo4zgaKHN546XgX6
 d/9xZkv7zCOz80TVpRxQP7w01yO8dVQb76FoDhdngA8QJAoqaTNbHNmEfj0mMFMZjFgbsk9jbRn
 SodUHouIntb6wNA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Ensure that notify_change() doesn't clobber a delegated ctime update
with current_time() by setting ATTR_CTIME_SET for those updates.

Don't bother setting the timestamps in cb_getattr_update_times() in the
non-delegated case. notify_change() will do that itself.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 +++---
 fs/nfsd/nfs4xdr.c   | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index 52033e2d603eb545dda781df5458da7d9805a373..c0a3c6a7c8bb70d62940115c3101e9f897401456 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -539,7 +539,8 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		iattr->ia_mtime.tv_nsec = modify.nseconds;
 		iattr->ia_ctime.tv_sec = modify.seconds;
 		iattr->ia_ctime.tv_nsec = modify.nseconds;
-		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
+		iattr->ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
+				   ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
 	}
 
 	/* request sanity: did attrlist4 contain the expected number of words? */

-- 
2.50.1


