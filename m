Return-Path: <linux-fsdevel+bounces-23567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD4292E5D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC85228517E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65F16E893;
	Thu, 11 Jul 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3RoEDci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296316E869;
	Thu, 11 Jul 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696126; cv=none; b=WCOOoWLkBPgKiRl0LG4ZhB1UNr99fBQu5zMd7FZUVlT1e4413RItn14xMgMyjIDTWwUa5lyLeUy93tT2GsAbQtPDlfRMYVR2uCZWCuz2PxozaMZWFVwgIwh5TB1T/r0fjI2KOW1FxCxF3LArQ2pIqXH7xTr2t5PKRU7lFlVWdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696126; c=relaxed/simple;
	bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Af2b2teXqvSrDMnWtB/EXDzF553F8ippFSG8YgRBmq2fC7DeHfC2Yp48v5nO6mIBGvoG6I+GmsEgmtARZsEe7DEMft3ScnlXW3KIFee3dXUtNLG66wVz17KwnySOHW+JcHO8jwEi4n7HoiVbONmUw2uPsSZU76PKUGBz/ucnm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3RoEDci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61540C4AF19;
	Thu, 11 Jul 2024 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696126;
	bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p3RoEDciD+DzxXOQ4bkKEi/2XUp+heLaAS7X8Rk2SnsiE8e8X+bNY6DnQrWWaPCg8
	 vDT2+s2Xj2d05hRPt9U1h20xOMTqaC4iyDa9XL3ktuDcG4PfpGXLsckn6gM9Pz76vr
	 7tmNuLiIYwtH2KSw5EBteQInK93cspWsfKPf2CsBJWRSYtQGXc17pRkEFbbJ4XVyEj
	 g0gBE7VDIKgTumvWLyAQHqK21u+zMeksCE0+4ZxsZF/zS0xNny2zd5DELfTBxS0IE0
	 3qJKTSkKQD3mdSNnbQxQ856Qipa1ntOZjZuwZcThGvzVEeTFW+SsAfTzXBGS0Nhn/R
	 q+UiX+o4cfhtg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:11 -0400
Subject: [PATCH v5 7/9] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-7-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
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
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aIxGR7na/Qdc3ayjXzlWsssXh9j6/eXvzZW4Lz1mI/Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70lLGwtVIH3fc84IqxhCflp0IWdNwkGUMG2A
 KdkQdY1RniJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JQAKCRAADmhBGVaC
 FS6uD/4iWWotu9rZZKKFv50AvekdwtGDtGPWRiHDnyK+Z4WsUIEm7Je//sOMkTYveYEOhKTwiw2
 JKNOdXyMaZppvgpDkeNa4cv9LhdxnQCV1yGdeh/RorjGmeNAekQF6FEuvXnYZDjU/b6P07Jhbsf
 BD3rSONfp1FDpMNZryrsO40nWnTF3Jk4xpZ23j/5uVlj6otGJOQJTHR233i+gb7LSlKmYffo2kQ
 ynpKKfUFhGoIIYspBFefTrK3pEVBGuwY+mlpteZbQofFI5+pYXqiLj2PAgZMnRAja5y9Xww1E52
 0gx8Cysjr06dcF1/CMrXF3hVDB+/NQzXV4a6EJDcmWL2ap13OLgV5LYfhpiSM0dLZDmSNK6+Vxo
 I1MJVA9Rnk3W49gq/rZD48IRm2M6ctw+raFZic5nKFC/qKSrNKp6znW9JPsQLbclpwn5s3BS0CU
 kTBWse7xWx83BQ4pbJl2np9CXPeprNQqup22HN/p5+jTqcaos8t9mN4bXfdA4xhnTMGcOfCY8QZ
 iGnLSJ7FaKQex+xK/q2E/1K2rvzPtmDJKFiVvSRgIUmpQ3b2/4v23Z671/UGCpCgT1MtYzzCYvU
 FbsAT67Wp8UNzXVatlzSKXwQvEDyRbXasYy1gEniN6W7uExCqQf/k0sA0ToW/ptxlQfb/z/EFd0
 /NYocsP6uJA2FgQ==
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


