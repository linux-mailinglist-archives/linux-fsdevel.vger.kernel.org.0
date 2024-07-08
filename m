Return-Path: <linux-fsdevel+bounces-23300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520092A673
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B101C20E01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81957152E03;
	Mon,  8 Jul 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKGmbJG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750115253B;
	Mon,  8 Jul 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454049; cv=none; b=Lbsyjndbh1jK6yEMpdB6UV0da/Ukv9aUX0Q9MCd8g+trlWpx5lASIwLvEgopLkJ4tGG3HAPA23C00Qlk0WgEWVkMpL6mY5/WsmZUP6xe9tPqqoU5dmyBzsOudtZZs7LR/+4FsrEzMV2du2VRJ4K02ybddMvRe5/y8oZsk5jjbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454049; c=relaxed/simple;
	bh=pHEQop1T1fiyamd9jcpDhT/4UZTaEZSdDGTRt6fHlCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pProLFYyJcMk9tKQ6Ysv7W6yOuCABZdT0rgyfEs5x6+21JBGPo9D7ld0xHFZZc5xj9L6uSsxp9lC2eamXiV0D+m4pWUEsmpxcnR18iTMTcKr/dFE223o/18K9+ldaGw9i5G1/STJhxHaxA8wAajwcFsAP0EsDEbASQSlz+wTgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKGmbJG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB567C116B1;
	Mon,  8 Jul 2024 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454049;
	bh=pHEQop1T1fiyamd9jcpDhT/4UZTaEZSdDGTRt6fHlCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UKGmbJG/7ixB3W/bGJpEZHxm4Uec9QfxZrgFj7++PEuKgl87p3bp8kWMv6leWLkSL
	 SVE0ZwRWnyuoBKzcBAsY3hxdEa0X62Miv77RfoVOdaXSkuwwXlhguWYSVRCWyNSR8w
	 UqoXJK6nxT/+k+DVz/Gl3FaKt6L25Cz9EQCL5H/2V/kCaXMFeFETwv0moyo4jhoEX4
	 t/GJxOCYUspDoZ2uG4F5c2jWw9oAwJGe+MWpZhRyY2YBRCjpOE3bHMVzXy3RGvcUua
	 XA3VRpPMWHL8cD2MZY1fzsiDd6vNFGncezD7lV3qig4l7B5Ga6JVX4VgJuYhxQ3ZER
	 Zj6EIUg8C99vQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:42 -0400
Subject: [PATCH v4 9/9] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-9-a0f3c6fb57f3@kernel.org>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
In-Reply-To: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pHEQop1T1fiyamd9jcpDhT/4UZTaEZSdDGTRt6fHlCQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuElSf4XFk52fOEHI6qnk5nkcaimuSsPCsyx
 xjkO5P9aUmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLhAAKCRAADmhBGVaC
 FesvEADXYZRR3EQySwlhPXaMFRM3Jq6pfSUAjqchFJ5ZK46/YfRIrrnfJ4JbxYnbmshpJcBbFpR
 0/5Av6Pr9UhcqUkFzuoN+lTegRgHwDiMg9lrS8JZ+RlrxJ/mI1jSkec7pdJeCA1o+uEspCwJlVV
 l2Cm9Wm5OJidm0vx4cGXlLZzmA4IHAdkNfWh2OXgnzFFtS0l40kW+3PF0/WGTPKccPdHhD862y6
 aGl4SZcQo2KyHwKsueuBZ4tdmXuTa0JkEAbMT4bH3FxqToAIDJA4U0MF44gKItQuNoJ2ZaL2Q80
 a3i190J0Loaigui6n9Cpypmy9nDd74qzubrfpMJbIqFWEwRZmDlHfRnv7nbY871QEYQ4xpJ3ili
 ceNhjnXNEO+drx5Re8ocxYDKT6KguzKI/aKc2WahemLhWKP7yaspe4q9VcpmjmlwAgf5tUCteyd
 vL0qw+tr6LTcIURjivpx/9GIxekvsxkhqUC8fzHzoPesyDiTUDc40q83qFeo7qhD1gSz4BEHkE9
 0xREDDycM33VqUVh2mPB/yAqqTCv4QDPuSl6S7UbBkaTsKVuI4Ib3fx3f0H3D85+gcTUpsfJwua
 sVJEZzud7NP7tgknaFzBM7ymq8J2fUaKNM/KfI0Xna2HmKe/3idcid7UzQ8mWcD7n4ta6cF7NGN
 kEUJE/n2ZdSh2Sg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 440e2a9d8726..6dc817064140 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4649,7 +4649,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.45.2


