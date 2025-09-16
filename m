Return-Path: <linux-fsdevel+bounces-61680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43780B58D2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2953A7211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401C2C21F5;
	Tue, 16 Sep 2025 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgiTKs98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4912C21E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998103; cv=none; b=szl7k0bQVoY+xqmh6GbtScDy/k3KQXopRtR3K0TtsL4QfeMjQOgtkBQO7+aPU8Y1jeFFQtk3KMuPrhJc/4cIbMxxsF2AeKTuekaH1gmwcvwz3V2BIX34+K4dmDRDKrKV6c9vLQ/EwSTaUUVkPdfuu6Rwi9L3pH0CUAfYO6WITMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998103; c=relaxed/simple;
	bh=psJk8MWkw4yWUzhoGl6iC+/oKrIajPgKeNxYtGpbGJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+iKbCKOq6mh+HJbFVUD3uXmmO6ttElmVAX8WBGjHNHaJ1Kxem/qXO47yM9eVRSScRMljPR0A7OWQNy2eQ7Y947efjVyTIJ24obJBtQzSAPa+4nrtFUYN6830QmEm1EOF1KyYFeOhAyUNfPGYqFvn8xUe9ZMURVFdKZyQRw7378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgiTKs98; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24456ce0b96so56441395ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998101; x=1758602901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=UgiTKs98TYt0zah/UeSi4De4R5qcPuP9nE+oBFiDNrhtI0JRukYpwBGkrD1qMj8YZJ
         zxAPGGH9qL2hIdPkF9Ps9Xnd7Jvxf/ZVlkbnd47UidqnLrPiaPttc/PPgcfGNO4KSZFH
         MII8pjx2Ab32A8kOPiHi/IVq0+PdVSk9AH6nKylqP4ciHrUFZteDTLfbAAMcPsfOW9/9
         SxBLWNNbByPGH2KJGO4I8tQi++oIv91NAcecNWvFFImMV/zfHb4u5kUEiUYwITx8m6l+
         PbhcI71UPtGbN3T10jjL7ELy4EIjkaG/PtU6I9mrth/K43lLg7JX0O8z0A9pbbonH3JS
         zeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998101; x=1758602901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=BYdoYY5w9vldZhtnxBpxG5I1il2q/EhzMY6TqgnH7C2h652H+MmOksEjYGgNu2f//0
         lqaZZcN5seyscNd3iEmmsdQnhg49M3PomWLWxmVBTWfVggxw6hOOyiiLv/cSOEsmV60M
         FxmobR8Z4dK6H4DdwOkQXxNt5ZRQ2zyKX5iYuGXRMH6+QhcFiAy6yixoSzUur8uPMilT
         zkBk8s8DpFiAf/h52yQqfibHpbTVxYwj64/Ql1piArvfrXBZWniYArfZu4ajviONH9lJ
         cbta4P1odaNyZqfR6+JPR+Qvzdp4nEmmG9ivyfE2I6a8UE+unRs4dDGW+V9pqY/CaAjd
         kKYA==
X-Forwarded-Encrypted: i=1; AJvYcCWK247ttofVmgwpiBpH0XIccJYigCpZpQiipSJpQmEm8Xs15eusTC46P595WykAlhxoQH95I2un+Bg0QJCi@vger.kernel.org
X-Gm-Message-State: AOJu0YysFIFhXzr6pt9EqVUMSj+tgvKbOBVWrWlQyIEdJLtoiypmi4Al
	XNO6DsN4XPJQ5OtRozJVQHf+gM0JdAx2mbnKvV0+7GWMt1Z4aU6tw8HH
X-Gm-Gg: ASbGnctpYtO8wdZX/iUiM6W38VuNsIs3VxX1P1XYQyf39n2WRQknTEo0nlcMBcRn0Qu
	926z7gB7T3bwMFegtrSaT5lccQM6EAqm7NKn3Qv5iqGzgZD5RG3ikRe9jWUU8rjgw40ouoxhQK4
	V9YOzUfWU0eQ3SnCG2jIygHl/pxNQvCXPdSHO7y2IoOg4ZEE5knyp/bTQudZoIS2cLawCtOAxB4
	KIREzELGebbNtm8nrDHlIxgjMPp+3/auBIiGbxPuPo2KYbyOrlNZe/xte6PsCLqoiU+7iUBPeXN
	0AqZKU3eygzchw27jG0hgoNSbjd6tp8YHkvOInOzT2DQQy/bapIrEK43IEEOV4a3Y85iVEeDJT4
	D47ywVEtYyjdbT1Di7cYqBeEjAkFP2fVYV7O8xXs=
X-Google-Smtp-Source: AGHT+IFncLMpEiSXyRV3g2udd9oLTip5CIZ6fjiDS7nm0eY3IrUPzgwzagMuf9PJuGmIj5O4nns0xw==
X-Received: by 2002:a17:903:2f87:b0:249:71f5:4e5a with SMTP id d9443c01a7336-267d161e3b9mr10726455ad.26.1757998100825;
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 01/14] ACPI: APEI: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:22 +0800
Message-Id: <20250916044735.2316171-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/acpi/apei/ghes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..97ee19f2cae0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1207,12 +1207,10 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
 	int ret = NOTIFY_DONE;
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return ret;
-- 
2.34.1


