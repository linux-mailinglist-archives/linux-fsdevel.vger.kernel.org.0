Return-Path: <linux-fsdevel+bounces-56106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FCBB13151
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201A718980C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B0242927;
	Sun, 27 Jul 2025 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j//j3UDY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0552417F0;
	Sun, 27 Jul 2025 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641395; cv=none; b=H35MMn6r8w0iur8Q2SrVG5ChZDB9NHkxzHNTOaq2aKrb4S+AWlu+1qfswOkINEBQfv4l6CTEWU3PFQo3i4KDc0IfoYZk5eqq2AUYNpWMIoXx7XVMPTSow8NbNsZ44XguGAC88uy4VdkhXhNUTi2i/EYcbSnaFIQ6RvhsobghCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641395; c=relaxed/simple;
	bh=+rAzc5qvjz0FCD5vq5bKYPfZ4fICvaRMvsO7vDhd3jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDNGJvPyG5zVdZxBiuRMKaxVP9V6eNUzsXtIYzGxuFFX1or7XjpMx8Bo9PO9+3gWNoWH2rRqdin//ZB5B9jQKzuWTH09AOfcccfCV36179c84rA2RqNoX7dAnMWX7sXe7wtwO661EbtduXTU69eU6xwbSCTaKXH1dYbB03QQAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j//j3UDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA525C4CEEF;
	Sun, 27 Jul 2025 18:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641395;
	bh=+rAzc5qvjz0FCD5vq5bKYPfZ4fICvaRMvsO7vDhd3jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j//j3UDYEBlIQkfjzSU5NDidUYnRXvyrCfJ6MVCU3Mp2YMWPv3BQoU/4+M28vBago
	 9DoPerhN1Z9nddbfogYC3RNdZMW+GTpkolJliGrTqjoQ0GUWFjR1BY//9IaY6pHYWX
	 pQg/fYjS9LZABAJ7aGn0/eqyW7DOa91O2AZCDQJTorMdKpg0aA59c6aA2G9/fNo2Fu
	 q332bFm67RRyuVnixm+IDQxAnCNpLcTVyT6YIW9DQadxgGayK+bZDqsnEQR5+YpETP
	 +2xrVAbiCtPehF1pKHOECBVejuj3rliB3ViZz5ZugSUoyRa8m4tFcwNu3qTI/oFVwV
	 bY5RhskdJauHQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 27 Jul 2025 14:36:17 -0400
Subject: [PATCH v3 7/8] nfsd: fix timestamp updates in CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-nfsd-testing-v3-7-8dc2aafb166d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+rAzc5qvjz0FCD5vq5bKYPfZ4fICvaRMvsO7vDhd3jo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGmuzw2tRrbXWdr3BilHRtPPJ+U2fZLJoVIn
 er1Rg2sIjuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxpgAKCRAADmhBGVaC
 FSVREACkTRoFThDlr5JQHtbmZEKJP3OfOVnEnDwD3H0VUsYJ98CcOXFEtDd+fj+EvH+xAsHLuij
 txpxtH7/6LkRxL0gEFU1v2iyebIttThcrg9hBMt2CdbNv5bfl+ytlGqjif1dLgvi4HAMiBSAh8u
 qscL8XWBOIdr8k+A+eUEUTfybskWlF1noISK0nnsLGqrkZhUzsTxedBvNK5lAaDrfnoSArkB5EQ
 /wlhiEaGaPZTeSxNxksWw+E+8q+pvOLXv1cz4GlrfNSUO52gfanACHcpcRQW0RtGAfxFsqFJew3
 F56DG5Pg4SmmMwJXEOfUUAyuh+JCQpg9E/zf4WBRUYGZM58sISnZ+4dDj1MqHg/eQs6+7+j2INp
 0PxwH9xPjS865tqF0fJ990UD3sOsL+X2VGtJTy9eqGa84vwM2ram1ZmOev6rrhfkx1RbdMemgF6
 zHuGjOoJ/MBtapzd0As/U25wzpOVc3/nGfaWjjEKHQTMPUnk/MaxvNRE1BsJABIacO5q7+sCydM
 0Wt6HYyzeW3PiNf7JY/68RHgSJ/KupwM5PZ9O6s60zODcz5l//OhhJ8fetbAh5ZrFStQJU63ZVJ
 nuYYHr/znrOh2NkhqQW96uUmSPQnk5D3GLD69L1Y7NKI7cwDxMj/VmHkCIFNtXKhTuBc/JhZTmP
 0fAbCIbAL/70naQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When updating the local timestamps from CB_GETATTR, the updated values
are not being properly vetted.

Compare the update times vs. the saved times in the delegation rather
than the current times in the inode. Also, ensure that the ctime is
properly vetted vs. its original value.

Fixes: 6ae30d6eb26b ("nfsd: add support for delegated timestamps")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f2fd0cbe256b9519eaa5cb0cc18872e08020edd3..205ee8cc6fa2b9f74d08f7938b323d03bdf8286c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9175,20 +9175,19 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 	int ret;
 
 	if (deleg_attrs_deleg(dp->dl_type)) {
-		struct timespec64 atime = inode_get_atime(inode);
-		struct timespec64 mtime = inode_get_mtime(inode);
 		struct timespec64 now = current_time(inode);
 
 		attrs.ia_atime = ncf->ncf_cb_atime;
 		attrs.ia_mtime = ncf->ncf_cb_mtime;
 
-		if (nfsd4_vet_deleg_time(&attrs.ia_atime, &atime, &now))
+		if (nfsd4_vet_deleg_time(&attrs.ia_atime, &dp->dl_atime, &now))
 			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 
-		if (nfsd4_vet_deleg_time(&attrs.ia_mtime, &mtime, &now)) {
-			attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
-					  ATTR_MTIME | ATTR_MTIME_SET;
+		if (nfsd4_vet_deleg_time(&attrs.ia_mtime, &dp->dl_mtime, &now)) {
+			attrs.ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
 			attrs.ia_ctime = attrs.ia_mtime;
+			if (nfsd4_vet_deleg_time(&attrs.ia_ctime, &dp->dl_ctime, &now))
+				attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET;
 		}
 	} else {
 		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;

-- 
2.50.1


