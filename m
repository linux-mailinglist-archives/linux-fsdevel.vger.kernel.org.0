Return-Path: <linux-fsdevel+bounces-14499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0787D1E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378BD284456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172835B67C;
	Fri, 15 Mar 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUnW5RJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3795B664;
	Fri, 15 Mar 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521622; cv=none; b=t18JExnXdcTK8p2L9WIrz1pUOl5e4S4npUd7P+JPd7qOE4rFz5u2eaqj9llLSJVEic7vWtD7+riemB5xsXlOl9OehRQyxAtJoOF7tpMTKSQG07Ex6bWcvlpQUQOBJr+zidMKDfwx8TQq779Gy1upnooOLLB5To6b7TR2BNpnjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521622; c=relaxed/simple;
	bh=OiEZefexIM68VHJefg6W7dC1hIlEpf01M9ECnJ7jCAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHD+e9sApbpAVPIn7s+RxTE5y/S4o3WkjoRhPY8ERd2iYE0Nc6RYft4rUv8G53NqCXGBV5j5N0/Yf4R0Te3atzmjtPKnWUE3J8Hi/jHktVhlJxiwAsaySyARSbnnByjjhfwLe710wYxgRUkKDoynmCMyVP29m8PIk2bJlQN7vtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUnW5RJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3FEC43601;
	Fri, 15 Mar 2024 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521622;
	bh=OiEZefexIM68VHJefg6W7dC1hIlEpf01M9ECnJ7jCAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JUnW5RJd+BgZBkpS/H86jl0Iis4Orkp4l5LoP/m44lmU/zoqYFK5iOf+zPcpWW2DP
	 EHmnGAFj+9oxTTUV+hUeZW+YeyDFSYBtFh1jFrsp3IVHtp/GFREBwMIGelt7jLzcsc
	 11UP6HuKVCcCGMBf74lxFJ+ryCvvwEt24SHE+O0PS7O8zTzrHxWUEh8EABSIjnidBE
	 UdhK5rdamea0Lc/ScOKeaFrBJvU+0Bipb3nX+7uNZHgFzAzR4DT1Uy/hBkDa7GM9WV
	 GesOK9Vmx11/M/YvQGi9FQOhQfA3ZGT74ighkkvs107Xq8hSSzpRLGomrkjVnzCElr
	 44X3ZAU62Iscg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:02 -0400
Subject: [PATCH RFC 11/24] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-11-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OiEZefexIM68VHJefg6W7dC1hIlEpf01M9ECnJ7jCAM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzusMS1CmGt3vVgFg6eaeQpLE4HDnWTQ53Hm
 +kXZ6P2QvOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 FZyfD/9hH9KoMcs5bPmR43gVXALqNXpGQKiLRBR1clk3cQsQO71gxXwRFQA1sIlvrvzw6IL6X/K
 eAN+ucfon4aVD2fvfQMmAzL9VHPiMXJSIIoouZwcPp9mudKmtf3BWBMNsY2FmvxkdVW4MbxfUP9
 ERB4QWjAsgQVWv6SUcQhjjoZ0MVZiG3yvuH//TVNLH16xPrzxFp40siRB/utynoxxWMMxtnPpBW
 Gz76hsrBQhUDoSx6s9NIv6BHV3eO/3XFBmuNSu5qFSiN19o3VR5fJFvM3pjhbXS2O2d1Sem2Omh
 n01ucuOAs7hV5rgrht5FhrnQqVDlo761Cay8wAWeVCpEXrGP7IsP1efVJlJkhpeRWGYnuQ9YRLY
 O/DH3NPIeqWWohCiLBBxYTipIR2+gdA5F9QVXK0xr+JpzfbBj+cCxuKDK8QtNOiS0FnJ8L2yWLc
 McVABjaXpVmiA0StQufkkX2d49h+pLQugA9XMVJ51fVR/SmrU7eFfq6vnaP7qJoObC1MQ5/+YX8
 udTuhAaxuRPxMMFfhVIuH4eCcC49+ZTY1o0grohOjsq2SnvSJ2xpfgpKnflZrdswNYSQ+kU7miV
 R0dEJWMNloeZlU7dvof3AQCs95xEGIKDSKtOtMyZRydk09Tq2jv0neVSM6lOiGmmePst7q6ZnCs
 WPDTujwK2c2XFig==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

fh_verify only allows you to filter on a single type of inode, so have
nfsd4_delegreturn not filter by type. Once fh_verify returns, do the
appropriate check of the type and return an error if it's not a regular
file or directory.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 17d09d72632b..c52e807f9672 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7425,12 +7425,24 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_delegation *dp;
 	stateid_t *stateid = &dr->dr_stateid;
 	struct nfs4_stid *s;
+	umode_t mode;
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	if ((status = fh_verify(rqstp, &cstate->current_fh, 0, 0)))
 		return status;
 
+	mode = d_inode(cstate->current_fh.fh_dentry)->i_mode & S_IFMT;
+	switch(mode) {
+	case S_IFREG:
+	case S_IFDIR:
+		break;
+	case S_IFLNK:
+		return nfserr_symlink;
+	default:
+		return nfserr_inval;
+	}
+
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s, nn);
 	if (status)
 		goto out;

-- 
2.44.0


