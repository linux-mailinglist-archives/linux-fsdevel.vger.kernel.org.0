Return-Path: <linux-fsdevel+bounces-19514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C248C64C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 12:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FFDDB22BAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543D5A79B;
	Wed, 15 May 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7CxKjwu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681C2AC29;
	Wed, 15 May 2024 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767654; cv=none; b=i8rUH4Jxcw4pLpsCUimtW8G5AbV+x3usxKShJMQgeqTcD+vXoBm3hUS9coCg1szGcAo0MNIgfslfDUSVl/sfbui1ElrOR6nKeiajo1B/If7bFfFWXiGJseI+kdclcRJ+CdPViQJVlVSW1vbvqaTHKbiwac/rCAc/Hp10Di4KLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767654; c=relaxed/simple;
	bh=Lojht7Xjnj67v23RYwEiN4Oi8cjL16M1wOq/ga0DAco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j70F1+xAljmucwWp0jfLswVpZ02pR1QKnvtyg8lGg35oXYVK65KC/+DpRkJAl82LJ/X4b5Ni7Q/NAgf79TqtWSHpkh0bKuvFXP2LMN1NhkgIu8/+3CNu5cHWTgJDvUP0+Xhc+aMn2Kzncpg5dltRp9RBtfqV461z+VzRS0bkqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7CxKjwu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f6765226d0so382763b3a.3;
        Wed, 15 May 2024 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715767652; x=1716372452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Smjmp3PZxXRa4Z/icpgGYu/3oa70ypICQV2SCcf0T8=;
        b=e7CxKjwuL8Q2E/95ZbAdsORS9HDrVCx2M9eR7ylsr/JdIfQcXdJd2SdfbXprQKxypT
         azxNEs47qecxDufA69o1kMEdfni2/ECn1TA2bS95SbNiibamDazfuDzGVFfKp0gzPTsM
         8oPT9U8+3fHOC27Byj7knmE9jIXWFgBVG1YkXrsZ4bIVwt8Y2MDql/QYSn5MO/PQsQpA
         Pj504U/H7yAGVWJQFGnoGaJQKOFhpZw/huXE9m2YnmHD7bDs03DSOkDe1ZBH1ySPX5ig
         vXKjX9tG3bneS4QLau7EVUiakiu5as7LB/5Iyz1tmjFDUcMp1Xz/WyAhyiFMfOwhlwcv
         ZJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715767652; x=1716372452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Smjmp3PZxXRa4Z/icpgGYu/3oa70ypICQV2SCcf0T8=;
        b=FQ2NdtGfUwYBydxjU+5VC42osC6C0VR4m6fmmHql9lSRDs/wvisLg4P0ghD+Ks5yU9
         qyKWcKfH0yjP4g25iYH1/30WtvMmvVsF+dczR3guSV3TT1N28K0qRfIuFWcWcISu2vbH
         p1d50JQeL31eOKsSSkGF6bWRo8zw6KDrbc7GJYEHN/DQu+BY/DSk2VVcqpBAcv1dN079
         AsDVS6GzZ/7QoqZm9ExaI9garw9VWgBhG73DeYbPlRmwX30I7nTDrqnKH9+jyOIjlGRs
         Fk7ridnCJOVg+x+X13VZwb4AYfGP0VLXbn2lgBjZ00AL1ExG2MyARtmaLBqS2T9SMLgY
         O8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUdH/bPKX5VYwKRZFOShJUa5KgAqiBWOQogRzGNnGcEkHJMj+wl/0P4pVfEXI7fkacnJBh4T1Uf2BDIyNFOB3vaEPfPBnyS6xc5/nfYoA==
X-Gm-Message-State: AOJu0Yxvva0ZZMm3HicyRXFp9/P7G4mmFaYCEykDv/25YrI3DPkTgf30
	a77yJWaDvEV9xCMo4K2v/lU4EdVeK4fZqw0RiK8ZnJ4+3q7NjTHa
X-Google-Smtp-Source: AGHT+IHu8ud56F2dFyxL0lKuNw7iN1lRrHXWphyMV556F3uBB6P/FLw0jTJ3cF74MdCQGbTkqTa0SA==
X-Received: by 2002:a05:6a20:dc94:b0:1af:a9ad:fbb9 with SMTP id adf61e73a8af0-1afde1c5dcemr11873054637.59.1715767652516;
        Wed, 15 May 2024 03:07:32 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-177-168.dynamic-ip.hinet.net. [220.143.177.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade27fsm10687222b3a.108.2024.05.15.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:07:32 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: [PATCH v2 2/2] genirq/proc: Refine percpu kstat_irqs access logic
Date: Wed, 15 May 2024 18:06:32 +0800
Message-Id: <20240515100632.1419-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

Interrupts which have no action and chained interrupts can be
ignored due to the following reasons (as per tglx's comment):

  1) Interrupts which have no action are completely uninteresting as
     there is no real information attached.

  2) Chained interrupts do not have a count at all.

Refine the condition statement, and convert the access of kstat_irqs
into the unconditional statement.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87h6f0knau.ffs@tglx/
Tested-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 kernel/irq/proc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af..e3d03103522c 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -461,10 +461,10 @@ int show_interrupts(struct seq_file *p, void *v)
 {
 	static int prec;
 
-	unsigned long flags, any_count = 0;
 	int i = *(loff_t *) v, j;
 	struct irqaction *action;
 	struct irq_desc *desc;
+	unsigned long flags;
 
 	if (i > ACTUAL_NR_IRQS)
 		return 0;
@@ -488,18 +488,12 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs) {
-		for_each_online_cpu(j)
-			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
-	}
-
-	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
 		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ?
-					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
+		seq_printf(p, "%10u ", *per_cpu_ptr(desc->kstat_irqs, j));
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
-- 
2.25.1


