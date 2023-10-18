Return-Path: <linux-fsdevel+bounces-682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880427CE4D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F30281DF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467DB3FB2F;
	Wed, 18 Oct 2023 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcpsqU3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5B3FB12
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 17:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BBFC433D9;
	Wed, 18 Oct 2023 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650899;
	bh=oV0lFdI7Yn7QJ5JE87c+C5HW+Uto4gEIDr/OnGVhofo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GcpsqU3PkpNElzrRNZAh3XTjk9L9FU1ZFKJ0Nuy36O4dTnIGzGvLmzqNHSEPu56yj
	 fwpfkupeILBixno66h7UwaC+ESWCL5Mn9+PHSEDIe/d39R2QJtMWQdIk9dtKO+8mBv
	 fs9yJoR0RLy47E5axLbnbDIwRRY/K92Ahi/zp/JiYqTrHQqZBsRgMsLEMiI58WmFY7
	 CPOULDJXAtNvZY2Y4tUNSA5fdezHHf+X+L8uPAgCasaFp2dpwPzXlw41p5JMyEMgSF
	 V8IDjIp+cpdNbLf2y+84w2Z35QTu7OAnQl+JskaMxc+mKp7GxaRqPDtAUViX1j0jwi
	 1qYxkdVgrYioQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Oct 2023 13:41:10 -0400
Subject: [PATCH RFC 3/9] timekeeping: add new debugfs file to count
 multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-3-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
 David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oV0lFdI7Yn7QJ5JE87c+C5HW+Uto4gEIDr/OnGVhofo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjIZJAEh2EvSWsTRIXNUoSp+/gPrdnrW38DM
 8NdE4JkFmWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyAAKCRAADmhBGVaC
 FYbiD/0ZFfWVcuSGUPgSgemJY2MzGuMffXnd/jkl+/NHQ1nlRsWS01DWyVwdWucUQasEC1H0rdI
 5uXOT2GcTX/68+GO+2tqvb1JlhSnujcLZm1Lg456xiDlllxlwIhZ9tZrlYVCOrYuP8jEqXYvjZU
 V+pX3XjE/kpytbDpv4jBNXvd33alsrO1+bznAl0pM2sOm/dVXZQSQ8NYrpztvxjJk5qNLqUPS7Z
 U77qUZBIXUm2mQR8NpLwL471ld2/NmDB4pWDRjvCl9+E9LUaKW68g5iDdMrP1FYZEgo5nuBug26
 G9gk1+WG8MzsHsYFl6ELLbS2zBVqoMtrdqt568EogG7jT0bV9ZMQdIYySUOXW4QYfw8xmG5gMep
 x76CG8p1DUeFingRztj1TLljnTJOBjvvu6/y4uHysrrk48R5ZJgW10j9GNfzFxlmWLjzROb5uq1
 DrLstWJYcyyzYThiFx6ceWhtadCHD8oOozKVH0QwA2Iz6TUjCXq4wmT/TUthsNQ64iTwZKIscuS
 i8Te9fkr7v+sjrBd7L3KROqoW+H82LEsMIQaJGP7fXOLTpmGndcbF9RRWYs3TY48ha1YUBvq1tG
 mr5XAlH/ldtbzv9DCdGsn+zCmXwMuFoPEEiGSzhQzKBi1Xi62s7eCGftf2cmFcAvZBqTr8ByLyl
 avNZl9vDKp3Z4KQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add two percpu counters for tracking multigrain timestamps -- one for
coarse-grained timestamps and one for fine-grained ones. Add a new
debugfs file for summing them and outputting the result.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/time/timekeeping.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7c20c98b1ea8..c843838cb643 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -24,6 +24,8 @@
 #include <linux/compiler.h>
 #include <linux/audit.h>
 #include <linux/random.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
@@ -59,6 +61,9 @@ static struct {
 
 static struct timekeeper shadow_timekeeper;
 
+struct percpu_counter mg_fine_ts;
+struct percpu_counter mg_coarse_ts;
+
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
 
@@ -2326,6 +2331,7 @@ void ktime_get_mg_fine_ts64(struct timespec64 *ts)
 
 	ts->tv_nsec = 0;
 	timespec64_add_ns(ts, nsecs);
+	percpu_counter_inc(&mg_fine_ts);
 }
 
 /**
@@ -2361,6 +2367,7 @@ void ktime_get_mg_coarse_ts64(struct timespec64 *ts)
 		ts->tv_nsec = 0;
 		timespec64_add_ns(ts, nsec);
 	}
+	percpu_counter_inc(&mg_coarse_ts);
 }
 
 /*
@@ -2581,3 +2588,33 @@ void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
+
+static int fgts_show(struct seq_file *s, void *p)
+{
+	u64 fine = percpu_counter_sum(&mg_fine_ts);
+	u64 coarse = percpu_counter_sum(&mg_coarse_ts);
+
+	seq_printf(s, "%llu %llu\n", fine, coarse);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(fgts);
+
+static int __init tk_debugfs_init(void)
+{
+	int ret = percpu_counter_init(&mg_fine_ts, 0, GFP_KERNEL);
+
+	if (ret)
+		return ret;
+
+	ret = percpu_counter_init(&mg_coarse_ts, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&mg_fine_ts);
+		return ret;
+	}
+
+	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO,
+				NULL, NULL, &fgts_fops);
+	return 0;
+}
+late_initcall(tk_debugfs_init);

-- 
2.41.0


