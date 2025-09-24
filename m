Return-Path: <linux-fsdevel+bounces-62650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A478CB9B5D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AA02E0129
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEAF32ED20;
	Wed, 24 Sep 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj9/M65W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC703191B4;
	Wed, 24 Sep 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737286; cv=none; b=OXN2svV+rLCaL2bR5sdH/maNzrOmDNHeTnHZFoVTEdIsJtm8m1QUmp/Ze5NtIln6kQicKA/LBsEfDC/uJ3/2l3e+EbvkzZ/LmYrZt9+IHZEyOD6ljw4NiNbvvvydNHmnRaWlieQHU9cvWRzNXwCm0l8jx7In+EZ2iqV/q9+YKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737286; c=relaxed/simple;
	bh=Yb0DmRfzIW8mYKknj70/f7qtDH44V7RUbhVqY5+tUj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKiiqpwA8M2EeBbKi7i+OTh67utm4xqPPf/XyhTwl2XdEhA/5uhtTd+feERklb+lXJcvcup6Q6I4URKX9qeXgF9ANv/4ZMjUbfw5Bul/xqadZn8djEha0lEA1us1Nj9VNzj0XBRtT12xOJbnEjUdqTNtM4IN8NCRDOa8a9jiwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj9/M65W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC60CC4CEE7;
	Wed, 24 Sep 2025 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737286;
	bh=Yb0DmRfzIW8mYKknj70/f7qtDH44V7RUbhVqY5+tUj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yj9/M65WsfeQKO9eklHqBzQ0nutOo/Yf45CPsyQJm/Hp9BZrGXSe2jBY+5mvwmeUJ
	 djPDKYepA+DZbA0CPbVmQsvsYmbIuyfalZOtmxUyphhTr+5EZGsWs7M0i1OvFroNyX
	 VTtCSQhD0shakJWz069XlniBDL20h/h9Y1f3CJVLmPVGaQs1fFH9Cql2wcKJgJZOcA
	 NtP1iUo/v5U7wSY871kPMRBjUpYY3xr2Vr1x285yZdZHstI60X7v+folzVnOyK2gXn
	 LA/PuCiCw0EpuMQo3jHvhIRxRELCOMSWjiEb/4bSgkqS8GDaAmThW2T/9BAIgPWnQZ
	 1+AxQN/0y4Syg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:18 -0400
Subject: [PATCH v3 32/38] nfsd: send basic file attributes in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-32-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Yb0DmRfzIW8mYKknj70/f7qtDH44V7RUbhVqY5+tUj8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMRdM/SNrtKr0wfgbfJ/uBdnztZq8wVEs3AK
 TaEZz5WHOGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEQAKCRAADmhBGVaC
 FatnEADVyh8WtE08835RDpDtcQEHIPUIFHo0DMhfwERLMttDavODenEi0QnFiD1Hj426bZ/J5zF
 7bEt6rcFxjAmyEEAO8zqK1kd/bMLJP3SXe9ThAwneqe+aHrtmQKdaTvFXa737eoG/PDbSawQOz1
 vhoSMZm3eng3/IT0u7Z2kI+E2QLr9Ti3LLqrCIVGR0UUk4+audAOeJFC6OvmDTfyFDjnah4O7/O
 4VWTx48+GxWB1hYyvSBIWBQxAEzUm2APyfE43HD6dzigt9dSatnvhhV7Q6C+Cbld5wTU3lKgutI
 kd9ykIQqnmQak4y0aPv0tkDN2LIIChrV1QcO+JHHxG3elSCw+IxpsBlXbpCVROhZ1B+hZl20NhB
 h+OlkgJIZ5cp3V2J+hhIDWmOQcbrOF/GDaqhRQRqESyD070T9gKHPT3npy03e0SZBC14vIv2P2i
 vFT6PirzKpLrm/ByCgze6xJag1gJaBQ+X0O0IqyZFjZXiMJ/LbMAwplqC5Jn5g1sQWDrXuFaQBu
 ApSI/uBzBQMTZ6ChlY+RQ2Jcnu+BZNYynY1hur0wwwkPo5jyFj6slOMYzCphQTQEwBj2KdaRAza
 Z+8gnEhXew04i5CBfEKKMbZDoS34WgcrC+vNTRCDOV/muIhHfhxmxwcQFo5gH8arO7KsKqigQ6E
 YieMwjDMcKa20lg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In addition to the filename, send attributes about the inode in a
CB_NOTIFY event. This patch just adds a the basic inode information that
can be acquired via GETATTR.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d1eba4bd8be243022f89f6ac58067c5469a8feba..1db2bd974bfa9d899f590f4b4e869115ab73aff6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3758,12 +3758,22 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	goto out;
 }
 
+#define CB_NOTIFY_STATX_REQUEST_MASK (STATX_BASIC_STATS   | \
+				      STATX_BTIME	  | \
+				      STATX_CHANGE_COOKIE)
+
 static bool
 nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct dentry *dentry, struct nfs4_delegation *dp,
 			  char *name, u32 namelen)
 {
+	struct nfs4_file *fi = dp->dl_stid.sc_file;
+	struct path path =  { .mnt = fi->fi_deleg_file->nf_file->f_path.mnt,
+			      .dentry = dentry };
+	struct nfsd4_fattr_args args = { };
 	uint32_t *attrmask;
+	__be32 status;
+	int ret;
 
 	/* Reserve space for attrmask */
 	attrmask = xdr_reserve_space(xdr, 3 * sizeof(uint32_t));
@@ -3774,6 +3784,41 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	/* FIXME: d_find_alias for inode ? */
+	if (!path.dentry || !d_inode(path.dentry))
+		goto noattrs;
+
+	/*
+	 * It is possible that the client was granted a delegation when a file
+	 * was created. Note that we don't issue a CB_GETATTR here since stale
+	 * attributes are presumably ok.
+	 */
+	ret = vfs_getattr(&path, &args.stat, CB_NOTIFY_STATX_REQUEST_MASK, AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		goto noattrs;
+
+	args.change_attr = nfsd4_change_attribute(&args.stat);
+
+	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
+		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
+	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
+		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
+		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[2] = 0;
+
+	if (args.stat.result_mask & STATX_BTIME)
+		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+
+	ne->ne_attrs.attrmask.count = 2;
+	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
+
+	status = nfsd4_encode_attr_vals(xdr, attrmask, &args);
+	if (status != nfs_ok)
+		goto noattrs;
+
+	ne->ne_attrs.attr_vals.len = (u8 *)xdr->p - ne->ne_attrs.attr_vals.data;
+	return true;
+noattrs:
 	attrmask[0] = 0;
 	attrmask[1] = 0;
 	attrmask[2] = 0;

-- 
2.51.0


