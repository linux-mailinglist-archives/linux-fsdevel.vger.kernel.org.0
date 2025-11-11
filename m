Return-Path: <linux-fsdevel+bounces-67952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5388C4E679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F8D1899730
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5136A02B;
	Tue, 11 Nov 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBriXazs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493936A01B;
	Tue, 11 Nov 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870436; cv=none; b=OcQXE+cPGqsyLv927iY6O2BhZoX+WRPtX3uGwzAb7DrzZ3MsbxgymclN/qfwyM6se8vrqJBibgaogjg+54ZySFWaFFy623X64XQ2W1uOt037oOMNsxdSK1WNb+2Tb6WHirKfJnp4CUKyiohkOdHVh8HWJw6qJ1SP6BxlioRsryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870436; c=relaxed/simple;
	bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MW7gLPvmtd72ECZ+R3JsK1cN/p5KJGZN1A7BCYRDvylaBc1kY90D1Wx/lkZDJHppym3IXdWYpEuZvqz6Ly9DeDa+axGFjL/uGz18/nmP4d+xDC5bZuu3uJmEAh0n/2PgIUy7ITzg3pUOEnLd2xhxLk3HN/goLT8/ZiHeaajoG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBriXazs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583DCC16AAE;
	Tue, 11 Nov 2025 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870435;
	bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sBriXazsGvwzX8sfYOAoq6YOjrzTz9m9C6K3aqyg8PpCzCvY4JZCBPE/4yEdrOZEf
	 mmTxKD173a6r0SHow4/2EFTDvLoFkwn48cHacDAMVlecwUdWmlsZc0wJdIB9GEQKwJ
	 D2JywEUtfYXroa7hEvkEiSrzT7w/UqlpNMAWA1O+fw2BnIAfaQsyLjV8afDcZVKz/a
	 +Z83MmQj30CuG37weAlonjzUFETuXkx2NtJbxgGIu6VV8fnPT6s45Std0bcyWWospw
	 IEwx5myLSUQ20/Pn6xs6rEEp8pA/qwqxnXvdm38SR6KxTth51lkCN2VXp0wy1cp3Qo
	 Ybz2ZgymNvQaQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:56 -0500
Subject: [PATCH v6 15/17] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-15-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
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
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yulLeJZn1mX+cSvDuaJcOgJyv8hH6SOCKBioc8zxN20=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RqWSACxk50vyNQMQP4PR4OYc58LpTlSBjs+
 2A3IG27B8GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEagAKCRAADmhBGVaC
 FQvtEADOPlbj0rDKzXOHmg547rZDguovFl+WNjgEQKxUTxUVDdL+z5sZUZu6KbqrqOGnOcTI93b
 2ehze8MZsDpKz9NZBbNebzkoP38Zy5LqyOZQ7usMdiqHJBuPBrQsf+eWRrS3YDbgzenrb57Zg2x
 2nCAwKgvgJjnXm0XfsNr/32e3wiG/w0+YY+DiPFyPormrp1V2WXVZy5rh+CLDGgGlUC5+yDIhuV
 XY54Vm3ysK1JAxWFpbtm92jXv4h6R0BAtNDTQOl2BkKz6bW6NxVhOfyyhSRAsaYG7Bq/L9IdDhx
 ybJl6qI5M9PdQgU3+PMnEKZ2IgpMwunMqBKF2MZQNh+QgQeyM7KCj6569LMPUr0nceynnnDzx+V
 NrWN17J6UJZNzuKzf2/CLz5XnxkPeaYSIYZTzJ8RnvDLSAL/wf+l+4O3QWp2o+Itsq/d/Da2UVO
 TxuTKygqAYG/jtKEkj4jAZZ7hFtlvKIbD79hMw/HgX/4XgtuhEtHKOQSp2wC16sk6O79TvPQJIf
 1qFWAwdSFlstTGK0Si5Qo6j19/1LwoyCgY6vhsPBPHnqFmhvPNDWZfwY++1qv7dBQ22+2R+RusH
 E+Q9C90sZUwVl9T8J6lkjJ3PebfP8xhj+M5bbhpBt4mzEvGSBt52fXHmN9zBCw1IlJAm7/ppEfI
 wfUiePRk+RTI7yQ==
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


