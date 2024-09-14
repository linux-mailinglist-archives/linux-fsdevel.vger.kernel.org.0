Return-Path: <linux-fsdevel+bounces-29390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E572D979292
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6B628154F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDFC1DA620;
	Sat, 14 Sep 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0wkJ2rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4091D9350;
	Sat, 14 Sep 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333673; cv=none; b=jMSoDijNKSbJ4ywCRx1K5F2qhVR4DQpuUovln0O4egVozOsfepLKx1eGORAJhNlrW/6jYp9vlLiFQ+sxOgCe3oYlfsC8oSiCJxqaPuS70nl8XKyCXs52UurRPTXMf4i3cvZ4pMEgMf8PrmZaD3gOeoA3TP/PM/guDsF8j1r5dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333673; c=relaxed/simple;
	bh=gE8r0Qbj4D8u7V9shLCLoJR+0WYqh7zAXrVYnVeHWEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JguhdejjYn+ADav1jWIc14IA0+nErUOAZmJFf2+4vzP/75NrPS9JUTvGZj5YW40w0hP2uWzvdN3jnwvEDr0CEwfBEdhYYA2T7unc7K/7PWAn0Gr99N68yCBwr6pbNmL12ZZiN7PkCeG2tqlZLyPWXGdn2jmYn9qU3gbu0PKEOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0wkJ2rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3738DC4CECC;
	Sat, 14 Sep 2024 17:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333672;
	bh=gE8r0Qbj4D8u7V9shLCLoJR+0WYqh7zAXrVYnVeHWEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R0wkJ2rwtbowlAve1guhZzLO89JBiB6wfkUI9wk3bplGqMCoTw9HGM4KS8fTDOshB
	 FuZWd67kwt4rXUsO6CyB2+Ab6PMhi1ARNtC/t9cutBzZelr/O7diYk1RtBKLvbXFwj
	 tFYMT7EBiTl4wyF3ptzVe8+gBbE4nobdO7AjF3pR/1ftAychS6wsoIDxrRWGG/ajRJ
	 8El2g5E5XmxrAyULWb6SehvjQWXEmUzvBqZFIwqsSMLoOvY0obrig7U5h2VflcZRPB
	 hRzANQMSzmpqk6mhxGQh3iMgVDaA7LDTb/Cp6c6d3nZNG5jhWPSAOkjEbJx7IVPYfx
	 liPdJfoPZ6GWw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:24 -0400
Subject: [PATCH v8 11/11] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-11-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gE8r0Qbj4D8u7V9shLCLoJR+0WYqh7zAXrVYnVeHWEs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLG77OZfuwOGAG5Ly687wn48EdQFM4UuCpjV
 SX1+Zqe5KSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxgAKCRAADmhBGVaC
 FfuLEAC3RtpxYP6q0t0xpB+5OwE31ZZoYfdisPWuC6dQLRBf3JPHoqiJI1tM3i2ks/CU726MZIK
 hrROc4CQsVRZrxvfgB3tCcL+TZFHq1469dvPTsHpldJ9POculR2FqNZaK07nhswJGDtwXp9KryG
 TXSExFmSv3iZAZqDa4RNy6DAuOb4nMchTbC/v+BhHmGES71T+aZMSfGP5kpvjDeTdI9WcIRtbgX
 rC34F9nBnt5pGNWL8wyImBu/GKNQYb5N6eaq7Yyv8eNLqtOlwEc4NRsrqSGcnWOxt32FpzMkP3i
 8vXlw7NOtTM/uv4uG3Dvq8Gatg8/6EsknseTHtcNd77XEDGCf6pqTzZ+vfkg1v9GuomVqwDubWI
 9UUBtVq9VcF59teol7/FyZoXiOigJ7wj/mCK6vzRepGszlCjC7Bi+j500YArHMd+322IG9y5EXe
 O8t6skl5tsxmALcyf4FPYk/fLSj5Fkx/H7fFWygBTxXDCrCAfbNMcmCqbOYyIY6rpY8JueiwWXB
 TTaoMNYhE2yNiwQNLRUg+4lRgBX5G18vQaYIvFbIgMw0Bdg80zssmKfdd6v9hTOlgzD9IoJM+p2
 mvIvWO/A2NlUe2C+lWB3tkbElYUryFmwB6RZZNxpBq/egGr6D3hSxNiFV8m497rAIxKwUeqzIz9
 YmSBRVn00Sho7OQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..5f17eaaa32e2 100644
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
2.46.0


