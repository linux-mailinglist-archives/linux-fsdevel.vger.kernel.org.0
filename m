Return-Path: <linux-fsdevel+bounces-14506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E781687D217
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A585928150F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA365E086;
	Fri, 15 Mar 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLPvsPtQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D05DF3A;
	Fri, 15 Mar 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521645; cv=none; b=VCdWWhsRGdiGlaCE/BgUHejTjULhgHoLUF1cB3se7S3anzKjjeIXO5tQp/Erbg83sSsSfC79xsY4bJ4MyD+CTuKZbXw4pcv96lg5Gystmnf1ZqyYGZJugLrXrsI9e7+L1w6spSqdAmXMTkNfV/LWmQTQ6LKFjVRro5MIQJ97KDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521645; c=relaxed/simple;
	bh=XiLoCX5bhdIOKqVgg6TYQoclvr1Nu5zRdr/p/ktT9jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmvvTutwcBUWA0gyJ4705t5+nAgkef/EpR2X61nQgdBd+KwRHC3mJmqGpnmZQfgf4JI8O6264lKhU9c8a0i2GE2RaURmWuicofhxK6dZmB7ZY815EXND8UdZOP0VLtz8OttTEy9wER1IGBaU0LXWbPQ5ODrNnW3hn8Yj2P/CY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLPvsPtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE688C43141;
	Fri, 15 Mar 2024 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521644;
	bh=XiLoCX5bhdIOKqVgg6TYQoclvr1Nu5zRdr/p/ktT9jI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BLPvsPtQdNH5QPkGe5nrzfrhOhLNi2qwiwA2ylgWSBrlb8XTozNQ95eRiDkApXBll
	 Eq/eMNeqMJxZDFAbeyaPJb8yLCrV1oTKxOV4sRgugj+PnBh8S6DZfOmNr4wSWICVab
	 I5QqpFrWSpRjYP1+RlK5lZifRgcaXmY54Fm2zkhqTwoveWgpZXmf5R3c7Todz0zo81
	 pI+rzNF1Jp0ez4zvsj7YUucHPhITnQWcxkyFNmAcDyfNWcSSIMqYF29mAECLJJOmvz
	 SVdnJUW4+S1K8Mapl2DOyY4KX5QyBbkA/+cgzyLr6AqS/Jpro5R9JA+INPyQubZ3dF
	 mxOhzh3d1u28g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:09 -0400
Subject: [PATCH RFC 18/24] nfs: add a tracepoint to
 nfs_inode_detach_delegation_locked
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-18-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XiLoCX5bhdIOKqVgg6TYQoclvr1Nu5zRdr/p/ktT9jI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzuFU9/qcgtCrWHrKJL7PuqWD46v0PKpVFYD
 d0wkTeXPv2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 Ff3SEACwqsjqTGfQkWOWe61DrYWuJK3UYZgCteOaTcV+W2NWpxdnkFRovxC3Se9EQLFO4XYdz9h
 sn0mFfChkDAvBCMdBVVXnmiUSbyibhezGotYkv/OvUgiXR7EBtFEkB+gHkwRKlMDjJ26di0puOO
 uSrdJuCp0u73L9RkjUAQldmInEzMQ0/BoGkzflTS6JtvfYM2lWk8Vl3zPA1d+PC4V5GbewJQ+EM
 V5H4uqj2ZMEpL9R8oGjTpMT7MANepirW1NOyv6fwvSqbNg9q9q8sbCSyDJ3SBvLOeNcvC9ftk2d
 aTdXJSePeMTuALlxkeoa+KdleIx7qwV5d0pYLnLp5Ln6LfRe0m3pybLzBcLyKgIZ2evFWpbm/KP
 EROuJMgNarMgNsejXdkODcuHcKrt77wRFe4HC93mAQQSJVCxzF8BexykjGwbkBmEM2Qy3HQy1QS
 PVEMszQUJhJ7Ljm4y97zwWZftIkSfahruJsqoRXJd16/qLTJHrb5p1dkZFAvGwsmaMozMu6EOaf
 3EVaCPZVvYPu+Q5ovAeQuueGEkvAoZcV7dwrvlFmpWuFv4YfE38lxbNby4N+UNXQsL5H1GbLRJf
 PXVHfP5hiziscco0g7ByP2lUwWP2uvoj/h5wG1zJT9XgMaBX9nQ3pjZNb+f8BYuBV4j+0qxneoO
 5NqX/6yGWQJ5Gsw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We have a tracepoint for setting a delegation and reclaiming them. Add a
tracepoint for when the delegation is being detached from the inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c | 2 ++
 fs/nfs/nfs4trace.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d4a42ce0c7e3..a331a2dbae12 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -342,6 +342,8 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		rcu_dereference_protected(nfsi->delegation,
 				lockdep_is_held(&clp->cl_lock));
 
+	trace_nfs4_detach_delegation(&nfsi->vfs_inode, delegation->type);
+
 	if (deleg_cur == NULL || delegation != deleg_cur)
 		return NULL;
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index fd7cb15b08b2..b4ebac1961cc 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -926,6 +926,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 			TP_ARGS(inode, fmode))
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_set_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_reclaim_delegation);
+DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 
 TRACE_EVENT(nfs4_delegreturn_exit,
 		TP_PROTO(

-- 
2.44.0


