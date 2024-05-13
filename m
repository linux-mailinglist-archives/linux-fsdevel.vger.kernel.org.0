Return-Path: <linux-fsdevel+bounces-19366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD088C4072
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 14:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6569B21FC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B214F119;
	Mon, 13 May 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEMYFzXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0821C683;
	Mon, 13 May 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602008; cv=none; b=OqLw6h8eaLdq5ILWDXW4vja39yIk7eQAISmImt2P+BwqJcWNkP4aXWNpyqPfKI0CaMxlU3QYkELAorkaNc8zZviMEj40vCIQ/YlCml9WYKZaUyUT1SBzaq4B0YdTMl1R9/VopbckNt0SSbfoGoyV4EPatb+PRvhxEnVQREIid2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602008; c=relaxed/simple;
	bh=mkEscee/8PTBU/Moln1t49dlb7pXUoW1uiTFBmeiegM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfC95KABJ6V3en/oTs1Qniayd5qqneDV8j17dvmLsuUw9zB6FsrtR3WVoko5hY6ks5F3ehnivHimevuMaiSRv2NNz2GjmeONad/G4cRXQU7YBGhl5zB/EZyvssJm0ZFhOSQ7UBu7glFRgwSKa2LHhvLSzslgp1N6d+nqNA2CxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEMYFzXZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f447260f9dso3348954b3a.0;
        Mon, 13 May 2024 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715602007; x=1716206807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/gXD3z+R3GJm5HhsrqQaUIDNEik5symS8WpYm7aZpw=;
        b=JEMYFzXZum9RYASxLVqKJcwmoVDMS3cAZ7zKzgRtWgSZNDb3tZw2/dbGljtaRWWQGg
         XUeIt7JE9pk4IFVh5+HurhIKOdVFu+AQyWLt52vpqaStX/OOtujEOg3GoPYtQ67JW8em
         fDpDAhp7YG/0cwcSI4Bv4F6OBzon7NAcY396fivcyRTLmYqCYYWE/qZkh1CyZbfyFeoJ
         xz7QrAZETSoak+DkLUb4eA3tjkVLwKSmbbTKOzRUahgYL7yYzi7Mog9sHkfGHcKapBYr
         P9FhrPkmRpVUSOy/xtOtg3LVjSkV7OfDdtpVi2fLg2Kv/vWn5bDlhGqJZa8UNzLbE7tm
         KO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715602007; x=1716206807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/gXD3z+R3GJm5HhsrqQaUIDNEik5symS8WpYm7aZpw=;
        b=DPzv9DnfWJJsU7VT5HQkdt3MnSiF9LE8q6l4dcKSvz+GKYAyZenphzoZqeLCTs4FKx
         ijtYY5dNoSSvzAmhaicni4kCjNQWXstSOx+X4iU7bnZshkGwApAssFw6uj1XH7pNMPWe
         wd5t2KNadnw5Qm3Ept/nfV2A06kipSY8JgHM39DA4xKjkFeFF7TfAbgOjqPBTz/5saa6
         NYjZlJk1gDLar1bL7g4HwX33NODWgi/elm2KHcPQVJHoOl0ZtFMhHIiF60Pcymyvk2U+
         /JaT+VYH+YiByJ4wzUF8on9yWWTTzr5kBoGV899QpODcOhWDlIQ53lzzmTmi4mv20ftJ
         5VmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCLx6Z/1lo7+DX/tOYCeBlEci0mNyz8/ub0wSp2GXQNtRw4EOouJBddhuP+zWx5QwP0TrJByOwVZom6myubmkhKLjL2fRYCMwK5rB/iA==
X-Gm-Message-State: AOJu0YzNtxSBKkz0TiCzjkM/MOWZRc9F7gNeK1pZjJf/XjiMgYQF+OV7
	b3FShaBZ41pkeHpeVw/A7LE/zQJDddMGZFhoHGX5uUfz5wcj/TAr3blFXpqM
X-Google-Smtp-Source: AGHT+IHz5O3eyaqrEVZd9oufyNTV+J6MJszIibyiY+LLZRDNTxcy37uzlaX2nsWRXkXDXdkAOey30A==
X-Received: by 2002:a05:6a20:9190:b0:1a9:852f:6acf with SMTP id adf61e73a8af0-1afde0a8e5dmr9848938637.11.1715602006732;
        Mon, 13 May 2024 05:06:46 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-204-48.dynamic-ip.hinet.net. [220.143.204.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b1esm7446131b3a.171.2024.05.13.05.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:06:46 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/2] genirq/proc: Try to jump over the unallocated irq hole whenever possible
Date: Mon, 13 May 2024 20:05:47 +0800
Message-Id: <20240513120548.14046-2-ahuang12@lenovo.com>
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

Current approach blindly iterates the irq number until the number is
greater than 'nr_irqs', and checks if each irq is allocated. It is
inefficient if the big hole (the last allocated irq number to nr_irqs)
is available in the system.

The solution is to try jumping over the unallocated irq hole when an
unallocated irq is detected.

Tested-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 fs/proc/interrupts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cbf09..111ea8a3c553 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -19,6 +19,12 @@ static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
 	(*pos)++;
 	if (*pos > nr_irqs)
 		return NULL;
+
+	rcu_read_lock();
+	if (!irq_to_desc(*pos))
+		*pos = irq_get_next_irq(*pos);
+	rcu_read_unlock();
+
 	return pos;
 }
 
-- 
2.25.1


