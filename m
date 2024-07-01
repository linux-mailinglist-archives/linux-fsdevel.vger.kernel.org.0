Return-Path: <linux-fsdevel+bounces-22865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644AD91DCBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20108284DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA4015B118;
	Mon,  1 Jul 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbCgOOtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792C158DBE;
	Mon,  1 Jul 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829651; cv=none; b=MW0C4l5PeCrxc5qYErcJkJlxGvM9muidkVv2Nj8JKIcJAEzjZjMd6ZMiEDS4iVJVwwryvcYE6YJfP8sWIOFnM2gnQGQV2ExohT13VfGRG9895BshlDdfEORP7bzfp14gzz2bAJQdQJKyvlVJfx+aDypPdgxacuydaDr2JwpbkwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829651; c=relaxed/simple;
	bh=jBp9emvazqFESk9G7QwGGoZvRRiz39syH6qfqPr/6xQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjYz6l67rBp1F1CQpQ+9upApn1JvTxGdW0j5pKFcbv6zC0/6KdItF6tKicwTk1LcrH4/qKQw/4fu9kyeCRC3ZgC9y6HLPKiXntI0gUAgbLSuvW2qpi79ATS7pAbokdgBVeRKOf32WT+xXXAoRuIhziSBK9mdfKNzv6Iuyk8buRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbCgOOtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47338C4AF0C;
	Mon,  1 Jul 2024 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829651;
	bh=jBp9emvazqFESk9G7QwGGoZvRRiz39syH6qfqPr/6xQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CbCgOOtCgUjRuhHIWfPhLp3fatj5tSfEke2ujk22gomfJxaHjykanHdCLJsVPENww
	 2aXenQM8IIxPiVGUyt0GORcZ46T9nxZTtaoeuMzgsm0o3GEGcpZjgTtzXmmKT1cm6m
	 paG8e/3l7XyGgoXks1x9hsLuZTQIQ9WQ+d11FHIuP3WkhBypQ+Xs80Y6c+rvklcoyf
	 XB8iYZErJozXyVqVesry5IgFJWyVHnECAiVfCO5V1zTVGWxTQGpfiFfPzBdGxr0/xD
	 NiLrOWZX710iSvmB+1ivdK4CDLwx28tslbEbRW7GPmgFXcwRIU2sWF9bY5cDeu7lSo
	 DWDIWNVIC/gdA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:46 -0400
Subject: [PATCH v2 10/11] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-10-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jBp9emvazqFESk9G7QwGGoZvRRiz39syH6qfqPr/6xQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR5DeUDlpeVrrOk9nljfFxINKx8vAHQj6+ym
 pt0XVjbScaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeQAKCRAADmhBGVaC
 FQ4KEAC7+XATsQb1o9n+cr8hbr/gERAz5tQsrEdtwYNRSvbbaYxIt5s/AYE4ciw0lt0bl434GRB
 9LRV0yRq0wV3vI8lfLFfplAztGqVXE6BMg4WTH6etk66sx8D1Objgt7jyaDYUNAWjRjkwKTh26D
 /eLu4mVHkMzueOfI0DtfM9U6DhTwTOAhSHj5SKw9BrNiwNEvfOwuMS2rNx5xOAk0bIsCc6zUDsU
 OofZ/0TrsSd5jEvY+JXK871Q2ZOYcBbki7pVhHbNJcviwvBCa1DlSiqhzp2+syH7dGvjxWyTQ7O
 UUayRkml6sjLFWnGzUKGDR2WNHTVlJObHQvzuElRDK+m9jJSck/6KA/mVrtF3Vp/5y8Y19uc+gs
 1Gcmh3yjdhp0Q6roRW4tl4J5AYxO/xVnUF/Dw73sLkMmZl32xuCIva8Kwg71aqqEfnTd8twX2bp
 X3W0nsg9fUiQJ5PgB/r/+IebovLu5sn3XaOlGN9//EQFD73PWzCRl1Hm9oppgPWK0DrQI0PwNhQ
 gQFFa8W8IeZRaUTIRo8vYdBENdYU7UTeW0R+a3aduMYkonp7z3CUtwhKk3/QDFEmFRvl5YaYJdV
 QFwXrAsHexrEk0N7gn/NqHuh/K4IujwcOfcF6b4xmMmaQqsBReLMbGaNf6c1TFMWP83vRfKduyA
 wR49eVH/7rg3m+Q==
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
index 8cdd27db042b..60a8e05eed34 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4653,7 +4653,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.45.2


