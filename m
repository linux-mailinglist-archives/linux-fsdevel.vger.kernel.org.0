Return-Path: <linux-fsdevel+bounces-62652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2ECB9B610
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66EF1BC237F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C432F753;
	Wed, 24 Sep 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA/E8dj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3C32ED3B;
	Wed, 24 Sep 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737293; cv=none; b=Q+KClsj644o3v181956csMIXIJQ71SSZIzE2AmM2Osc4VaxysaO9FlIZfS1JfLSVJ1IP0z79M2XMZIDBR9gnCMaZioWVpp4UzJAu2mV/CjizOWYFEwmKdtHEmwomrnbZX9vOOnPs+qty91BahtkbcWMUIDr2VZopUzljMzW+ugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737293; c=relaxed/simple;
	bh=5RE84LKjBGiK7kQFVP0HVmIwi2kwDabjZbJ86eImrfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3HGMJgubZ9PyeUSeXNmOu65r1jmQpJSIpz7zyxD2KlWE5+PmK6SVlJy1kHGuQ2veM054lVN7kseKOy5YEWTHz8qhcSG/Ma3ndylJR1NrM788Rtb4BkrDwDMFJ9/BnKOI04chqz6Ca46/EAVdazl+rDKXtUw5S6pnS+v3UAc+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA/E8dj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89CDC4CEE7;
	Wed, 24 Sep 2025 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737293;
	bh=5RE84LKjBGiK7kQFVP0HVmIwi2kwDabjZbJ86eImrfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YA/E8dj3CG45p5A9nOYxu4Ct0e+qiLCBWDWXACsedeusV1lJo4/5J5/yw84+TNluZ
	 RFmRFoYWuFnarWWe1caKPoKWYEQmgTdgIGWTMIpmmfInagWBYcMIsuEKf7FXsnafAU
	 4InBUDg7o0jePKKXBiBamjWMx20m1Ar2Soviuze4+h1gi0zaLuBqr7rYlTZ3punjDv
	 yl/OlkFKp/Rq6iUMfKBDacBoKrA0iOxMjYZQCE+YigNBtXgHz71qtOU/g3EUGN79cu
	 s2SsrkcLKIXTtGY7v3/z3Aawc4glBg24uekA5nstCOBhIN/n869AgUmDJ3tFBvwjWU
	 pgAP6KPmyekKw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:20 -0400
Subject: [PATCH v3 34/38] nfsd: add a fi_connectable flag to struct
 nfs4_file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-34-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5RE84LKjBGiK7kQFVP0HVmIwi2kwDabjZbJ86eImrfI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMRxRSjjHl8nPJXf4BAyFzpQbpkKV+avEBxd
 Mt9+NVamvyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEQAKCRAADmhBGVaC
 FaWuEADCkGKJwLiEoyhy5tI1/9I4hjsh34VlD+Q8G+2X4MsLc/16PeEvl3rM2yuASE2FRVGqQ8m
 W73GoVwhCnP/mY37op1nIcUVTQWdXoJVDycB55ZdTQ42tJfbtzCiCIhpP0+4rcCi6VJHTzvXzFz
 T4iPxJ2oRrgT5x+hiy5yOx4T5vsRJ/k7maFHfREMSCdFqQX7ztJkDvoYlxH17zWVyxTUDlxtyAM
 08n21L3sHyZx04UvmVDEshhGLRGioZW1exaIK8RykxcITn67I2ojcIbk9/vUyeUy2WSHOOXVOWa
 2xDcpOZ0OMchMf+qQ+FzD4mEpHCXAvGUPbJCD2aLpLme+VOWMRE+kc49rT/IBBH/TdGWD5oc5VT
 0UQCZV9y2hIwl0YqP3PsCGX1CWM+ncYiLUdvX2000iyokoKKX3Km6WiSkwVBNi8TAMao/q+0PCW
 VUOoFGx1/Vr4PPnpUETrV0xNAff3Kwldx6NcTSDuvlwEA0c3PyujnNquSQaNShFjBpiQJ0dmUwX
 BnQoZVcQ/ceWwRNAeekFN7gi14TtCz06z/iDU3T2m7ZxvDvd2nkFhvTn924LvaG7SSjCOL4Sk5X
 we3T6V+eA33XxOCYRB4iyIFyUdG+7tEWwxYfRRhSWIYOUfBRLXRcblYVvjQXHa5NR/Z1xgFXl4C
 Gw26b+j0hiWP7dA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When encoding a filehandle for a CB_NOTIFY, there is no svc_export
available, but the server needs to know whether to encode a connectable
filehandle. Add a flag to the nfs4_file that tells whether the
svc_export under which a directory delegation was acquired requires
connectable filehandles.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/state.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2147b5f80ca0e650e9dbdb63de7c9af6f4bc7bff..9b5f559ff6125a551f73ac103f8af2e3763dc3e6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5031,6 +5031,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	memset(fp->fi_access, 0, sizeof(fp->fi_access));
 	fp->fi_aliased = false;
 	fp->fi_inode = d_inode(fh->fh_dentry);
+	fp->fi_connectable = fh->fh_export->ex_flags & EXPORT_FH_CONNECTABLE;
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 232b64e1d7721d3074364ff788b4f72b02a6c63f..6e066f0721e6a48394e182b3c273a44d2fbb652d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -730,6 +730,7 @@ struct nfs4_file {
 	int			fi_delegees;
 	struct knfsd_fh		fi_fhandle;
 	bool			fi_had_conflict;
+	bool			fi_connectable;
 #ifdef CONFIG_NFSD_PNFS
 	struct list_head	fi_lo_states;
 	atomic_t		fi_lo_recalls;

-- 
2.51.0


