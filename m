Return-Path: <linux-fsdevel+bounces-67173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E2C36EA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2013B1A25EC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD7337BA5;
	Wed,  5 Nov 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knfdSpUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2F34DB46;
	Wed,  5 Nov 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361701; cv=none; b=tmSBuhFfqjOj1G8+ziyBlTLc+JGAnP8WQ2HGwAWM/FsrYbSKLhkee1VWq492tnpysABibq11UPDM/yei0/j++EDHCkGVtjbzInS4T4GT8kKTlJi/DfTctYeTVD1qOw30G6fHaK7qKOCEkHVECTWLq4G/0/HFLEdmtBufKAJ9mwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361701; c=relaxed/simple;
	bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kb3uObcbriNeVYPod0qHnjKrDv3R8T1T2zAR9XfkUT492XpPlxq5Op8jTuJxXT4aSPSDcWxAv6cfMZa63jDacqe7kev8yIAbKeq4GKjJy0G1uETGgo68ETRTw8P6XOVbdFgRY6tZ0AYPggNCI9ottf7lYNmoef/Y67ywzEq3VsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knfdSpUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2532C4CEF5;
	Wed,  5 Nov 2025 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361701;
	bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=knfdSpUQnWPn3itXlZlQDx/8tNajmeoKCSJ7DuRO9rI1Qdov/KedLOSm9T96JJlFJ
	 YtPlj+PgoVMLh0Be5iCCEoQO1JFzk5bDjkDwLv3I5lkf19qj+CC+tT1o5PatGPRF3M
	 2IH7GV7JtO+JEl32SYC9iBQ118iIkjVEcfnDXXPymEJv8ezfkhjW/OU3c3zlXwG8Bc
	 samk4zx7TE453p8UakAZVOU0WPhB2igoxMd8atpUFlTRU8lPlz2+18muxQSKJM5iYz
	 oZoPThxlI0SRWVlxANzmvKdhu9tZ4U4+pi8yA2o7c1/9WmhT6HyWMogT5HP8gK++fm
	 NlP7wzS42Ol4A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:54:01 -0500
Subject: [PATCH v5 15/17] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-15-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4EttPFxRPGR+DCRBfozxNBfOp+kzrdRKFxz7
 noCX+Ay2kGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBLQAKCRAADmhBGVaC
 Fc6GD/90HKaWLqhYzTjprv+oduTewzG4BBOMbV4qDkuJwfCgjx/MK51Ie5Q1TXGZkSmv4OqYYCU
 lMUug/7A79bJpNe1fb1L+tYySlZG8FVCYFngqLzt80zjStQuHTJy40bURvtPDVYJFNwIrv2dA0m
 GuD6E+3ibyQw0LIEQoiz7LcTJBuuj9jSxMcz4MZdUZc0ueXwSmR3SIHx1ZUBRR0TOEFNIP/wiaA
 BYNeTw+y+/mMC6ETFzpXyxrcfxwqJnGBiLJ8u6kjYcR7gNjC1Xo+L4Fzu4pFGSTpuDgseyw5Kc/
 VyVXhGs+CP34+LwjfMHmNQxZwdE7k6uHd7/ePTtn9KJQzX+xK8UzIuOVFzZUo3PoNfVa5ZfzvRJ
 JZQTibc4EH02p/G79FV5p2E9ByP+faSi0In2VyHzeDrl8KRbJofc5ZV7oxDRCaLL7r21cFL+9bQ
 cyv77nNUw/EA0qW5us/bK9iSWmzl8teC0buXooh92ZnI8N9miYfmiXZw8C/W3Sb0jq9sBhV1YIv
 ae4JWmP56hQtGGKRbWesdqPjp74qO7ZC2+OWM6ENDjUG6KWGY7nEwHkDzCn0QnursNbSg9StrZp
 0TP5gHffpIDIhZM1uz4gm8zjMr+QSsQDZ/7naG56/AOO44ploBGkZlhFNL3PVjGj6olYlL1X7Bj
 0/gZ3gCwg9yDDOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Trond pointed out: "...provided that the presented stateid is
actually valid, it is also sufficient to uniquely identify the file to
which it is associated (see RFC8881 Section 8.2.4), so the filehandle
should be considered mostly irrelevant for operations like DELEGRETURN."

Don't ask fh_verify to filter on file type.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 81fa7cc6c77b3cdc5ff22bc60ab0654f95dc258d..da66798023aba4c36c38208cec7333db237e46e0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7828,7 +7828,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
+	if (status)
 		return status;
 
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);

-- 
2.51.1


