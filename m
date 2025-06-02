Return-Path: <linux-fsdevel+bounces-50351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F73DACB11F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C52818980E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92424239E79;
	Mon,  2 Jun 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsLYoqQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449F239567;
	Mon,  2 Jun 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872986; cv=none; b=fpXfjwbGQeavwBUjtQLHTaWrbUutsnLceGCyZ7Cz7U6hVFrDT5KdGf49pXsNO41docPFB4vvTwi6Yh+Fgf3XO/04d65Xy6Ku48TGdBxSiL0+EUcD7s3M/zG/c2lO9a5MQvLcBaJbYh233JPpmOt2x6ZtbdOKUtsagXB4nDI3bMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872986; c=relaxed/simple;
	bh=x1o0Ihmm4BVt5ZC6hQAevJ2br6+2hL/MI5r9KqN/NNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZBZ/n62ibmrov/oYy0agCE+cdgicbo2bmZHAvVLpAbc0NBeFQXa+YktbdivCa3NjrO+ruz5ba8uzQ8/tqEMs/N91hd96QY66+gsk93Deir9mQEWROTEdcCmSb4MWCrWvUItyCI/yrOmt2ILyfUpFHTuuvrzry9VD15NPQynXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsLYoqQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F21C4CEEB;
	Mon,  2 Jun 2025 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872986;
	bh=x1o0Ihmm4BVt5ZC6hQAevJ2br6+2hL/MI5r9KqN/NNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YsLYoqQW5Hhlb2D2ckZkD6c/4IyvIKoYrf27/Yq57Kcoa2bi1S6Iz+6lNWKqPwkha
	 UuwJt/f/3+P7VHseotyV8M0fCmrJOZZYZMREZdBwr9hnIB62nDJVvdwJNb5bqZ10Q2
	 3+cxc6aDE0lJf7LBx5QqrRVMjOnz5R3wbc0mv2G/646TJZoLoSkUJbPNHMEgUCdhoo
	 q4UVtOSArgpNApBT3TkqaD6zWte/ci3JogL8GF5bbLFCJdZ1+D8SEUe4NmkUSSIiOt
	 RGf6gntioX3oRbO6HjX8SEN9BgydRmJK/x2McPFUrn5kZ28rit1peJrpIffJiQphf3
	 51T28tXpuzdPg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:04 -0400
Subject: [PATCH RFC v2 21/28] fsnotify: export fsnotify_recalc_mask()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-21-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x1o0Ihmm4BVt5ZC6hQAevJ2br6+2hL/MI5r9KqN/NNw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7pfOaDl5D8IUu3Zh9z/dAF7GZkLHCc/cGwt
 tkaZ2PJF5aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6QAKCRAADmhBGVaC
 FbhgEACWbSTkaxvAegVDzQuZYFsLQb8pnSrkPTuqXzRpePBGVdykoJdXrH6HntRb9iUx1PJuaVj
 PKp4IsKLlg5SebxTEeYQPuEOC4q5aaDObvFQJg+mXt5vpQ6pFiVd8R6Rpgpujb3AlI/qQ9Ye70J
 JXdL5NzcdBlxk8f+sxK29NGNJ4ISvnlQBFIDHXrB2IDl/H6NkKpNWt/hx+vXk4fEj8XAoJ7LU7Y
 K5BLzc/GHENujpMuZhDAw416cLBIrVY44a9qXoTNCgpqB9vKSev0EInZjPJzKFuwVa9uAVkOdnp
 gz4Y69ZjSFrF/i/5GQLyJDE805cq2H+tOD+eil5QkMBFkfRvuaNMHUtiBKN3LeUbANyQtkMTVYM
 zi6akgLPnib5fQ6Fgc15gBf5SyUvsTlMPJovAwbLBd/G/GbczFoEOwYN3Ocu5pEXDb2TL6ifBlf
 4tdTuFBozBlQ/hISmeKTJqgDhzdVo/LGk19NtD9JPAUGlhTwRBL0tEdDjbSJiP8QhBmzzAsdp3x
 JhEd1t3J9V27WEqw46/2J+pgsnyZS0Emn6JB3e576fUDOQuGnLqTwm9RBULMZYCmTE4V/5H4Q2S
 Flpr95jfb2MBhrD6bQivvFwfC3R4nxrma0JMd0Lp5LtZZdWJ2crVQ0hrjQLsVhuooUOG41YQrq7
 SZ2rN5pPtEaR7Uw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd needs to call this when new directory delegations are set or unset.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d761dd05c1b361c251818dee89b9cf..ff21409c3ca3ad948557225afc586da3728f7cbe 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -308,6 +308,7 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	if (update_children)
 		fsnotify_conn_set_children_dentry_flags(conn);
 }
+EXPORT_SYMBOL_GPL(fsnotify_recalc_mask);
 
 /* Free all connectors queued for freeing once SRCU period ends */
 static void fsnotify_connector_destroy_workfn(struct work_struct *work)

-- 
2.49.0


