Return-Path: <linux-fsdevel+bounces-34432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE09C5768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB2BB313CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23D22DA9B;
	Tue, 12 Nov 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gunn5CQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CF22DA86;
	Tue, 12 Nov 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407911; cv=none; b=XuDtN6BumVWtBl4oGt9K3muTOJUh0FvBbqCVSO/HxpzcaIoZC2IRI7Z05UUGtuY3h6ifEEPTEspho+TrS2nd/uPWdgchij1OnHt7P83FDKVRnzlwSGhGCOu5gFLafR9WYdeX5hRoTigKiSuMIA45Y7vOYz7Cn4izDGqZc5wESrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407911; c=relaxed/simple;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTQGu60zlqpwS1uFur0nIaGgF2So5DPLLMYq+OsyIlkrTXnXd/1vlyE4MdL/sUWols+4wsEY8zVo9GrkjoZs44ps4cDVJ43VdwF5ohYFQQvbnsH4i50JZcgUrKWBNmpMXRxL19jrSua3yhkjWGzx4Oc6PfsbVhoM2ICMjD2Hrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gunn5CQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C348EC4CED6;
	Tue, 12 Nov 2024 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407911;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:From;
	b=Gunn5CQAaktO+NoAQQ9+noozarUaYsx8GjDNfnDikRtJCO5UupHGtXjI/JPaXfkFj
	 arRgNcUkG0tw9JCOW2cupf6TX99/9RcMNHTLwOxLvHZWtglsUxUq5ocUIEYmPk67N1
	 8RfU4Hm3f7SIHi1nI7X1mc/8v0laEyLDX7gqPwfX9ziPK66JzoKne2k4GGnKl4pLCR
	 3FeBFAW7c8WLBROF9kta1KwhPvs7T/U/Kh7nbkUseYYTrOtsTQVlqRKKfwewVsNKoY
	 ebFdzwTz1rt/Ldib50gzlYqbVIzCjMfZEk/JC1IzFjhgCjH1IM5Cg7ipv1m5/E4GQO
	 OYwkZ+cAqXO5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Tue, 12 Nov 2024 05:38:27 -0500
Message-ID: <20241112103829.1654449-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.323
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


