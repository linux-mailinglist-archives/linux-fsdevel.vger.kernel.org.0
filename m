Return-Path: <linux-fsdevel+bounces-51569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44470AD842F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344C93A0EF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069D2E62B7;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pa4BXj8X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5A2DFA39;
	Fri, 13 Jun 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800078; cv=none; b=DF33zobQgWIOQIKdLua+t0wEPqtl3a6HyNv7tR31x231p6iMAqNzzOFlDmpT1oaFSRM1HeQ5yfGYlI7zRpmsRvWkMkDX5loiQtvdQoIyesxdIL1Ky6YUzMQaYRBf4O/3gKw98zkCddYfG2qcYIgvg6pwzkZEyQ9XSbeyOse2hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800078; c=relaxed/simple;
	bh=Y4iV9C4umBIJQDfCkIVbrtgbaHfxhWl6IvJxU8auxJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUPF5MwI95CPvfRPHm7IOoNHo1GRPGyOLMoC7PqWGa9Km0GWdXwAUOshfgP/2QjxZdOnw6OIWFnX1mvFk9fR9ZpX5lWRmuakIHAbA/RvWqnAMgllGw6aLaB59PhiqaZBc1t3+76PZb0sz1Isg/vgEcmBLFSjUzs3sstOyJorA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pa4BXj8X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gLxodVxuYhSoBTX91ArgyEKcVSKMCv5W8OlWLT5OU50=; b=pa4BXj8X987Ib0OPJXxp0KZv/q
	3TN51A+5vzrLhd16BWQ0Qk9nuOm3V4kmLONHAFgADm0wQL7yMYI2OYST8YrAZlFujcBroxZ0zrdWV
	UqyRshut3f3YZVofMuof27YF+FEt3GYo5p+tFY1Z4XPyC1bevcyzJDKXXnfMyN3GBVuBe1dSpRLl9
	OZh0AuFslk6/MPFlF2nzfcqYG4L3JIEsJOFU5SSpgPwrfQ1kkqXxR1W64Tu6mjHQYMy3xsDlFaVby
	lGPDmBIGbshY+9ck9bQbRijauzh/j/yfzeBcSu1DM271vXedzeImi45VzCQn396f6EXZ+J6DcuBs/
	Hljtjhjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qr9-2w9p;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 16/17] rpc_create_client_dir(): don't bother with rpc_populate()
Date: Fri, 13 Jun 2025 08:34:31 +0100
Message-ID: <20250613073432.1871345-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

not for a single file...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index c14425d2d0d3..e4b53530eb1b 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -852,19 +852,6 @@ rpc_destroy_pipe_dir_objects(struct rpc_pipe_dir_head *pdh)
 		pdo->pdo_ops->destroy(dir, pdo);
 }
 
-enum {
-	RPCAUTH_info,
-	RPCAUTH_EOF
-};
-
-static const struct rpc_filelist authfiles[] = {
-	[RPCAUTH_info] = {
-		.name = "info",
-		.i_fop = &rpc_info_operations,
-		.mode = S_IFREG | 0400,
-	},
-};
-
 /**
  * rpc_create_client_dir - Create a new rpc_client directory in rpc_pipefs
  * @dentry: the parent of new directory
@@ -881,16 +868,18 @@ struct dentry *rpc_create_client_dir(struct dentry *dentry,
 				   struct rpc_clnt *rpc_client)
 {
 	struct dentry *ret;
-	int error;
+	int err;
 
 	ret = rpc_new_dir(dentry, name, 0555);
 	if (IS_ERR(ret))
 		return ret;
-	error = rpc_populate(ret, authfiles, RPCAUTH_info, RPCAUTH_EOF,
-		    rpc_client);
-	if (unlikely(error)) {
+	err = rpc_new_file(ret, "info", S_IFREG | 0400,
+			      &rpc_info_operations, rpc_client);
+	if (err) {
+		pr_warn("%s failed to populate directory %pd\n",
+				__func__, ret);
 		simple_recursive_removal(ret, NULL);
-		return ERR_PTR(error);
+		return ERR_PTR(err);
 	}
 	rpc_client->cl_pipedir_objects.pdh_dentry = ret;
 	rpc_create_pipe_dir_objects(&rpc_client->cl_pipedir_objects);
-- 
2.39.5


