Return-Path: <linux-fsdevel+bounces-30798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB598E543
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC011F21D41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A9A22AA7B;
	Wed,  2 Oct 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY4qgNaa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C52225D9;
	Wed,  2 Oct 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904484; cv=none; b=l+HcEFYaQQjtnnmY4idEFq+BA2N2v64VfmPuR0bhwRoeLmSaTPcX61xw+SPsh29YXQfhFyFoIS+R6tIYMblxProIZPdVoIWzYi1WN4NyUkyYL+I/P7PgyuS3nQgmPNJtqEpyPpmKDJvz71daYNvL+5ghpHGROCrnxvIqLMC1C5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904484; c=relaxed/simple;
	bh=5/dsLO8cNmOaM6p0rv+Qvzx/xMvPBJnx6tvOBbPfMzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcUa7mhcQ8lr/TLJfNg75UgjQkB79jsi2EJOkQko4x4xekno8YFYkWMk/2/GnF0mWwndmohbkUNdaKh9iPHHg25rrgbHcfJXDr17yXTwURXhAwEUUUXFAAZKqOYfcB3Wlg6sP584izJ1fIVBH4+mwSO8TT9xxN6Okysx517og5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY4qgNaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF362C4CEE1;
	Wed,  2 Oct 2024 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904484;
	bh=5/dsLO8cNmOaM6p0rv+Qvzx/xMvPBJnx6tvOBbPfMzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pY4qgNaaCqezS32qjDZEbsRs2uGb8OTkbND/gQNC3DZDk0GQyrjGRmxHYO6BtyTWX
	 EQfJp0qmbpEp8Y4fEBEdJjYyDC1X6D/lcrtX9zhRMFR6vrtcr9gEpaw9lqhsBV4dzt
	 hc/hRRGOV1mrRGkkpHthnO5R0XB4+yg2XN5Y8PwXRYhYvmUUyN5X088MqLAETzHPqn
	 O26reMyyJqwCWRtn9LB+2DwWyURABcR1Pa7VdYMKNk9ArrOhg9DFEh4PfCmVFPe9Be
	 NqUMbmrsKxgNgWyLK1sCeoxlIVRcC4VfPN2PcY5JZrL6kxFEm9kVwZtbsg1V1uskh8
	 uQiYUVOkUhxhA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:27 -0400
Subject: [PATCH v10 12/12] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-12-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5/dsLO8cNmOaM6p0rv+Qvzx/xMvPBJnx6tvOBbPfMzs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/brALjfB22SLtWrZvbq9dOIudVwmi0I1qA+aV
 n4HN6LIytCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26wAAKCRAADmhBGVaC
 FRSFEACPohqXeTh7KgceuIiMgaiZvFEfTN6SD/E380ADOa3A/9s4jdNxUzvvIUF5TGO3RjuqvXp
 vQ39lbU+sN/EReWdsZdlcuP9wIJTEDPEo0Sd1UVdKEqRfvB7MXkHnFyhigbts8E4EeZm3vtO5Um
 dEueBuYGU/uHUQ+C6uWNdEqboX38koaVM6De2O+XxmDB25xapHTAlc+OjmcQvs6DpWxF5RNdpJg
 84pcISszclA73/fk3T5S6O5wVNqceFy6Rj/wOaY0mSjy0XDKDJKGBWz7VJtKWZKTPmcLIh46ehW
 D3rEEFjv/THx5b+VU8ecQynhSjyfgPRiRgZ/ZFcxmYMlGzxi639VSAmecRyY4j1lwNLBwcaxP3U
 qfns+SkW0ZRePXxgunj1ox6ARPkr5OFR5Pa7/h0JkK0hjguHgiSpu5K82GofgSxXHpUFOv0Dkyj
 Ee32pebJG1fZRa4wWzJRSNqUvn+2uXCZvk35HWRS2uPOeNohiJVtbaJ34ZRn78lHec+pf5Z7ZJ5
 GKT64vZ0wq2zEDEprVAk5g9Pid6BM0mn2dixzCz1QwYLKWJdWrcK7YfU6uGpmvh/UiXzYOPesTz
 zpKM7FScCuy994O5F+7EBot7sYRW87SFI2Nu0MwRE5tPQdBY/CHLfBwZP8GTD2ThHGIm8ZnGudD
 XIxJwAEylXRaCkQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a621dc7b5e7b46402b2b714b45bea..5f17eaaa32e2902228be7b245c5b3b11c5fb6a56 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4804,7 +4804,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.46.2


