Return-Path: <linux-fsdevel+bounces-29326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF179781DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C1E1F25DF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE861E1A08;
	Fri, 13 Sep 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuAeewB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92F1E1326;
	Fri, 13 Sep 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235686; cv=none; b=A6+yMFhC78ysq3jjObvBRRePmgi9/aT4QzJvMZ6PZX2LzCbveFwSptC7g9QDaubO4VXHkDA319OabfhNcTz+uggHdDRTQPc0yF1EW4rCSvVqsnxpdiKT7vTUCfNh4vMDlI8dfuRoEw/LTJAlT82MxRtDmy3P32BI3I2iyPXa+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235686; c=relaxed/simple;
	bh=Fd5IxgHtKcN7b8Mow1VZm20amle3gCRV/bljD+jCFMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+OHKRNZvYV7YiUG/jSAsnR9mU67uv+ts7fyBUgObpdKWU4SMo3ka6elpq9WKHTVnTIgbBBEmY7s15lViSEhQCqf0ysPDC+eWIsOSJGyhSmRPxN23RYshiTdmf2AEiEPX5vLnmXhQp5oUj2DLszCffN0WNrfXMBDTZ5fhDemmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuAeewB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F73AC4CECF;
	Fri, 13 Sep 2024 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235685;
	bh=Fd5IxgHtKcN7b8Mow1VZm20amle3gCRV/bljD+jCFMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AuAeewB9Uk7nJE0YghyMUcM9Xs6hH7Buvcm/8ac7LUircjJ8rWbR972Y3zmopxj35
	 dHOxrhzMWZQW6+Ws79B1QbjRzDJfTaA0kiad8DS4JBRVlnsnHLYC1PwaP8lZc99++9
	 D1kH/eGfMk6TCGXCy8hPSW60oqJwsZ9Tkou1a7D7EGO5tcqWkwFizJT4h7VgVXr9k0
	 Q5obx6sQ+NBHF5bYHFWxqUIyTh4vTzgtrwe8fZ7E4HBK/l/HuSkfwOi7oiSvqa9tWY
	 pqYldPVtk6dJdZ9BlYGDbE82T1FO68q7vsNgRcqmifwK/TCMW7RN9VYg7PKB9sj59G
	 wRS3JooNdN2NA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:18 -0400
Subject: [PATCH v7 09/11] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-9-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Fd5IxgHtKcN7b8Mow1VZm20amle3gCRV/bljD+jCFMs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQJL6h7gS7IiFUm1AH2Gox/Iu4o0pKKpwApl
 Kim5XpJ0R6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECQAKCRAADmhBGVaC
 FW87D/0a7vdE5p5oQ4JFJCRWyOBMckH3r9Y3OOWcv+EttrTbdiLCPa/rUw5s4ZYKOk/rN5BoRkQ
 CB2QK7M5veam7/xYvK2iv4okI6HbMig8Tzq3QFpgitnqYPwpugbI8Oti5AajHA/kqQUGPH5YQRu
 pZSmKs4IjJuG4rGNeu4d4j5oPW7UwslRmPL3skIKxFYYm0s+tDzeVo5+CLeMSab7n9Qxnyq1zAi
 McegWVYmasqTxVRAxiJ0OVPtf/3VwGbbXAd+PURarKFUkGoNLkpjm6Q2Y2uKo7N3z+FWGns+i0Q
 rkU7m1LmbBP16Lc4z44oh17/sgwU9zLQsZqu+UaeDNHgnMKTRE0eF+ddR2qJit+RRTw8uIkN7zj
 egk9PZZrC4rVou++Ngk7kTOyMRfFMHhsoo3in12P3kM91uwSbtx6w8tznVK9WnZC6wwyMJYhOYZ
 YMA+ZKF4oTlJAaoeWSWkp7uAbZy7eUGQO4DOUXOMayJQYdt86VFvTjQMn5xG1LkQ2ssY0+zWaS2
 kEqLUYyjpYm5s1vs07Qe6/Ngh/5yaT7goaFapf3Sjxs0JXDJz0MOkxy2TccBCvY/MLT8FR0emSf
 RDi8FwFRjVH6VoCo3raSm2rWAvMKE2v1yByb0bWKucYzavOTCasGbt0HloiZ48/hDiQaDVl+OaX
 si75ypYgIGP/+Nw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..a125d9435b8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7298,7 +7298,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.46.0


