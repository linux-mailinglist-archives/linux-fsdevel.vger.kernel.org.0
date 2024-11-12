Return-Path: <linux-fsdevel+bounces-34429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092C9C57CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22EFB3DEDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3463DABE9;
	Tue, 12 Nov 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQdaxhCm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D692332D6;
	Tue, 12 Nov 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407881; cv=none; b=WvxS4TRRq18rKW5cRZx5+48P/i7ZdNmRvx7mJojkFmeuIh0Qw07lle1NTsHfTjy2m9J7GeA03Y2dnUkapvfk6V7N+dANTx9Q73ilKpv2n1SkqHPw85FoBA5GGVh2m6GIzQzBwoF7RcHZYCLx8iAFm7h+WyiQxWAtW+DICfWDc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407881; c=relaxed/simple;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHXhKw6h8ANZ2tSrkvGmpm4pLzmfX/rrL+zTxcDTWdecIdD9vI4HYpT8TM3XlUpdkEhV5XvnndZ/KHdjroKliRsno0TZ4BrxEiI1C1tY4P3XjNDngX1V5J8hGoe8Wms8xHq80tHhRiY5b7ZGlr/VfT+aVuKpLfHUG9nyh6+XWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQdaxhCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D68EC4CECD;
	Tue, 12 Nov 2024 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407881;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQdaxhCmDtwFf/aDB4nOWh+rAXoNKxtBfDXXlCKyUsYc2iumxTXfDqXp0XZ8pbjhv
	 Og5s/SFxkeoH329erLSDF2XpBH0qyPZTP29yxsdwAXl4bzUVJOYKW+fDSgPDKh6ZMw
	 lz3OcQd0sK6YjeZCZLNZ16U3SlqbKKEDyvreIvtPedaBetNLdFn0+Ic1mmIXimZ6k8
	 SpOSTa/O+6MAespLoSZaT56ChLgAKN1U21d82bXMTneUlFabnLtULXf9IXEXsMcxQg
	 OhWcj7uBYBtcGngrYZKLwCAXGnAANI5ymkYvgYUW/oBCqJf4RziHX4+UMw8aJe9IMu
	 lcs5WKtO//xhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 8/8] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Tue, 12 Nov 2024 05:37:42 -0500
Message-ID: <20241112103745.1653994-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103745.1653994-1-sashal@kernel.org>
References: <20241112103745.1653994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.171
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


