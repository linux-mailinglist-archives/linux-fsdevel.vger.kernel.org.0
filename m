Return-Path: <linux-fsdevel+bounces-19367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA28C4074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 14:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFD2B222ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4614F121;
	Mon, 13 May 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7sxbp21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C21C683;
	Mon, 13 May 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602018; cv=none; b=hCRCDTVRnvpCxSfe/9GfIg2nLYn7fDyGjAyW0C2ZOlBIGX6wX6kZKSpj36no8Ro3mDKvIVCWb5JFv1FFJ6Pag4aZ+ZDD2X/iONLGYAN+fYKe9J5CLFhOjnhzq4yej+JYQE2p+k9FCejqGyH3qPUYrBHdXDMLDenGg1kJgNjlz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602018; c=relaxed/simple;
	bh=xsGQyMUhP00Zqt+lGxpgG0zKx7Cp/SFFHHzkQaew4Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XylMEOPoPIm5NwGGwYEZtWyg5HGkYiO17goYXzfKaDleIm3YqRQqiwV5DEYTdLVGEjLCh4tYnYJLGXsSyNrR8Wn9jMfgVk6lK6asx3PVVJ1purS+NEzx9ezxMxyfEIDip5Qofv7KrwsyvpDjW/C0kzDowsr7fvYCffbIQ31OErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7sxbp21; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso3636965b3a.3;
        Mon, 13 May 2024 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715602016; x=1716206816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBSGhcRATGfWqcuw9ROtUQ71vyzWXEjjFm1V6NJTT0Y=;
        b=G7sxbp21HgY1LTDbcJRH66MKoUEgrpgqH8tR3LAg6xR0iQOLW6PZZDN116bAuwCeE5
         gzPieBqoi/Oa+yljXYB0TTgBQZPqIZwHMmzos1Enl6B1iARYZfgW+sfNTuTN4qHrbmbE
         gPTIMxSJImVt+/AXtSlIN2brd9Wuorl5JrcRfbo+sjs+cKoNeNFBQNwBy6eucOVhiVO3
         Pg5mRDLDZMnI8eEYWguoeiv1b/e36aamx+nISuLBflJg0qMTi/ivlT08ljvI+3IXsmEv
         lXOJRw28eSH6YULrWQZnYUtgkeWNJKjYyU/oVqBaMwNBUxoa1OZXJ3fZMIofv0k2w+na
         1f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715602016; x=1716206816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBSGhcRATGfWqcuw9ROtUQ71vyzWXEjjFm1V6NJTT0Y=;
        b=N+vXe2ghc2gp8A6i32bTBmpCMshK0BxQxue/YDPRTwx1LTR5Ml0ZYurv16UzTd3Xzb
         i1ADsiyfZQJ1oeVrGMKg1dfzn2TkxGkcVD2Jjk39RC3jb02RMj8I2Sv6RHPxV2CSC0n5
         OYqTOjiXPiwGvcZh+x/qwQRRHVcM9Qk9VpvbO4GyNCtlfc9bZ1tU6EyHA74Me8TJFc1T
         v/GJBZBL2XtZ9ZjoAF3qNMkHE1PGmmIbN6bflNiFB2LfzuvQSifxZR4XM1aVRAPsFeWE
         Xvo1Z2U6j+FYJxmuumCBXucvL6N6FZogqs+R3h/EB8Lfzc5jk2Rz6VA+Ss1tW7aFTP9l
         Bzuw==
X-Forwarded-Encrypted: i=1; AJvYcCWtMo4T/1rBNBSJXtdXOT9EjigNUnhJVnheZ+W1J86UPHrVinKjSmZTa/f2KgKttNsetTZeQKggYBgLRMYMZgRnisNBUfKt7OSjpBjGag==
X-Gm-Message-State: AOJu0YxmJeb+gaWxAOzQNfmv/ED8n3IKnZdiYbICLZunpi2HU1CBr2vw
	Av+RMRP/bJzO913pOsLnUTspOYKlHE20e6zd+0KGtl/DNzsaRdCG3k8xElJz
X-Google-Smtp-Source: AGHT+IFiCkyceinqWjKp3qasZ/AZ4ESi/IBe1hBQMdHCVdIO0QRYINlrHJFq9+4IMlcIsS6y2bNYsg==
X-Received: by 2002:a05:6a20:3c87:b0:1a3:dd15:dacb with SMTP id adf61e73a8af0-1afde1d913cmr12462779637.52.1715602016566;
        Mon, 13 May 2024 05:06:56 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-204-48.dynamic-ip.hinet.net. [220.143.204.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b1esm7446131b3a.171.2024.05.13.05.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:06:56 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 2/2] genirq/proc: Refine percpu kstat_irqs access logic
Date: Mon, 13 May 2024 20:05:48 +0800
Message-Id: <20240513120548.14046-3-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513120548.14046-1-ahuang12@lenovo.com>
References: <20240513120548.14046-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

There is no need to accumulate all CPUs' kstat_irqs to determine whether
the corresponding irq should be printed. Instead, stop the iteration
once one of kstat_irqs is nonzero.

In addition, no need to check if kstat_irqs address is available
for each iteration when printing each CPU irq statistic.

Tested-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 kernel/irq/proc.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af..bfa341fac687 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -461,7 +461,7 @@ int show_interrupts(struct seq_file *p, void *v)
 {
 	static int prec;
 
-	unsigned long flags, any_count = 0;
+	unsigned long flags, print_irq = 1;
 	int i = *(loff_t *) v, j;
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -488,18 +488,28 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs) {
-		for_each_online_cpu(j)
-			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
+	if ((!desc->action || irq_desc_is_chained(desc)) && desc->kstat_irqs) {
+		print_irq = 0;
+		for_each_online_cpu(j) {
+			if (data_race(*per_cpu_ptr(desc->kstat_irqs, j))) {
+				print_irq = 1;
+				break;
+			}
+		}
 	}
 
-	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+	if (!print_irq)
 		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);
-	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ?
-					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
+
+	if (desc->kstat_irqs) {
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", *per_cpu_ptr(desc->kstat_irqs, j));
+	} else {
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", 0);
+	}
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
-- 
2.25.1


