Return-Path: <linux-fsdevel+bounces-34431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A219C57D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB1CB3F226
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3922D3AB;
	Tue, 12 Nov 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNoaoeOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227222D39B;
	Tue, 12 Nov 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407908; cv=none; b=qgPBJCf8cxpqinDUJIGS7LoQ2BSAqt3qK3Lc0wkG+p67mSjRNirv76HuAxfA0AfYKbjaEEkCppOJS9KMIhVhIki7JKwEysUxqOaAcyRRSBrBXRPBBPpln50TpZVuO8W6yADYkLwKRflY7U/8kI1fZvGvvwYBfie7+MzEC5frQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407908; c=relaxed/simple;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6Nq5lTfuvOlzip2P5lIk7vCsrrLjLyMnTCr/9IEQTm9YDtduyN/5gIGsgzIigdifN46MQDOyAmxHzT+zMAEBFhZnn0hVZxzfPb8OBrpKgdTE2NVCZZi9I3IzMkRmymwN0C3j8BhgwUo3oGqU4EevO/r9tfTnzStG2gFHnceX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNoaoeOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44A5C4CED4;
	Tue, 12 Nov 2024 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407907;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNoaoeOeKPANLiGOeyThOToQ7Hs9DpzJQNlBRZUCUqWDg0tBnPfWhetxYLLTSPydo
	 v2TwAcFDHV8QOP+a24hHUDaVez6SZT0KMTQ/WWDLlSTj+MIO+DiqVVwrko8fJXmHgj
	 1wCUVNC1trIYfvt2DW6VxsIhGzGf0T3k6HgnfpmJtqdSBNqBKQMdR7CDOL4+LrF72e
	 ilJSvazpYHQtIC9CJGOFmg+EfmCEsyoPJRtny5yF1qM48DviDMRwq3zld3DaF+v+yU
	 GThCfedCDmkh+THi0rJuKwGrlv9A7ky10KXtL1c5yYiA4+J4HIzoSuSfhPn9nyWa0x
	 Ib12nd555oFTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/5] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Tue, 12 Nov 2024 05:38:15 -0500
Message-ID: <20241112103817.1654333-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103817.1654333-1-sashal@kernel.org>
References: <20241112103817.1654333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.285
Content-Transfer-Encoding: 8bit

From: David Wang <00107082@163.com>

[ Upstream commit 84b9749a3a704dcc824a88aa8267247c801d51e4 ]

seq_printf is costy, on a system with n CPUs, reading /proc/softirqs
would yield 10*n decimal values, and the extra cost parsing format string
grows linearly with number of cpus. Replace seq_printf with
seq_put_decimal_ull_width have significant performance improvement.
On an 8CPUs system, reading /proc/softirqs show ~40% performance
gain with this patch.

Signed-off-by: David Wang <00107082@163.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/softirqs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index 12901dcf57e2b..d8f4e7d54d002 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -19,7 +19,7 @@ static int show_softirqs(struct seq_file *p, void *v)
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		seq_printf(p, "%12s:", softirq_to_name[i]);
 		for_each_possible_cpu(j)
-			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
+			seq_put_decimal_ull_width(p, " ", kstat_softirqs_cpu(i, j), 10);
 		seq_putc(p, '\n');
 	}
 	return 0;
-- 
2.43.0


