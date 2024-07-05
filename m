Return-Path: <linux-fsdevel+bounces-23236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5380928CDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D1B28B67F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D617B437;
	Fri,  5 Jul 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIF28tq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9517A92C;
	Fri,  5 Jul 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199001; cv=none; b=lWv76TljHy3RpBlaSW5ZvUWgAowxYU/HGyMJ0RAcZIcm0Kjb8KUpWubKcHOMJMc8OQpG3LMhFNI9CmMeoxTwb/qKfYFwf5m+0RQPFoPlOLQNaK0x7jcPqCtAvyEEtS39pyiCf/TnYjZc5LF7AsTXcLQZJoS4sFozWYJlGPIGQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199001; c=relaxed/simple;
	bh=pHEQop1T1fiyamd9jcpDhT/4UZTaEZSdDGTRt6fHlCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnlD2QER/kokYC7pIzNkpejgpxHUe6zNEq7J/fS/awVugL6ZuQ7mXoBb5oDthIsc7mFRTv3Ay8VkjXwvIcZT19P8m7G8tqIljtk+k2YFbQj02TLcrd7J9bT3E7I1tH1844w6btyc+fT6pCJJgm+7n6Skvy6mbt/g4INjDAujzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIF28tq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69069C4AF07;
	Fri,  5 Jul 2024 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720199000;
	bh=pHEQop1T1fiyamd9jcpDhT/4UZTaEZSdDGTRt6fHlCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GIF28tq/EK13s4RMBEeSAadr35rKcDq5IRamnX6pCdUp3F+CPwHJy0EA/gmZalfou
	 6nDCJ9rdvrdzfiZ9Lqx/ZNlKYu/E2Qa2C4xa96YCY2+X0Y2Iy0/p3taIHbI9vsvitd
	 GCGmLULp8AGxtTjKnaYWN6c004o78XS8dz0M1yPcaUbfmtH3qwUKJ40TLysp68TwTU
	 h7063zJs4fhYdQ2p2VXwE0vJ3vQ4IakiOzZ4jkHjufH/yAUxuYsjmL6D/EEeCLiicE
	 TquJDQsI0jsWjpEV1da96vz8CaJCe2pj/NI/a0Yfm5WdG1CKuViVs5FJoCZ/gjtEGu
	 fp8sXV5JVvSIA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Jul 2024 13:02:43 -0400
Subject: [PATCH v3 9/9] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-mgtime-v3-9-85b2daa9b335@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pHEQop1T1fiyamd9jcpDhT/4UZTaEZSdDGTRt6fHlCQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc9+3lWva5fNpNEWzu+7Rzw+GWxPBkon5ZUU
 ZWSCd8FdEiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognPQAKCRAADmhBGVaC
 FcQ/EACXCMgwagZgAeeTGej6ZdWdoV08xda+ukWEVKdoIUb77+9qfa7Yv3j2f/9/vUmczA20jEa
 pMsyqiMipIpjHb/h6QXN34WJ12LdxjE1uXpo6tCZsInC6UN2DZS9BhXeYb7ejNH9aGX2uo+Ss9l
 eQKtsAwT2TQVgdXIggjo30q/WL0UDdlrrNaz8TwUVCsPoC2KeveW+rJYoKLJoVkw+AC6d91L+2O
 nI4jEVV+3rGAmY3a9UkYPb9aaAAzUpLQaYUYnKHgfn71zVj3thfOkumCfZ69GwVT+tt/3fonV/M
 EAnDuUuqXuuKMpqD6+6+iJ68pd7sk1HIlFtp2RvvY+8BUdr4pZ0ty/hgbke0sRNIeLSFJxPXTjQ
 tAQqsdr6u7uujdhIgMen0qCwqfC21yKaJzDa2+ETo+srnwz/Zxz4UwjpYZiU/OBc3C7Cah+WE70
 om/sbkLTeER/YssLnFxwJK2dAAc8Ut5jqRaV6+TL6dtDmGDzd/rVbY+9uT7yZMU4xBpCggzk837
 /xiNN+jD3DNYksPSR8+nl8+3A0tWZLKIqmqHjthV2ypV8JzeqG/3h6XVp7CS123/twcsw8uF2zH
 T+mn6oJ7266/eKdofn/eqBog5C5KQrE5oXZvl+0FraKOGR3haAe4gkhgk++OZcAxCEUAZUtV1Jt
 kQ8/0xbEalSX4mA==
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


