Return-Path: <linux-fsdevel+bounces-34023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0B9C2200
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7F12828DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB72192B71;
	Fri,  8 Nov 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oMjnYx5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219918FC8F;
	Fri,  8 Nov 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082978; cv=none; b=UGXZzHBmGN1hAglKjq5yHC9JMHATLsM+6JwaVgS9fCtFJMSzNmv4NcydnUnN25idFDEMSH6wC994NArHFKk5uyaXHrm6m8uyfgzN+XYZ48SYGNpuzf3960XW/rco2JidwATMh2NjgqhIi9opXJAbJRXMXRaKY8pmHcwHZbbaBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082978; c=relaxed/simple;
	bh=Iev3IASF6jXs9vLj+2w+9QdXRkWMP80eM6ZO8Ho25tI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZfBve3gUAAJkIS69HGkdkaF4kfV8cMg/F3/skH/R9cTlWRjBf88npHs0CDlAQzW053r3heZkZVnE/h7RvWEvKSiQVI/2JdLybGC8GOdOnVQwKLJRl8YANTCvGNSx+5TfUXadJ0JSwfEBMIfS3/EhnHwvUr1SRFr/5K54QxF2Ztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oMjnYx5X; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eZrpT
	xlepteoc3aJs0xBvP2dTguuevOY8C1Vgzg+8cY=; b=oMjnYx5XQQdks+F+bLkEu
	w4bASjEeSefb4HLJKK9k6rw0+Lc5P1TcDcbmB7S1mVJB1u84FXEm9vDgpXjiiPTv
	ClkyArRHptwuWVyaGTDrB87Q1ceerZq74pxiDLGyOzyppSAi6uiP1bzaZmGbz2Un
	pRu07OQhCXfU+srNYDKNFI=
Received: from rlk.localdomain (unknown [111.30.253.150])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnfvHDOi5nZwfpAw--.25591S2;
	Sat, 09 Nov 2024 00:22:28 +0800 (CST)
From: "enlin.mu" <18001123162@163.com>
To: 18001123162@web.codeaurora.org, enlin.mu@unisoc.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org, hch@lst.de, tglx@linutronix.de
Subject: [PATCH] proc/softirqs: change softirqs info from possile_cpu to online_cpu
Date: Sat,  9 Nov 2024 00:22:25 +0800
Message-Id: <20241108162225.19401-1-18001123162@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnfvHDOi5nZwfpAw--.25591S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1kZr4fWr4rWrWfZr1xGrg_yoWfWrc_Za
	s7A3WayF1Sqr98Aryjyw13t395A3ykAr92g3W8KFyUZw1UGw15tFZ8Jr98Wrs7CFW0grZ3
	CryxWFnYqw1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1CzutUUUUU==
X-CM-SenderInfo: bpryiiyrrsjiewsbjqqrwthudrp/1tbiqRiRDmcuNe9OywAAs4

From: Enlin Mu <enlin.mu@unisoc.com>

like /proc/interrupts,/proc/softirqs which shows
the number of softirq for each online CPU

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 fs/proc/softirqs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index 04bb29721419..01698b8f3898 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -13,13 +13,13 @@ static int show_softirqs(struct seq_file *p, void *v)
 	int i, j;
 
 	seq_puts(p, "                    ");
-	for_each_possible_cpu(i)
+	for_each_online_cpu(i)
 		seq_printf(p, "CPU%-8d", i);
 	seq_putc(p, '\n');
 
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		seq_printf(p, "%12s:", softirq_to_name[i]);
-		for_each_possible_cpu(j)
+		for_each_online_cpu(j)
 			seq_put_decimal_ull_width(p, " ", kstat_softirqs_cpu(i, j), 10);
 		seq_putc(p, '\n');
 	}
-- 
2.25.1


