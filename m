Return-Path: <linux-fsdevel+bounces-62653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28FAB9B628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6331BC23C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA832F77F;
	Wed, 24 Sep 2025 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYrKVroK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDC32ED3B;
	Wed, 24 Sep 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737297; cv=none; b=HXKtq/k44fTs0JOjdjo2Nh/06ajDeibHLhuOWLZLVLBr/0f5xN7cPPXh8RuaZl9i4NUa0oMzbKxTPmG6B3ORonI+xIu2rASdy9F+Go9RAs6N8z92KzwuUwCRzHhfY2+zv/2utAqVQtDpTPpWIfCy8W8149F9HfD2GCk3XH82OAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737297; c=relaxed/simple;
	bh=JcxHvOXRYhqMkY14M94w4z9Ug8jggTyMKTC+J+FogYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0aRqF6K2nBlPmViDbakVqciBkf2QOMQDMfoMH9RLGxcWNqdufj1W3s7VAU269+HdE9xv9uwuY1hIZqV3AcCH0THGa/VCrX1MPyY+5KaJWWL8UEbPRWfH0RQJWa2mX2GwDSmOeiznVCkXVWbkgxMHynXhYMtHP7en1VJu6N7xaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYrKVroK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E143C4CEF4;
	Wed, 24 Sep 2025 18:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737296;
	bh=JcxHvOXRYhqMkY14M94w4z9Ug8jggTyMKTC+J+FogYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CYrKVroKognKGyWB9Khp7q2/9YJAJJ/aMMMUsKkYjELQBwzwhzgK/5MunuasK5+Vl
	 vdp4dU14cCba6OrhYyI9j6nwjdOxyDnxEsMLwT5nnKjyhSCTbyds+MO9vqnvMhKfeN
	 jU3o164yCn0v6q7pLaudF0PEX9OuEWvOvFL0fqYsZELFfVFO7m0WjU3bbuJPUYoDOQ
	 wYRZsGusEsucvCr0PRJPiWDf07YJjvMFa06NIOHzbjgZ6J5Js9cZ7nipe4vQv7gFYq
	 j25jRCw8hvXgctZcepjiqDQHN51oM2MdIjx2HZr3PiJUCxgUa1Fj4rAr0jrCDlZ0gu
	 8UBcBc2Bgqvcw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:21 -0400
Subject: [PATCH v3 35/38] nfsd: add the filehandle to returned attributes
 in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-35-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JcxHvOXRYhqMkY14M94w4z9Ug8jggTyMKTC+J+FogYY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMSr3cJZS5yFuKni1oFHmSbQfCCXUriSX7aj
 bSVrdvcLCWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEgAKCRAADmhBGVaC
 FX20D/0cBxr4r4QLJsXJsinTHcjuG++fMzUqJd2npSJ0h1ODPwmueysqbrgAgqoCSZPN2twuS1l
 hTOQJ/+VX4shakYkkwGw82XJyuC9hpHeaLpHd53VGMw9/3cohAGcdHPrM4mDtuVi0ej5Nq5J5OP
 L4cy9WoJUQZ06G0q07LaXOMwlMu2YsXjpkCJW/lzblzgieaElwGa1X8GYCc4Uqd+Ss+5Q/KrcTq
 HSceA4lfDgoyy1UDwBDxtt7flxf654yvujoUEmQ5XuO/dTsrTN+OOTtEcwIqZPt4i2S+sUw4n0U
 +Rk36FSwchwN/iKRNJIb9e/YVDcCT+N6FMFbxruKiR0ABYI7z6Mj8OoqZ6k39X4qhzG2DFe2DYS
 G6Ael2x9srOzzmZx7E/K3iqrXKniTuyEpfgd0wgLXlCZaej8ajgxz5uw/6fk1PhuuTsp7rxMc4y
 fl0n0xQL51DNmHJodT6yixFjN4UiCR/azY0TIFTLyqumtbd5kqTCfZxhI9Hy2MqDID2z3hsBblm
 9cO5DW8UYjOqLXnwwD0Q35eVdp+h8PWFO9E7a6ZJ0AzXwl/IPBqPbxDpwlvgW7/mNRWHPTjEQTU
 Difo/x/Lip4wz9PC8oG3/W2l9UAbWPBf9EWiT8a2avlvGzypkNRjH/wnKHDi7cgBJKXIfZ6N+6w
 KUutQZo7O6zku4w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd's usual fh_compose routine requires a svc_export and fills out a
svc_fh. In the context of a CB_NOTIFY there is no such export to
consult.

Add a new routine that composes a filehandle with only a parent
filehandle and nfs4_file. Use that to fill out the fhandle field in the
nfsd4_fattr_args.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 822a9d47dd88df579e4f57f04dd6737653f71c94..11b622aca5111502b483f269b1fce6a684804645 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3763,6 +3763,39 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	goto out;
 }
 
+static bool
+setup_notify_fhandle(struct dentry *dentry, struct nfs4_file *fi,
+		     struct nfsd4_fattr_args *args)
+{
+	int fileid_type, fsid_len, maxsize, flags = 0;
+	struct knfsd_fh *fhp = &args->fhandle;
+	struct inode *inode = d_inode(dentry);
+	struct inode *parent = NULL;
+	struct fid *fid;
+
+	fsid_len = key_len(fi->fi_fhandle.fh_fsid_type);
+	fhp->fh_size = 4 + fsid_len;
+
+	/* Copy first 4 bytes + fsid */
+	memcpy(&fhp->fh_raw, &fi->fi_fhandle.fh_raw, fhp->fh_size);
+
+	fid = (struct fid *)(fh_fsid(fhp) + fsid_len/4);
+	maxsize = (NFS4_FHSIZE - fhp->fh_size)/4;
+
+	if (fi->fi_connectable && !S_ISDIR(inode->i_mode)) {
+		parent = d_inode(fi->fi_deleg_file->nf_file->f_path.dentry);
+		flags = EXPORT_FH_CONNECTABLE;
+	}
+
+	fileid_type = exportfs_encode_inode_fh(inode, fid, &maxsize, parent, flags);
+	if (fileid_type < 0)
+		return false;
+
+	fhp->fh_fileid_type = fileid_type;
+	fhp->fh_size += maxsize * 4;
+	return true;
+}
+
 #define CB_NOTIFY_STATX_REQUEST_MASK (STATX_BASIC_STATS   | \
 				      STATX_BTIME	  | \
 				      STATX_CHANGE_COOKIE)
@@ -3811,6 +3844,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
 	attrmask[2] = 0;
 
+	if (setup_notify_fhandle(dentry, fi, &args))
+		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+
 	if (args.stat.result_mask & STATX_BTIME)
 		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
 

-- 
2.51.0


