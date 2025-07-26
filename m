Return-Path: <linux-fsdevel+bounces-56081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF3B12AFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F430AA18D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC3288534;
	Sat, 26 Jul 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTSIijLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B41F418B;
	Sat, 26 Jul 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540328; cv=none; b=loVldVk4NKJyXOYqWChe2h16WBVndsh1rKlchcB6Ub4r6xo/QVPd2AWtMWRhQmS0+UlhVC7O7iZhzVs+Da0pJLtjeT/mRy6Z6JKMOSHILDm55dmc2Z+A5i6UOw6I0ZdEd2LUtkIW5NMmPPbd09QhtRtOaluj/YcwCXKhKPt/Mfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540328; c=relaxed/simple;
	bh=mllCwPj6DFXflnCokynS72iAnT7y1fHTRFT6HF/wY0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFjGQNe6eLFq5mFqSVdjoyuvXRPLNXQ/n91Q1KNZOoA7c2OerebUXglJrrYR9OVGjEGFJ3kaYZUFfLKcthMERdfd+84r/SySFH5lGw+MOt+zTlJMFcSO5j3rP3vZ71aLfYDUVDOgGK40ikLZI+EyUvJe2k4NFoEg3Mq7iMiyXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTSIijLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA618C4CEF4;
	Sat, 26 Jul 2025 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540328;
	bh=mllCwPj6DFXflnCokynS72iAnT7y1fHTRFT6HF/wY0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LTSIijLeO2ZDLhdXgiZFrgZQ4hcgtEAOdzXWlw/gtaet6h4mJXIv4i3t5fw4G5tmn
	 ukpTvXrNwekHCew8iXNovOsLH9bdyHD5joVfSWYLEy8vb1pC2cpWrBTQa7CM/P1DzW
	 v+qohV36AE3DSL7JGfSNg8lY8TuXQU3/9lH6vI9FRtkeanrhn91lKWtYJP6Mgbu88Q
	 pJxXVKiVC/2WpFwEL5dTdY544sQa/sosow0y2+dLDqMU/YTKr0WaheROW/jXe6SbE4
	 B83okeL2Hi7weFyMQ0znk5EtZgG2b+8vmjnm9PTb7kTKWGSt/YFgFQITaQuuld2q3e
	 +65yQspdkDyqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 26 Jul 2025 10:31:58 -0400
Subject: [PATCH v2 4/7] nfsd: track original timestamps in nfs4_delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-nfsd-testing-v2-4-f45923db2fbb@kernel.org>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
In-Reply-To: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mllCwPj6DFXflnCokynS72iAnT7y1fHTRFT6HF/wY0M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohObf5vYf6eHZexpl2tdgIQBRlhYg5k/CB7zNS
 Qtqf2Is2GeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3wAKCRAADmhBGVaC
 FVHlD/4wEeSisUzy2cOJj2eHQFitOxNZ75zC68DqX51dQ+tSYIBTR5KzX1xQkQ6WWVGk6lJ5AXx
 gU1v09XrwREoMzDkIJIK9FDDFigovYpsWId4uqUq13sKj1jtOTMg97CEyYXXZ4ZBy26YHVHdtaO
 ib2eJKtMk9yIr4llGv/EOhi9gio/fugeYBkPtszvt0iYl9frauW4p04Qud1F9g4XEjiANyHb/ny
 cF5dkxfNDdrcNH+vxSA5fNYXGRHDhzfHBGTVjxBE69+1Pl6e3NrGMZtLDD3hEIUNKFxrGixDN/J
 RWOtmw86mi/PAYQLO4W6aXYVuC/l/8i5A//xOkvWMdTzboVkkMGM7Ew5ObFTqxKd3BnpoaU7IYe
 TpEPirrNOGZCTFb7sHNfwSGEyuF4IV+hdzyU24pfPA0tZDhS2j9wqh3JZxpsSHmspdm2KdK/qo2
 V6qO1w40uSN7jqY7YZPYZcqTMdhNHs3n23FFAtUNhpsxCwZ6o8lvrbQUW1gOPHb/oWO5PLbeMFd
 SnhePojyUi2iKKRHs4tYRqWtBOnV3GdosOF28al3Thnb9UvfOwBtBwIwPjQ7lNfxWG2L/R36BU6
 eHvImRvXEAzTgOOBsD8Mb3MbPoQjkJC6pHTgAUcSEl7Q5jUnQcfd/VjRPWx8a707A6RtIDvgP30
 GXAX50ClADOWB9g==
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


