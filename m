Return-Path: <linux-fsdevel+bounces-23298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A192A662
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536E71F2110A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78614F13E;
	Mon,  8 Jul 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdZmqhZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA014EC6E;
	Mon,  8 Jul 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454044; cv=none; b=goRwBp+SJjCUV6IuQFkOptui3dNAsOVZFpBKXOZdCXKiJbjkzdJfVYXgsP7UktJXRBVEfB2G8DFC9kXyg5aZ1SQW8pARS+AU7ngdiO8ih0rXcuGLVivwPqCfxTYndPkEZZzcibF/TS00Twzy/9xa43F5wfu7n/iMKfla3/8Zih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454044; c=relaxed/simple;
	bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XX1lzKiPzCjbKrPOinDWi8ca9fPmHG+L92elKArBVermXrzHgCYOz1bKOq6QjzzGxwUwN1C0Km9jZxrrTes7FsYCngdv/SK0afZ+X1RJkrRqNkM+NPYwT0EQaOjU+8Cq/4r9VtnnkVbZJ0jGG6fcBxhyAYk/VwjXiionMH5+Lyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdZmqhZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B02DC4AF0F;
	Mon,  8 Jul 2024 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454043;
	bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdZmqhZEKcdRor0xeRZQ1AMbtjW8CCS6wtr9O5WYow4WRp4uGqcoWspFWu9aOgxk/
	 05tMfHGKk+jbx4L5sjDmCtp37o3pHA/E3ErO+DjPywyV7S9VxEDTgypzb2c/IgpNbZ
	 ZtaLocdM76/fWP/DNQD2TZjUMfKZcfr70nMP0S7IUdcv755TKcYHTmTEQPEU3wGDkZ
	 X3n2VKVCnCOtvaoqnFx83g5WFH/bOJeKHGmA1A00nqffpV4NGLpFSFWWkmSv1ovx0L
	 4de01hkrsGxPUOXTdsG7AiOLqm0l3pEyU5WwhAE7CZCRkeuIsiefmeENFR6jx6/xAi
	 FjxZUnHiiE7SQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:40 -0400
Subject: [PATCH v4 7/9] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-7-a0f3c6fb57f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuEhXGg7q/ZSXYWrlObmN4kWG5CFpkeFLGJL
 BloJF+qTcyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLhAAKCRAADmhBGVaC
 FWd2D/4nrrrq9qnRRkHaEtLBNuSn/vN9DMXD7XETJ5F+WVPpSdvHtM7RvXEvUR188K+EDnmqFa7
 o7+7pTjzyn+uIzpSE0j9ZEBO482oLUFDAgItrDGhJeXZUfEQHKYdukxSKgarTD5nYbYC/i4TjDM
 RXka9WXpUFUIsCqd98h1XZ+S5W3AT88rUp/jv1LD0P+yF/Lp3FGcORSuAF95AU1GrjLSoKL2X5q
 mBf4nBLDpSmvRAdTGSSScut5LJdrMYO9jg6gJf8Cb4Mc3bDRPGo+oGd2nL1kTG+WyrErLM3IfqR
 9H7jH8QQqXyvoso0FNo8KN3SCsgwXxMLq0qEv1iWFONDAyMYbmy5udOw6BEzIGBaYGMvPg9G1I7
 nRUJUZPDWBdr7unHL2np3W4PFAT/l2nh7cZkxSkTk8z0pIQVG6udI1wTxdGpuC/zptSfzJpWzXB
 fRwotHXbhtA5mXZhu3gwUW8jNFYAy389DNBbYcPp66G2Mff8KECeoEJz0lRK5nzAaV43OCaOqPQ
 2YuwPX57BH6wGkn+gvPZ0Fa6/0wMNEaZsZqNsf11YevvL/5srjIMlSr/luKwInTOD9YjtkP1HZR
 K08XctFRkt5sYW9WLrcZufyxUtPXnoe86WEOj3V8UMjB/HtQg4qUvpljpL1fhq+HiBfjzwrJ7ve
 tRYcHqYUd5VvbRA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eb899628e121..95d4d7c0957a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7294,7 +7294,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.45.2


