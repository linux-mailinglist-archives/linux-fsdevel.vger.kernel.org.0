Return-Path: <linux-fsdevel+bounces-56100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE61B13140
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43681772F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE4226CE5;
	Sun, 27 Jul 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9mG2wYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258162253FE;
	Sun, 27 Jul 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641386; cv=none; b=W+v99dbU33sfGaQCusdnUt9UhWOKXGl6M0X35BObbshja0z2bTN6KiqZki04OyitZIiTrG8nVdb+uVOJQDAU+2qD/ifIpzXSyakLXFc/9FZ9WCUQbAG+6OuUUT/4GrIRTYc1E3qILIY2KO4eKtnC0gymu57XhQ1gNVlSwGfiBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641386; c=relaxed/simple;
	bh=wX+jZhM05ADBnfHIbs04wC7/mLDtqIQ+H+KgWBk6ve0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAwUeSi6KDtoDhNCYS4ORKsJmVj3I4YqUhQUccmD3/9Zg2D32CUlgbxZjhurLOEgyDgwB0YzVQPXl0BUO0gplix58RbogipCsYgtFVGi+w1sZp21tzM+PHVUCZY6pm94r3nGm14SAMfiGmPShL2OMBaZtHaj5JZlIuRhfkF2XXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9mG2wYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64560C4CEF9;
	Sun, 27 Jul 2025 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641385;
	bh=wX+jZhM05ADBnfHIbs04wC7/mLDtqIQ+H+KgWBk6ve0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n9mG2wYwa94UbZ4p/3F4N4tvjteq4TYUsHWu0uW9/Sf7PGlIndG3+FDvjgEJxH5QW
	 sVN7V2+Znt70kuGjB27PfDdhuDasZANp/Ajw5jiHxXnWOSITzqkqXlEr2qiZShkrGR
	 mjSkLndFXUxo8hPM2dkvdkSs5+JfVvUuJWyOds0Pig0vL0wWfA5o/pffqzAOB6xTND
	 oA3Cj5fmUtxiAtajIsPRrJwixFL/NzI62GG1Q7+UUNXc4mDD/Nv6x+ZjflHP4IfV1x
	 si2FZwNIzh8vULRasf4atZ0Wc1OLxAPnc3BvpGH9deIiMwqsXO0LQhf+GP+agDwZvi
	 hNCAmesY2vpAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 27 Jul 2025 14:36:11 -0400
Subject: [PATCH v3 1/8] nfsd: fix assignment of ia_ctime.tv_nsec on
 delegated mtime update
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-nfsd-testing-v3-1-8dc2aafb166d@kernel.org>
References: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
In-Reply-To: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wX+jZhM05ADBnfHIbs04wC7/mLDtqIQ+H+KgWBk6ve0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGl7UXl6EFyujtglWHQECzmgMQ3mQNU6ot9j
 xI7j4TRwEGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxpQAKCRAADmhBGVaC
 FdGLEADMMRJ+fvYN4+akt/isW2b/MiRfbGI2KUKrtOuD+PgwpMT3dBevsiViI3rtMGciH/jHmAx
 uCUeVPbrNmAjtTDF6MyTfGu3XgWunL+0cPGKMT/gJNeVawzi82obIohAlj7aTJR7+7n7D2B5/WG
 FyTCuSeOpINTLvipFs2lBY2WsgZi+YbxcWhfwBeAYxOmyxnjGQCyBTIUDOq8GghA4AemzEHGQ/8
 DYEzgbJOpY5fhprY2Q8fWfYsi75Pzdsdhzets+Xsv40uAWVGVq2Q+rJyZ4ZFyehSrgyJL4BfzZP
 Fyx4RqwjucnyBQ/co2qiA7jULx4uCxTbJLIOX2B+fqeAOB0GbmusK90E5SgkWzFrGwe1PmjTocS
 WsMoQNv/uuKkWLPl34thQ0YodjkBUTFGojtsMeN2jUQubotjU+OiNJOhjiMZORXmvMa7jL7AROY
 kIOvXrO/45dE63R5F1PpczjV5DkFehKz8CNN02u3UviWIMc00yYdHWz0ffwpUQqj9qmJNXMVgQ5
 X4eZDU6xpwWh9DcqN4PhLK+vaBHV6aahJEseVbedEOddlNJoEmNk+m5noF9vSXKYPUOHwh6BFP2
 BCCzvm7e/izb5z+qPXvn3bHLGoBQXRMBB75bYCxHivlApJ/BEO9bx1V9GM/6exxqke7MZwL3ma6
 qRl8CcK/2dlBTtQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The ia_ctime.tv_nsec field should be set to modify.nseconds.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..52033e2d603eb545dda781df5458da7d9805a373 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -538,7 +538,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		iattr->ia_mtime.tv_sec = modify.seconds;
 		iattr->ia_mtime.tv_nsec = modify.nseconds;
 		iattr->ia_ctime.tv_sec = modify.seconds;
-		iattr->ia_ctime.tv_nsec = modify.seconds;
+		iattr->ia_ctime.tv_nsec = modify.nseconds;
 		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
 	}
 

-- 
2.50.1


