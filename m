Return-Path: <linux-fsdevel+bounces-56337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47685B16175
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77801AA2311
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069829DB9B;
	Wed, 30 Jul 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/wJu5Bs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E429CB58;
	Wed, 30 Jul 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881906; cv=none; b=PHxon4oMv/T+70kE1cxm8DxrwMZ7DCbjJ/IgDm4U/+myqMNqmAjCWiDjC8Io0cbVeU+nfohzHoSGQCaUUcudQAruPD2yhNDbC0Cwij8+Hes21+9tO4eoxhGEpCPi4eDgmBN0yfj8z5k0PmHCChm3X2PzEss3nWxd9z3jkT1kbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881906; c=relaxed/simple;
	bh=fdO6f13p1GTQnu6FzwkdZ4uJxgGOC3acS3Ht0AFuvgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZS/AZTGgK3jW4gv6R8tpgfbY2kq1bEYEjbR/maPkvo9tKe6tBlhC5n3+fzUU+ATnJXsprWwtKF/sSXzYwuXs5+nHJJvrOA42Kf7Lr6LcQp0Dh5xwUp3Cck3HJS+4yV9iOBkLQvOEKMGeW3wR7yvcTSvwLAAJwyNBp/8570Ucak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/wJu5Bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92F7C4CEF7;
	Wed, 30 Jul 2025 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881906;
	bh=fdO6f13p1GTQnu6FzwkdZ4uJxgGOC3acS3Ht0AFuvgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m/wJu5BspaQ9sh+h+bK9GcUP0ajqJB8qrL1e0ULPyclPU8qL1L73jHCpYwDmuf4b6
	 G/7IBpGUI5VUw3WxfWZOTRrYFxVB5kayqycEaVjcZZcJvsrM+fDJFw7+NJwV/42rEt
	 703oBBRnfcpvVwW654daUjF+2wDe6emjZMcvpN5Vwb08QHci89huytnHDvkpMeaBoJ
	 97j4ErxW+ScqKH5KNIjHqWp49EVbjUGySLUrCvKVSYZYUfo41v+4R5kHjnpYvZkzOu
	 maTLbWCrd+1eI7gkFnBi08PzuBGZXlOlsPeE2ycufsuhDQ/ab6bUPRDUA+CHIqwRkp
	 mZuNHoyCo67Rg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:34 -0400
Subject: [PATCH v4 5/8] nfsd: track original timestamps in nfs4_delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-5-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
In-Reply-To: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2805; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fdO6f13p1GTQnu6FzwkdZ4uJxgGOC3acS3Ht0AFuvgE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0oG+lic4zFr8udIEAYZwrO6rCEfUtc+wReY
 MXZVYJY4LWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodKAAKCRAADmhBGVaC
 FZklD/4wGAl9Fu+8Gb/lDEcmw0cYrxIK9BB7ToRpMBdOyXb15sskNc7HXQe0WV7DG9mUIAvRfju
 mhIr+xWNpndSlipcGs2874TzcSZCtkBF/JC3v8FbV05idjoLQMTabgir4fNi7NKw/bOMyXAlpk3
 XkwsmOFXd0SqwL1YRHK4W1U2pleiJH4AynIB5xnSG4eLoxb7ztFrSiAuFCsK7eZNTHjWq4RQkLw
 sP+tihM0tr2dk3HrvCaXSFo3U7jL0ATuuuBlexNElrOCMchufvbYSoCPtv8WtRpsR9FH8RmAFV0
 DrSRKc1oZHeyhPbp+p8YnModeABGtpDfcHgr1qwWIJR0oMnsj3HLyxbWaE4W+6XBoN1GQAzn3Qu
 B8ZsnNJv/M47Su96nzmInfjRdr5iDysYNuJQ36bi7ib7180Q2e85WgiSeFpzOHIc0Vq/TLl+5DH
 XAMfARbsTshClcjFk35g3LwYsOqyzzSxvO/rVh6XSGmOoL8s0ayu6Tc2AWK/1BFdnR9AySLjrAI
 tGF2akKIH/om06TP+oUtiVaz808JJUB9/1w9XRxdKdv+bVJdpBdxG8MCXt7PtG35r+Fx6tShD8l
 6CSx47j1dNmLA9R+LYh5hMH2U02Ca3FGQ2kq+DGFSz1wa0ST/qc6YprfsjGVmnEIFELIjfpnj3J
 HCBSwyjOXEotpDw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Trond points out [1], the "original time" mentioned in RFC 9754
refers to the timestamps on the files at the time that the delegation
was granted, and not the current timestamp of the file on the server.

Store the current timestamps for the file in the nfs4_delegation when
granting one. Add STATX_ATIME and STATX_MTIME to the request mask in
nfs4_delegation_stat(). When granting OPEN_DELEGATE_READ_ATTRS_DELEG, do
a nfs4_delegation_stat() and save the correct atime. If the stat() fails
for any reason, fall back to granting a normal read deleg.

[1]: https://lore.kernel.org/linux-nfs/47a4e40310e797f21b5137e847b06bb203d99e66.camel@kernel.org/

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 11 ++++++++---
 fs/nfsd/state.h     |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 77eea2ad93cc07939f045fc4b983b1ac00d068b8..8737b721daf3433bab46065e751175a4dcdd1c89 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6157,7 +6157,8 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	path.dentry = file_dentry(nf->nf_file);
 
 	rc = vfs_getattr(&path, stat,
-			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+			 STATX_MODE | STATX_SIZE | STATX_ATIME |
+			 STATX_MTIME | STATX_CTIME | STATX_CHANGE_COOKIE,
 			 AT_STATX_SYNC_AS_STAT);
 
 	nfsd_file_put(nf);
@@ -6274,10 +6275,14 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 						    OPEN_DELEGATE_WRITE;
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
+		dp->dl_atime = stat.atime;
+		dp->dl_ctime = stat.ctime;
+		dp->dl_mtime = stat.mtime;
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
-		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
-						    OPEN_DELEGATE_READ;
+		open->op_delegate_type = deleg_ts && nfs4_delegation_stat(dp, currentfh, &stat) ?
+					 OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_READ;
+		dp->dl_atime = stat.atime;
 		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
 	}
 	nfs4_put_stid(&dp->dl_stid);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 8adc2550129e67a4e6646395fa2811e1c2acb98e..ce7c0d129ba338e1269ed163266e1ee192cd02c5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -224,6 +224,11 @@ struct nfs4_delegation {
 
 	/* for CB_GETATTR */
 	struct nfs4_cb_fattr    dl_cb_fattr;
+
+	/* For delegated timestamps */
+	struct timespec64	dl_atime;
+	struct timespec64	dl_mtime;
+	struct timespec64	dl_ctime;
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.50.1


