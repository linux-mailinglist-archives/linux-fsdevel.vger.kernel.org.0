Return-Path: <linux-fsdevel+bounces-62649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79385B9B5B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344A616802F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C432CF62;
	Wed, 24 Sep 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk5Em+hZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62931D37A;
	Wed, 24 Sep 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737282; cv=none; b=QYdU/wwu5/PzPJKTnSCpqIkamOT28dgWiA2mgfpe27N3uWuTaQq1LithaFeLDcGNJqGqOlz7M50CJv98TbGgYEOz6tCny7X0vGOPxNPuUUMJipl9wieiXCt/1nhx5ejJbcntgDa1b1KfGpGsc14prbpIWrUh/c7vBchsKrC9EW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737282; c=relaxed/simple;
	bh=1IfGS6y61I8ta5ngi2krf2oUWMAL8emeB0zZ/r6QSmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abBeLaTpCxlhXpSJQnrOslDwnuAlzeCQKsN7TI8ZBHuCmhzQWoxlRAE1HJ3KW53TBvyIG097BkaOKNYgjpqJK+gTe8rD4PFcSXK5A+meZjgdiYcasbgwmU6vn/6l3RFvq1ClrYcKVWqQDAUzdQbxL5PPAfJZZ53kny8Lu9OX7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk5Em+hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4203FC19422;
	Wed, 24 Sep 2025 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737282;
	bh=1IfGS6y61I8ta5ngi2krf2oUWMAL8emeB0zZ/r6QSmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nk5Em+hZUqXcb9a5WrIujJRu8Ym1eB8lDBO9RAObWIPYuRpScVIwA/l0/Kh1jQseu
	 qwStz2tb5lFRaOAXf37cTnj/E8MEJTbVZh8JPu11udeomOSWVwOoRyjSHRBdhUyCtw
	 313eas2hxPHB1chSyh1OoU/014jhvcAqUceyUPj2GGhLsdIvwoGb1mLeGMlMlbVhB3
	 KoDCsqpP/64Qbs8PzdglKcJorOLjlefJLQpXsfPR8N09Qflhrm6MwUK7zlXtyHPisd
	 LydYxqri2UMlNC/ih5P8s+VWaOO/LUZHUxuWSJXSTAYE7R6oQT7X4remWABEvN124N
	 Qhx4FNFo3sK7g==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:17 -0400
Subject: [PATCH v3 31/38] nfsd: allow nfsd4_encode_fattr4_change() to work
 with no export
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-31-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1IfGS6y61I8ta5ngi2krf2oUWMAL8emeB0zZ/r6QSmU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMRai7sphepaNa2UzQgbeyIdSiI8XOICWIt0
 /fA24OcZdqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEQAKCRAADmhBGVaC
 FQo/EACaTi8TlYfe+cBRmCg7rU0YFmAIUWHAWkguF/qytDsed9Oi2jMo/2fiaTEh2K2434zEkYQ
 +OqWNzcjQWplahAUJgtvFTFfHPBQ4pAZH1HgkV1d1bAf/bDIy3qYEzacigBUMuUV4gDkWwAsEEI
 MLsAz5SPQiLmOO3qd1oLDNxgYrRmbzfPYrJnawWATiSKwKLjHSuiJu8arKP2IghZE/p52yiPbbn
 gtvyDMgoKgT6CMpmlw3JStrS1hVBt8ymXFHpAZVP2mATf+baHN9R6DuvF9I8Y2rZ3kK57KRduRf
 xNBT0zne377eEfEDptOhre1nAgyHG3fLia+XgYWEtYeNrZfkfy88WLXMkgzusBuxCE9ynThVQxu
 RHb2RrZbgalhPDnWZU5E27AIdObqeyoSYAQSaqwX/tGzm3HtOiJuyQL2TCwWy+PgMi3RRW4AAHr
 xHarHChBNd53Tal9Y4B0F3fms/m7WvzxWHHKti5e/rOO9VyIN+cJDqrspv/fHdtUnqpiZ71RhvO
 g75ygm+gBHVeKeDLdhoT/qjWG/UtrCrqoPMmK0pOK1Rjs3LssstBaCShuugoLay8BDi1g1wbzVr
 /TC9dTE6MZGNY8T5ju9Jogdbrk/NOC579Yl6DIQaz54LY22L7T09dJ6xMAJZuw2KQR8SX7A70eG
 bSoS7gT5T61O/ng==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In the context of a CB_NOTIFY callback, we may not have easy access to
a svc_export. nfsd will not currently grant a delegation on a the V4 root
however, so this should be safe.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9a463f9c8a67704d90d1551b7de59e4e89a2a81d..d1eba4bd8be243022f89f6ac58067c5469a8feba 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3027,7 +3027,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 {
 	const struct svc_export *exp = args->exp;
 
-	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
+	if (exp && unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
 		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
 
 		if (xdr_stream_encode_u32(xdr, flush_time) != XDR_UNIT)

-- 
2.51.0


