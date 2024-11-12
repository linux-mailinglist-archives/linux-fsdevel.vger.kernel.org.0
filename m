Return-Path: <linux-fsdevel+bounces-34430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD39C5520
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9639328B946
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673801FFC52;
	Tue, 12 Nov 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ+OFVXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BC1FFC4E;
	Tue, 12 Nov 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407895; cv=none; b=olB6W9XOpOiD60/LGT8CBznj2HHKAPyXN+/ElGC10xCi2PiAJehz7esgLfCvgpi3D3HOWH+sQ/1XCghd/zYDGRqd8yTF6IWmf5fIZT5tOefJajY/vqDxZRXWgUfc5VbCBWRsJ37mGUCA0hGiKf1AgscFfpIUjrVHjBX29/F9hTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407895; c=relaxed/simple;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYQDIeIhEO5Wtc13nZ4M7oGcAwROM+awDMqziCoARWs5bJwt1VbwF9FZ+2tIj8c/4KqGlR6mzizvURm5K4O5USl78ZLEJyI/Ycsp+ZcOsl3zUcMowfvmoJDiYydFA3nXOIde5F0xgz1prhz3tC2Aois4ZeojqDaJSzViqlUbh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ+OFVXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85147C4CED4;
	Tue, 12 Nov 2024 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407895;
	bh=0B3GM3Pdioo3nMOBEQS4Plqu3UZIoKk5afiFKD6k6I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQ+OFVXe1O1qpjIuqdlz35S6ITIR2B5xtWa70bBlL02+leaGJdMiA5KgZ39QibNnv
	 3XQWNGuHazr4YhgsOhTnOXRroCDs7bs+rmh04pS4LnCYA3wEYtdCGWltBLQ3RPEigA
	 evNI2Fl5Gmwxi/bt9IcOU+W3wOeMvQsIVk6rB+/JTpepD/bLhSk2iELGiXbsaN1/Q/
	 S4B8nQRMz/dhcwW73EIYqhZK/+6gJ9e8vWI79uelXiKVIOpfSd04XdoUmJ9SyL8Eps
	 TWl8FL4oQoHJMv7hmXfPKqEX7MTSNH5SH8dGcVM0s29ICBUoQ1+84I8Z8tnkCLqcv5
	 izf5BEKjwyGmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/6] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Tue, 12 Nov 2024 05:38:01 -0500
Message-ID: <20241112103803.1654174-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103803.1654174-1-sashal@kernel.org>
References: <20241112103803.1654174-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.229
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


