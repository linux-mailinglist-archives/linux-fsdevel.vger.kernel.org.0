Return-Path: <linux-fsdevel+bounces-30772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618F98E31C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0851F23EF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B221F421;
	Wed,  2 Oct 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akemb1Uy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434621D2C7;
	Wed,  2 Oct 2024 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895020; cv=none; b=PqkPpCHPKHt969XX93Irj//1+4tCgx1+RgWopIrx+TFCa/0W4NUxQ1llc5j0s04HC9ZE2YvpQoxDGZiwecG8D0HyKX/41T8lpni7r3cBtTxfAg9i/UQaiQCsEbHFaMoMZH7eZ1noYJTgSD1C4ZxKNu2hUxFcHJW9AscbHxOfv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895020; c=relaxed/simple;
	bh=17YM0jGTS4LAz/A8JflBVmBC2Z9foP+AR8Y8ijPQ/zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSMmAjXV/FUZn56JLt5FMe8usEms9qEqokC7QnnqVpdDLX3B1nkfR8HHxSHXzPICaPwxzO8w8NP+0SXYdNozfMommhyKAe/Bt9YIswa2KOPp8H1PCLF1chW9iFWM5kZb3M4D8v5/YsH6QP7Ah3lzSWPVJZaFAAzZ7lP9Nh/g5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akemb1Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9498DC4CED9;
	Wed,  2 Oct 2024 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895020;
	bh=17YM0jGTS4LAz/A8JflBVmBC2Z9foP+AR8Y8ijPQ/zQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Akemb1UyyNFZQmH2LT47raszKyXtRV8Opv79lAGvBUy5veSNjonNQxiw+IVzN9nCY
	 Y+RVnuYvs8780OesSMunIUbvJkmLs38rBbM+VEUm6zd8XhOloDQGdvcDyTHJJi/V3P
	 EgGDqjlwwWb7+G3F/ScifYFaSByiLxVRf7oD1Iqk16bnUSLTR3qZwzZkTcJhELv7Kj
	 lrGYtzXbw+gMDzQuv0vhqauJzLndBthDbMZ11gK8h+vEx43ENsZRCo3xIpSR7Z+iLO
	 abtnm7yB9DB1hoQnVtuPawl1gySiCzBzje93lgycsuXwwQaGDfIIYp2FhBbq5RHVnb
	 IUgKkPV3AGzLg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:38 -0400
Subject: [PATCH v9 10/12] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-10-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
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
 h=from:subject:message-id; bh=17YM0jGTS4LAz/A8JflBVmBC2Z9foP+AR8Y8ijPQ/zQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXNl90Ovh4yBGNYYNUjOfRa+vhMULk3F2EVv
 mLp/Zow2SGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzQAKCRAADmhBGVaC
 FcTYD/490T6GELPrEWHfHOVJ36jwwRdjutmRKiVEDi7ln7D6Vl8DndDba/fXaNQjlM2UwupkkIf
 nk6kqStlbV+8W9ZXduwJISOCi6IQCekXvU30NzAhKUXmwzh3gbLygwxCgWpuc5lcYpRihX3ymHj
 u4qIjO7elCUBpr2L06qvIFSvLUOvTUy3fXXplCywwsqhXtX0lwOM5Evq2hB24ZCC86vdX3mWAHb
 rlFHyQl3x5nwhmymQGFXW1RZEj4wJppf2lxHppsNw2cwP3wUrApo8vwYvK0QJyKfT3HeVPtIOTG
 L3FrqMXZ+0xYdJPp4akSdrhjhNpG7lYgbQojjd53suHonfTHvRf3QU2cfXw/nZZ0qcR8WoclGxF
 sthItaTwpvidMz47RbYM/yboSWLf+uvl7IJn+sAtUKnAd/mXKMP1M2Gvq8SpHUjlwh06qpyHZmm
 /wqsZByc3ICGZNsbZSdO9g9Y3pZmfv6KmVQeAXasPsDGBKOEcYL5q5z5D4+YDH8f5KOVy3eXr5i
 D+whU5wyxnGqIao7BD6OC2sXqDhGJ27JgwqZemBcL1eDTyz5fJkj0ZuJ6Db9p4W5c86OwbkMCB4
 IPGG98gvWdzJghGcUd0Dozfd/TSPCeeDqtv4TQFIBH15fojwSDo1+J1/Io7/F/Y6kzpc9QTOuEg
 Kikb9wfEApjZaOw==
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
index e72145c4ae5a..a125d9435b8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7298,7 +7298,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.46.2


