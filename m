Return-Path: <linux-fsdevel+bounces-64955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A52BF7603
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DCD19A23ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD23B34CFC6;
	Tue, 21 Oct 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmNbAiLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824134CFA2;
	Tue, 21 Oct 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060400; cv=none; b=lHRPe4KhXs+JbxkbhSBNHt+B7rO/EJAoNVhgATg7Hz0pM8lYzKTrDEAox4+quNCGETAEIpeX2eeZh9h774L9mUaUkkbtiKdU4G6uVxY3mpzLIbtgjo1/z5c5sAUCEXqfs+KkXLUQmc1SwGJxDz2OosRtrx01MYyq19uaQY61sSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060400; c=relaxed/simple;
	bh=5KL194cDy8pXTi8dv0lTe3U1RaJZS0i7BDkxSupOVDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tD3CwBrB4f1W/1glTRoj/YzwjpjxXWdvFSAn/avzpW2pyqd06GotdjXDtv/xiV5YfZb3KNR9aSQ+ipK8x+g3r9uLWUt2WezSg8n6hLdsp3uuWyagujExncS3vounqMP7b3hFuvUdrUupOiirbFtSzudyCh3obslptXTyp/YdC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmNbAiLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778B9C4CEF7;
	Tue, 21 Oct 2025 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060399;
	bh=5KL194cDy8pXTi8dv0lTe3U1RaJZS0i7BDkxSupOVDk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FmNbAiLKdbuqj1n3+yLXw7edwgAi3YMmopkPxwUYu95iG6zbsPiWjeduKwLt1wvGj
	 U2/Oe1pFeyQqi/TV2hyfTD8U/KTZz8V2yJW4ZRrw17bX26OpvDXejjASgoDyjx17Q4
	 trymAEPBcMdB4WH4FDQ/o6/sY7GyOKOWcF6gLhKMS95ASp2aicBAbjEEaLHszdA8Gs
	 HGnWGS8ZN3qSMfSfMYafZz48pmTHXiX6Cvqw8eg88W7RDhatsUUd1cw7CKSD5Wmqys
	 eDf0rgR5VhE0Zp9FxQ7EttIOGXk/TVNOEZe7+nYE5RrrvRyuGoLWMz9R+J4n0yctLH
	 bUOoLmNBw7NbA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:46 -0400
Subject: [PATCH v3 11/13] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-11-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
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
 h=from:subject:message-id; bh=5KL194cDy8pXTi8dv0lTe3U1RaJZS0i7BDkxSupOVDk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YGlGvZvStPLKVjUq7mDndmacDCTXRTakxh0
 UxfxYQt60mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBgAKCRAADmhBGVaC
 Fdp8EACeFGg5hC0OvCKrPGcyj0JttbsPqGpdPyDWKECBezl2A5xaWxazaaKSL1q3wsP6XJRmj6U
 U4t7VNIBnGbA1mwWJqyknxwYCV3OX48poB8pGx1QJQRuPDebqhKv1RLwZ0R0prNvS3Ru5bS3O6s
 I6tQtIgobO/Gnmy5SW7AfFUcKgZdFupFClT0QSRn5rNk292ORayPgkG+Tw1RSCB02glbEkKnFzE
 M0zOWqFzUol0ES2ZGFamBOSv60tsf1Cud6Kq+M4f53DIuhYbVWgfdudppz6T3RC9TYMTwTNGIqM
 p2YpbPGtA7cUCuf4h9TifCod+tmsZODvlaO5x+oo7dzrWEcM+xYyunRZ6V99saH7Pq4l+tBS41k
 TSCJ2tB+NkuTLc2Z3qgv22+HxL6nWibgNd1iebonCau+at4mU0+SL4SNn8iYKZrkmbNdtWsa8qr
 9GyU9Jt6ulr77IDz2VLV8mTQlItyrze2wYpE7PvI8tjHALuH1YWsdP47C7xMsK/m9q6zHYCvUEh
 VDeYY4SDS28sXTfCOLFoV8I3lzYFdIrIYLnzGyZn9zdDJc5N3ApfYjg7suZMF0J6DCud6bB+IkX
 SMo/VnXScB9HFHBgo9bCJLhd5w42vDbk5iinBeVDSFXx9xC1oVLW0P2xpKQfHnwY1PnO50bvxJv
 HZyXO82iJFuLEQw==
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
index 35004568d43eb27254802f6f5784a3c04c20fe08..8efa37055b21ca2202488e90377d5162613b9343 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7832,7 +7832,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
+	if (status)
 		return status;
 
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);

-- 
2.51.0


