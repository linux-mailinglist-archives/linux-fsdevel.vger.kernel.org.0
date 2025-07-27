Return-Path: <linux-fsdevel+bounces-56104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A15B1314C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922601897C8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB4239E6E;
	Sun, 27 Jul 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjPUaPbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32D23909C;
	Sun, 27 Jul 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641392; cv=none; b=kMZKU2ZHHSr5H1Cs4Cv642Oe2Jqq9UDud2Z4r2ydoH3QPnXSyqdULhGbVwTBuRRhnHQaxBAtTAYx+9Ku7h6IHdrfV1g7Xh8Cm0EKiXptVRv+01W3JI3y1FhLgfxc5ZXcLDX9KGfCSXkYn8C3el+PqGZXF29Igbb86tPIRT/AyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641392; c=relaxed/simple;
	bh=fdO6f13p1GTQnu6FzwkdZ4uJxgGOC3acS3Ht0AFuvgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deA5ba0J/RijIiqL4W6shwsIgIaViq8w1Igv43zewydKuDBhN7y2FMsHCm1LkjT3+NpaNepxdjdyTFNMgoyB+Mb26hP6X3cIv+Gpgom7aURRmLNX9CM3MV7Dk4u6uUUjQEa3q2uRlxICk0CyJqcOr9F3PDeVPpAHnihfkUoqvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjPUaPbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE388C4CEEF;
	Sun, 27 Jul 2025 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641392;
	bh=fdO6f13p1GTQnu6FzwkdZ4uJxgGOC3acS3Ht0AFuvgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tjPUaPbIkSik7w2Y3GUReyLhpy8l2uYCWtDq6KTsvcVFegt3f54KDQJGWCEQwM4C6
	 X3To8bgaKDn2xpT2LCHWe95c6tGjDiBInWkG0w8fKKlaCZDRPlTYJAQ/20zdvcrSBT
	 w7n+eIIUZk+2bAScMT68Q0YS8d0uJOSJFPM6h920qyc+LjhSmrQlyZGscira26ZkO8
	 gi4+Y5r4xB+9Rh0BZEQMCFcJQkOpEVYkBh2MqE+d7BxngY2E6KMk5k67Jddy3jG5Fj
	 V3beodo1QsmVhUVlvvhvakYYXGTeyCmblScIif9MYIohmJajiBkVl18ADLCXYnhUAI
	 MwG2MkqUF44mw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 27 Jul 2025 14:36:15 -0400
Subject: [PATCH v3 5/8] nfsd: track original timestamps in nfs4_delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-nfsd-testing-v3-5-8dc2aafb166d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2805; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fdO6f13p1GTQnu6FzwkdZ4uJxgGOC3acS3Ht0AFuvgE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGmlQKzsiog12wrAlno6OgP/0STkBQ+c233u
 IDzv4lwcJmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxpgAKCRAADmhBGVaC
 FTf8EACDdtbcx0EjmZAijW3mC6d4HG3fgUAlDWqLLyApRLJgNohVhm91v5qjnFOTP0/9PXIb7ny
 TgW3O9PEsYkwOvIpHbWlL8cPrh+idAZmYkI5MA/ppn903OGYU9bQh4hqD+vbAfQvZznYFu71IsL
 ifGxJjPXTAaFytGx0BSAkr7MmznLEb5X+FxvoqbaMCMG5c8lFPAhBUr3Q9/by+A8F4seOvx2cgk
 tOU+HRu8bAgngsCU0mWwtOWK1fr1moReUPK4qmpWJhICyyb08Vtnf1PsYg5j9KsDJvku2zFrgXu
 JpLs8wCFlq9P0dbQUT7JEz2hVoxi1fQ+U/4c34P+87kyj/ZyqEZPyXxO4yFPGLH3mKKz4y3X47a
 aF+ibH5+YWh7o92eMxCFNJTmo3Pjty8ufXD66MC7y8p8Lgm9Nruvad7AOzU4NGeyP75QTJKLtym
 +t8LOR/d5V1s3Snyg3Sz3ThK/E0QQe4BoNA4AW3Mi8SN+bChpP3pzkGlABphIIgk0D//jGiwhyx
 gzuZpZ/P2vtuI9e6oSM7CMF4Gfp/zqZuJOtJGMEBjX6N83ffSZNoEjEsC2ckeWjR/upemncNI+p
 PUQnVkVzWAp9MHvSKP8lcL4sNGkCAKaBUMRe+hUhjlaMQfBKdRNzpYD67BKk0YFpekhLg+JH10Y
 /e7PXbrVBvDIGmg==
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


