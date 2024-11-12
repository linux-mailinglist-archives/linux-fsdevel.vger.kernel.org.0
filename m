Return-Path: <linux-fsdevel+bounces-34427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD449C5690
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B805B3B3B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75675220D66;
	Tue, 12 Nov 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5isNNVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94521FD97;
	Tue, 12 Nov 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407833; cv=none; b=e8uLY+jKbZPvLqZ8bzZ+VJShT+C//o42838lp403Ev23jOj4cvkk5uK2HQfcKwJeOUsfDNuPym5QQTiOuRdPmBW57LxCv02o7HeokUR+RxSCEYBACrLpB+kyDmM15G7vbfhu0gHgGPtmseUpLubi7nlQrd3XcIbLOK7xf8WFu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407833; c=relaxed/simple;
	bh=tSHtvglTHqGCMeJEkIb1FMtoexRMYub3jo+WZxZEg8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCC9CEmrIEpe1StkEvb3rNA7Pvt2qA6ITTcRXfLKBLCZ5vTZyvGUEmpkInZNnslYM21NBuVaIj3XOhrANM3Amgm1WujYGh/hcvDkUWg3sbiiIKyU/sb0TW5tNJ1wRnQjHNSELMVjoNVWJKSXj5mRdt0K/Ne60UVFkXnoj41DCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5isNNVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BDBC4CED6;
	Tue, 12 Nov 2024 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407833;
	bh=tSHtvglTHqGCMeJEkIb1FMtoexRMYub3jo+WZxZEg8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5isNNVVhcxcVZbjamxBcBQGubym/ZGajZzAaN1tJFm+Hx40nNihFhbFHCbEysJX4
	 xxNKTZ6ncf9ywBYyxJax4NBiR/p8BHAiVbDdNAWFL9RFXlseSLAnHS9Q47Y4Qq6sSk
	 KyjzMi4anC9Apy206KmSPFDXABz1XBAyx++CHCT3R6QGy01vJntjJjS38qflVeM4k8
	 fLqBhs9F6qjQVDhiXBJQRnnMbBfxQagvL7aurfkXLVeT/1eA/yq/LngTCqXt1Zegxz
	 I95LeDLvAvr31b193lwrQVhv/+FmbRmx+MeJkUT9cQmyIvE1hrs4q58Ns33voSacKE
	 lWnkSfPU7mS4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/15] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Tue, 12 Nov 2024 05:36:36 -0500
Message-ID: <20241112103643.1653381-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
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


