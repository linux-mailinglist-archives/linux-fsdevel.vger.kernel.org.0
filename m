Return-Path: <linux-fsdevel+bounces-34428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565B99C54EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1402846FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527B2280BD;
	Tue, 12 Nov 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAFIR4Zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6B2280A9;
	Tue, 12 Nov 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407862; cv=none; b=OTEVYwXYcLomOljKclVEUl7tpk+izpsQtzsk1DaXK+9Hw8N5DOpPPTAWpJWKSB06ueWYeqPzhZHIiwj7oWfRv99cY/TM1gXJB8F8unjVjtCM9EDBtjEi7wybN9br/4eZqmQ/PDF36EuiQjGqCyT5bNfEoGDfkutyfQOp+2lULrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407862; c=relaxed/simple;
	bh=tSHtvglTHqGCMeJEkIb1FMtoexRMYub3jo+WZxZEg8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bspvg6kCNES9TrO3mDQVFuIDGRcKwfcp5X61mZgGPOWY+3Rw/mVJrmNSxuYxkOPftwkGHIRn9LzNTpHYudIWqnqbaBZIg13vhB6kYn7XLZNEHj9saqGl/kIbnQzlkTKfzW92FOvruP7Qy/cgpRPfq5qKrl0VmZYhHX2qetjoVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAFIR4Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A08C4CED7;
	Tue, 12 Nov 2024 10:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407861;
	bh=tSHtvglTHqGCMeJEkIb1FMtoexRMYub3jo+WZxZEg8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAFIR4ZjMdgAfZ5xzqzJUBnUMcwQ9nV9cRF66YaBw+aGvQicBinTGJ+F60Ak9wwfP
	 vBbNHpoDZjiSkrB+HFz0kEwQT2r29QeCyP22AiT+rZNIEmYLgxE4nT2AwVEd8jkspo
	 q0OiD3TB+v0Rsi3cgr4NqOzw7MA59ewAjlAVHe7VE8+pD1h4RAXbpycp9psqAmJhlw
	 OMZ/2lQ7EyeiNM/Hq8IdM446Je/AURoxxdiETTaLKpwj+bMSpLqh/ELvMPb5CdIrQJ
	 K9ndqLYppuSLXim2Sz7BkqgXajCTO2Ls+ucgYGdMNAr2OTUSnNQHSZ5ywZsgfsMzo/
	 xqfGA0dC45oog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/12] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Tue, 12 Nov 2024 05:37:14 -0500
Message-ID: <20241112103718.1653723-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
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


