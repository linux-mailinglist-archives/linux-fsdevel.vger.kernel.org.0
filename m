Return-Path: <linux-fsdevel+bounces-64487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2FCBE8676
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB5FE4FF020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C6393DDA;
	Fri, 17 Oct 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjxqErQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9F330331;
	Fri, 17 Oct 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700776; cv=none; b=DAYZi/RzBO3cMggRJQIjWkIEo1u7Jme8roqkLFlvXGqiGDoStb7+JJ3+FzFVgiYCKAVh6kEtlsQImix1yZAxe2fCKAtLe+bNFHSIl8PJz5LDTx8StfaTZBgbJTpbnlc+rKdvEbvMUVhC44a++QwzTIY4GgHwPUVmLdsQoC5iRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700776; c=relaxed/simple;
	bh=J5we6Oj9umwD8eK5iokfF/EbyCh2/ylz1MJttYCYqeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J0hUtn+YT9eBbH07Z/jbkwKQJB9QIlveEQ/VdSOgRJXa4EYgYnrbf0XZKF15jZj2/w3lxkyDjDeMtXDYB0mZdkShXeiZ2AC12deTVaxuwHtqMDUkK40IZnbHS7GhLBIhLR5O6iL5UWGet3ZYF7e3NC0RTq2tKT9ZOzRySrCfl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjxqErQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D00C4CEE7;
	Fri, 17 Oct 2025 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700776;
	bh=J5we6Oj9umwD8eK5iokfF/EbyCh2/ylz1MJttYCYqeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jjxqErQMA621E1yRf7VaipX9BIV9U5fm5gP/oKUKoCg98c09OSn/GxnRs8T4LIptU
	 zIsyL/8y/7vhukEdnmoNBAl8t2XMTyT/I+FJNsDQqVnukrTYxHV7lD1+//gQ3dvclb
	 x0hgXqSkxsbGzvRZsrNA6nU3/gXq2UUWCI85CMTwGBKpuAxDJcB6L/ycCN8tl5twRi
	 nASX69izfqkVKLHgFAe1MypBrtO6buQL50un2wZ71D46wgorN7Wf3tA6r6n9f7pd4b
	 N6MVrt6E3Y8WG7/1fd+ORwHqR7aZ8feGO51I/8MHzvZ3iWrBrFho3FHw9W21PJghjM
	 vVUfnvkqJhEIg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:32:02 -0400
Subject: [PATCH v2 10/11] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-10-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=J5we6Oj9umwD8eK5iokfF/EbyCh2/ylz1MJttYCYqeQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilCAGkGsw47MvRREQlQJQZ+ISsRDRTLDUtQv
 n7WoFo8rU2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQgAKCRAADmhBGVaC
 FcD1EADKeSf58pm0DeMKqyvmt+MULuxJcMZopXd7TwRsuHlfEMlL3hbPqOabQo07QrZOht4s9Lu
 KHlPd3wa4O8DHV0yMnEqdRrkIKqFtXYpB76ap3Xcu5xFKswTCe4NNhc5A64i6p+8sZwQcFzF4nM
 4qYY3FRUitA1uB+4SAHJr3FLUZ/SFj/FDPP0FVkQlGhcdtQE9R1jBUePP9fdvmBg9BWRdwDBx05
 liHCcpZh4bKDeaxVmq8ZVX5hdTKIAwMgUZCrIbbn7et06+93zKzyng9mRDyLokn94E6KxUbDKKv
 6db9BnUSXELDV2fxTTaFoVGLA/jgNyNEoX2jKd//h19/gAj3Hqrvq8myydGSm8OeYF5lOwmu76F
 AtBAB81glByya+IhvlvxHOFV6CVht1MlRFW0ByK7gLznf7S8nNFtmN2irZkSfNdH5KoLO0obQw+
 9+lgqiy6M1ZWU0wBziQiTekdia7W/fcPHZ6Ksdu/mzgO5KcXvC2dwwhrW+S5cU6PsQm6yUqNgR8
 fSQBqqawg/8HyI7IBPi4emT9AQMwmhdqFbTo2RMNfqGEJJdADjcvjPrfGBNSFG/gfDWCjpQDXVi
 qowmDcJ9LmybVmQ16Y0zr6FvTUX98M8c7+VY5uvj90zJsb4ADza1fHPBLL1B7AXM7Sh4dE2GX4H
 QjXgjr3pkJcZwkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Trond pointed out: "...provided that the presented stateid is
actually valid, it is also sufficient to uniquely identify the file to
which it is associated (see RFC8881 Section 8.2.4), so the filehandle
should be considered mostly irrelevant for operations like DELEGRETURN."

Don't ask fh_verify to filter on file type.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f074f49ecaf0c7a3db78ec147136e..b06591f154aa372db710e071c69260f4639956d7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7824,7 +7824,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
+	if (status)
 		return status;
 
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);

-- 
2.51.0


