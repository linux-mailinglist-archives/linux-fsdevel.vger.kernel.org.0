Return-Path: <linux-fsdevel+bounces-56336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD7B16172
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075285A7370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF229C346;
	Wed, 30 Jul 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhBkoUw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAB29C34B;
	Wed, 30 Jul 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881905; cv=none; b=CU0k7mOY5Mmex/bynl/Sr/uE75YUjRydCP7dba7qnGHhGOK6uahjz2p6G2lgX3v9V/KtLRBYh+taNHrwe63wetuvubq706bNRjw8hgjbWVKAzQyc9kIZN55z82/MQCT9RXnTkVfUoEC1dGb0HajhUCFWpGGoVlz9nFpPM7KRqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881905; c=relaxed/simple;
	bh=tB28A7UEW/1kAwxOpup/7X4hmWe1RoJvUGt2RZpGRko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYh0X84nhujBvmXeQqn31PtuwdEZnkeSmrAsVR3LS34QI/4Q5nA3pBcAs9gAWJow9qxM3v1Ix6ZaauMj1NhaFCL4JjC02bmg9OG1W+UZuCCnO2MX8D58vMm6OUXkO0tV5da24pShB4zmrSqZ3PfaRfrv5M1J6W8ZD+20VLh3edo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhBkoUw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3183CC4CEFC;
	Wed, 30 Jul 2025 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881904;
	bh=tB28A7UEW/1kAwxOpup/7X4hmWe1RoJvUGt2RZpGRko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NhBkoUw9wLmkYcMIvvWjwWh/XQjoigI2SSjBl4DhzvF7icIEuE8klhY7B47IEjaWD
	 pzB2ov9mRXbvxI4pWjfQCuGfOtQvCLD5nMji7WxJ5EYGJlKRa070/EsHOHvSSl5JAN
	 y8lQBSoZTq80RgdSLwHjII5dk83zAGcyAaG/GaPfvbqS2k6+ThDpLV9Oe+AHcNR74Z
	 irorm7aOPwl825UAytDcdsObDt0QsWy1PhvToIndf+t1OmeYWpjvF3Bijj63JBcuO8
	 joGykFppGnS6phaox52xaEWjhENmyvcMA9OnyUJo7EANdsWy0GA67EQZi7o1KaX4WH
	 alLxUQp2MxBOQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:33 -0400
Subject: [PATCH v4 4/8] nfsd: use ATTR_CTIME_SET for delegated ctime
 updates
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-4-7f5730570a52@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tB28A7UEW/1kAwxOpup/7X4hmWe1RoJvUGt2RZpGRko=;
 b=owEBbAKT/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0ngBLUqXHCJyEICLnOeZqPtjb7bf9xnIxNa
 qy2ohAXa1iJAjIEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodJwAKCRAADmhBGVaC
 FfLzD/isgA9VmMDTr6dEPY202PlRxS3TzdJKRoe0sQnt5mnTLr2X1jCJOsVGYqZL/9PPyC4+ItL
 vQkmVGRCZ4L2ipNpsNynSRgro4VCy/tkokYAJN0XLm4bOeGmMfcILY2OY4DjmYzcnwEtt0WF8r0
 C0N2l44GbMANrP6B2bVCt1TaNdnvlpd7dxF1CS2yC6/668/w7x9nrGOlJMUJ55uQGNxufxzl9CR
 4ci5uxb9zXEXmmB3q32J+oyNJ4FcK+hPMkuXEUBwd/TjfKbrQy4MPW9d2DuiscdSHfT7VOeBvyr
 JkhgcV8jJEj18JEqsnCJwJoNQ//nwlhwREEd0vToAeonzWzchus75IxULN1ty3lj+q/+KGHtg1x
 oGDlBgkWFiDA+XKXDjOcP+Zvr2PKVsqkB2QhMwDO8Ok14Ry0VXch/i5lDXKylEBlkmu2X/g3qaK
 wb1gLGLH/bEDbgPMKSzdZf7CRflYipL2hTnW2ZLB/C7CVv2gUpkU3wR0vOKgFsc6H+CI3/95W4n
 XZyI7d/xwweuuBu0zk70VybH/bS3NaVChTbJH4YSiIPOZp5kEdaMcLH1otpeFjQL7Wm/enPfgxv
 BQAmCwMgB++kw8dnOqwkOEx1leZriMn+9Wo0GSnToZXgrD5Lul9dEMXl3Sv1mUyRqqH3yZp5eNx
 tA958PYDhtwIS
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


