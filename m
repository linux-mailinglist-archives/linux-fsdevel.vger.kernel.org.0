Return-Path: <linux-fsdevel+bounces-56101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A72B13143
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4FB3A9F62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6578322D4FF;
	Sun, 27 Jul 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSIAwYWL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04422A7E4;
	Sun, 27 Jul 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641387; cv=none; b=Ofg+tAjBTHT6mQI8H/m/T9tpB5eo61x76zq/ACij3REHfU3Il5oGnKwW9wnyxUw18Mr7OEwbZaCqk0Jz4KE5vljFwtl0z1vVnB/VKg6X7IcISdKcHal3/eOWiOmEZQoYidZKeDi5IqUQmtrHbRjRTsK7tllugUt1BcvkT9dnAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641387; c=relaxed/simple;
	bh=XDfX4u5DGDNsbxUiLltzn/YVAvj+NJLvOFItEakukpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThY5ZgVIn8OMuTWjGCLq3z2p28XUyULybhohbQZ+5Wk4z+17/FrtueQHxo9rGU/8CAB0OOCQ8PBkxR37qrCXfwP+wUvF/3hgTEGqVD0sEGq8s2wQi/c0n6b9P2mfcrEDZ4GxYBZVzxftQR0QCZeEPqHcRZa20lMd8R7n58obyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSIAwYWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016C9C4CEF8;
	Sun, 27 Jul 2025 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641387;
	bh=XDfX4u5DGDNsbxUiLltzn/YVAvj+NJLvOFItEakukpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSIAwYWLn+2BSZjXw1kFjg5U/mLacopZUxPzxh1ctw9m9CSaczv3GP4WPJJwFm1OA
	 BOMXO7oo1a3HyPcEXKXGbQRQiSo4dSYZdiZKBWY91F3Xlu1TvSc18ilmk7wGNsSxj3
	 daRjvOghqXXRxru+yUk1dDswQs2ShSq8epmFdxI5pMrS1flw35cGqRIwMfuBhc9jIq
	 PrSpe5iVxB5iNFXZ5OrVMtV0dAQWANM8676ngs1tyPLISkBoppd5QUZyt1LHYe2sA0
	 TpwHyT909OwVI7uTGsQgVqDZQ8Z5rjOm4rn98BnQS860dRRt69GfqpqSFbmP3R+25F
	 gq19ycbUq4wsQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 27 Jul 2025 14:36:12 -0400
Subject: [PATCH v3 2/8] nfsd: ignore ATTR_DELEG when checking ia_valid
 before notify_change()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-nfsd-testing-v3-2-8dc2aafb166d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=675; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XDfX4u5DGDNsbxUiLltzn/YVAvj+NJLvOFItEakukpE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGlOH8UIIILD0ORSvdTIZ5UZT88AECxsI6nY
 9y/+hOeWwiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxpQAKCRAADmhBGVaC
 FQ+KD/4xANew4PQHdCK1r7dlcSt105LXkHTJUSnPdbsEK/90zR9S818wFFbh6Irqyu7CMw8K+CE
 wlslK5Tw9FMeHc1qtatc3Rk1A9VQrEaRcggApd3aNlM+ITvMwCHGlIu6/3WF81rfWjGwipUFH8c
 YRMnpoT7u9H9xp6QRfAmjFB9f/lbKnEXKW3MBC4uYrw43hj/q72Ii47ufPSn1jtQH17+rJmhEGF
 hEVQbuQTId47wW9eOO3yf+19gXjsPkUwmiLeQddNoDiox1V3BNKLRBbD2jqfv/UON/bXtPk6P+a
 EKJ8HB5zMABU9nmb8Pnk8/PKdXV83y5qAzx2NGlrVYhleBRLITxeD+UxMuimfDH4qqDmAwFcQ26
 P4uLQqkVzg12QtLiTzVvEgGZHLza/ZFmsZtn8CnVrX3Lu7Jco3Fb3vYBS8MNnJZb6nsu1frrUEA
 XLksKyjXzU1W9bobwKascP718IpqMpNhbrcxqB9CqHcYJBD/m+HCHQRwrW/s4bn09vtxF76uwYx
 2YrZcTqoLlxo8w7gP2LKW98BJ5ZWRjigWJ1AoOBEKEa+DrCsJG3BqG6mpPmKJ5UY2FC7X3jtX8X
 3ONhjCnFeAzvVVtuQXS1Jydx3UmqGW1fkjmca1fVkgPHOK0+wJIS8j1MLGYZiOda8EH79xQ9T+g
 wmU2gT8u8b1CSwA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the only flag left is ATTR_DELEG, then there are no changes to be
made.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eaf04751d07fe9be4d1dd08477bc5a38ac99be3a..68d42fc5504d8750174b9a2aef10886ed92f528b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -467,7 +467,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 			return 0;
 	}
 
-	if (!iap->ia_valid)
+	if ((iap->ia_valid & ~ATTR_DELEG) == 0)
 		return 0;
 
 	/*

-- 
2.50.1


