Return-Path: <linux-fsdevel+bounces-34426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670819C547C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C290286B44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282521A6EE;
	Tue, 12 Nov 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A++R1Xzg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F021A4AD;
	Tue, 12 Nov 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407796; cv=none; b=B+DEJPYGCInFwTZcTiTJJwks00lwi2Z2zne86y6an7eRKmgsaE4/wP5tf8QtdGqcTUieSChPT6Nwp1xQqap6MixWWcb+gzl3aPKrC+Gj+yhi7BpZuTi96lu0ZSKjcyES73BLXclEVrxLPnhdwNqiUyQ2wolfKQvU+IbTgpk2efc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407796; c=relaxed/simple;
	bh=tSHtvglTHqGCMeJEkIb1FMtoexRMYub3jo+WZxZEg8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJLb4+Ap+Nv8Qxck1Y4h3R0/MNMDxX2/Nia3GFBywBNPpmv2BHTTPbmpbMo7DmiOm48gRGC8w+TgTz3fAJ9T1gpoxPPC8IyKbJrIerEtzAut1EfV6+88ui1UUxTpkP2EiiRpwdjP7NlxbMsrtcV4GxwmSSEGN0vJcqKWYfe1ScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A++R1Xzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68032C4CECD;
	Tue, 12 Nov 2024 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407796;
	bh=tSHtvglTHqGCMeJEkIb1FMtoexRMYub3jo+WZxZEg8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A++R1Xzg8dmYqHLxqEht9Vj2+06emiXM06CQothZF7yl4vFc6Z52XOO57v5dQGKME
	 iM/xroHKemglZ5/2WZomgykOqSu87GdYR+XMEe6o15UGEYEXa+nZ2hSWE0t6jD+Vmd
	 tT2OUDTs5xcNJKCx3qeSNZ8bwqWcv8yuxD0zVIdRaD9URHjEnRJ9z31t55tdkKKrlJ
	 5zZ1VEiWK0PTREf0IC8O3oDn81mlSKvcMqeIbxBALdZZdQBdDUHOYKl8UQ6KU6mRFe
	 DNJfnyRWr4su2LT7K8ZXTDFDC00w02Uvk8DKze49h0G2Ifkfr6QMYaoBpzlICfhydB
	 +JiZHJYuTivVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 16/16] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Tue, 12 Nov 2024 05:35:58 -0500
Message-ID: <20241112103605.1652910-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
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
index f4616083faef3..04bb29721419b 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -20,7 +20,7 @@ static int show_softirqs(struct seq_file *p, void *v)
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


