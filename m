Return-Path: <linux-fsdevel+bounces-30485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7898BA79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D8A1F23295
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360261C6894;
	Tue,  1 Oct 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcPTEgr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A761C57B3;
	Tue,  1 Oct 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780378; cv=none; b=T+slMO0OfyeHYTwOrVcNNQYOmbPcXV34xegCMT2hmpZX6DnVM2sIuBniTi5Ovqr/o106yxu42OeUu3litBhi49klEzIrkGDAg8cw3edGW0oXbV/ecCDv9kakH6Ix/Y/dk5DxSqQD132Pw9h3S31lb+PwH3xIj6DTAysNZX5teos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780378; c=relaxed/simple;
	bh=R1V1oQO/HR6pPYBHRjWPfl1W07s8BDOLPrB79M1Pup0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cR8nmEYPHz7Zg+HhG2OHGYNTjM/NVMkfxfzKCULcBWnUxFB2I0kEoln5NXn6xO8wKGWRMF6w07dYNMLI+Cei1EPFf1PD3wTbN68et4qdwpIyYue9w2Xa3xY3N9At4BeZeL9E5gCoX7e5q1DycHu+L3enF9mnneZ8OofMdV1u3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcPTEgr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6341C4CECE;
	Tue,  1 Oct 2024 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780378;
	bh=R1V1oQO/HR6pPYBHRjWPfl1W07s8BDOLPrB79M1Pup0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LcPTEgr3LIGpj4IMEcDLwZimr+7Ka2J8XUVYJXcwKexQKZRNl+B/gz/p1/b1Ylg8+
	 5nl9CYhLE3VfTvJdjoQb+w0VjGkr6Q5WjwuZVLIsYjCFnbyFhvrqCrRv69UmT5XrXT
	 1enVv01CYalZXPqATGBvKz4kxfKoy9Imojb/0cKnCsxxiJclCGg+P2+epw74hC0C2k
	 m0ujunF3zeyo4m+MwsdvxZpNOOXYRmHFmWHzYWity/uxVQsD5uYUaAFVhpb8WOA0c3
	 pLmLBS9EQuyu02S9dw0f7VlIShj37pTPClFGAtaQqBXbOiCj0GmcModGTyJjik3m73
	 7GdWlXZfKyRcA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:59:04 -0400
Subject: [PATCH v8 10/12] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-10-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
In-Reply-To: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=R1V1oQO/HR6pPYBHRjWPfl1W07s8BDOLPrB79M1Pup0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X7QTZdC+qxCWqwkeb7mXbXTPnc8Dvvtk79L
 Esr57Aa61CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+wAKCRAADmhBGVaC
 FdWkEADGKsoLv/ON86grStfqxYFB5hLkrC5iL1RD8FZTihZ13PjlUIGKzv3+EtpBirfR1HR7mUO
 ExlJgkZE4GBWdZwAzOu5D+8QI8jad78VVCjiGPvZ/k3bHeXGOomYdKca/IW+bHQIBl3Lota2iGL
 LSV9Cuc86cEaNFJdUzKhMpPxpxUZkLttJOTH1mr/kBcCOVW/BSqmU8GuRbcBpbvo/09mwD8TVfP
 XUh0RBYgmfR2hyAZTm+e2ecFXTzgrINqlrdoQSWX0zv8sLQqVPPuSp/JrJu+iP7bCq2we7c0g7k
 YFte4XhTL9E49zLQOfCw9CyT33b1Yck4rppXMU0afyUv85H+h7TwNJCqRrXbCD0D2pCeueWEtwd
 OYpViuzKDxY7CNUKoqmKHqk37O1UGvATwb4zBymQvCW/iAjguRQcxVqvtWE6XL8VLAw3sAZzP6a
 5QUHD7N98tDqYbP6Nj+efzGD1Ikjcvbi1r1832k6tHWymtTwy0V9+4eEZ0mS+Ci1wjgHBepOB6k
 GDRlhIMLvA6AdeLGnE+I8adHq+bonD5tCuwBrQzVRihxan4TRqBEjHlEV3uajBoYgYSS6K31Yf6
 hjy/of4I7I1g6mQGqIrYJ9v0CQpPHyk7dzDi22K7Cp53vlktS294Q+5TJgQ7bEQo7qa3Z3OWcqr
 w/9y2eQqRkTcA8Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a4ce704460..b77acba4a719 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7329,7 +7329,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.46.2


