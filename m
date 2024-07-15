Return-Path: <linux-fsdevel+bounces-23697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F49314ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C21F23691
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B771940A1;
	Mon, 15 Jul 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op5sWagJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE9192B87;
	Mon, 15 Jul 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047777; cv=none; b=uwpygMcF2vmKoIlHhwHwUCQU50tCA/3zigK+GT8slZfDFidEYhdMaK6ZcOeItGiCGjUbKmLdq+Itrsn/IS+3+o4Qcv1GY1PKmpH7exxNxS/uM+S+NZgneFDA9aM+ZYKx5xCgwUgyp6fvwKpXsn3Nkx4aXkaEUXByoPhW40m2nC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047777; c=relaxed/simple;
	bh=EGo15KA9RzWejobFOdJXVIKVsZGyPzCyG1uwa3tZn1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9B6lq+lVLKPmuKibwIjee5i3KhVAieXkmRkfe+vx8SY/1p/cGZvEeeWRiH8QKdSeqWoS+5YckKgYFhLPiVvhg+jnUgcFJ5Q4Pj6PzjH74e/sHZy8ouz5pKhhhsesRBKi3O+P+Df0xbuvmPjsADFW9GcoiFoNgejhsONpPILqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op5sWagJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312FFC4AF0A;
	Mon, 15 Jul 2024 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047776;
	bh=EGo15KA9RzWejobFOdJXVIKVsZGyPzCyG1uwa3tZn1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Op5sWagJjl+DaoEpT6U6Roz5G+OZlHnYlPX1GVRhRCs1ph5A4POU7AelkpSydaFE1
	 0S/6XZ5jrsy1l+pU8jT0i8xNz7C46rPcqZFpDt+RZwciCR30kKbKz24evOTitf1+Vr
	 FzJPtBPOU5iclZk+mYyMWcBFe2aGVnk/Rn4MMAL/btOLEN7TC8VvQMsoRlssdnUhcZ
	 RS8B6yYf90rMB3TbhzRrgFQYyqfAqu/Tv/l74Z/8C5XrCGsIXk7l2nSGlPXuk9Pf3/
	 YnBJu+MnFdqez9L3jJ10joq8GI/5b45+aubtvZlH8RUDpFYLgxThEgXVu7Ys1oCnQc
	 YomcYnBGoWouQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 08:49:00 -0400
Subject: [PATCH v6 9/9] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mgtime-v6-9-48e5d34bd2ba@kernel.org>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
In-Reply-To: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
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
 Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EGo15KA9RzWejobFOdJXVIKVsZGyPzCyG1uwa3tZn1I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlRrD4m6AcCbQEbB3V0ipLp+HPBka/5rUVsmDG
 +UI6LP4LSyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpUawwAKCRAADmhBGVaC
 FehwEACB/2bL0lHsL7x+6a2mF1cA08ExumwGUUpjqhfW/iUJDZW8NksCANkEjZy3jkVO2UFom9k
 MsZ5dg106pC96JwTEgOw+Wz+KchU1EDu+k20LB4uv5tnPDvb/ET5ncKyvxJ5+wX90wtxidCfK4h
 TWJwKVyQsBqdLsZ9w4OXei8HGv99hsDxrY/rhQ1KaOY6CEdzPcQOpCJbSKZ0n3rRR4X3KCEm0A4
 vJv7X1XCzEgq0XUFHxamtkbmLAiGeaDng0kVnJQntBpaoFWUvbE8nUnCKwO42rKF9RgKHFMFhr9
 Hr5D7G1iySVSJQ2BR5sJDVgMk5HGd1iyI2pVyeFVC6McOAbLpkl2Q5lHCE8kJkxFjd8KLcIwiVW
 o50Xzk8xJyxBuopmF8fzBrgaXB7Vsova2nDppB4/gexJo9H/PagYElk6p9zsOndkBubvDxLfP3h
 EJ+mL8K/MHCwpTOt1Ef72Y4QbrbvjsKee5N/8O7YTpBbai8Df1rRFhQrunoWqFh94wkmlSaFm7q
 bvYRMax6wvvOUL4sKAulaMdnh/m92gAeta1TxcYbI7XC5LI0f/7NQjMaSTQW+lXe6+Um8SHiZvY
 H5DVd1+vLNraR6/Ry+rSfK0uCHPXRyQadKt9ly2ZbezoPAN3Fslo6ewd+azr8Y3pyp9SvkpysRm
 d24+EIjmNvSAjGw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7f2b609945a5..75a9a73a769f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4660,7 +4660,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.45.2


