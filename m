Return-Path: <linux-fsdevel+bounces-23234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51345928CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05911F253A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9060F1779BA;
	Fri,  5 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TReJYSx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7008176ADD;
	Fri,  5 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198996; cv=none; b=uJjFUmTWZEjuDBUOGjOS4vAoUl5jOO0uHHrV5EfghB0iqajrZE+jwX5hrDnd70DlqbiOI4POChZlYxND9k7S4/C2tOMzY0e45EDwdObhhjSk7rRESLjot8bTHVuz9vXx/ACTH9s9NfClbr9casqAjTqHxUUiUcPk021uEvCPYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198996; c=relaxed/simple;
	bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjefnuT26666vFKgTfVrGavvGsRgcBP7UZ3YVzlcYAZSMtHoG7UuWCsMwgxizdFERGXaex3C+yk+XQaWYLy39BSlQ9T0poCYiBEJg+tWnjkDUluVwNl+oDfnDMzj4CIKCZBKmw2CyLRE0/nbsiKUEzWgNHAxxapVugYl0X4cD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TReJYSx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9BFC4AF0B;
	Fri,  5 Jul 2024 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198995;
	bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TReJYSx1sCjaFckosgokJVYdFRsqdc+BEhrB6aLK/aeu7kaO3qZ0EY14m5FOVfeIV
	 bquuw2wB7AGQAeXWVitRFh1iucPOFXlLIvpMO1xHm+pSXrnj2JfNcK+3uImbVUJqF8
	 ooVP46QyE9vcHkMC+vCCeyxejoUMK9J7MyO4dDaDlx5SzUZ2CruJdKJrVXtDZoY7OM
	 n9G7T8zBnKQlervr77kDsbh/uWnOKDtqF9wkDmMcrFtbDcaTSw9MEBrBP63aMfsdpq
	 jPjUQE4G1sPS53d+EAtLlH0HeUSTzP0a5rmiq+sxQ5cBkQ0+jqTP6hXvUixI69VNoB
	 97ddI9/Tc46VQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Jul 2024 13:02:41 -0400
Subject: [PATCH v3 7/9] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-mgtime-v3-7-85b2daa9b335@kernel.org>
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
In-Reply-To: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
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
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc9kz56sgDasuPVWKgUS6NFCixJC5I3irJH/
 BJ6/27HOlmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognPQAKCRAADmhBGVaC
 FaabEACeX3QSlJx8oIO3SRGCQ+Om1KIdPCb3C38Fh01RPmQPMKulGZ6MoP+EegyFuxbH8BPk69D
 P0KfnfHp4PgPo/KVYA1IXdGLZl/ftLMHnSX/TSoHm5zsXYc+eE4VyfBjXrMkxK3uucFCipmehFL
 OonO5/qF6IhuwmuHA6hqOjKWjFusQBdNiCl/d0WlGJSTK2spR5fz+95PtBAKTaolM1FuRNPU0Np
 UF+bepYzTVyXvZu2D8RI386JfFI6MhEkOlR+zUbWS2j2eZZT8NUX4Mfu9g31FmS4/mM3/AWRVQy
 BWu7PXB+AJ2cQpK/KgrgAm/QYhHhjjBXk++FjAraItffpUyBIp0mpj+rODhirB/L4Ql0lDEr9qW
 G46O6Erz6NmeTBhZ/naS/BbbyX2nONvhsXU+C7E8rlLng+WVZjN5jGfHpm1Ddf0rNkZgIGUZMX1
 +sKOcVouQRuTLN9Kwlyb5Ad35NIJwQLqnH1uX+uy9v68qD5eKL/irYtkXUJS4x/6jNu84uX5uor
 67SSc5xXA7hQ+YOrHaSl91bPhqrPDmhI3w3chsfl1z/mh0Wt/xWUp3q/HnsoODCEOM2AHJvMisr
 X1ejiE3Sc9O7jkpCNMxwoA3FdcFBZlSIhPXGpEm9/tyvPIkrQqCAoJTAtVQnnIVzCUpOHoowEdl
 chcIJfIVrHpmk6g==
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


